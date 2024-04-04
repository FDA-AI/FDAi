const sqlite3 = require('sqlite3').verbose();
const mysql = require('mysql2/promise');



// Open the SQLite database
let db = new sqlite3.Database('./test_db.sqlite', sqlite3.OPEN_READONLY, (err) => {
  if (err) {
    console.error(err.message);
  }
  console.log('Connected to the SQLite database.');
});

const path = require('path');
require('dotenv').config({ path: path.resolve(__dirname, '../.env') });
const url = require('url');
let DATABASE_URL = process.env.DATABASE_URL;
// Parse the DATABASE_URL
let dbUrl = url.parse(DATABASE_URL);

// Extract the user and password from the auth string
let [user, password] = dbUrl.auth.split(':');

// Extract the database name from the pathname
let database = dbUrl.pathname.replace('/', '');

// Extract the host and port from the host string
let [host, port] = dbUrl.host.split(':');

// Now you can use these variables to connect to your database
mysql.createConnection({
  host: host,
  port: port,
  user: user,
  password: password,
  database: database
}).then((conn) => {
  console.log('Connected to the MySQL database.');

  // Query the SQLite database for all table names
db.all("SELECT name FROM sqlite_master WHERE type='table'", [], (err, tables) => {
  if (err) {
    throw err;
  }

  // For each table in the SQLite database
  tables.forEach((table) => {
    // Query the SQLite database for all rows in the current table
    db.all(`SELECT * FROM ${table.name}`, [], (err, rows) => {
      if (err) {
        throw err;
      }

      // For each row in the SQLite database, insert it into the MySQL database
      rows.forEach((row) => {
        conn.query(`INSERT INTO ${table.name} SET ?`, row, (err, res) => {
          if (err) throw err;
          console.log(`Inserted: ${res.insertId}`);
        });
      });
    });
  });
});

  // Close the SQLite database connection
  db.close((err) => {
    if (err) {
      console.error(err.message);
    }
    console.log('Close the SQLite database connection.');
  });
}).catch((err) => {
  console.error('Unable to connect to the MySQL database: ', err);
});
