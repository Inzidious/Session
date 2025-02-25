//
//  InsightsView.swift
//  SessionApp
//
//  Created by Shawn McLean on 12/3/24.
//

import SwiftUI
import Charts

struct InsightsView: View {
    @Environment(\.dismiss) private var dismiss
    @State var firstActive:Bool = true
    @State var secondActive:Bool = true
    @State var thirdActive:Bool = true
    @State var fourthActive:Bool = true
    
    let firstData = SampleData.moodExample
    let secondData = SampleData.sleepExample
    let thirdData = SampleData.foodExample
    let fourthData = SampleData.movementExample
    
    @State var data:[(type:String, color:Color, dataSet:[SampleData])]
    
    func setupData()
    {
        self.data = []
        if(firstActive){self.data.append((type:"Mood", color:.red, dataSet:firstData))}
        
        if(secondActive){self.data.append((type:"Sleep", color:.blue, dataSet:secondData))}
        
        if(thirdActive){self.data.append((type:"Food", color:.green, dataSet:thirdData))}
        
        if(fourthActive){self.data.append((type:"Movement", color:.orange, dataSet:fourthData))}
    }
    
    var body: some View
    {
        ZStack
        {
            Rectangle().fill(Color("ShGreen").opacity(0.4)).ignoresSafeArea()
            
            VStack
            {
                HStack
                {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left.circle")
                                .font(.title2)
                                .foregroundColor(Color(#colorLiteral(red: 0.8823529412, green: 0.6941176471, blue: 0.4156862745, alpha: 1)))
                                .scaleEffect(1.25)
                        }
                    }
                    .padding(.leading)
                    
                    Spacer()
                    Image("icon_tracking").resizable().frame(width:50, height:50
                                                             
                    )
                    Text("Insights").font(Font.custom("OpenSans-Bold", size:45))
                    Spacer().frame(width:40)
                }
                
                Spacer().frame(height:10)
                
                VStack
                {
                    HStack()
                    {
                        Spacer().frame(width:35)
                        Text("Select Time Frame").font(Font.custom("OpenSans-Soft-Bold", size:25))
                        Spacer()
                    }
                    HStack
                    {
                        Button()
                        {
                            
                        }
                    label:
                        {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius:10)
                                    .frame(width:50, height:40)
                                    .foregroundColor(Color(.black).opacity(0.2))
                                
                                Text("Day").font(Font.custom("OpenSans-Soft-Bold", size:20)).foregroundColor(.black)
                            }
                        }
                        
                        Button()
                        {
                            
                        }
                        label:
                        {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius:10)
                                    .frame(width:58, height:40)
                                    .foregroundColor(Color(.black).opacity(0.2))
                                
                                Text("Week").font(Font.custom("OpenSans-Soft-Bold", size:20)).foregroundColor(.black)
                            }
                        }
                        
                        Button()
                        {
                            
                        }
                        label:
                        {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius:10)
                                    .frame(width:62, height:40)
                                    .foregroundColor(Color(.black).opacity(0.2))
                                
                                Text("Month").font(Font.custom("OpenSans-Soft-Bold", size:20)).foregroundColor(.black)
                            }
                        }
                        
                        Button()
                        {
                            
                        }
                        label:
                        {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius:10)
                                    .frame(width:50, height:40)
                                    .foregroundColor(Color(.black).opacity(0.2))
                                
                                Text("Year").font(Font.custom("OpenSans-Soft-Bold", size:20)).foregroundColor(.black)
                            }
                        }
                        
                        Button()
                        {
                            
                        }
                        label:
                        {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius:10)
                                    .frame(width:80, height:40)
                                    .foregroundColor(Color(.black).opacity(0.2))
                                
                                Text("Custom").font(Font.custom("OpenSans-Soft-Bold", size:20)).foregroundColor(.black)
                            }
                        }
                    }
                    HStack()
                    {
                        Spacer().frame(width:35)
                        Text("Select Variables").font(Font.custom("OpenSans-Soft-Bold", size:25))
                        Spacer()
                    }
                    HStack
                    {
                        Button()
                        {
                            firstActive.toggle()
                            setupData()
                        }
                    label:
                        {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius:10)
                                    .frame(width:55, height:40)
                                    .foregroundColor(Color(.black).opacity(0.2))
                                
                                Text("Mood").font(Font.custom("OpenSans-Soft-Bold", size:20)).foregroundColor(.black)
                            }
                        }
                        
                        Button()
                        {
                            secondActive.toggle()
                            setupData()
                        }
                    label:
                        {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius:10)
                                    .frame(width:65, height:40)
                                    .foregroundColor(Color(.black).opacity(0.2))
                                
                                Text("Sleep").font(Font.custom("OpenSans-Soft-Bold", size:20)).foregroundColor(.black)
                            }
                        }
                        
                        Button()
                        {
                            thirdActive.toggle()
                            setupData()
                        }
                        label:
                        {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius:10)
                                    .frame(width:55, height:40)
                                    .foregroundColor(Color(.black).opacity(0.2))
                                
                                Text("Food").font(Font.custom("OpenSans-Soft-Bold", size:20)).foregroundColor(.black)
                            }
                        }
                        
                        Button()
                        {
                            fourthActive.toggle()
                            setupData()
                        }
                        label:
                        {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius:10)
                                    .frame(width:106, height:40)
                                    .foregroundColor(Color(.black).opacity(0.2))
                                
                                Text("Movement").font(Font.custom("OpenSans-Soft-Bold", size:20)).foregroundColor(.black)
                            }
                        }
                    }
                }
                
                Spacer().frame(height:10)
                
                Chart
                {
                    ForEach(data, id:\.type){ dataSeries in
                        ForEach(dataSeries.dataSet) { data in
                            LineMark(x: .value("Year", data.year),
                                     y: .value("Population", data.population))
                        }
                        //.foregroundStyle(by: .value("Data Type", dataSeries.type))
                        .foregroundStyle(dataSeries.color)
                        .symbol(by: .value("Data Type", dataSeries.type))
                    }
                }
                .chartXScale(domain: 2002...2025)
                .chartYScale(domain:["A", "B", "C", "D", "E"])
                .aspectRatio(1, contentMode: .fit)
                .padding()
            }
            .onAppear()
            {
                setupData()
            }
        }
    }
}

#Preview {
    InsightsView(data:[])
}
