//
//  LoginViewModel.swift
//  NewMovieApp
//  Created by Erkan Emir on 10.05.23.

import Foundation

class LoginViewModel {
    var username: String?
    var password: String?
    
    var user =  Account()
    
    func getAccountDatas() {
        guard let username else { return }
        guard let password else { return }
        
        AuthService.allLoginProcess(username: username, password: password) { accountDatas, error in
            if error != nil { return }
            
            guard let data = accountDatas else { return }
            
            self.user.username = data.username
            self.user.avatar = data.avatar
            self.user.id = data.id
            self.user.name = data.name
//            
            self.writeToJson()
            print(data)
        }
    }
    
    func jsonPath() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask)[0].appendingPathComponent("Users.json")
        print(url)
        return url
    }
    
    func writeToJson() {
        do {
            try JSONEncoder().encode(user).write(to: jsonPath())
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
}
