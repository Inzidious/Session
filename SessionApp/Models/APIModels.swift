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

struct NewsFeed : Codable
{
    let pageNodes:[PageNode]
}

struct PageNode : Codable, Hashable
{
    let title:String
    let topic:String
    let body:String
}

func getExNodes() -> [PageNode]
{
    var res = [PageNode]()
    
    res.append(PageNode(title: "Make Something Out of Your Mental Health Challenges", topic: "https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_1_288x288/public/field_blog_entry_images/2025-02/256px-Charles_Darwin_01.jpg?itok=02idtZFD",
                        body: "Today the news occured"))
    
    res.append(PageNode(title: "Kinky Eyes Wide Open in the Film Babygirl", topic:
"https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_1_288x288/public/teaser_image/blog_entry/2025-02/iStock-Fetishiism.jpg?itok=qEb2SdDn",
                        body: ""))
    
    return res
}

func getPageNodes() async throws -> [PageNode]
{
    let endpoint = "http://144.126.221.170:3000/newsfeed"
    //let endpoint = "http://localhost:3000/newsfeed"
    //print("HereAPI1")
    guard let url = URL(string:endpoint) else{
        print("URLError")
        throw APIError.invalidURL
    }
    
    print("HereAPI2")
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    print("HereAPI3")
    
    if let responseString = String(data: data, encoding: .utf8) {
            //print("Response Data: \n\(responseString)")
    } else {
        print("Failed to convert data to string.")
    }
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
        throw APIError.invalidResponse
    }
    
    //print("HereAPI4")
    
    do {
        let decoder = JSONDecoder()
        //print("hereAPI55555")
        let res:[PageNode] = try decoder.decode([PageNode].self, from:data)
        //print("hereAPI6:")//, res.firstName)
        return res
    }   catch let jsonError as NSError {
        //print("really?")
        print("JSON decode failed: \(jsonError)")
        throw APIError.invalidData
    }
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
    
    if let responseString = String(data: data, encoding: .utf8) {
            print("Response Data: \n\(responseString)")
    } else {
        print("Failed to convert data to string.")
    }
    
    print("HereAPI3")
    
    var newres = response as? HTTPURLResponse
    
    if(newres != nil)
    {
        if let code = newres?.statusCode
        {
            print("good cast: ", code)
        }
    }
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
        print("Response New problems")
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
