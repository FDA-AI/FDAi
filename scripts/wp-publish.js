const fs = require('fs');
const path = require('path');
const axios = require('axios');
const dotenv = require('dotenv');
const markdownIt = require('markdown-it');
const slugify = require('slugify');

// Load environment variables
function loadEnvironmentVariables() {
  const envFilePath = path.resolve(__dirname, '..', '.env');
  if (fs.existsSync(envFilePath)) {
    dotenv.config({ path: envFilePath });
    console.log('.env file loaded successfully.');
  } else {
    console.log('.env file not found. Environment variables will be loaded from the environment.');
  }
}

// Load environment variables
loadEnvironmentVariables();

// Function to read Markdown files in a folder
function readMarkdownFiles(folderPath) {
  return fs.readdirSync(folderPath).filter(file => file.endsWith('.md'));
}

// Function to format the title
function formatTitle(filename) {
  return filename
    .replace(/-/g, ' ')
    .replace(/\b\w/g, c => c.toUpperCase());
}

// Function to convert Markdown to HTML
function convertMarkdownToHTML(markdownContent) {
  const md = new markdownIt();
  return md.render(markdownContent);
}

// Function to handle errors when creating or updating WordPress pages
function handleWordPressPageError(error, requestData) {
  console.error('Error creating or updating WordPress pages:');
  if (error.response && error.response.data) {
    console.error('Response data:', error.response.data);
  } else if (error.request) {
    console.error('Request method:', requestData.method);
    console.error('Request URL:', requestData.url);
    if (requestData.headers) {
      console.error('Request headers:', requestData.headers);
    }
    if (requestData.body) {
      console.error('Request body:', requestData.body);
    }
    console.error('Error making request to WordPress:', error.request);
  } else {
    console.error('Error processing WordPress request:', error.message);
  }
}

// Function to create or update WordPress pages
async function createOrUpdateWordPressPages(pagesData) {
  const wordpressURL = process.env.WORDPRESS_SITE_URL;
  const username = process.env.WORDPRESS_USERNAME;
  const password = process.env.WORDPRESS_PASSWORD;

  try {
    // Get authentication token from WordPress
    const authResponse = await axios.post(`${wordpressURL}/wp-json/jwt-auth/v1/token`, {
      username,
      password
    });
    const authToken = authResponse.data.token;

    // Set authentication headers
    const headers = {
      'Authorization': `Bearer ${authToken}`,
      'Content-Type': 'application/json'
    };

    // Create or update WordPress pages
    for (const pageData of pagesData) {
      const { title, content, slug } = pageData; // Destructure pageData to get title, content, and slug
      try {
        // Check if the page exists
        const pageExistsResponse = await axios.get(`${wordpressURL}/wp-json/wp/v2/pages?slug=${slug}`, { headers });

        if (pageExistsResponse.data.length > 0) {
          // Update existing page
          const pageID = pageExistsResponse.data[0].id;
          await axios.post(`${wordpressURL}/wp-json/wp/v2/pages/${pageID}`, { title, content }, { headers });
          console.log(`Page '${title}' updated successfully.`);
        } else {
          // Create new page
          await axios.post(`${wordpressURL}/wp-json/wp/v2/pages`, { title, content, slug }, { headers });
          console.log(`Page '${title}' created successfully.`);
        }
      } catch (error) {
        console.error(`Error processing page '${title}':`, error.response ? error.response.data : error.message);
      }
    }
  } catch (error) {
    console.error('Error authenticating with WordPress:', error.response ? error.response.data : error.message);
  }
}


// Main function to process Markdown files and create/update WordPress pages
function processMarkdownFiles(folderPath) {
  const markdownFiles = readMarkdownFiles(folderPath);
  const pagesData = [];

  markdownFiles.forEach(markdownFile => {
    const markdownFilePath = path.join(folderPath, markdownFile);
    const markdownContent = fs.readFileSync(markdownFilePath, 'utf-8');
    const pageTitle = formatTitle(path.basename(markdownFile, path.extname(markdownFile)));
    const pageContent = convertMarkdownToHTML(markdownContent);
    pagesData.push({ title: pageTitle, content: pageContent });
  });

  createOrUpdateWordPressPages(pagesData);
}

// Usage: Provide the folder path containing Markdown files as argument
const folderPath = path.resolve(__dirname, '..', process.env.WP_MARKDOWN_FOLDER_PATH);
processMarkdownFiles(folderPath);
