//
//  APIManager.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 04.10.2022.
//

import Foundation



final class APIManager{
    
    private enum APIError: Error{
        case FailedToGetData
    }
    
    static let shared = APIManager()
    
    private let mainUrl = "https://imdb-api.com/en/API/"
    private let apiKey = "k_m8tol6b3"
    
    private init(){}
    
    func getMostPopularMovies(completionHandler: @escaping(Result<[Video], Error>)->Void){
        
        let stringUrl = "\(mainUrl)MostPopularMovies/\(apiKey)"
        guard let url = URL(string: stringUrl) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if error != nil {
                return
            }
            
            guard let data = data else { return}
            do{
                let results = try JSONDecoder().decode(APIResponse.self, from: data)
                completionHandler(.success(results.items))
            }
            catch{
                completionHandler(.failure(APIError.FailedToGetData))
            }
        }
        task.resume()
    }
    
    func getMostPopularTVs(completionHandler: @escaping(Result<[Video], Error>)->Void){
        
        let stringUrl = "\(mainUrl)MostPopularTVs/\(apiKey)"
        guard let url = URL(string: stringUrl) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if error != nil {
                return
            }
            
            guard let data = data else { return}
            do{
                let results = try JSONDecoder().decode(APIResponse.self, from: data)
                completionHandler(.success(results.items))
            }
            catch{
                completionHandler(.failure(APIError.FailedToGetData))
            }
        }
        task.resume()
    }
    
    func getInTheatres(completionHandler: @escaping(Result<[Video], Error>)->Void){
        
        let stringUrl = "\(mainUrl)InTheaters/\(apiKey)"
        guard let url = URL(string: stringUrl) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if error != nil {
                return
            }
            
            guard let data = data else { return}
            do{
                let results = try JSONDecoder().decode(APIResponse.self, from: data)
                completionHandler(.success(results.items))
            }
            catch{
                completionHandler(.failure(APIError.FailedToGetData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping(Result<[Video], Error>)->Void){
        
        guard let url = URL(string: "https://imdb-api.com/API/SearchTitle/\(apiKey)/\(query)") else { return }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            
            guard let data = data, error == nil else { return }
            
            do{
                let results = try JSONDecoder().decode(SearchResponse.self, from: data)
                completion(.success(results.results))
            }
            catch{
                completion(.failure(APIError.FailedToGetData))
            }
        }
        task.resume()
    }
    
}


