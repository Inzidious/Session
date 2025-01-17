//
//  ExampleData.swift
//  SessionApp
//
//  Created by Shawn McLean on 12/3/24.
//

import Foundation

struct SampleData: Identifiable, Equatable
{
    let year:Int
    
    let population:String
    
    var id:Int { year }
    
    static var moodExample: [SampleData]
    {
        [SampleData(year:2005, population: "A"),
         SampleData(year:2010, population: "B"),
         SampleData(year:2015, population: "A"),
         SampleData(year:2020, population: "E"),
         SampleData(year:2025, population: "B")]
    }
    
    static var sleepExample: [SampleData]
    {
        [SampleData(year:2005, population: "A"),
         SampleData(year:2010, population: "C"),
         SampleData(year:2015, population: "D"),
         SampleData(year:2020, population: "E"),
         SampleData(year:2025, population: "B")]
    }
    
    static var foodExample: [SampleData]
    {
        [SampleData(year:2005, population: "D"),
         SampleData(year:2010, population: "C"),
         SampleData(year:2015, population: "E"),
         SampleData(year:2020, population: "A"),
         SampleData(year:2025, population: "B")]
    }
    
    static var movementExample: [SampleData]
    {
        [SampleData(year:2005, population: "B"),
         SampleData(year:2010, population: "D"),
         SampleData(year:2015, population: "E"),
         SampleData(year:2020, population: "A"),
         SampleData(year:2025, population: "C")]
    }
}
