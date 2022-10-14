# CureDAO Mono Repo

The goal of this monorepo is to acheive maximum interoperability and minimum duplication of effort between the various projects in the digital health ecosystem.  

## Why a monorepo?

Let's get one thing clear.  **A monorepo is not a monolith**.  

In fact, a well-designed monorepo helps to avoid the creation of monolithic applications by providing maximum visibility and reusability between: 
- UI components
- Analytical tools and models
- API documentation/libraries
- Data transformation pipelines

This allows us to easily share code and data between projects.  

**But won't this be a massive dependency to use in other projects?**

Hell, no. Libraries and components can automatically be published to NPM and consumed by other projects.  So if you only need one library, you don't need to install the entire monorepo.  And if you need to make a change to a library, you can do so in the monorepo and publish the new version to NPM.

### More Info on Monorepos

- [Monorepo in Git](https://www.atlassian.com/git/tutorials/monorepos)
- [Monorepo != monolith](https://blog.nrwl.io/misconceptions-about-monorepos-monorepo-monolith-df1250d4b03c)
- [Nrwl Nx Resources](https://nx.dev/latest/angular/getting-started/resources)

Here's the base structure of our monorepo:

```
- apps/
    - {{appName}}  <-- A complete user-facing application
    - {{appName}}-e2e  <-- Cypress end-to-end tests for the application
- libs/
    - {{apiName}}-api-spec <-- OpenAPI >3.0.1 specifications designed with Stoplight Studio
    - {{apiName}}-sdk-{{language}}  <-- Language-specific libraries for using APIs will live
- tools/
    - {{toolName}}  <-- A tool that is not a user-facing application but is used by developers
```



## How to add a new API

1. Create a new lib for the API spec file (replace `my-api-name` with the name of the API):

```sh
nx generate @trumbitta/nx-plugin-openapi:api-spec

✔ What name would you like to use? 
A: my-api-name-api-spec

✔ Do you want me to also create a sample spec file for you? (y/N) 
A: true
```

2. Paste the API spec file in the newly created `my-api-name-api-spec` file in the [libs](libs) folder.


3.  Create an API client library from the spec file (replace `my-api-name` with the name of the API):

```sh
nx generate @trumbitta/nx-plugin-openapi:api-lib

✔ What name would you like to use? 
· my-api-name-sdk-typescript-fetch

✔ Which OpenAPITool generator would you like to use?  
· typescript-fetch

✔ Is the API spec file published online? (y/N)
· false

✔ If online, what is the URL where I can get the API spec file from?
·

✔ If online, which authorization headers do you need to add?
·

✔ If local, what is the name of the lib containing the API spec file?
· my-api-name-api-spec

✔ If local, what is the path of the API spec file starting from the lib root?
· src/my-api-name-api-spec.openapi.yml
```

4. Create an API docs library from the spec file (replace `my-api-name` with the name of the API):

### Generate or update sources

Given the libs created in the examples above, then:

`nx run api-docs:generate-sources`

### Then you can simply serve it
npx http-server libs/api-docs/src

# Or you can configure a Nx serve target for it, or do whatever you want
```

## Monorepo Structure

This project use [Nx](https://nx.dev) to manage the inter-related dependencies.

🔎 **Smart, Fast and Extensible Build System**

### Adding capabilities to your workspace

Nx supports many plugins which add capabilities for developing different types of applications and different tools.

These capabilities include generating applications, libraries, etc as well as the devtools to test, and build projects as well.

Below are our core plugins:

-   [React](https://reactjs.org)
    -   `npm install --save-dev @nrwl/react`
-   Web (no framework frontends)
    -   `npm install --save-dev @nrwl/web`
-   [Angular](https://angular.io)
    -   `npm install --save-dev @nrwl/angular`
-   [Nest](https://nestjs.com)
    -   `npm install --save-dev @nrwl/nest`
-   [Express](https://expressjs.com)
    -   `npm install --save-dev @nrwl/express`
-   [Node](https://nodejs.org)
    -   `npm install --save-dev @nrwl/node`

There are also many [community plugins](https://nx.dev/community) you could add.

### Generate an application

Run `nx g @nrwl/react:app my-app` to generate an application.

> You can use any of the plugins above to generate applications as well.

When using Nx, you can create multiple applications and libraries in the same workspace.

### Generate a library

Run `nx g @nrwl/react:lib my-lib` to generate a library.

> You can also use any of the plugins above to generate libraries as well.

Libraries are shareable across libraries and applications. They can be imported from `@curedao/mylib`.

### Development server

Run `nx serve my-app` for a dev server. Navigate to http://localhost:4200/. The app will automatically reload if you change any of the source files.

### Code scaffolding

Run `nx g @nrwl/react:component my-component --project=my-app` to generate a new component.

### Build

Run `nx build my-app` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `--prod` flag for a production build.

### Running unit tests

Run `nx test my-app` to execute the unit tests via [Jest](https://jestjs.io).

Run `nx affected:test` to execute the unit tests affected by a change.

### Running end-to-end tests

Run `nx e2e my-app` to execute the end-to-end tests via [Cypress](https://www.cypress.io).

Run `nx affected:e2e` to execute the end-to-end tests affected by a change.

### Understand your workspace

Run `nx graph` to see a diagram of the dependencies of your projects.

### Further help

Visit the [Nx Documentation](https://nx.dev) to learn more.

## ☁ Nx Cloud

### Distributed Computation Caching & Distributed Task Execution

[Nx Cloud](https://nx.app/) pairs with Nx in order to enable you to build and test code more rapidly.
