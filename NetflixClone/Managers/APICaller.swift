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
    
    // Movie
    func getTrandingMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.BASE_URL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleModel.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func getUpcomingMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.BASE_URL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_, error in
            guard let data = data , error == nil else {
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleModel.self, from: data)
                completion(.success(results.results))
            }
            catch{
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getPopuler(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.BASE_URL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleModel.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getTopRated(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.BASE_URL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleModel.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }

        }.resume()
    }
    
    func getTrandingTv(completion : @escaping (Result<[Title],Error>)-> Void){
        
        guard let url = URL(string: "\(Constants.BASE_URL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleModel .self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
        }.resume()
    }
}
