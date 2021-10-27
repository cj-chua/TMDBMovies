# TMDBMovies
Demo app to test out TMDB movies api

# Building and Running the app
- Clone the repo

`git clone git@github.com:cj-chua/TMDBMovies.git`

- Change build target to `TMDBMovies`

- Enter your TMDB API key in `TMDBInfo.plist`. If you don't have one, create a developer account at https://www.themoviedb.org/

`APIKEY  String  <your api key>`

- Run the app

# Notes
- When developing the app my main focus is on responsiveness. I've made sure that remote api calls don't interrupt with the UI.
- I've used UserDefaults as the persistent storage for this coding challenge. It's not the best option here but it gets the job done, 
since the data we're trying to persist is just a boolean. If we were to scale it I would probably go for core data or sqlite database.
Personally I prefer https://github.com/groue/GRDB.swift since I've had experience using it.
- There are many ways to pass data around in an app. Let me know if is a better approach!
