// import * as api from "../typescript-node-client/api"
import * as env from "./env-helper"
import * as fileHelper from "./qm.file-helper"
import * as qmLog from "./qm.log"
import * as timeHelper from "./qm.time-helper"
import * as testHelpers from "./test-helpers"

// tslint:disable-next-line:no-var-requires
const qm = require("../public/js/qmHelpers.js")
env.loadEnvFromDopplerOrDotEnv(".env")
function isTruthy(value: string | undefined) {return (value && value !== "false")}
function getRequestOptions(path: string) {
    const options = {
        headers: {"User-Agent": "Request-Promise", "Content-Type": "application/json"},
        json: true, // Automatically parses the JSON string in the response
        qs: {
            access_token: env.getAccessToken(),
            allStaticAppData: true,
            clientId: env.getQMClientIdOrException(),
            includeClientSecret: true,
        },
        uri: qm.getAppHostName() + path,
    }
    if(options.qs.access_token) {
        qmLog.info("Using CUREDAO_PERSONAL_ACCESS_TOKEN: " + options.qs.access_token.substring(0,4)+"...")
    } else {
        qmLog.error("Please add your CUREDAO_PERSONAL_ACCESS_TOKEN environmental variable from " + env.getAppHostName()
            + "/api/v2/account")
    }
    return options
}
function getBuildInfo() {
    return {
        androidVersionCode : qm.buildInfoHelper.buildInfo.versionNumbers.androidVersionCode,
        buildLink : testHelpers.getBuildLink(),
        buildServer : qmLog.getCurrentServerContext(),
        builtAt : timeHelper.getUnixTimestampInSeconds(),
        debugMode : isTruthy(process.env.APP_DEBUG),
        versionNumber : qm.buildInfoHelper.buildInfo.versionNumbers.ionicApp,
    }
}
export function saveAppSettings() {
    qm.appsManager.getAppSettingsFromApi(env.getQMClientIdOrException(),
        function(AppSettingsResponse: { staticData: any }) {
            qm.staticData = AppSettingsResponse.staticData
            const as: any = qm.staticData.appSettings
            process.env.APP_DISPLAY_NAME = as.name  // Need env for Fastlane
            process.env.APP_IDENTIFIER = as.additionalSettings.appIds.appIdentifier  // Need env for Fastlane
            function addBuildInfoToAppSettings() {
                as.buildServer = qmLog.getCurrentServerContext()
                as.buildLink = testHelpers.getBuildLink()
                as.versionNumber = qm.buildInfoHelper.buildInfo.versionNumbers.ionicApp
                as.androidVersionCode = qm.buildInfoHelper.buildInfo.versionNumbers.androidVersionCode
                as.debugMode = isTruthy(process.env.APP_DEBUG)
                as.builtAt = timeHelper.getUnixTimestampInSeconds()
            }

            addBuildInfoToAppSettings()
            qmLog.info("Got app settings for " + as.appDisplayName + ". You can change your app settings at " +
                getAppEditUrl())
            const url = env.getAppHostName()
            if(url) {
                as.apiOrigin = url.replace("https://", "")
            }
            return writeAppSettingsToFile(qm.staticData.appSettings)
        }).catch(function(error: string) {
            qmLog.error(error)
        })
}
function getAppEditUrl() {
    return getAppsListUrl() + "?clientId=" + qm.getClientId()
}
function getAppsListUrl() {
    return "https://builder.quantimo.do/#/app/configuration"
}
function getAppDesignerUrl() {
    return "https://builder.quantimo.do/#/app/configuration?clientId=" + qm.getClientId()
}

export function writeAppSettingsToFile(appSettings: any | undefined) {
    qm.staticData = qm.staticData || {}
    qm.staticData.buildInfo = getBuildInfo()
    appSettings = appSettings || qm.staticData.appSettings
    const content =
        `// noinspection DuplicatedCode
if(typeof qm === "undefined"){if(typeof window === "undefined") {global.qm = {}; }else{window.qm = {};}}
if(typeof qm.staticData === "undefined"){qm.staticData = {};}
qm.staticData.appSettings = `+ qmLog.prettyJSONStringify(appSettings)
    try {
        fileHelper.writeToFile(env.paths.www.appSettings, content)
    } catch(e) {
        // @ts-ignore
        qmLog.error(e.message + ".  Maybe www/data doesn't exist but it might be resolved when we copy from public")
    }
    try {
        fileHelper.writeToFile("build/chrome_extension/data/appSettings.js", content)
    } catch(e) {
        // @ts-ignore
        qmLog.error(e.message + ".  Maybe build/chrome_extension/data doesn't exist but it might be resolved when we copy from public")
    }
    return fileHelper.writeToFile(env.paths.src.appSettings, content)
}
