//
//  GlobalManifest.swift
//  SessionApp
//
//  Created by Shawn McLean on 2/28/25.
//
import Foundation

class GlobalManifest {
    static let shared = GlobalManifest()
    var manifest:[LoadedAsset] = []
    
    private init() {
        let a1 = LoadedAsset(id:1,
                            title:"5-Point Check In",
                            thumbnail:"",
                            size:0,
                            author:"Author",
                            url:"https://thereapymuse.sfo2.digitaloceanspaces.com/5-Point_Check_In.m4a")
        
        manifest.append(a1)
        
        let a2 = LoadedAsset(id:2,
                             title:"Anxiety Reduction",
                             thumbnail:"https://thereapymuse.sfo2.digitaloceanspaces.com/joshua.jpg",
                             size:0,
                             author:"Author",
                             url:"https://thereapymuse.sfo2.digitaloceanspaces.com/Anxiety_Reduction.mp3")
        
        manifest.append(a2)
        
        let a3 = LoadedAsset(id:3,
                             title:"Bedtime Wind Down",
                             thumbnail:"https://thereapymuse.sfo2.digitaloceanspaces.com/joshua.jpg",
                             size:0,
                             author:"Author",
                             url:"https://thereapymuse.sfo2.digitaloceanspaces.com/Bedtime_Wind_Down.mp4")
        
        manifest.append(a3)
        
        let a4 = LoadedAsset(id:4,
                             title:"Container Meditation",
                             thumbnail:"https://thereapymuse.sfo2.digitaloceanspaces.com/joshua.jpg",
                             size:0,
                             author:"Author",
                             url:"https://thereapymuse.sfo2.digitaloceanspaces.com/Container_Meditation.m4a")
        
        manifest.append(a4)
        
        let a5 = LoadedAsset(id:5,
                             title:"Focus Meditation",
                             thumbnail:"https://thereapymuse.sfo2.digitaloceanspaces.com/joshua.jpg",
                             size:0,
                             author:"Author",
                             url:"https://thereapymuse.sfo2.digitaloceanspaces.com/Focus_Meditation.mp3")
        
        manifest.append(a5)
        
        let a6 = LoadedAsset(id:6,
                             title:"Safe Place Sensory Meditation",
                             thumbnail:"https://thereapymuse.sfo2.digitaloceanspaces.com/joshua.jpg",
                             size:0,
                             author:"Shauna Berg",
                             url:"https://thereapymuse.sfo2.digitaloceanspaces.com/Safe_Place_Sensory_Meditation.m4a")
        
        manifest.append(a6)
        
        let a7 = LoadedAsset(id:7,
                             title:"Sama Vritti",
                             thumbnail:"https://thereapymuse.sfo2.digitaloceanspaces.com/joshua.jpg",
                             size:0,
                             author:"Author",
                             url:"https://thereapymuse.sfo2.digitaloceanspaces.com/Sama_Vritti.m4a")
        
        manifest.append(a7)
        
        let a8 = LoadedAsset(id:8,
                             title:"Speedy Vinyasa Flow",
                             thumbnail:"https://thereapymuse.sfo2.digitaloceanspaces.com/joshua.jpg",
                             size:0,
                             author:"Author",
                             url:"https://thereapymuse.sfo2.digitaloceanspaces.com/Speedy_vinyasa_flow.mp4")
        
        manifest.append(a8)
        
        let a9 = LoadedAsset(id:9,
                             title:"Fully Body Strech",
                             thumbnail:"https://thereapymuse.sfo2.digitaloceanspaces.com/joshua.jpg",
                             size:0,
                             author:"Author",
                             url:"https://thereapymuse.sfo2.digitaloceanspaces.com/fully_body_strech.mp4")
        
        manifest.append(a9)
        
        let a10 = LoadedAsset(id:10,
                            title:"Morning Meditation",
                            thumbnail:"https://thereapymuse.sfo2.digitaloceanspaces.com/joshua.jpg",
                            size:0,
                            author:"Author",
                            url:"https://thereapymuse.sfo2.digitaloceanspaces.com/morning_meditation.mp4")
        
        manifest.append(a10)
        
    }
    
}
