//
//  APICaller.swift
//  NETFLIX_CLONE
//
//  Created by 권정근 on 7/3/24.
//

import Foundation


struct Constants {
    static let API_KEY = "678025f9b853729922748d16feb442f9"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedtogetData
}

class APICaller {
    
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                // 데이터 확인용
//                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
