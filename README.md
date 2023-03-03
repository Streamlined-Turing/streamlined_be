![Stream](https://user-images.githubusercontent.com/111480866/221070931-fce120af-633a-4ee3-9eab-dfe994549beb.png)

# Streamlined Backend Service
The goal of this project is to create a successful web application from a student-led project idea. Our team has created an app to solve a real world problem, allows users to authenticate with a third-party service, and consume at least two other apis. This project was created using Service Oriented Architecture. The frontend repo can be found [here](https://github.com/Streamlined-Turing/streamlined_fe).

## About StreamLined
StreamLined is a tool to track movies and TV shows a user would like to watch, are currently watching, and also track media a user has watched. Once a user has created a StreamLined account, they will have access to a dashboard with three default lists to categorize their media: 'Currently Watching', 'Want to Watch', and 'Watched'. The user will be able to search for movies and TV shows by title, view the media details, and save to the appropriate list in their dashboard. Once a user has finished watching their show or movie, the user will be able to provide reviews and ratings. Users of this app will be to set their streaming services and search for their desired media based on the streaming service available to the user.

## Learning Goals
* Build API endpoints by consuming existing APIs
* Build app using Service Oriented Architecture
* Continued practice following Facade and Service design patterns.

## Setup
This project requires Ruby 2.7.4 

1. Fork and clone this repository.
2. `cd` into the root directory.
3. Run `bundle install`
4. Run `rails db:{drop,create,migrate,seed}`
5. To run the test suite, run `bundle exec rspec`
6. To run this server, enter `rails s`
7. Open a browser window and go to http://localhost:5000

You should now be able to hit the API endpoints using Postman or a similar tool.

## Running the test suite
The backend portion of the app makes calls to the Watchmode and TheMovieDataBase API which are VCR stubbed but you need to register and aquire your own API keys to produce any endpoints.

### Figaro Gem
Our team used the gem Figaro to create a hidden .yml file to save our env files (You can use any gem you know can accomplish this).
The gem is already listed in Gemfile but you need to follow the steps at https://github.com/laserlemon/figaro#:~:text=Figaro%20installation%20is%20easy%3A   
Start at `bundle exec figaro install`   
The variable names of your api keys must follow this pattern.    
```
config/application.yml

watch_mode_api_key: YOUR WATCHMODE API KEY
moviedb_api_key: YOUR TMDB API KEY
```   

The steps to aquire these keys can be found on their respective websites.   
WatchModeAPI:  https://api.watchmode.com/?message=MXxZb3UgSGF2ZSBCZWVuIExvZ2dlZCBPdXQu   
TMDBAPI: https://developers.themoviedb.org/3/getting-started/introduction   
## Built With
```
Ruby on Rails
RSpec
```
## Database Schema
![Screen Shot 2023-02-23 at 3 51 51 PM](https://user-images.githubusercontent.com/111480866/221070847-eeb02ed9-43d7-4bff-a2c9-4d7d47a06602.png)

## Json Contract for User
![Screen Shot 2023-02-23 at 5 08 47 PM](https://user-images.githubusercontent.com/111480866/221070631-305e77dc-7456-4cd0-8aab-464f9125d4b1.png)

## API Endpoints
[Endpoints Documentation](./docs/api_endpoints.md)

## Contributors 

* Nigel Aung-Myint: [Github](https://github.com/Pocketzs) | [LinkedIn](https://www.linkedin.com/in/nigel-aung-myint-719254254/)
* Thomas Casady: [Github](https://github.com/Tscasady) | [LinkedIn](https://www.linkedin.com/in/thomas-casady-00b71a255/)
* Kerynn Davis: [Github](https://github.com/Kerynn) | [LinkedIn](https://www.linkedin.com/in/kerynn-davis/)
* Joe King: [Github](https://github.com/this-is-joeking) | [LinkedIn](https://www.linkedin.com/in/king-joseph/)
* Alex Pitzel: [Github](https://github.com/pitzelalex) | [LinkedIn](https://www.linkedin.com/in/alex-pitzel-231619235/)
* Kelsie Porter: [Github](https://github.com/KelsiePorter) | [LinkedIn](https://www.linkedin.com/in/kelsie-porter/)

## API Credits 
* [Watchmode](https://api.watchmode.com/)
* [The Movie Database](https://developers.themoviedb.org/3/getting-started/introduction)
