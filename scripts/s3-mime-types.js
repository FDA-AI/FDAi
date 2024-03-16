// Load environment variables
require('dotenv').config({ path: '../.env' });

const { S3Client, ListObjectsV2Command, CopyObjectCommand } = require("@aws-sdk/client-s3");

// Initialize S3 client
const s3 = new S3Client({
  region: process.env.AWS_REGION,
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
  }
});

const bucketName = process.env.BUCKET_NAME;

// Function to get MIME type based on file extension
function getMimeType(fileName) {
  const extension = fileName.split('.').pop().toLowerCase();
  const mimeTypes = {
    js: 'application/javascript',
    css: 'text/css',
    gif: 'image/gif',
    png: 'image/png',
    jpg: 'image/jpeg',
    jpeg: 'image/jpeg',
    svg: 'image/svg+xml',
    mp4: 'video/mp4',
    html: 'text/html',
    // Add more MIME types as needed
  };

  return mimeTypes[extension] || 'application/octet-stream';
}

// Function to update the Content-Type for each object in the bucket
async function updateContentTypes() {
  try {
    let continuationToken;
    do {
      const listParams = {
        Bucket: bucketName,
        ContinuationToken: continuationToken,
      };

      // List objects in the bucket
      const listedObjects = await s3.send(new ListObjectsV2Command(listParams));

      for (const object of listedObjects.Contents) {
        if (!object.Key.endsWith('.css')) {
          continue;
        }
        const mimeType = getMimeType(object.Key);
        console.log(`Updating ${object.Key} to MIME type ${mimeType}`);

        // Copy object to itself with new metadata
        const copyParams = {
          Bucket: bucketName,
          CopySource: encodeURIComponent(`${bucketName}/${object.Key}`),
          Key: object.Key,
          MetadataDirective: 'REPLACE',
          ContentType: mimeType,
        };

        await s3.send(new CopyObjectCommand(copyParams));
      }

      continuationToken = listedObjects.NextContinuationToken;
    } while (continuationToken);
  } catch (error) {
    console.error("An error occurred:", error);
  }
}

// Run the update process
updateContentTypes();
