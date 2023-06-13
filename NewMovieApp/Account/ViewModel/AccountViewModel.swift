//
//  AccountViewModel.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 11.06.23.

import Foundation
import Alamofire

class AccountViewModel {
    
    var accountDatas: Account?
    var favouritedDatas =  [Result]()
    var successCallBack: (()->())?
    var id =  String()
    
    var avatarURL: URL? { URL(string: CoreHelper.shared.imagePath(path: accountDatas?.avatar?.tmdb?.avatarPath ?? "")) }
    
    func fetchAllProcess(id: String) {
        self.id = id
        fetchProfileData(sessionID: id)
        fetchFavourited(id: id)
    }
    
    func fetchProfileData(sessionID: String) {
        CoreService.request(type: Account.self,
                            url: CoreHelper.shared.url(path: "/account") + "&session_id=\(sessionID)") { items, error in
            if error != nil { return }
            self.accountDatas = items
            print(items)
//            self.successCallBack?()
            
        }
    }
    
    func fetchFavourited(id: String) {

        let url = "https://api.themoviedb.org/3/account/\(id)/favorite/movies"
    

            CoreService.request(type: Favourited.self,
                                url: url) { items, error in
                print(url)
    
                if error != nil { return }
                guard let items = items?.results else { return }
                self.favouritedDatas = items
                self.successCallBack?()
                print(items)
            }
        }

    
 
}
