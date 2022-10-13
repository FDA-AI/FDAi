var express = require('express'),
    app = express(),
    bodyParser = require('body-parser'),
    morgan = require('morgan');
const path = require('path');
const { initialize } = require('@oas-tools/core');
const mcache = require('memory-cache');
const proxy = require('express-http-proxy');
var Bugsnag = require('@bugsnag/js')
var BugsnagPluginExpress = require('@bugsnag/plugin-express')
const http = require("http");
const {numberFormat} = require("underscore.string");
Bugsnag.start({
    apiKey: process.env.BUGSNAG_API_KEY || "5b0414a9a476d93d154fa294c76ac6ed",
    plugins: [BugsnagPluginExpress],
})
var cache = (duration) => {
    return (req, res, next) => {
        let key = '__express__' + req.originalUrl || req.url
        let cachedBody = mcache.get(key)
        if (cachedBody) {
            res.send(cachedBody)
        } else {
            res.sendResponse = res.send
            res.send = (body) => {
                mcache.put(key, body, duration * 1000);
                res.sendResponse(body)
            }
            next()
        }
    }
}

var middleware = Bugsnag.getPlugin('express')
// This must be the first piece of middleware in the stack.
// It can only capture errors in downstream middleware
app.use(middleware.requestHandler)
// This handles any errors that Express catches. This needs to go before other
// error handlers. Bugsnag will call the `next` error handler if it exists.
app.use(middleware.errorHandler)

app.use(morgan('dev'));
// CORS (Cross-Origin Resource Sharing) headers to support Cross-site HTTP requests
app.use(function(req, res, next) {
    // Don't allow cross-origin to prevent usage of client id and secret
    // res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST');
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With, content-type, Authorization, X-Client-ID, X-Client-Secret');
    next();
});

const proxyUrl = process.env.API_URL || 'https://app.quantimo.do/api';
var serverPort = 5000;
if(process.env.PORT){
    serverPort = numberFormat(process.env.PORT);
}
app.use('/#app', express.static(path.join(__dirname, '../src')))
app.use('/docs', express.static(path.join(__dirname, '../src/docs')))
// app.use('*', proxy(proxyUrl));
//app.use('/api', proxy(apiUrl+'/api'));
app.use('/api', proxy(proxyUrl, {
    proxyReqOptDecorator: function(proxyReqOpts, srcReq) {
        // you can update headers
        proxyReqOpts.headers['X-Client-ID'] = process.env.QUANTIMODO_CLIENT_ID;
        // you can change the method
        //proxyReqOpts.method = 'GET';
        return proxyReqOpts;
    }
}));
app.use(bodyParser.urlencoded({ extended: true }));  // must come after any proxy calls, or it fucks up the body
app.use(bodyParser.json());

app.use(express.json({limit: '50mb'}));

const config = {
    middleware: {
        security: {
            auth: {
                access_token: () => { /* no-op */ },
                bearerAuth: () => {  },
                client_id: () => { /* no-op */ },
                curedao_oauth2: () => { /* no-op */ },
            }
        }
    }
}
initialize(app, config).then(() => {
    let server = http.createServer(app);
    server.listen(serverPort, () => {
        console.log("\nApp running at http://localhost:" + serverPort + " in " + app.get('env') + " mode");
        console.log("________________________________________________________________");
        if (config.middleware.swagger?.disable !== false) {
            console.log("API docs (Swagger UI) available on http://localhost:" + serverPort + '/docs');
            console.log("________________________________________________________________");
        }
    });
});
