# Personal FDA

The Food and Drug Administration regulates the safety and efficacy of drugs, medical devices, and food.

Unfortunately, we have very little data on the benefits and harms of the thousands of chemicals that we put in our bodies every day. 

This is an initial prototype for what we envision as an even more awesome the Food and Drug Administration (FDA) of the future.

The main purpose is to make it easier, cheaper, and faster to 
1. conduct randomized-controlled clinical trials 
2. collect epidemiological data for observational studies for 
   1. initial drug discovery
   2. research that would be immoral to conduct in humans (e.g. forcing people to smoke or consume a chemical believed to be harmful)
   3. research on unpatentable molecules that would not have sufficient financial incentive for a pharmaceutical company to conduct clinical trials


## Features
[outcome-labels.md](../../docs/components/outcome-labels/outcome-labels.md)
* [Outcome Labels](../../docs/components/outcome-labels/outcome-labels.md)
* [Predictor Search Engine](../../docs/components/predictor-search-engine/predictor-search-engine.md)
* [Root Cause Analysis Reports](../../docs/components/root-cause-analysis-reports/root-cause-analysis-reports.md)
* [Observational Mega-Studies](../../docs/components/observational-studies/observational-studies.md)
* [Real-Time Decision Support Notifications](../../docs/components/decision-support-notifications/decision-support-notifications.md)
* [No Code Health App Builder](../../docs/components/no-code-app-builder/no-code-app-builder.md)
* [AI Robot Doctor](https://www.curedao.org/blog/optomitron)
* [Chrome Extension](https://www.curedao.org/blog/chrome-extension)  

# Development

## Getting started
1. Clone the repository
2. Copy `.env.example` to `.env` and update the values
3. Run `composer install`

## Running the application with a local web server
1. Run `php artisan serve`
2. Visit `http://localhost:8000` in your browser

## Running in Docker
1. Run `docker-compose up -d`
2. Visit `http://localhost:8000` in your browser

## Running the tests
1. Run `php artisan test`

## Contributing
1. Fork the repository
2. Create a new branch that starts with `feature/`
3. Make your changes
4. Create a pull request
5. Wait for the tests to pass
6. Wait for the pull request to be merged
7. Celebrate!

## Guidelines
* [Commands](docs/commands.md)
* [Development](docs/development.md)
* [Testing](docs/testing.md)
* [IDE PhpStorm configuration](docs/phpstorm.md)
* [Xdebug configuration](docs/xdebug.md)




