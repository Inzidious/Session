//
//  APIClient.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/3/24.
//

import Foundation

struct SpaceData : Codable,Identifiable
{
    var id:Int
    var title:String
    var url:String
    var imageUrl:String
    var newsSite:String
    var summary:String
    var publishedAt:String
}

@MainActor class SpaceAPI : ObservableObject
{
    @Published var news:[SpaceData] = []
    
    func getData() async throws
    {
        guard let url = URL(string:
            "https://api.spaceflightnewsapi.net/v3/articles") else {
           return
        }
        //print("inside getData. URL: " + url.absoluteString)
        
        let (data, response) = try await URLSession.shared.data(from:url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
        {
            //print("Bad response in API fetch")
            return
        }
        
        //print("after response")
        //print(data)
        
        let spaceData = try! JSONDecoder().decode([SpaceData].self, from: data)
        
        //print(spaceData[0])
        self.news = spaceData
        
        /*URLSession.shared.dataTask(with: url)
        { data, response, error in
            
            print("here")
            guard let data = data else
            {
                let tempError = error!.localizedDescription
                
                print("Error!")
                DispatchQueue.main.async {
                    self.news = [SpaceData(id: 0, title: tempError, url: "Error", imageUrl: "Error", newsSite: "Error", summary: "Try swiping down to refresh when you have internet", publishedAt: "Error")]
                }
                return
            }
            print(data)
            let spaceData = try! JSONDecoder().decode([SpaceData].self, from: data)
            print("Data:")
            print(spaceData)
            
            
            DispatchQueue.main.async
            {
                print("Loaded successfully. Articles: \(spaceData.count)")
                self.news = spaceData
            }
        }*/
    }
    
    
}
