/* eslint-disable no-unused-vars */
const Service = require('./Service');

/**
* Delete a measurement
* Delete a previously submitted measurement
*
* returns CommonResponse
* */
const deleteMeasurement = () => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
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
* Get measurements for this user
* Measurements are any value that can be recorded like daily steps, a mood rating, or apples eaten.
*
* variableName String Name of the variable you want measurements for (optional)
* sort String Sort by one of the listed field names. If the field name is prefixed with `-`, it will sort in descending order. (optional)
* limit Integer The LIMIT is used to limit the number of results returned. So if youhave 1000 results, but only want to the first 10, you would set this to 10 and offset to 0. The maximum limit is 200 records. (optional)
* offset Integer OFFSET says to skip that many rows before beginning to return rows to the client. OFFSET 0 is the same as omitting the OFFSET clause.If both OFFSET and LIMIT appear, then OFFSET rows are skipped before starting to count the LIMIT rows that are returned. (optional)
* variableCategoryName String Ex: Emotions, Treatments, Symptoms... (optional)
* updatedAt String When the record was last updated. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* userId BigDecimal User's id (optional)
* sourceName String ID of the source you want measurements for (supports exact name match only) (optional)
* connectorName String Ex: facebook (optional)
* value String Value of measurement (optional)
* unitName String Ex: Milligrams (optional)
* earliestMeasurementTime String Excluded records with measurement times earlier than this value. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss  datetime format. Time zone should be UTC and not local. (optional)
* latestMeasurementTime String Excluded records with measurement times later than this value. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss  datetime format. Time zone should be UTC and not local. (optional)
* createdAt String When the record was first created. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* id Integer Measurement id (optional)
* groupingWidth Integer The time (in seconds) over which measurements are grouped together (optional)
* groupingTimezone String The time (in seconds) over which measurements are grouped together (optional)
* doNotProcess Boolean Ex: true (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* doNotConvert Boolean Ex: 1 (optional)
* minMaxFilter Boolean Ex: 1 (optional)
* returns List
* */
const getMeasurements = ({ variableName, sort, limit, offset, variableCategoryName, updatedAt, userId, sourceName, connectorName, value, unitName, earliestMeasurementTime, latestMeasurementTime, createdAt, id, groupingWidth, groupingTimezone, doNotProcess, clientId, doNotConvert, minMaxFilter }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        variableName,
        sort,
        limit,
        offset,
        variableCategoryName,
        updatedAt,
        userId,
        sourceName,
        connectorName,
        value,
        unitName,
        earliestMeasurementTime,
        latestMeasurementTime,
        createdAt,
        id,
        groupingWidth,
        groupingTimezone,
        doNotProcess,
        clientId,
        doNotConvert,
        minMaxFilter,
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
* Post Request for Measurements CSV
* Use this endpoint to schedule a CSV export containing all user measurements to be emailed to the user within 24 hours.
*
* userId BigDecimal User's id (optional)
* returns Integer
* */
const measurementExportRequest = ({ userId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        userId,
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
* Upload a spreadsheet with measurements
* Import from a spreadsheet containing a Variable Name, Value, Measurement Event Time, and Abbreviated Unit Name field.  Here is an <a href=\"https://bit.ly/2jz7CNl\" target=\"_blank\">example spreadsheet</a> with allowed column names, units and time format.
*
* userId BigDecimal User's id (optional)
* file File  (optional)
* returns Integer
* */
const measurementSpreadsheetUpload = ({ userId, file }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        userId,
        file,
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
* Post a new set or update existing measurements to the database
* You can submit or update multiple measurements in a \"measurements\" sub-array.  If the variable these measurements correspond to does not already exist in the database, it will be automatically added.
*
* body List An array of measurement sets containing measurement items you want to insert.
* userId BigDecimal User's id (optional)
* returns PostMeasurementsResponse
* */
const postMeasurements = ({ body, userId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        body,
        userId,
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
* Update a measurement
* Update a previously submitted measurement
*
* body MeasurementUpdate The id as well as the new startTime, note, and/or value of the measurement to be updated
* returns CommonResponse
* */
const updateMeasurement = ({ body }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        body,
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
  deleteMeasurement,
  getMeasurements,
  measurementExportRequest,
  measurementSpreadsheetUpload,
  postMeasurements,
  updateMeasurement,
};
