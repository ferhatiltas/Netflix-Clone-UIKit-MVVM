//
//  APICaller.swift
//  NetflixClone
//
//  Created by ferhatiltas on 11.03.2022.
//

import Foundation

struct Constants{
    static let API_KEY = ""
    static let BASE_URL = "https://api.themoviedb.org"
}

enum ApiError{
    case failedTogetData
}
class ApiCaller {
    static let shared = ApiCaller()
    
    func getTrandingMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        
        
        guard let url = URL(string: "\(Constants.BASE_URL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else {return}
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesModel.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
            
        }.resume()
    }
}
