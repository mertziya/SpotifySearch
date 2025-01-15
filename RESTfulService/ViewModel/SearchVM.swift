//
//  SearchVM.swift
//  RESTfulService
//
//  Created by Mert Ziya on 8.01.2025.
//

import Foundation

protocol ExerciseDelegate: AnyObject{
    func didSearchSongs(songs: [Song])
    func didReturnJWTToken(token : String)
    func didFailWithError(error: Error)
}

class SearchVM{
    
    weak var delegate : ExerciseDelegate?
    
    
    func searchSongs(name: String){
        RESTservice.searchSongWith(name: name) { result in
            switch result{
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.didFailWithError(error: error)
                }
            case .success(let songs):
                DispatchQueue.main.async {
                    self.delegate?.didSearchSongs(songs: songs)
                }
            }
        }
    }


    func loginUser(email : String , password: String){
        RESTservice.login(email: email, password: password) { result in
            switch result{
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            case .success(let token):
                self.delegate?.didReturnJWTToken(token: token)
            }
        }
    }
}
