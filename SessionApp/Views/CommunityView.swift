//
//  CommunityView.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/3/24.
//

import SwiftUI

class NotificationManager: ObservableObject {
    
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
    @State private var changeProfileImage = false
    @State private var openCameraRoll = false
    @State private var imageSelected = UIImage()
    
    // Move notification testing states to a separate debug view
    @State private var showDebugMenu = false
    
    var body: some View {
        ZStack {
            Color("BGRev1")
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 16) {
                    // Header
                    Text("Community")
                        .font(.system(size: 34, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // Profile Card
                    ProfileCardView(
                        profileImage: $imageSelected,
                        hasSelectedImage: $changeProfileImage,
                        openCameraRoll: $openCameraRoll
                    )
                    
                    // Community Content
                    VStack(spacing: 16) {
                        CommunityImageSection(
                            imageName: "peer_group",
                            title: "Peer Groups",
                            buttonImage: "PeerGroupButton"
                        )
                        CommunityImageSection(
                            imageName: "facilitated_group",
                            title: "Facilitated Groups",
                            buttonImage: "FacilitatedGroupButton"
                        )
                    }
                    .padding(.horizontal)
                    
                    // Add some bottom padding to ensure last item is visible
                    Spacer()
                        .frame(height: 20)
                }
                .padding(.vertical, 12)
            }
        }
        .sheet(isPresented: $openCameraRoll) {
            ImagePicker(
                sourceType: .camera,
                selectedImage: $imageSelected
            )
        }
        #if DEBUG
        .overlay(alignment: .bottomTrailing) {
            debugButton
        }
        #endif
    }
    
    #if DEBUG
    private var debugButton: some View {
        Button {
            showDebugMenu.toggle()
        } label: {
            Image(systemName: "ant.circle.fill")
                .font(.title)
        }
        .padding()
        .sheet(isPresented: $showDebugMenu) {
            NotificationDebugView()
        }
    }
    #endif
}

// MARK: - Supporting Views

struct ProfileCardView: View {
    @Binding var profileImage: UIImage
    @Binding var hasSelectedImage: Bool
    @Binding var openCameraRoll: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 20) {
                Image("res_hand")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160)
                
                VStack(spacing: 12) {
                    ProfileImageButton(
                        profileImage: profileImage,
                        hasSelectedImage: hasSelectedImage,
                        action: {
                            hasSelectedImage = true
                            openCameraRoll = true
                        }
                    )
                    
                    VStack(spacing: 4) {
                        Text("Name")
                            .font(.headline)
                        Text("Oakland")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            HStack {
                Spacer()
                Text("Friends 71 • Teachers 12")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.primary, lineWidth: 2)
        }
        .padding(.horizontal)
    }
}

struct ProfileImageButton: View {
    let profileImage: UIImage
    let hasSelectedImage: Bool
    let action: () -> Void
    
    var body: some View {
        NavigationLink(destination: ProfileView()) {
            if hasSelectedImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
            } else {
                Image("add_profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
            }
        }
    }
}

struct CommunityImageSection: View {
    let imageName: String
    let title: String
    let buttonImage: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .center, spacing: 20) {
                // Left side artwork
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 100)
                
                Spacer()
                
                // Right side button image
                Image(buttonImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.trailing, 8)
            }
            
            HStack {
                Spacer()
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.primary, lineWidth: 2)
        }
        .padding(.horizontal)
    }
}

// MARK: - Debug Views
#if DEBUG
struct NotificationDebugView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var notificationManager = NotificationManager()
    @State private var title = ""
    @State private var subtitle = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Notification Test") {
                    TextField("Title", text: $title)
                    TextField("Subtitle", text: $subtitle)
                    
                    Button("Request Permission") {
                        notificationManager.requestAuthorization()
                    }
                    
                    Button("Schedule") {
                        notificationManager.scheduleNotification(
                            title: title,
                            subtitle: subtitle
                        )
                    }
                    
                    Button("Cancel All", role: .destructive) {
                        notificationManager.cancelNotification()
                    }
                }
            }
            .navigationTitle("Debug Menu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
#endif

#Preview {
    CommunityView()
}
