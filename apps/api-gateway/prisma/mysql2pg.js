const mysql = require('mysql2/promise');
const { Client } = require('pg');
const fs = require('fs');
const path = require('path');
const dotenv = require('dotenv');
dotenv.config({ path: path.join(__dirname, '..', '.env') });

// MySQL connection configuration
const mysqlConfig = {
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DATABASE,
};

// PostgreSQL connection configuration
const postgresConfig = {
  host: process.env.POSTGRES_HOST,
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DATABASE,
};
async function exportMySQLToPostgreSQL() {
  const mysqlConnection = await mysql.createConnection(mysqlConfig);
  const postgresClient = new Client(postgresConfig);
  await postgresClient.connect();

  // Define an array of user ids that you want to import
  const userIds = [1]; // replace with your user ids

  try {
    // Get the list of tables in the MySQL database
    const [tables] = await mysqlConnection.query('SHOW TABLES');

    for (const table of tables) {
      const tableName = table[`Tables_in_${mysqlConfig.database}`];

      // Check if the table has a user_id field
      const [fields] = await mysqlConnection.query(`DESCRIBE ${tableName}`);
      const hasUserIdField = fields.some(field => field.Field === 'user_id');

      // Get the table structure and create the table in PostgreSQL
      const [tableInfo] = await mysqlConnection.query(`SHOW CREATE TABLE ${tableName}`);
      const createTableQuery = tableInfo[0]['Create Table'];

      // Modify the create table query to be compatible with PostgreSQL
      const modifiedCreateTableQuery = createTableQuery
        .replace(/`/g, '"')
        .replace(/ENGINE=InnoDB/g, '')
        .replace(/DEFAULT CHARSET=\w+/, '')
        .replace(/COLLATE=\w+/, '')
        .replace(/COMMENT='.*?'/g, '');

      await postgresClient.query(modifiedCreateTableQuery);

      // Export data from MySQL and import into PostgreSQL
      let selectQuery = `SELECT * FROM ${tableName}`;
      if (hasUserIdField) {
        selectQuery += ` WHERE user_id IN (${userIds.join(', ')})`;
      }
      const [rows] = await mysqlConnection.query(selectQuery);
      if (rows.length > 0) {
        const columns = Object.keys(rows[0]);
        const values = rows.map((row) => Object.values(row));

        const insertQuery = `
          INSERT INTO "${tableName}" ("${columns.join('", "')}")
          VALUES ${values.map((row) => `(${row.map((value) => (value === null ? 'NULL' : `'${value}'`)).join(', ')})`).join(', ')}
        `;

        await postgresClient.query(insertQuery);
      }
    }

    // Export comments and constraints from MySQL and recreate in PostgreSQL
    const [constraints] = await mysqlConnection.query(`
      SELECT CONCAT(
        'ALTER TABLE ', TABLE_NAME,
        ' ADD CONSTRAINT ', CONSTRAINT_NAME,
        ' ', CONSTRAINT_TYPE, ' (', GROUP_CONCAT(COLUMN_NAME ORDER BY ORDINAL_POSITION), ');'
      ) AS constraint_query
      FROM information_schema.KEY_COLUMN_USAGE
      WHERE CONSTRAINT_SCHEMA = '${mysqlConfig.database}' AND REFERENCED_TABLE_NAME IS NOT NULL
      GROUP BY CONSTRAINT_NAME
    `);

    for (const constraint of constraints) {
      const constraintQuery = constraint.constraint_query;
      await postgresClient.query(constraintQuery);
    }

    console.log('Data export and import completed successfully.');
  } catch (error) {
    console.error('Error during data export and import:', error);
  } finally {
    await mysqlConnection.end();
    await postgresClient.end();
  }
}

exportMySQLToPostgreSQL();
