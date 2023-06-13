//
//  AuthService.swift
//  NewMovieApp
//  Created by Erkan Emir on 10.05.23.

import Foundation
import Alamofire

//"Aslanaslan44",
//"password":"aslan444"
class AuthService {
    static var shared = AuthService()
    var requestToken = ""
    var sessionID    = ""
    
    func createRequestToken(completion: @escaping ()->()) {
        CoreService.request(type: RequestTokenStruct.self,
                            url: CoreHelper.shared.url(path: "/authentication/token/new")) { items, error in
            guard let token = items?.requestToken else { return }
            print(items)
            self.requestToken = token
            completion()
        }
    }
    
    func createSessionWithLogin(username: String,password: String,completion: @escaping ()->()) {
        
        let parameters: Parameters = ["username": username,
                                      "password": password,
                                      "request_token": requestToken]
        
        CoreService.request(type: RequestTokenStruct.self,
                            url: CoreHelper.shared.url(path: "/authentication/token/validate_with_login"),
                            method: .post,
                            parameters: parameters,
                            encoding: JSONEncoding.default) { items, error in
            guard let token = items?.requestToken else { return }
            self.requestToken = token
            print(self.requestToken)
            print(items)
            completion()
        }
    }
        
    func createSession( complete: @escaping (String?,Error?)->()) {
        let parameters = ["request_token": requestToken]
        
        CoreService.request(type: SessionStruct.self,
                            url: CoreHelper.shared.url(path: "/authentication/session/new"),
                            method: .post,
                            parameters: parameters,
                            encoding: JSONEncoding.default) { items, error in
            
            guard let sessionID = items?.sessionID else { return }
            print(items)
            self.sessionID = sessionID
            complete(sessionID,error)
        }
    }
    
    func allLoginProcess(username: String,password: String,completion: @escaping (String?,Error?)->()) {
        createRequestToken {
            self.createSessionWithLogin(username: username, password: password) {
                self.createSession { id, error in
                    completion(self.sessionID,error)
                }
            }
        }
    }
}

//let headers = [
//  "accept": "application/json",
//  "content-type": "application/json"
//]
//let parameters = [
//  "media_type": "movie", "media_id": 550, "favorite": true ] as [String : Any]
//
//let postData = JSONSerialization.data(withJSONObject: parameters, options: [])
//
//let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/account/null/favorite")! as URL,
//                                        cachePolicy: .useProtocolCachePolicy,
//                                    timeoutInterval: 10.0)
//request.httpMethod = "POST"
//request.allHTTPHeaderFields = headers
//request.httpBody = postData as Data
//
//let session = URLSession.shared
//let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//  if (error != nil) {
//    print(error as Any)
//  } else {
//    let httpResponse = response as? HTTPURLResponse
//    print(httpResponse)
//  }
//})
//
//dataTask.resume()

//import Foundation
//
//let headers = [
//  "accept": "application/json",
//  "content-type": "application/json"
//]
//let parameters = ["session_id": "2629f70fb498edc263a0adb99118ac41f0053e8c"] as [String : Any]
//
//let postData = JSONSerialization.data(withJSONObject: parameters, options: [])
//
//let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/authentication/session")! as URL,
//                                        cachePolicy: .useProtocolCachePolicy,
//                                    timeoutInterval: 10.0)
//request.httpMethod = "DELETE"
//request.allHTTPHeaderFields = headers
//request.httpBody = postData as Data
//
//let session = URLSession.shared
//let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//  if (error != nil) {
//    print(error as Any)
//  } else {
//    let httpResponse = response as? HTTPURLResponse
//    print(httpResponse)
//  }
//})
//
//dataTask.resume()
