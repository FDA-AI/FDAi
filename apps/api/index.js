var express = require('express'),
    app = express(),
    bodyParser = require('body-parser'),
    morgan = require('morgan');
const path = require('path');
const envPath = path.resolve('./.env');
const {loadEnvFromDopplerOrDotEnv} = require("../ionic/ts/env-helper")
loadEnvFromDopplerOrDotEnv(envPath);
const { initialize } = require('@oas-tools/core');
const mcache = require('memory-cache');
const proxy = require('express-http-proxy');
const http = require("http");
const {numberFormat} = require("underscore.string");

// SuperTokens - init
const cors = require("cors");
const helmet = require("helmet");
require("dotenv").config();
let supertokens = require("../../libs/supertokens-node");
let Session = require("../../libs/supertokens-node/recipe/session");
let { verifySession } = require("../../libs/supertokens-node/recipe/session/framework/express");
let { middleware, errorHandler } = require("../../libs/supertokens-node/framework/express");
let ThirdPartyEmailPassword = require("../../libs/supertokens-node/recipe/thirdpartyemailpassword");
let axios = require("axios");
// SuperTokens - init

// Change these values if you want to run the server on another address
const apiPort = process.env.REACT_APP_API_PORT || 3001;
const apiDomain = process.env.REACT_APP_API_URL || `http://localhost:${apiPort}`;
const websitePort = process.env.REACT_APP_WEBSITE_PORT || 3000;
const websiteDomain = process.env.REACT_APP_WEBSITE_URL || `http://localhost:${websitePort}`;

supertokens.init({
    framework: "express",
    supertokens: {
        // TODO: This is a core hosted for demo purposes. You can use this, but make sure to change it to your core instance URI eventually.
        connectionURI: "https://try.supertokens.io",
        apiKey: "<REQUIRED FOR MANAGED SERVICE, ELSE YOU CAN REMOVE THIS FIELD>",
    },
    appInfo: {
        appName: "SuperTokens Demo App", // TODO: Your app name
        apiDomain, // TODO: Change to your app's API domain
        websiteDomain, // TODO: Change to your app's website domain
    },
    recipeList: [
        ThirdPartyEmailPassword.init({
            /*
             We use different credentials for different platforms when required. For example the redirect URI for GitHub
             is different for Web and mobile. In such a case we can provide multiple providers with different client Ids.

             When the frontend makes a request and wants to use a specific clientId, it needs to send the clientId to use in the
             request. In the absence of a clientId in the request the SDK uses the default provider, indicated by `isDefault: true`.
             When adding multiple providers for the same type (Google, GitHub etc.), make sure to set `isDefault: true`.
             */
            providers: [
                // We have provided you with development keys which you can use for testing or when running our demo apps.
                // IMPORTANT: Please replace them with your own OAuth keys for production use.
                ThirdPartyEmailPassword.Google({
                    // We use this for websites
                    isDefault: true,
                    clientId: "1060725074195-kmeum4crr01uirfl2op9kd5acmi9jutn.apps.googleusercontent.com",
                    clientSecret: "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",
                }),
                ThirdPartyEmailPassword.Google({
                    // we use this for mobile apps
                    clientId: "1060725074195-c7mgk8p0h27c4428prfuo3lg7ould5o7.apps.googleusercontent.com",
                    clientSecret: "",
                }),
                ThirdPartyEmailPassword.Github({
                    // We use this for websites
                    isDefault: true,
                    clientSecret: "e97051221f4b6426e8fe8d51486396703012f5bd",
                    clientId: "467101b197249757c71f",
                }),
                ThirdPartyEmailPassword.Github({
                    // We use this for mobile apps
                    clientSecret: "00e841f10f288363cd3786b1b1f538f05cfdbda2",
                    clientId: "8a9152860ce869b64c44",
                }),
                /*
                 For Apple signin, iOS apps always use the bundle identifier as the client ID when communicating with Apple. Android, Web and other platforms
                 need to configure a Service ID on the Apple developer dashboard and use that as client ID.
                 In the example below 4398792-io.supertokens.example.service is the client ID for Web, Android etc. For iOS
                 the frontend for the demo app sends the clientId in the request which is then used by the SDK.
                 */
                ThirdPartyEmailPassword.Apple({
                    // For Android and website apps
                    isDefault: true,
                    clientId: "4398792-io.supertokens.example.service",
                    clientSecret: {
                        keyId: "7M48Y4RYDL",
                        privateKey:
                          "-----BEGIN PRIVATE KEY-----\nMIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgu8gXs+XYkqXD6Ala9Sf/iJXzhbwcoG5dMh1OonpdJUmgCgYIKoZIzj0DAQehRANCAASfrvlFbFCYqn3I2zeknYXLwtH30JuOKestDbSfZYxZNMqhF/OzdZFTV0zc5u5s3eN+oCWbnvl0hM+9IW0UlkdA\n-----END PRIVATE KEY-----",
                        teamId: "YWQCXGJRJL",
                    },
                }),
                ThirdPartyEmailPassword.Apple({
                    // For iOS Apps
                    clientId: "4398792-io.supertokens.example",
                    clientSecret: {
                        keyId: "7M48Y4RYDL",
                        privateKey:
                          "-----BEGIN PRIVATE KEY-----\nMIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgu8gXs+XYkqXD6Ala9Sf/iJXzhbwcoG5dMh1OonpdJUmgCgYIKoZIzj0DAQehRANCAASfrvlFbFCYqn3I2zeknYXLwtH30JuOKestDbSfZYxZNMqhF/OzdZFTV0zc5u5s3eN+oCWbnvl0hM+9IW0UlkdA\n-----END PRIVATE KEY-----",
                        teamId: "YWQCXGJRJL",
                    },
                }),
                ThirdPartyEmailPassword.Discord({
                    clientId: "4398792-907871294886928395",
                    clientSecret: "His4yXGEovVp5TZkZhEAt0ZXGh8uOVDm",
                }),
                ThirdPartyEmailPassword.GoogleWorkspaces({
                    clientId: "1060725074195-kmeum4crr01uirfl2op9kd5acmi9jutn.apps.googleusercontent.com",
                    clientSecret: "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",
                }),
                // ThirdPartyEmailPassword.Okta({
                //     clientId: "4398792-0oa6kpw2hM4SO48oI696",
                //     clientSecret: "dNvaVoYBUp5RvYKcXtH7p2kKd94yW_jTOFaoq4CX",
                //     oktaDomain: "supertokens.okta.com",
                // }),
                // ThirdPartyEmailPassword.ActiveDirectory({
                //     clientId: "4398792-b82b545b-4506-4d99-96e7-16f50dbd3e85",
                //     clientSecret: "TLi7Q~l.NUqCTlyBykkyTFqHXjpnTFoQSv.E0",
                //     tenantId: "57ca402e-7209-4054-9f96-1617f23051ea",
                // }),
            ],
        }),
        Session.init(),
    ],
});

