//
//  CommunityView.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/3/24.
//

import SwiftUI

class NotificationManager {
    
    static let instance = NotificationManager() // Singleton
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification(title:String, subtitle:String) {
        
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        content.badge = 1 // NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
                
        // time
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60.0, repeats: true)

        // calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 8
//        dateComponents.minute = 0
//        dateComponents.weekday = 2
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // location
//        let coordinates = CLLocationCoordinate2D(
//            latitude: 40.00,
//            longitude: 50.00)
//        let region = CLCircularRegion(
//            center: coordinates,
//            radius: 100,
//            identifier: UUID().uuidString)
//        region.notifyOnEntry = true
//        region.notifyOnExit = true
//        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)

    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}

struct CommunityView: View {
    
    @State var changeProfileImage:Bool = false
    @State var openCameraRoll:Bool = false
    @State var imageSelected:UIImage = UIImage()
    
    @State var notiTitle:String = ""
    @State var notiSub:String = ""
    
    var body: some View {
        ZStack
        {
            Rectangle().fill(Color("BGRev1")).ignoresSafeArea()
            
            VStack
            {
                Text("Community")
                    .frame(maxWidth: .infinity, alignment: .trailing).padding(.horizontal, 20)
                    .font(Font.custom("Roboto", size:38))
                
                ZStack
                {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height:220)
                        .foregroundColor(Color(.white).opacity(0))
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 5)).padding(.horizontal, 20)
                    
                    VStack
                    {
                        HStack
                        {
                            Image("res_hand").resizable().frame(width:200, height:150)
                            
                            VStack
                            {
                                Button()
                                {
                                    changeProfileImage = true
                                    openCameraRoll = true
                                }
                                label:
                                {
                                    if changeProfileImage
                                    {
                                        ZStack
                                        {
                                            Circle().frame(width: 100, height: 100)
                                                .foregroundColor(Color(.white).opacity(0))
                                                .overlay(
                                                    Circle().stroke(.black, lineWidth: 5)).padding(.horizontal, 20)
                                            
                                            Image(uiImage: imageSelected)
                                                .resizable()
                                                .frame(width:120, height:120)
                                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                        }
                                    }
                                    else
                                    {
                                        ZStack
                                        {
                                            Circle().frame(width: 100, height: 100)
                                                .foregroundColor(Color(.white).opacity(0))
                                                .overlay(
                                                    Circle().stroke(.black, lineWidth: 5)).padding(.horizontal, 20)
                                            
                                            Image("add_profile")
                                                .resizable()
                                                .frame(width:120, height:120)
                                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                        }
                                    }
                                }
                                
                                Text("Name")
                                Text("Oakland").opacity(0.5)
                            }
                        }
                        
                        HStack
                        {
                            Spacer()
                            Text("Friends 71 Teachers 12").opacity(0.5)
                        }
                    }.padding(.horizontal, 30)
                    
                }
                
                VStack(spacing:10)
                {
                    Image("res_peer")
                    
                    Button("Request permission")
                    {
                        NotificationManager.instance.requestAuthorization()
                    }
                    
                    TextField("Notification title", text:self.$notiTitle)
                    TextField("Notification subtitle", text:self.$notiSub)
                    Button("Schedule notification")
                    {
                        NotificationManager.instance.scheduleNotification(title: self.notiTitle, subtitle: self.notiSub)
                    }
                    
                    Button("Cancel notification") {
                                    NotificationManager.instance.cancelNotification()
                                }
                    
                    Image("res_facil")
                }.padding(20)
            }
        }.sheet(isPresented:$openCameraRoll)
        {
            ImagePicker(sourceType:.camera, selectedImage:self.$imageSelected)
        }
    }
}

#Preview {
    CommunityView()
}
