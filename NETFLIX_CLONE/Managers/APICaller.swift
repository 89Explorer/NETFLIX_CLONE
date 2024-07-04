//
//  APICaller.swift
//  NETFLIX_CLONE
//
//  Created by 권정근 on 7/3/24.
//

import Foundation

// MARK: Constants
struct Constants {
    // static let API_KEY = "678025f9b853729922748d16feb442f9"
    static let baseURL = "https://api.themoviedb.org"
    static let API_KEY = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2NzgwMjVmOWI4NTM3Mjk5MjI3NDhkMTZmZWI0NDJmOSIsIm5iZiI6MTcyMDA3MjU2OS4zMjg0ODIsInN1YiI6IjY1ZTUyODRmMjBlNmE1MDE4NjUzYzIwYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NCie8pDtWpOfDiQSjXXIWNx892BSvMfCW-7pOoliFfA"
}

// MARK: ERROR
enum APIError: Error {
    case failedToGetData
}


// MARK: APICaller 클래스
class APICaller {
    
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.API_KEY)"
        ]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                completion(.failure(APIError.failedToGetData))
                return
            }
            guard let data = data else {
                print("No data received")
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                // Print JSON data to debug
//                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//                    print("JSON Response: \(json)")
//                }
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("JSON Decoding error: \(error.localizedDescription)")
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/trending/tv/day")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.API_KEY)"
        ]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                completion(.failure(APIError.failedToGetData))
                return
            }
            guard let data = data else {
                print("No data received")
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                // Print JSON data to debug
//                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//                    print("JSON Response: \(json)")
//                }
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("JSON Decoding error: \(error.localizedDescription)")
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.API_KEY)"
        ]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                completion(.failure(APIError.failedToGetData))
                return
            }
            guard let data = data else {
                print("No data received")
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                // Print JSON data to debug
//                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//                    print("JSON Response: \(json)")
//                }
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("JSON Decoding error: \(error.localizedDescription)")
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.API_KEY)"
        ]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                completion(.failure(APIError.failedToGetData))
                return
            }
            guard let data = data else {
                print("No data received")
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                // Print JSON data to debug
//                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//                    print("JSON Response: \(json)")
//                }
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("JSON Decoding error: \(error.localizedDescription)")
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.API_KEY)"
        ]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                completion(.failure(APIError.failedToGetData))
                return
            }
            guard let data = data else {
                print("No data received")
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                // Print JSON data to debug
//                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//                    print("JSON Response: \(json)")
//                }
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("JSON Decoding error: \(error.localizedDescription)")
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMulti(with keyWord: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let keyWord = keyWord.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        let url = URL(string: "https://api.themoviedb.org/3/search/multi")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "query", value: keyWord),
          URLQueryItem(name: "include_adult", value: "false"),
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer \(Constants.API_KEY)"
        ]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                completion(.failure(APIError.failedToGetData))
                return
            }
            guard let data = data else {
                print("No data received")
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                // Print JSON data to debug
//                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//                    print("JSON Response: \(json)")
//                }
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("JSON Decoding error: \(error.localizedDescription)")
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
