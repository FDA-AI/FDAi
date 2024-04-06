/* eslint-disable no-unused-vars */
const Service = require('./Service');

/**
* Create a Study
* Create an individual, group, or population study examining the relationship between a predictor and outcome variable. You will be given a study id which you can invite participants to join and share their measurements for the specified variables.
*
* body StudyCreationBody Details about the study you want to create
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* returns PostStudyCreateResponse
* */
const createStudy = ({ body, clientId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        body,
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
* Delete vote
* Delete previously posted vote
*
* userId BigDecimal User's id (optional)
* returns CommonResponse
* */
const deleteVote = ({ userId }) => new Promise(
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
* These are open studies that anyone can join
* These are studies that anyone can join and share their data for the predictor and outcome variables of interest.
*
* causeVariableName String Deprecated: Name of the hypothetical predictor variable.  Ex: Sleep Duration (optional)
* effectVariableName String Deprecated: Name of the outcome variable of interest.  Ex: Overall Mood (optional)
* userId BigDecimal User's id (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* includeCharts Boolean Highcharts configs that can be used if you have highcharts.js included on the page.  This only works if the id or name query parameter is also provided. (optional)
* recalculate Boolean Recalculate instead of using cached analysis (optional)
* studyId String Client id for the study you want (optional)
* returns GetStudiesResponse
* */
const getOpenStudies = ({ causeVariableName, effectVariableName, userId, clientId, includeCharts, recalculate, studyId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        causeVariableName,
        effectVariableName,
        userId,
        clientId,
        includeCharts,
        recalculate,
        studyId,
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
* Get Personal or Population Studies
* If you have enough data, this will be a list of your personal studies, otherwise it will consist of aggregated population studies.
*
* causeVariableName String Deprecated: Name of the hypothetical predictor variable.  Ex: Sleep Duration (optional)
* effectVariableName String Deprecated: Name of the outcome variable of interest.  Ex: Overall Mood (optional)
* userId BigDecimal User's id (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* includeCharts Boolean Highcharts configs that can be used if you have highcharts.js included on the page.  This only works if the id or name query parameter is also provided. (optional)
* recalculate Boolean Recalculate instead of using cached analysis (optional)
* studyId String Client id for the study you want (optional)
* sort String Sort by one of the listed field names. If the field name is prefixed with `-`, it will sort in descending order. (optional)
* limit Integer The LIMIT is used to limit the number of results returned. So if youhave 1000 results, but only want to the first 10, you would set this to 10 and offset to 0. The maximum limit is 200 records. (optional)
* offset Integer OFFSET says to skip that many rows before beginning to return rows to the client. OFFSET 0 is the same as omitting the OFFSET clause.If both OFFSET and LIMIT appear, then OFFSET rows are skipped before starting to count the LIMIT rows that are returned. (optional)
* correlationCoefficient String Pearson correlation coefficient between cause and effect after lagging by onset delay and grouping by duration of action (optional)
* updatedAt String When the record was last updated. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* outcomesOfInterest Boolean Only include user_variable_relationships for which the effect is an outcome of interest for the user (optional)
* principalInvestigatorUserId Integer These are studies created by a specific principal investigator (optional)
* open Boolean These are studies that anyone can join (optional)
* joined Boolean These are studies that you have joined (optional)
* created Boolean These are studies that you have created (optional)
* aggregated Boolean These are aggregated n=1 studies based on the entire population of users that have shared their data (optional)
* downvoted Boolean These are studies that you have down-voted (optional)
* returns GetStudiesResponse
* */
const getStudies = ({ causeVariableName, effectVariableName, userId, clientId, includeCharts, recalculate, studyId, sort, limit, offset, correlationCoefficient, updatedAt, outcomesOfInterest, principalInvestigatorUserId, open, joined, created, aggregated, downvoted }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        causeVariableName,
        effectVariableName,
        userId,
        clientId,
        includeCharts,
        recalculate,
        studyId,
        sort,
        limit,
        offset,
        correlationCoefficient,
        updatedAt,
        outcomesOfInterest,
        principalInvestigatorUserId,
        open,
        joined,
        created,
        aggregated,
        downvoted,
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
* Get studies you have created
* These are studies that you have created.
*
* causeVariableName String Deprecated: Name of the hypothetical predictor variable.  Ex: Sleep Duration (optional)
* effectVariableName String Deprecated: Name of the outcome variable of interest.  Ex: Overall Mood (optional)
* sort String Sort by one of the listed field names. If the field name is prefixed with `-`, it will sort in descending order. (optional)
* limit Integer The LIMIT is used to limit the number of results returned. So if youhave 1000 results, but only want to the first 10, you would set this to 10 and offset to 0. The maximum limit is 200 records. (optional)
* offset Integer OFFSET says to skip that many rows before beginning to return rows to the client. OFFSET 0 is the same as omitting the OFFSET clause.If both OFFSET and LIMIT appear, then OFFSET rows are skipped before starting to count the LIMIT rows that are returned. (optional)
* userId BigDecimal User's id (optional)
* updatedAt String When the record was last updated. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* returns GetStudiesResponse
* */
const getStudiesCreated = ({ causeVariableName, effectVariableName, sort, limit, offset, userId, updatedAt, clientId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        causeVariableName,
        effectVariableName,
        sort,
        limit,
        offset,
        userId,
        updatedAt,
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
* Studies You Have Joined
* These are studies that you are currently sharing your data with.
*
* causeVariableName String Deprecated: Name of the hypothetical predictor variable.  Ex: Sleep Duration (optional)
* effectVariableName String Deprecated: Name of the outcome variable of interest.  Ex: Overall Mood (optional)
* sort String Sort by one of the listed field names. If the field name is prefixed with `-`, it will sort in descending order. (optional)
* limit Integer The LIMIT is used to limit the number of results returned. So if youhave 1000 results, but only want to the first 10, you would set this to 10 and offset to 0. The maximum limit is 200 records. (optional)
* offset Integer OFFSET says to skip that many rows before beginning to return rows to the client. OFFSET 0 is the same as omitting the OFFSET clause.If both OFFSET and LIMIT appear, then OFFSET rows are skipped before starting to count the LIMIT rows that are returned. (optional)
* userId BigDecimal User's id (optional)
* correlationCoefficient String Pearson correlation coefficient between cause and effect after lagging by onset delay and grouping by duration of action (optional)
* updatedAt String When the record was last updated. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* outcomesOfInterest Boolean Only include user_variable_relationships for which the effect is an outcome of interest for the user (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* returns GetStudiesResponse
* */
const getStudiesJoined = ({ causeVariableName, effectVariableName, sort, limit, offset, userId, correlationCoefficient, updatedAt, outcomesOfInterest, clientId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        causeVariableName,
        effectVariableName,
        sort,
        limit,
        offset,
        userId,
        correlationCoefficient,
        updatedAt,
        outcomesOfInterest,
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
* Get Study
* Get Study
*
* causeVariableName String Deprecated: Name of the hypothetical predictor variable.  Ex: Sleep Duration (optional)
* effectVariableName String Deprecated: Name of the outcome variable of interest.  Ex: Overall Mood (optional)
* userId BigDecimal User's id (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* includeCharts Boolean Highcharts configs that can be used if you have highcharts.js included on the page.  This only works if the id or name query parameter is also provided. (optional)
* recalculate Boolean Recalculate instead of using cached analysis (optional)
* studyId String Client id for the study you want (optional)
* returns Study
* */
const getStudy = ({ causeVariableName, effectVariableName, userId, clientId, includeCharts, recalculate, studyId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        causeVariableName,
        effectVariableName,
        userId,
        clientId,
        includeCharts,
        recalculate,
        studyId,
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
* Join a Study
* Anonymously share measurements for specified variables
*
* studyId String Client id for the study you want (optional)
* causeVariableName String Deprecated: Name of the hypothetical predictor variable.  Ex: Sleep Duration (optional)
* effectVariableName String Deprecated: Name of the outcome variable of interest.  Ex: Overall Mood (optional)
* userId BigDecimal User's id (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* returns StudyJoinResponse
* */
const joinStudy = ({ studyId, causeVariableName, effectVariableName, userId, clientId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        studyId,
        causeVariableName,
        effectVariableName,
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
/**
* Post or update vote
* I am really good at finding user_variable_relationships and even compensating for various onset delays and durations of action. However, you are much better than me at knowing if there's a way that a given factor could plausibly influence an outcome. You can help me learn and get better at my predictions by pressing the thumbs down button for relationships that you think are coincidences and thumbs up once that make logic sense.
*
* body Vote Contains the cause variable, effect variable, and vote value.
* userId BigDecimal User's id (optional)
* returns CommonResponse
* */
const postVote = ({ body, userId }) => new Promise(
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
* Publish Your Study
* Make a study and all related measurements publicly visible by anyone
*
* causeVariableName String Deprecated: Name of the hypothetical predictor variable.  Ex: Sleep Duration (optional)
* effectVariableName String Deprecated: Name of the outcome variable of interest.  Ex: Overall Mood (optional)
* userId BigDecimal User's id (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* includeCharts Boolean Highcharts configs that can be used if you have highcharts.js included on the page.  This only works if the id or name query parameter is also provided. (optional)
* recalculate Boolean Recalculate instead of using cached analysis (optional)
* studyId String Client id for the study you want (optional)
* returns PostStudyPublishResponse
* */
const publishStudy = ({ causeVariableName, effectVariableName, userId, clientId, includeCharts, recalculate, studyId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        causeVariableName,
        effectVariableName,
        userId,
        clientId,
        includeCharts,
        recalculate,
        studyId,
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
  createStudy,
  deleteVote,
  getOpenStudies,
  getStudies,
  getStudiesCreated,
  getStudiesJoined,
  getStudy,
  joinStudy,
  postVote,
  publishStudy,
};
