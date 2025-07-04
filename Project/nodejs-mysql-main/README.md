# NodeJs app with MySQL Database

A simple nodejs app connected with mySQL database.

## Getting Started

1. Clone the repo
```bash
downlod into repo https://github.com/greytyler/Terraform/blob/main/Project/nodejs-mysql-main/
cd nodejs-mysql
```
2. Create a `.env` file in root directory and add the environment variables:
```bash
DB_HOST="localhost"
DB_USER="root" # default mysql user
DB_PASS=""
DB_NAME=""
TABLE_NAME=""
PORT=3000
```
> Make sure to create the database and the corresponding table in your mySQL database.
3. Initialize and start the development server:
```bash
npm install
npm run dev
```
![running app](./screenshots/db-output.png)
