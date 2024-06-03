# SQS-Frontend

This is the frontend for the [SQS](https://codeberg.org/Birkenfunk/SQS) backend. It displays the Weather data it gets from the backend in a compact grid.

## How to use
It is very simple to use. First of all you have will have to start the Backend some where reachable from your computer.

For this purpose you can use the docker-compose in the [./src](./src) folder.

If the backend is running you can download the app from the [Github Repo](https://github.com/birkenfunk/SQS-Frontend/releases) and start it. If you want to use the website you will have to use a tool for this e.g. an Apache/ Nginx Server or the http-server from npm.

If you enter the app you first have to add your backend server. For this you first have to select the correct protocol (http/ https), then your IP and last add a port. By default it has prefilled http, localhost and 4000.

If the sever is correct you can press next and now can search for a city.

# Development
## Requirements
- Flutter (>= 3.22.1) 
- Docker & Docker-compose

## Start development

1. Checkout this reposetory.
1. All sourcecode is in the src folder 
1. Open it in your prefered IDE
2. Sourcecode Structure
	- Prodoctive code is under src/lib 
	- Test code is under src/test
	- Integration test code is under src/integration_test
1. Run `make get_package` in the src folder. this will download all sources
2. Now you are ready to develope.