app.use(
  cors({
      origin: websiteDomain, // TODO: Change to your app's website domain
      allowedHeaders: ["content-type", ...supertokens.getAllCORSHeaders()],
      methods: ["GET", "PUT", "POST", "DELETE"],
      credentials: true,
  })
);

app.use(
  helmet({
      contentSecurityPolicy: false,
  })
);
app.use(middleware());

// custom API that requires session verification
app.get("/sessioninfo", verifySession(), async (req, res) => {
    let session = req.session;
    res.send({
        sessionHandle: session.getHandle(),
        userId: session.getUserId(),
        accessTokenPayload: session.getAccessTokenPayload(),
    });
});

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

app.use(morgan('dev'));
// CORS (Cross-Origin Resource Sharing) headers to support Cross-site HTTP requests
app.use(function(req, res, next) {
    // Don't allow cross-origin to prevent usage of client id and secret
    // res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST');
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With, content-type, Authorization, X-Client-ID, X-Client-Secret');
    next();
});

var serverPort = 5000;
if(process.env.PORT){
    serverPort = numberFormat(process.env.PORT);
}
app.use('/', express.static(path.join(__dirname, '../ionic/src')))
app.use('/#app', express.static(path.join(__dirname, '../src')))
app.use('/docs', express.static(path.join(__dirname, '../src/docs')))
// app.use('*', proxy(proxyUrl));
//app.use('/api', proxy(apiUrl+'/api'));
const novaOrigin = process.env.NOVA_ORIGIN || 'https://app.quantimo.do';
app.use('/nova', proxy(novaOrigin, {
    proxyReqOptDecorator: function(proxyReqOpts, srcReq) {
        // you can update headers
        proxyReqOpts.headers['X-Client-ID'] = process.env.CONNECTOR_QUANTIMODO_CLIENT_ID;
        proxyReqOpts.headers['X-Client-Secret'] = process.env.CONNECTOR_QUANTIMODO_CLIENT_SECRET;
        // you can change the method
        //proxyReqOpts.method = 'GET';
        return proxyReqOpts;
    },
    proxyReqPathResolver: function (req) {
        req.url = '/nova' + req.url;
        console.log('proxyReqPathResolver', req.url)
        return req.url;
    }
}));
const apiOrigin = process.env.API_ORIGIN || 'https://app.quantimo.do'
app.use('/api', proxy(apiOrigin, {
    proxyReqOptDecorator: function(proxyReqOpts, srcReq) {
        // you can update headers
        proxyReqOpts.headers['X-Client-ID'] = process.env.QUANTIMODO_CLIENT_ID;
        proxyReqOpts.headers['X-Client-Secret'] = process.env.QUANTIMODO_CLIENT_SECRET;
        // you can change the method
        //proxyReqOpts.method = 'GET';
        return proxyReqOpts;
    },
    proxyReqPathResolver: function (req) {
        req.url = '/api' + req.url;
        console.log('proxyReqPathResolver', req.url)
        return req.url;
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
app.use(errorHandler());

app.use((err, req, res, next) => {
    res.status(500).send("Internal error: " + err.message);
});
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
