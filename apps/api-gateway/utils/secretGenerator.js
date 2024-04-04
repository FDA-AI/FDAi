const fs = require('fs');
const crypto = require('crypto');
const path = require('path');

function generateJwtSecret() {
    return crypto.randomBytes(32).toString('hex');
}

const envPath = path.resolve(__dirname, '../.env');
const env = fs.readFileSync(envPath, 'utf8');

if (env.includes('JWT_SECRET=Change_ME!!!')) {
    const newSecret = generateJwtSecret();
    const newEnv = env.replace('JWT_SECRET=Change_ME!!!', `JWT_SECRET=${newSecret}`);
    fs.writeFileSync(envPath, newEnv);
    console.log('JWT_SECRET has been updated in .env file');
} else {
    console.log('JWT_SECRET does not need to be updated');
}
