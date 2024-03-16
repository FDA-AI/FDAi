const { Octokit } = require("@octokit/rest");

process.env.GITHUB_TOKEN = 'TOKEN HERE';
process.env.GITHUB_REPOSITORY = 'FDA-AI/FDAi';
process.env.ISSUE_NUMBER = '1';

const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN });

async function postComment(owner, repo, issue_number, body) {
  await octokit.rest.issues.createComment({
    owner,
    repo,
    issue_number,
    body,
  });
}

const [owner, repo] = process.env.GITHUB_REPOSITORY.split("/");
const issueNumber = parseInt(process.env.ISSUE_NUMBER, 10);
const commentBody = "This is a comment made by a script 🤖";

postComment(owner, repo, issueNumber, commentBody)
  .then(() => console.log("Comment posted successfully."))
  .catch(error => console.error("Failed to post comment:", error));
