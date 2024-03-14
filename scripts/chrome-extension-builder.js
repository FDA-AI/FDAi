const fs = require('fs');
const path = require('path');

// Replace this with the actual client ID and app settings response
const clientId = 'your-client-id';
const appSettingsResponse = {
  appDisplayName: {
    name: 'New App Name',
    description: 'New App Description'
  }
};

const sourceDir = path.join(__dirname, 'apps', 'browser-extension');
const targetDir = path.join(__dirname, 'apps', `browser-extension-${clientId}`);

// Create the target directory if it doesn't exist
if (!fs.existsSync(targetDir)) {
  fs.mkdirSync(targetDir, { recursive: true });
}

const manifestPath = path.join(sourceDir, 'manifest.json');
const newManifestPath = path.join(targetDir, 'manifest.json');

fs.readFile(manifestPath, 'utf8', (err, data) => {
  if (err) throw err;

  const manifest = JSON.parse(data);

  // Update the manifest fields
  manifest.name = appSettingsResponse.appDisplayName.name;
  manifest.description = appSettingsResponse.appDisplayName.description;
  manifest.clientId = clientId;

  const updatedManifest = JSON.stringify(manifest, null, 2);

  fs.writeFile(newManifestPath, updatedManifest, 'utf8', (err) => {
    if (err) throw err;
    console.log('Manifest file has been updated successfully.');
  });
});
