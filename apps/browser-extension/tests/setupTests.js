const LocalStorage = require('node-localstorage').LocalStorage;
global.localStorage = new LocalStorage('./tests/scratch');
localStorage.clear();
process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

global.parseDate = function(dateString) {
  return new Date(dateString);
}

global.getQuantimodoAccessToken = async function() {
  return 'demo';
}

// You might need to install these packages if you're dealing with HTTPS and keep-alive
// npm install https agentkeepalive
const https = require('https');
const { HttpsAgent } = require('agentkeepalive');
const fetch = require('node-fetch');

const httpsAgent = new https.Agent({
  rejectUnauthorized: false, // WARNING: This disables SSL/TLS verification.
});

async function fetchWithInsecureSSL(url, options = {}) {
  // Add the custom HTTPS agent to the request options
  options.agent = httpsAgent;
  return fetch(url, options);
}

global.fetch = fetchWithInsecureSSL;

// Now you can use fetchWithSystemDns instead of fetch

global.apiOrigin = 'https://local.quantimo.do';
