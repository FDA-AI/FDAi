/* eslint-disable no-unused-vars */
const Service = require('./Service');

/**
* Delete user tag or ingredient
* Delete previously created user tags or ingredients.
*
* taggedVariableId Integer Id of the tagged variable (i.e. Lollipop) you would like to get variables it can be tagged with (i.e. Sugar).  Converted measurements of the tagged variable are included in analysis of the tag variable (i.e. ingredient). (optional)
* tagVariableId Integer Id of the tag variable (i.e. Sugar) you would like to get variables it can be tagged to (i.e. Lollipop).  Converted measurements of the tagged variable are included in analysis of the tag variable (i.e. ingredient). (optional)
* returns CommonResponse
* */
const deleteUserTag = ({ taggedVariableId, tagVariableId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        taggedVariableId,
        tagVariableId,
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
* Delete All Measurements For Variable
* Users can delete all of their measurements for a variable
*
* no response value expected for this operation
* */
const deleteUserVariable = () => new Promise(
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
* Variable categories
* The variable categories include Activity, Causes of Illness, Cognitive Performance, Conditions, Environment, Foods, Location, Miscellaneous, Mood, Nutrition, Physical Activity, Physique, Sleep, Social Interactions, Symptoms, Treatments, Vital Signs, and Goals.
*
* returns List
* */
const getVariableCategories = () => new Promise(
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
* Get variables along with related user-specific analysis settings and statistics
* Get variables. If the user has specified variable settings, these are provided instead of the common variable defaults.
*
* includeCharts Boolean Highcharts configs that can be used if you have highcharts.js included on the page.  This only works if the id or name query parameter is also provided. (optional)
* numberOfRawMeasurements String Filter variables by the total number of measurements that they have. This could be used of you want to filter or sort by popularity. (optional)
* userId BigDecimal User's id (optional)
* variableCategoryName String Ex: Emotions, Treatments, Symptoms... (optional)
* name String Name of the variable. To get results matching a substring, add % as a wildcard as the first and/or last character of a query string parameter. In order to get variables that contain `Mood`, the following query should be used: ?variableName=%Mood% (optional)
* variableName String Name of the variable you want measurements for (optional)
* updatedAt String When the record was last updated. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* sourceName String ID of the source you want measurements for (supports exact name match only) (optional)
* earliestMeasurementTime String Excluded records with measurement times earlier than this value. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss  datetime format. Time zone should be UTC and not local. (optional)
* latestMeasurementTime String Excluded records with measurement times later than this value. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss  datetime format. Time zone should be UTC and not local. (optional)
* id Integer Common variable id (optional)
* lastSourceName String Limit variables to those which measurements were last submitted by a specific source. So if you have a client application and you only want variables that were last updated by your app, you can include the name of your app here (optional)
* limit Integer The LIMIT is used to limit the number of results returned. So if youhave 1000 results, but only want to the first 10, you would set this to 10 and offset to 0. The maximum limit is 200 records. (optional)
* offset Integer OFFSET says to skip that many rows before beginning to return rows to the client. OFFSET 0 is the same as omitting the OFFSET clause.If both OFFSET and LIMIT appear, then OFFSET rows are skipped before starting to count the LIMIT rows that are returned. (optional)
* sort String Sort by one of the listed field names. If the field name is prefixed with `-`, it will sort in descending order. (optional)
* includePublic Boolean Include variables the user has no measurements for (optional)
* manualTracking Boolean Only include variables tracked manually by the user (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* upc String UPC or other barcode scan result (optional)
* effectOrCause String Provided variable is the effect or cause (optional)
* publicEffectOrCause String Ex:  (optional)
* exactMatch Boolean Require exact match (optional)
* variableCategoryId Integer Ex: 13 (optional)
* includePrivate Boolean Include user-specific variables in results (optional)
* searchPhrase String Ex: %Body Fat% (optional)
* synonyms String Ex: McDonalds hotcake (optional)
* taggedVariableId Integer Id of the tagged variable (i.e. Lollipop) you would like to get variables it can be tagged with (i.e. Sugar).  Converted measurements of the tagged variable are included in analysis of the tag variable (i.e. ingredient). (optional)
* tagVariableId Integer Id of the tag variable (i.e. Sugar) you would like to get variables it can be tagged to (i.e. Lollipop).  Converted measurements of the tagged variable are included in analysis of the tag variable (i.e. ingredient). (optional)
* joinVariableId Integer Id of the variable you would like to get variables that can be joined to.  This is used to merge duplicate variables.   If joinVariableId is specified, this returns only variables eligible to be joined to the variable specified by the joinVariableId. (optional)
* parentUserTagVariableId Integer Id of the parent category variable (i.e. Fruit) you would like to get eligible child sub-type variables (i.e. Apple) for.  Child variable measurements will be included in analysis of the parent variable.  For instance, a child sub-type of the parent category Fruit could be Apple.  When Apple is tagged with the parent category Fruit, Apple measurements will be included when Fruit is analyzed. (optional)
* childUserTagVariableId Integer Id of the child sub-type variable (i.e. Apple) you would like to get eligible parent variables (i.e. Fruit) for.  Child variable measurements will be included in analysis of the parent variable.  For instance, a child sub-type of the parent category Fruit could be Apple. When Apple is tagged with the parent category Fruit, Apple measurements will be included when Fruit is analyzed. (optional)
* ingredientUserTagVariableId Integer Id of the ingredient variable (i.e. Fructose)  you would like to get eligible ingredientOf variables (i.e. Apple) for.  IngredientOf variable measurements will be included in analysis of the ingredient variable.  For instance, a ingredientOf of variable Fruit could be Apple. (optional)
* ingredientOfUserTagVariableId Integer Id of the ingredientOf variable (i.e. Apple) you would like to get eligible ingredient variables (i.e. Fructose) for.  IngredientOf variable measurements will be included in analysis of the ingredient variable.  For instance, a ingredientOf of variable Fruit could be Apple. (optional)
* commonOnly Boolean Return only public and aggregated common variable data instead of user-specific variables (optional)
* userOnly Boolean Return only user-specific variables and data, excluding common aggregated variable data (optional)
* includeTags Boolean Return parent, child, duplicate, and ingredient variables (optional)
* recalculate Boolean Recalculate instead of using cached analysis (optional)
* variableId Integer Ex: 13 (optional)
* concise Boolean Only return field required for variable auto-complete searches.  The smaller size allows for storing more variable results locally reducing API requests. (optional)
* refresh Boolean Regenerate charts instead of getting from the cache (optional)
* returns List
* */
const getVariables = ({ includeCharts, numberOfRawMeasurements, userId, variableCategoryName, name, variableName, updatedAt, sourceName, earliestMeasurementTime, latestMeasurementTime, id, lastSourceName, limit, offset, sort, includePublic, manualTracking, clientId, upc, effectOrCause, publicEffectOrCause, exactMatch, variableCategoryId, includePrivate, searchPhrase, synonyms, taggedVariableId, tagVariableId, joinVariableId, parentUserTagVariableId, childUserTagVariableId, ingredientUserTagVariableId, ingredientOfUserTagVariableId, commonOnly, userOnly, includeTags, recalculate, variableId, concise, refresh }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        includeCharts,
        numberOfRawMeasurements,
        userId,
        variableCategoryName,
        name,
        variableName,
        updatedAt,
        sourceName,
        earliestMeasurementTime,
        latestMeasurementTime,
        id,
        lastSourceName,
        limit,
        offset,
        sort,
        includePublic,
        manualTracking,
        clientId,
        upc,
        effectOrCause,
        publicEffectOrCause,
        exactMatch,
        variableCategoryId,
        includePrivate,
        searchPhrase,
        synonyms,
        taggedVariableId,
        tagVariableId,
        joinVariableId,
        parentUserTagVariableId,
        childUserTagVariableId,
        ingredientUserTagVariableId,
        ingredientOfUserTagVariableId,
        commonOnly,
        userOnly,
        includeTags,
        recalculate,
        variableId,
        concise,
        refresh,
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
* Post or update user tags or ingredients
* This endpoint allows users to tag foods with their ingredients.  This information will then be used to infer the user intake of the different ingredients by just entering the foods. The inferred intake levels will then be used to determine the effects of different nutrients on the user during analysis.
*
* body UserTag Contains the new user tag data
* userId BigDecimal User's id (optional)
* returns CommonResponse
* */
const postUserTags = ({ body, userId }) => new Promise(
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
* Update User Settings for a Variable
* Users can change the parameters used in analysis of that variable such as the expected duration of action for a variable to have an effect, the estimated delay before the onset of action. In order to filter out erroneous data, they are able to set the maximum and minimum reasonable daily values for a variable.
*
* variable List Variable user settings data
* includePrivate Boolean Include user-specific variables in results (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* includePublic Boolean Include variables the user has no measurements for (optional)
* searchPhrase String Ex: %Body Fat% (optional)
* exactMatch Boolean Require exact match (optional)
* manualTracking Boolean Only include variables tracked manually by the user (optional)
* variableCategoryName String Ex: Emotions, Treatments, Symptoms... (optional)
* variableCategoryId Integer Ex: 13 (optional)
* synonyms String Ex: McDonalds hotcake (optional)
* returns CommonResponse
* */
const postUserVariables = ({ variable, includePrivate, clientId, includePublic, searchPhrase, exactMatch, manualTracking, variableCategoryName, variableCategoryId, synonyms }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        variable,
        includePrivate,
        clientId,
        includePublic,
        searchPhrase,
        exactMatch,
        manualTracking,
        variableCategoryName,
        variableCategoryId,
        synonyms,
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
* Reset user settings for a variable to defaults
* Reset user settings for a variable to defaults
*
* userVariableDelete UserVariableDelete Id of the variable whose measurements should be deleted
* no response value expected for this operation
* */
const resetUserVariableSettings = ({ userVariableDelete }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        userVariableDelete,
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
  deleteUserTag,
  deleteUserVariable,
  getVariableCategories,
  getVariables,
  postUserTags,
  postUserVariables,
  resetUserVariableSettings,
};
