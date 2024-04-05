/* eslint-disable no-unused-vars */
const Service = require('./Service');

/**
* Tracking reminder notifications, messages, and study results
* Tracking reminder notifications, messages, and study results
*
* sort String Sort by one of the listed field names. If the field name is prefixed with `-`, it will sort in descending order. (optional)
* userId BigDecimal User's id (optional)
* createdAt String When the record was first created. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* updatedAt String When the record was last updated. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* limit Integer The LIMIT is used to limit the number of results returned. So if youhave 1000 results, but only want to the first 10, you would set this to 10 and offset to 0. The maximum limit is 200 records. (optional)
* offset Integer OFFSET says to skip that many rows before beginning to return rows to the client. OFFSET 0 is the same as omitting the OFFSET clause.If both OFFSET and LIMIT appear, then OFFSET rows are skipped before starting to count the LIMIT rows that are returned. (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* returns FeedResponse
* */
const getFeed = ({ sort, userId, createdAt, updatedAt, limit, offset, clientId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        sort,
        userId,
        createdAt,
        updatedAt,
        limit,
        offset,
        clientId,
      }));
    } catch (e) {
      reject(Service.rejectResponse(
        e.message || 'Invalid input',
        e.status || 405,
      ));
    }
  },
);
/**
* Post user interactions with feed
* Post user actions on feed cards
*
* body List Id of the tracking reminder notification to be snoozed
* userId BigDecimal User's id (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* returns FeedResponse
* */
const postFeed = ({ body, userId, clientId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        body,
        userId,
        clientId,
      }));
    } catch (e) {
      reject(Service.rejectResponse(
        e.message || 'Invalid input',
        e.status || 405,
      ));
    }
  },
);

module.exports = {
  getFeed,
  postFeed,
};
