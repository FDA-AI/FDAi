let GOOGLE_CLIENT_ID = process.env.CONNECTOR_GOOGLE_CLIENT_ID || "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";
let GOOGLE_CLIENT_SECRET = process.env.CONNECTOR_GOOGLE_CLIENT_SECRET || "1060725074195-kmeum4crr01uirfl2op9kd5acmi9jutn.apps.googleusercontent.com";
const QUANTIMODO_CLIENT_ID = process.env.CONNECTOR_QUANTIMODO_CLIENT_ID || 'oauth_test_client';
const QUANTIMODO_CLIENT_SECRET = process.env.CONNECTOR_QUANTIMODO_CLIENT_SECRET || 'YJDffKcoDLGYjMujyOclx0jarDcw3xnt';
module.exports = {
    GOOGLE_CLIENT_ID,
    GOOGLE_CLIENT_SECRET,
    QUANTIMODO_CLIENT_ID,
    QUANTIMODO_CLIENT_SECRET
}