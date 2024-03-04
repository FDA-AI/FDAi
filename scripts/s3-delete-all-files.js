// Load the AWS SDK for Node.js
const { S3Client, ListObjectsV2Command, DeleteObjectsCommand } = require("@aws-sdk/client-s3");

// Load environment variables
require('dotenv').config({ path: '../.env' });

// Set up the AWS S3 client
const s3 = new S3Client({
  region: process.env.AWS_REGION,
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  },
});

const bucketName = process.env.BUCKET_NAME

// Function to delete all objects in the bucket
async function emptyS3Bucket() {
  try {
    const listedObjects = await s3.send(new ListObjectsV2Command({ Bucket: bucketName }));

    if (listedObjects.Contents.length === 0) return;

    const deleteParams = {
      Bucket: bucketName,
      Delete: { Objects: [] },
    };

    listedObjects.Contents.forEach(({ Key }) => {
      deleteParams.Delete.Objects.push({ Key });
    });

    await s3.send(new DeleteObjectsCommand(deleteParams));

    if (listedObjects.IsTruncated) await emptyS3Bucket(); // Recurse if there are more objects to delete
    console.log('All objects deleted successfully.');
  } catch (err) {
    console.error("Error:", err);
  }
}

// Run the function to empty the bucket
emptyS3Bucket();
