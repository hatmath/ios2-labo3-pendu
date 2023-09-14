//
//  MovieDownloader.swift
//  ios2-labo2-pendu
//
//  Created by Simon Turcotte (2395412) et Mathieu Hatin (2296939)
//  API KeY : 691c8ed9
    
import Foundation

struct Movie: Codable {
    var imdbID: String
    var Title: String
    var Year: String
    var Rated: String
    var Released: String
    var Genre: String
    var Director : String
    var Actors: String
}

class MovieDownloader {
    private var currentMovie: Movie?
    static let shared = MovieDownloader()
    private init() {}

    func fetchRandomMovie(completion: @escaping (Result<Movie, Error>) -> Void) {
        let apiKey = "691c8ed9"

         if let randomTitleID = generateRandomTitleID() {
            let urlString = "https://www.omdbapi.com/?apikey=\(apiKey)&i=\(randomTitleID)"

            if let url = URL(string: urlString) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }

                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            self.currentMovie = try decoder.decode(Movie.self, from: data)
                            self.printMovieInfo(self.currentMovie!) // Print movie details to console
                            completion(.success(self.currentMovie!))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                }.resume()
            }
        } else {
            let error = NSError(domain: "MovieDownloader", code: -1, userInfo: [NSLocalizedDescriptionKey: "No movie title IDs available"])
            completion(.failure(error))
        }
    }

    func getCurrentMovie() -> Movie? {
        return self.currentMovie
    }
    
    func generateRandomTitleID() -> String? {
        let generateFrom1 = "LISTE"
        let generateFrom2 = "RANDOM"
        let generateFrom = generateFrom2
        let minValue = 1
        let maxValue = 55252
        
        if generateFrom == generateFrom1 {
            return listeFilms.randomElement()
        } else {
            return String(format: "tt%07d", Int.random(in: minValue...maxValue)) as String?
        }
    }
    
    private func printMovieInfo(_ movie: Movie) {
        print("Movie Title: \(movie.Title)")
        print("Year: \(movie.Year)")
        print("Rated: \(movie.Rated)")
        print("Released: \(movie.Released)")
        print("Genre: \(movie.Genre)")
        print("Director: \(movie.Director)")
        print("Actors: \(movie.Actors)")
    }
    
    func toString(_ movie: Movie) -> String {
        return """
        Movie Title: \(movie.Title)
        Year: \(movie.Year)
        Rated: \(movie.Rated)
        Released: \(movie.Released)
        Genre: \(movie.Genre)
        Director: \(movie.Director)
        Actors: \(movie.Actors)
        """
    }
}
