var express = require('express'),
    app = express(),
    bodyParser = require('body-parser'),
    logger = require('morgan');
app.use(logger('dev'));
const path = require('path');
const envPath = path.resolve('./.env');
const {loadEnvFromDopplerOrDotEnv} = require("../ionic/ts/env-helper")
loadEnvFromDopplerOrDotEnv(envPath);
const { initialize } = require('@oas-tools/core');
const proxy = require('express-http-proxy');
const http = require("http");
const {numberFormat} = require("underscore.string");
const qm = require("../ionic/src/js/qmHelpers");
var crypto = require('crypto');
var audit = require('express-requests-logger')
const Str = require('@supercharge/strings')
require("dotenv").config();
const urlHelper = require("./utils/urlHelper");
const passport = require('passport')
app.use(require('cookie-parser')());
app.use(require('body-parser').urlencoded({ extended: true }));
app.use(require('express-session')({ secret: 'keyboard cat', resave: true, saveUninitialized: true }));
app.use(passport.initialize());
app.use(passport.session());

showLogs = (req, res, next) => {
    console.log("\n==============================")
    console.log("req", req.url)
    console.log(`req.session.passport --> `,req.session.passport)
    console.log(`req.user -> `,req.user)
    console.log(`req.session.id -> ${req.session.id}`)
    console.log(`req.session.cookie --> `,req.session.cookie)
    console.log("===========================================\n")
    next()
}
app.use(showLogs)
// CORS (Cross-Origin Resource Sharing) headers to support Cross-site HTTP requests
app.use(function(req, res, next) {
    // Don't allow cross-origin to prevent usage of client id and secret
    // res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST');
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With, content-type, Authorization, X-Client-ID, X-Client-Secret');
    next();
});
app.use('/', express.static(path.join(__dirname, '../ionic/src')))
app.use('/#app', express.static(path.join(__dirname, '../src')))
app.use('/docs', express.static(path.join(__dirname, '../src/docs')))
app.use('/data', express.static(path.join(__dirname, '../ionic/src/data')))
app.use('/js', express.static(path.join(__dirname, '../ionic/src/js')))
var apiRouter = require('./routes/api');
var authRouter = require('./routes/auth');
var googleRouter = require('./routes/google');
app.use('/', apiRouter);
app.use('/', authRouter);
app.use('/', googleRouter);
var server = http.createServer(app);
server.listen(urlHelper.serverPort);
