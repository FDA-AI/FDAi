var express = require('express');
var ensureLogIn = require('connect-ensure-login').ensureLoggedIn;
var db = require('../db');
const proxy = require("express-http-proxy");
const urlHelper = require("../utils/urlHelper");
const stringHelper = require("../utils/stringHelper");
const qm = require("../../ionic/src/js/qmHelpers");
var ensureLoggedIn = ensureLogIn();


let unauthorizedResponse = {
  "error": "Unauthorized",
  "message": "You are not authorized to access this resource.",
  "status": 401
};

function fetchUser(req, res, next) {
  db.all('SELECT * FROM todos WHERE owner_id = ?', [
    req.user.id
  ], function(err, rows) {
    if (err) { return next(err); }

    var todos = rows.map(function(row) {
      return {
        id: row.id,
        title: row.title,
        completed: row.completed == 1 ? true : false,
        url: '/' + row.id
      }
    });
    res.locals.todos = todos;
    res.locals.activeCount = todos.filter(function(todo) { return !todo.completed; }).length;
    res.locals.completedCount = todos.length - res.locals.activeCount;
    next();
  });
}

//Use the req.isAuthenticated() function to check if user is Authenticated
checkAuthenticated = (req, res, next) => {
  if (req.isAuthenticated()) {
    let user = req.user
    let qmUser = req.session.qmUser
    let token = user.accessToken || user.access_token.access_token;
    req.headers['Authorization'] = `Bearer ${token}`
  }
  return next()
  //res.redirect("/#/app/login")
}

var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  if (!req.user) { return res.render('home'); }
  next();
}, fetchUser, function(req, res, next) {
  res.locals.filter = null;
  res.render('index', { user: req.user });
});

router.get('/active', ensureLoggedIn, fetchUser, function(req, res, next) {
  res.locals.todos = res.locals.todos.filter(function(todo) { return !todo.completed; });
  res.locals.filter = 'active';
  res.render('index', { user: req.user });
});

// GET method route
router.get('/api/v1/user', checkAuthenticated, (req, res) => {
  if(!req.user){
    const email = req.query.email
    if(email){
      return db.findUserByEmail(email).then((user) => {
        const storedPassword = user.password
        const providedPassword = req.query.password

        if(user){
          res.json(user)
        }else{
          res.status(401).json(unauthorizedResponse);
        }
      })
    }
    return;
  }
  if(!req.user){
    res.status(401).json(unauthorizedResponse);
    return;
  }
  let user = stringHelper.camelCaseKeys(req.user)
  res.status(200).json(user)
})

router.use('/api', checkAuthenticated, proxy(urlHelper.API_ORIGIN, {
  proxyReqOptDecorator: function(proxyReqOpts, srcReq) {
    // you can update headers
    // proxyReqOpts.headers['X-Client-ID'] = process.env.QUANTIMODO_CLIENT_ID;
    // proxyReqOpts.headers['X-Client-Secret'] = process.env.QUANTIMODO_CLIENT_SECRET;
    const user = srcReq.user;
    if(user && user.access_token && user.access_token.access_token){
      proxyReqOpts.headers['Authorization'] = `Bearer ${user.access_token.access_token}`;
      proxyReqOpts.headers['X-Client-ID'] = QUANTIMODO_CLIENT_ID;
      proxyReqOpts.headers['Accept'] = 'application/json';
    }
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

module.exports = router;
