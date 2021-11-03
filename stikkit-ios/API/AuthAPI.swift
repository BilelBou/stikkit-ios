//
//  AuthAPI.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 21/04/2021.
//

import Foundation
import JWTDecode

public class AuthAPI {
    let urlAPI = "https://api.stikkit.fr/"
    let defaults = UserDefaults.standard
    public static let shared: AuthAPI = AuthAPI()
    
    func login(email: String, password: String, completion:@escaping (Int) -> Void) {
        let urlLogin = URL(string: urlAPI+"auth/login")
        var request = URLRequest(url: urlLogin!)
        let body = [
            "email":email,
            "password":password
        ]
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        request.httpBody = bodyData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            do {
                if let error = error {
                    print(error)
                    completion(404)
                } else {
                    if let response = response as? HTTPURLResponse, let decodedResponse = try? JSONDecoder().decode(JWT.self, from: data!){
                        print(response.statusCode)
                        let jwt = try decode(jwt: decodedResponse.accessToken)
                        self.defaults.setValue(jwt.claim(name: "firstName").string, forKey: "firstName")
                        self.defaults.setValue(jwt.claim(name: "lastName").string, forKey: "lastName")
                        self.defaults.setValue(jwt.claim(name: "phone").string, forKey: "phone")
                        self.defaults.setValue(jwt.claim(name: "email").string, forKey: "email")
                        self.defaults.setValue(jwt.claim(name: "image").string, forKey: "image")
                        self.defaults.setValue(jwt.claim(name: "id").integer, forKey: "id")
                        completion(response.statusCode)
                    }
                }
            } catch {
                print("error")
                completion(404)
            }
        }
        task.resume()
    }
    
    func register(firstName: String, lastName: String, email: String, password: String, completion:@escaping (Int) -> Void) {
        let urlRegister = URL(string: urlAPI+"auth/register")
        var request = URLRequest(url: urlRegister!)
        let body = [
            "firstName" : firstName,
            "lastName" : lastName,
            "email" : email,
            "password" : password
        ]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        request.httpBody = bodyData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else {
                if let response = response as? HTTPURLResponse {
                    print(response.statusCode)
                    completion(response.statusCode)
                }
            }
        }
        task.resume()
    }
    
    func getStickers(completion:@escaping ([stickerModel]) -> Void) {
        let urlGetStickers = URL(string: urlAPI+"stickers/ownerId/"+String(defaults.integer(forKey: "id")))
        var request = URLRequest(url: urlGetStickers!)
        
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else {
                if let response = response as? HTTPURLResponse, let decodedResponse = try? JSONDecoder().decode([stickerModel].self, from: data!) {
                    print(response.statusCode)
                    completion(decodedResponse)
                }
            }
        }
        task.resume()
    }
    
    func linkSticker(stickerId: String, completion:@escaping (Int)-> Void) {
        let urlLinkSticker = URL(string: urlAPI+"stickers/link/"+String(defaults.integer(forKey: "id"))+"/"+stickerId)
        var request = URLRequest(url: urlLinkSticker!)
        print(urlAPI+"/stickers/link/"+String(defaults.integer(forKey: "id"))+"/"+stickerId)
        request.httpMethod = "POST"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                completion(404)
            } else {
                if let response = response as? HTTPURLResponse {
                    print("Code ", response.statusCode)
                    completion(response.statusCode)
                }
            }
        }
        task.resume()
    }

    func createGroupe(name: String, me: [String], completion: @escaping (Int) -> Void) {

    }
}
