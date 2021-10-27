//
//  MovieDetailsView.swift
//  TMDBMovies
//
//  Created by Chong jin Chua on 10/26/21.
//

import SwiftUI

struct MovieDetailsView: View {

    // read only data for read purposes only
    let movie: Movie
    // view model
    @EnvironmentObject var movies: TrendingMovies

    var body: some View {
        List {
            Group {
                title()
                movieDetails()
                moviePoster()
                movieGenres()
                movieVoteAverage()
                movieOverview()
            }
            .frame(maxWidth: .infinity)
            .frame(alignment: .center)
        }
    }

    func title() -> some View {
        HStack(spacing: 15) {
            Text(movie.original_title)
                .lineLimit(nil)
                .font(.title)
            Button(action: {
                movies.toggleLike(for: movie)
            }) {
                Image(
                    systemName: movie.isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                    .font(.system(size: 25))
            }
        }
    }
    
    func movieDetails() -> some View {
        HStack {
            Text(movie.release_date)
            movieLanguages()
            if let r = movie.runtime {
                let (h,m) = minutesToHoursMinutes(minutes: r)
                Text("\(h)h \(m)m")
            }
        }
        .font(.system(size: 13))
    }

    func moviePoster() -> some View {
        Group {
            if let p = movie.poster {
                Image(uiImage: p)
            } else {
                ProgressView()
            }
        }
    }
    
    func movieGenres() -> some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(movie.genres, id: \.self) { genre in
                    Text(genre)
                        .font(.system(size: 13))
                        .padding(5)
                        .border(Color.black)
                }
            }
        }
    }
    
    func movieVoteAverage() -> some View {
        Text("⭐️ " + movie.vote_average + "/10")
    }
    
    func movieOverview() -> some View {
        Text(movie.overview)
            .lineLimit(nil)
    }
    
    func movieLanguages() -> some View {
        var languages: [String] = []
        movie.spoken_languages.forEach { languages.append($0) }
        return Text(languages.joined(separator: ","))
    }

    func minutesToHoursMinutes(minutes: Int) -> (Int, Int) {
        return (minutes / 60, minutes % 60)
    }
}

//struct MovieDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailsView(movie: Movie())
//    }
//}
