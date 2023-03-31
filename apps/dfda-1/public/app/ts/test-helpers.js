"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.releaseStage = exports.getReleaseStage = exports.getApiOrigin = exports.apiOrigins = exports.releaseStages = exports.getCiProvider = exports.deleteEnvFile = exports.deleteSuccessFile = exports.createSuccessFile = exports.getBuildLink = void 0;
var rimraf_1 = __importDefault(require("rimraf"));
var qmEnv = __importStar(require("./env-helper"));
var fileHelper = __importStar(require("./qm.file-helper"));
var qmGit = __importStar(require("./qm.git"));
var qmLog = __importStar(require("./qm.log"));
// tslint:disable-next-line:no-var-requires
var qm = require("../public/js/qmHelpers.js");
function getBuildLink() {
    if (process.env.BUILD_URL_FOR_STATUS) {
        return process.env.BUILD_URL_FOR_STATUS + "console";
    }
    if (process.env.BUILD_URL) {
        return process.env.BUILD_URL + "console";
    }
    if (process.env.BUDDYBUILD_APP_ID) {
        return "https://dashboard.buddybuild.com/apps/" + process.env.BUDDYBUILD_APP_ID + "/build/" +
            process.env.BUDDYBUILD_APP_ID;
    }
    if (process.env.CIRCLE_BUILD_NUM) {
        return "https://circleci.com/gh/curedao/curedao-web-android-chrome-ios-app-template/" +
            process.env.CIRCLE_BUILD_NUM;
    }
    if (process.env.TRAVIS_BUILD_ID) {
        return "https://travis-ci.org/" + process.env.TRAVIS_REPO_SLUG + "/builds/" + process.env.TRAVIS_BUILD_ID;
    }
}
exports.getBuildLink = getBuildLink;
var successFilename = "success-file";
function createSuccessFile() {
    return fileHelper.writeToFile("lastCommitBuilt", qmGit.getCurrentGitCommitSha())
        .then(function () {
        return fileHelper.createFile(successFilename, qmGit.getCurrentGitCommitSha());
    });
}
exports.createSuccessFile = createSuccessFile;
function deleteSuccessFile() {
    qmLog.info("Deleting success file so we know if build completed...");
    return fileHelper.deleteFile(successFilename);
}
exports.deleteSuccessFile = deleteSuccessFile;
function deleteEnvFile(cb) {
    (0, rimraf_1.default)(".env", function () {
        qmLog.info("Deleted env file!");
        if (cb) {
            cb();
        }
    });
}
exports.deleteEnvFile = deleteEnvFile;
function getCiProvider() {
    if (process.env.CIRCLE_BRANCH) {
        return "circleci";
    }
    if (process.env.BUDDYBUILD_BRANCH) {
        return "buddybuild";
    }
    if (process.env.JENKINS_URL) {
        return "jenkins";
    }
    // @ts-ignore
    return process.env.HOSTNAME;
}
exports.getCiProvider = getCiProvider;
exports.releaseStages = {
    development: "development",
    production: "production",
    staging: "staging",
};
exports.apiOrigins = {
    ionic: "https://app.quantimo.do",
    localhost: "http://localhost:80",
    production: "https://app.quantimo.do",
    staging: "https://staging.quantimo.do",
};
function getApiOrigin() {
    var url = qmEnv.getenv("QM_API_ORIGIN", null);
    if (url) {
        return url;
    }
    var stage = qmEnv.getenv("RELEASE_STAGE", null);
    if (stage) {
        // @ts-ignore
        if (typeof exports.apiOrigins[stage] !== "undefined") {
            // @ts-ignore
            return exports.apiOrigins[stage];
        }
        else {
            throw Error("apiOrigin not defined for RELEASE_STAGE: " + stage + "! Available ones are " +
                qm.stringHelper.prettyJsonStringify(exports.apiOrigins));
        }
    }
    console.info("Using https://app.quantimo.do as apiOrigin because QM_API_ORIGIN env not set and RELEASE_STAGE is ionic");
    return "https://app.quantimo.do";
}
exports.getApiOrigin = getApiOrigin;
function getReleaseStage() {
    var stage = qmEnv.getenv("RELEASE_STAGE", null);
    if (stage) {
        return stage;
    }
    var url = qmEnv.getenv("QM_API_ORIGIN", null);
    if (!url) {
        throw Error("Please set RELEASE_STAGE env");
    }
    if (url.indexOf("utopia.") !== -1) {
        return exports.releaseStages.development;
    }
    if (url.indexOf("production.") !== -1) {
        return exports.releaseStages.production;
    }
    if (url.indexOf("staging.") !== -1) {
        return exports.releaseStages.staging;
    }
    if (url.indexOf("app.") !== -1) {
        return exports.releaseStages.production;
    }
    throw Error("Please set RELEASE_STAGE env");
}
exports.getReleaseStage = getReleaseStage;
exports.releaseStage = {
    is: {
        production: function () {
            return getReleaseStage() === exports.releaseStages.production;
        },
        staging: function () {
            return getReleaseStage() === exports.releaseStages.staging;
        },
        development: function () {
            return getReleaseStage() === exports.releaseStages.development;
        },
    },
};
//# sourceMappingURL=test-helpers.js.map