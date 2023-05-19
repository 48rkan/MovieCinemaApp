//
//  Ext+ string.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 29.04.23.
//

import Foundation

extension String {
    var localize: String {
        let code = UserDefaults.standard.string(forKey: "appLanguage")
        let path = Bundle.main.path(forResource: code, ofType: "lproj") ?? ""
        let bundle = Bundle(path: path) ?? Bundle()
        
        return NSLocalizedString(self,
                                 bundle: bundle,
                                 value: "", comment: "")
    }
}
