var express = require('express'),
    app = express(),
    bodyParser = require('body-parser'),
    logger = require('morgan');
app.use(logger('dev'));
const path = require('path');
const envPath = path.resolve('../../.env');
const dotenv = require('dotenv');
dotenv.config({ path: envPath });
const http = require("http");
const qmLog = require('./utils/logHelper');
const envHelper = require("./utils/envHelper.js");
const urlHelper = require("./utils/urlHelper");
const authHelper = require("./utils/authHelper");
const passport = require('passport')
global.Q = require('q');
app.use(require('cookie-parser')());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use(require('express-session')({
    secret: envHelper.getRequiredEnv('JWT_SECRET'),
    resave: true,
    saveUninitialized: true
}));
app.use(passport.initialize());
app.use(passport.session());

showLogs = (req, res, next) => {
    if(!qm.fileHelper.isStaticAsset(req.url)){
        qmLog.debug("\n==============================")
        qmLog.info("req", req.url)
        qmLog.debug(`req.session.passport --> `,req.session.passport)
        qmLog.debug(`req.user -> `,req.user)
        qmLog.debug(`req.session.id -> ${req.session.id}`)
        qmLog.debug(`req.session.cookie --> `,req.session.cookie)
        qmLog.debug("===========================================\n")
    }
    next()
}
app.use(showLogs)
app.use(authHelper.addAccessTokenToSession)

// CORS (Cross-Origin Resource Sharing) headers to support Cross-site HTTP requests
app.use(function(req, res, next) {
    // Don't allow cross-origin to prevent usage of client id and secret
    // res.setHeader('Access-Control-Allow-Origin', '*');
    function isStaticAsset(url) {
      if(url.indexOf('.ttf') > -1){return true;}
      const extensions = ['.js', '.css', '.json', '.map', '.html', '.png', '.gif', '.svg', '.jpg', '.jpeg'];
      return extensions.some(extension => url.endsWith(extension));
    }
    if(!isStaticAsset(req.url)){
        qm.request = req;
        qm.response = res;
        res.setHeader('Access-Control-Allow-Methods', 'GET, POST');
        res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With, content-type, Authorization, X-Client-ID, X-Client-Secret');
    }
    next();
});
app.use('/', express.static(path.join(__dirname, '../dfda-1/public/app/public')))
app.use('/#app', express.static(path.join(__dirname, '../src')))
app.use('/docs', express.static(path.join(__dirname, '../src/docs')))
app.use('/data', express.static(path.join(__dirname, '../dfda-1/public/app/public/data')))
app.use('/js', express.static(path.join(__dirname, '../dfda-1/public/app/public/js')))
app.use('/', require('./routes/api'));
app.use('/', require('./routes/auth'));
app.use('/', require('./routes/fdai'));

//app.use('/', require('./routes/github'));
var server = http.createServer(app);
server.listen(urlHelper.serverPort);
console.info('Server running at ' + urlHelper.serverOrigin);
server.on('error', (e) => {
    if (e.code === 'EADDRINUSE') {
        console.error('Address in use, retrying...');
    }
})
