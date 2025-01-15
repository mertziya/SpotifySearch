//
//  RESTservice.swift
//  RESTfulService
//
//  Created by Mert Ziya on 7.01.2025.
//

import Foundation

enum ErrorType: Error{
    case spotifUrlError
    case unknownError
    case ArrayIsNil
    
    case authUrlError
    case authDataError // the data for the Login request couldn't be fetched
    case tokenError
}

class RESTservice{
    
    
    static func login(email: String , password: String, completion: @escaping (Result<String, Error>) -> () ){
        guard let url = URL(string: "http://172.20.10.4:5001/auth/login") else{
            completion(.failure(ErrorType.authUrlError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = LoginRequest(email: email, password: password)
        
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        }catch{
            completion(.failure(error))
            return
        }

        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(ErrorType.authDataError))
                return
            }
            
            do{
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                completion(.success(loginResponse.token)) // returns the token on succesfull completion
            }catch{
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
    static func searchSongWith(name : String , completion : @escaping (Result<[Song],Error>) -> () ){
        guard let token = UserDefaults.standard.string(forKey: "Token") else{
            completion(.failure(ErrorType.tokenError))
            return
        }
        
        guard let url = URL(string: "http://172.20.10.4:5001/directly-from-spotify?songName=\(name)") else {
            completion(.failure(ErrorType.spotifUrlError))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            // Handle network errors
            if let error = error {
                completion(.failure(error))
                return
            }

            // Ensure data is not nil
            guard let data = data else {
                completion(.failure(ErrorType.unknownError))
                return
            }
            
            do {
                let container = try JSONDecoder().decode(DataContainer.self, from: data)
                completion(.success(container.songsArray))
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
}
