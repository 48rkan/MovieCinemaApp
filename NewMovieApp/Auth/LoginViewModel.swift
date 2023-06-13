//  LoginViewModel.swift
//  NewMovieApp
//  Created by Erkan Emir on 10.05.23.

import Foundation
import Alamofire

class LoginViewModel {
    var username: String?
    var password: String?
    
    var callBack: ((String)->())?
    
    func getAccountDatas() {
        guard let username else { return }
        guard let password else { return }
        
        AuthService.shared.allLoginProcess(username: username, password: password) { id , error in
            if error    != nil     {
                print(error?.localizedDescription)
                return }
            guard let id = id else { return }
            
            Keychain.shared.set(id, forKey: "ID_USER")

            self.callBack?(id)
        }
    }
}
