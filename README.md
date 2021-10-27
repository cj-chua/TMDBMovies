# TMDBMovies
Demo app to test out TMDB movies api

# Building and Running the app
- Clone the repo

`git clone git@github.com:cj-chua/TMDBMovies.git`

- Change build target to `TMDBMovies`

- Enter your TMDB API key in `TMDBInfo.plist`. If you don't have one, create a developer account at https://www.themoviedb.org/
```
# In TMDBInfo.plist

APIKEY  String  <your api key>
```

- Run the app

# Notes
- When developing the app my main focus is on responsiveness. I've made sure that remote api calls don't interfere with the UI.
- I've used UserDefaults as the persistent storage. It's not the best choice but it gets the job done for this challenge, 
since the data we're trying to persist is just a bunch of booleans. If we were to scale it I would probably go for core data or sqlite database.
Personally I prefer https://github.com/groue/GRDB.swift as I've had experience using it.
- There are many ways to pass data around in an app. Let me know if is a better approach!
