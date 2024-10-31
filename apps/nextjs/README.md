# FDAi Next.js Example App


This is an example app that demonstrates how to use the FDAi SDK with Next.js.

## Getting Started

### Fork the repository

First, fork the repository to your own GitHub account.

### Clone the repository

Clone the repository to your local machine.


Copy `.env.example` to `.env` file in the root of the project. The following environment variables are supported:

[https://builder.dfda.earth](https://builder.dfda.earth)
- `DFDA_CLIENT_ID`: The client ID of your FDAi app.
- `DFDA_CLIENT_SECRET`: The client secret of your FDAi app.

See the .env file for how to get the rest of the required environment variables.

Start the database with [docker-compose](https://docs.docker.com/desktop/):

```bash
docker-compose up
```

First, install the dependencies:

```bash
yarn install
```

Then, run the development server:

```bash
npm run dev
```



Generate the Prisma client:

```bash
npx prisma generate[page.tsx]
```

Run the migrations:

```bash
npx prisma migrate dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

