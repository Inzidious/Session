//
//  APIModels.swift
//  SessionApp
//
//  Created by Shawn McLean on 1/21/25.
//

import Foundation

struct BankUser : Codable
{
    let id:Int
    let firstName:String
    let lastName:String
    let number:Int64
    let balance:Int64
}

func getBankUser() async throws -> BankUser
{
    let endpoint = "http://localhost:3000/account"
    print("HereAPI1")
    guard let url = URL(string:endpoint) else{
        print("URLError")
        throw APIError.invalidURL
    }
    
    print("HereAPI2")
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    print("HereAPI3")
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
        print("Response Error")
        throw APIError.invalidResponse
    }
    
    print("HereAPI4")
    
    do {
        let decoder = JSONDecoder()
        print("hereAPI5")
        let res:BankUser = try decoder.decode(BankUser.self, from:data)
        print("hereAPI6:", res.firstName)
        return res
    }   catch {
        throw APIError.invalidData
    }
}

enum APIError:Error{
    case invalidURL
    case invalidResponse
    case invalidData
}
