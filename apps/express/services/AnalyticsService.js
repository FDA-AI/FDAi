/* eslint-disable no-unused-vars */
const Service = require('./Service');

/**
* Get user_variable_relationships
* Get a list of user_variable_relationships that can be used to display top predictors of a given outcome like mood, for instance.
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
* commonOnly Boolean Return only public, anonymized and aggregated population data instead of user-specific variables (optional)
* returns GetCorrelationsResponse
* */
const getCorrelations = ({ causeVariableName, effectVariableName, sort, limit, offset, userId, correlationCoefficient, updatedAt, outcomesOfInterest, clientId, commonOnly }) => new Promise(
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
        commonOnly,
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
  getCorrelations,
};
