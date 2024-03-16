const fs = require('fs');
const path = require('path');
const { S3Client, GetObjectCommand, ListObjectsV2Command } = require('@aws-sdk/client-s3');
let env = process.env;
let envPath = fs.existsSync(path.resolve(__dirname, '.env')) ? '.env' : '../.env';
require('dotenv').config({ path: envPath});

if(!env.AWS_REGION || !env.BUCKET_NAME || !env.AWS_ACCESS_KEY_ID || !env.AWS_SECRET_ACCESS_KEY) {
  console.error("Please set the AWS_REGION, BUCKET_NAME, AWS_ACCESS_KEY_ID, and AWS_SECRET_ACCESS_KEY environment variables.");
  process.exit(1);
}

// Configure your AWS details
const s3Client = new S3Client({
  region: env.AWS_REGION, // e.g., 'us-east-1'
});

const bucketName = env.BUCKET_NAME;
const localDir = '../apps/dfda-1/public/app/public'; // Local directory to download to

// Function to download a file from S3
async function downloadFile(fileKey, filePath) {
  try {
    const downloadParams = {
      Bucket: bucketName,
      Key: fileKey,
    };

    const { Body } = await s3Client.send(new GetObjectCommand(downloadParams));
    const fileStream = fs.createWriteStream(filePath);

    Body.pipe(fileStream);

    Body.on('error', (err) => {
      console.error(`File Stream Error: ${err}`);
    });

    fileStream.on('finish', () => {
      console.log(`Downloaded ${fileKey} successfully.`);
    });
  } catch (err) {
    console.error("Error downloading file:", err);
  }
}

// Function to recursively create a directory and download its contents
function downloadDirectory(s3PathPrefix = '', directoryPath) {
  const listParams = {
    Bucket: bucketName,
    Prefix: s3PathPrefix,
  };

  s3Client.send(new ListObjectsV2Command(listParams))
    .then((data) => {
      if (!data.Contents) {
        console.log('No objects found.');
        return;
      }

      data.Contents.forEach((item) => {
        const fileKey = item.Key;
        const filePath = path.join(directoryPath, fileKey);

        if (!fs.existsSync(path.dirname(filePath))) {
          fs.mkdirSync(path.dirname(filePath), { recursive: true });
        }

        downloadFile(fileKey, filePath);
      });
    })
    .catch((err) => {
      console.error("Error listing objects:", err);
    });
}

// Start the download process
downloadDirectory('video', localDir);
