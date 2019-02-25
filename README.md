# Guide
## Run the project
To run this project, please enter the following command:
- `docker-compose-up`

The first time the command is ran, it will take awhile for the project to be up and running, since it will have to build and download all docker images.

## Pre Requesites
- `Docker 18.06.0+`

## Populate data from dataset
To populate data from the dataset, please enter the admin panel at `http://localhost:3000/admin` and click on `Import/Refresh data`. This will fire up a job that populates the database with data from the dataset (it may take around 30 seconds to do so).

## Admin Panel
The Admin panel, located at `http://localhost:3000/admin`, will give you a detailed overview of the data.

## API Requests
All API responses follow the JSON API spec.
The Following API endpoints are available:

| Endpoint                                              | Method | Response               |
| ----------------------------------------------------- | ------ | ---------------------- |
| `http://localhost:3000/api/heroes`                    | `GET`  | List of all heroes     |
| `http://localhost:3000/api/heroes/:hero_id`           | `GET`  | Hero data              |
| `http://localhost:3000/api/heroes/:hero_id/abilities` | `GET`  | Hero abilities list    |
| `http://localhost:3000/api/abilities`                 | `GET`  | List of all abilities  |
| `http://localhost:3000/api/abilities/:ability_id`     | `GET`  | Ability data           |

## Data Refresh
There is a cron job scheduled to run everyday (`DataImportJob`) at midnight to fetch data from the dataset, parse it and update the database.

## Running tests
To run tests please enter the following command:
- `docker-compose run api rspec`

## What was done
Main pieces of code created:
#### Models
`Hero` and `Ability` models were created.
#### Controllers
`Heroes` and `Abilities` controllers were created to handle the API requests/responses.
#### Services
`DataExtract`, `DataParser` and `DataPersist` services to extract, parse and persist the data, respectively.
#### Job
`DataImportJob` runs everyday at midnight, or on demand through the admin panel.
#### API Wrapper
`OverwatchApi` is a simple wrapper to deal with requests to the overwatch dataset.
#### Tests
All models, controllers and services have unit tests.
#### Admin Panel
Basic admin panel to overview the data present in the database.
#### Docker
The project was setup with docker in order to easily run in any machine.
