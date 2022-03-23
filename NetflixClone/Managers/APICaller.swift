//
//  APICaller.swift
//  NetflixClone
//
//  Created by ferhatiltas on 11.03.2022.
//

import Foundation

struct Constants{
    static let API_KEY = ""
    static let YoutubeAPI_KEY = ""
    static let BASE_URL = "https://api.themoviedb.org"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum ApiError : Error{
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
                let results = try JSONDecoder().decode(TrendingTitleModel.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
        }.resume()
    }
    
    // Search View
    
    func getDiscoveryMovies(completion : @escaping (Result<[Title],Error>)-> Void){
        guard let url = URL(string: "\(Constants.BASE_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        
        URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleModel.self, from: data)
                completion(.success(results.results))            }
            catch{
                completion(.failure(error))
            }
        }.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.BASE_URL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
             
            do {
                let results = try JSONDecoder().decode(TrendingTitleModel.self, from: data)
                completion(.success(results.results))

            } catch {
                completion(.failure(ApiError.failedTogetData))
            }

        }
        task.resume()
    }
    
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(YoutubeSearchModel.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }

        }.resume()
    }
    
}
