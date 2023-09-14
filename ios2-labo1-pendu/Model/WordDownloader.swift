//
//  WordDownloader.swift
//  ios2-labo2-pendu
//
//  Created by Simon Turcotte (2395412) et Mathieu Hatin (2296939)
//

import Foundation

class WordDownloader {
    private var currentWord : String?
    static let shared = WordDownloader()
    private init() {}

    func fetchRandomWord(completion: @escaping (Result<String, Error>) -> Void) {
        let apiUrl = URL(string: "https://random-word-api.herokuapp.com/word?length=9")!
        
        let task = URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "com.random-word-api", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let randomWords = try decoder.decode([String].self, from: data)
                if let randomWord = randomWords.first {
                    self.currentWord = randomWord
                    completion(.success(randomWord))
                    self.printReceivedWord(randomWord)
                } else {
                     completion(.failure(NSError(domain: "com.random-word-api", code: -2, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func printReceivedWord(_ word: String) {
        print("Mot reçu: \(word)")
    }
    func getCurrentWord() -> String? {
        return self.currentWord
    }
    
}
