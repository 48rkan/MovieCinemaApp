//
//  CoreManager.swift
//  NewMovieApp
//  Created by Erkan Emir on 08.04.23.

import Foundation
import Alamofire

public class CoreService {
        
    static func request<T: Codable>(type: T.Type,
                        url: String,
                        method: HTTPMethod = .get,
                        parameters: Parameters? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: HTTPHeaders? = nil,
                                    completion: @escaping (T?,Error?)->()) {
        
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "",method: method,parameters: parameters).responseDecodable(of: T.self) { object in
            switch object.result {
            case .success(let items):
                completion(items,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
}

//AF.request(url,method: method,parameters: parameters).responseDecodable(of: T.self) { object in
//    switch object.result {
//    case .success(let items):
//        completion(items,nil)
//    case .failure(let error):
//        completion(nil,error)
//    }
