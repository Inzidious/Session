import SwiftUI
import SwiftData
import Combine
import CachedAsyncImage

let sqsize:CGFloat = 100
let fontSize:CGFloat = 20
let numSquares:Int = 4

struct HomeView: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject var authManager: AuthManager
    @State private var user: User = GlobalUser.shared.user
    @Query var userList:[User]
    @State private var pageNodes:[PageNode]?
    @State private var newsSheet:Bool = false
    @State private var bodyText:String = ""
    @State private var isShowingReminderSheet = false
    @State private var title: String = ""
    
    private let adaptiveColumns = [GridItem(.adaptive(minimum:sqsize))]
    @StateObject var data = SpaceAPI()
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle().fill(Color("BGRev1"))
                ScrollView {
                    VStack {
                        HStack {
                            NavigationLink(destination: ProfileView()) {
                                Image(systemName: "person.circle.fill")
                                    .scaleEffect(1.9)
                                    .font(.title2)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color(red: 225/255, green: 178/255, blue: 107/255),
                                        Color(red: 249/255, green: 240/255, blue: 276/255)
                                    )
                            }
                            .padding(.leading, 50)
                            Spacer()
                            Button(action: { isShowingReminderSheet = true }) {
                                Image(systemName: "bell.badge.fill")
                                    .scaleEffect(1.3)
                                    .font(.title2)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color(red: 249/255, green: 240/255, blue: 276/255),
                                        Color(red: 225/255, green: 178/255, blue: 107/255)
                                    )
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 80)
                        .padding(.trailing, 50)
                        VStack {
                            Spacer().frame(height:25)
                            Text("Welcome back, " + (user.firstName ?? "Guest") + "!")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.openSansSoftBold(size: 28))
                                .padding(.bottom,30)
                            LazyVGrid(columns: [
                                GridItem(.adaptive(minimum: 130), spacing: 20)
                            ], spacing: 40) {
                                NavigationLink(destination:JournalView()) {
                                    smallBoxImage(boxText: "journal")
                                            .scaleEffect(0.75)
                                }
                                NavigationLink(destination: SessionListView(
                                    assetCategory: .constant(""),
                                    assetType: .breathing
                                )) {
                                    smallBoxImage(boxText: "breath")
                                        .scaleEffect(0.75)
                                }
                                smallBoxImage(boxText: "movement")
                                    .scaleEffect(0.75)
                                NavigationLink(destination: SessionMeditation(
                                    assetCategory: .constant("")
                                )) {
                                    smallBoxImage(boxText: "meditation")
                                    .scaleEffect(0.75)
                                }
                            }
                            .padding(.horizontal, 40)
                            Image("healthnews")
                                .padding(.horizontal, 20)
                                .padding(.top, 30)
                                .padding(.leading, 20)
                            if(pageNodes != nil) {
                                ForEach(pageNodes!, id: \.self) { pageNode in
                                    Button(action: {
                                        title = pageNode.title
                                        bodyText = pageNode.body
                                        newsSheet = true
                                    }) {
                                        VStack(alignment: .leading, spacing: 8) {
                                            HStack(alignment: .top, spacing: 12) {
                                                // Article image
                                                CachedAsyncImage(url: URL(string: pageNode.topic)) { phase in
                                                    if let image = phase.image {
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                    } else {
                                                        Image(systemName: "photo")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .foregroundColor(.gray)
                                                    }
                                                }
                                                .frame(width: 60, height: 60)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .background(Color(.systemGray5))
                                                .clipped()

                                                VStack(alignment: .leading, spacing: 4) {
                                                    Text(pageNode.title)
                                                        .font(.headline)
                                                        .foregroundColor(.primary)
                                                        .lineLimit(2)
                                                    Text(pageNode.body)
                                                        .font(.subheadline)
                                                        .foregroundColor(.secondary)
                                                        .lineLimit(3)
                                                }
                                            }
                                        }
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(20)
                                        .shadow(color: Color(.black).opacity(0.05), radius: 4, x: 0, y: 2)
                                        .padding(.horizontal, 50)
                                        .padding(.vertical, 6)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            Spacer().frame(height: 90)
                        }.task {
                            do {
                                try await pageNodes = getExNodes()
                            } catch {}
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .sheet(isPresented: $newsSheet) {
                NewsView(title: title, text: $bodyText)
            }
            .sheet(isPresented: $isShowingReminderSheet) {
                CreateReminderView()
            }
        }
    }
}

struct smallBoxImage: View {
    var boxText = "journal"
    
    var body: some View {
        Image(boxText)
            .scaleEffect(0.75)
            .frame(width: 110, height: 110)
            .scaledToFit()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: SessionEntry.self,
        User.self,
        configurations: config
    )
    
    return HomeView().modelContainer(container)
} 
