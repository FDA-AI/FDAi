const fs = require('fs');
const path = require('path');
const mime = require('mime-types');
const { S3Client, PutObjectCommand } = require('@aws-sdk/client-s3');
const { Upload } = require('@aws-sdk/lib-storage');

// Configure your AWS details
const s3Client = new S3Client({
  region: process.env.AWS_REGION, // e.g., 'us-east-1'
});

const bucketName = process.env.BUCKET_NAME;
const localDir = 'apps/dfda-1/public/app/public'; // Local directory to upload

// Function to upload a file to S3
async function uploadFile(filePath, fileKey) {
  const contentType = mime.lookup(filePath) || 'application/octet-stream';
  try {
    const fileStream = fs.createReadStream(filePath);
    const uploadParams = {
      Bucket: bucketName,
      Key: fileKey,
      Body: fileStream,
      ContentType: contentType,
    };
    const parallelUploads3 = new Upload({
      client: s3Client,
      params: uploadParams,
    });

    await parallelUploads3.done();
    console.log(`Uploaded ${fileKey} successfully.`);
  } catch (err) {
    console.error("Error uploading file:", err);
  }
}

// Function to recursively read a directory and upload its contents
function uploadDirectory(directoryPath, s3PathPrefix = '') {
  fs.readdir(directoryPath, { withFileTypes: true }, (err, items) => {
    if (err) {
      console.error("Error reading directory:", err);
      return;
    }

    items.forEach(item => {
      const localPath = path.join(directoryPath, item.name);
      const s3Key = path.join(s3PathPrefix, item.name);

      if (item.isDirectory()) {
        uploadDirectory(localPath, s3Key); // Recursively upload directories
      } else {
        uploadFile(localPath, s3Key); // Upload files
      }
    });
  });
}

// Start the upload process
uploadDirectory(localDir);
