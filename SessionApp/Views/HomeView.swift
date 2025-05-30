import SwiftUI
import SwiftData
import Combine

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
                            Spacer().frame(height:75)
                            Text("Welcome back, " + (user.firstName ?? "Guest") + "!")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.openSansSoftBold(size: 28))
                            LazyVGrid(columns: [
                                GridItem(.adaptive(minimum: 130), spacing: 20)
                            ], spacing: 20) {
                                NavigationLink(destination:JournalView()) {
                                    smallBoxImage()
                                }
                                NavigationLink(destination: SessionListView(
                                    assetCategory: .constant(""),
                                    assetType: .breathing
                                )) {
                                    smallBoxImage(boxText: "breath")
                                }
                                smallBoxImage(boxText: "movement")
                                NavigationLink(destination: SessionMeditation(
                                    assetCategory: .constant("")
                                )) {
                                    smallBoxImage(boxText: "meditation")
                                }
                            }
                            .padding(.horizontal, 40)
                            Image("healthnews")
                                .padding(.horizontal, 20)
                                .padding(.top, 30)
                            if(pageNodes != nil) {
                                ForEach(pageNodes!, id: \.self) { pageNode in
                                    Button() {
                                        bodyText = pageNode.body
                                        newsSheet = true
                                    } label: {
                                        let result = pageNode.title.replacingOccurrences(of: "      ", with: "")
                                        NewsViewTopic(title:result,
                                                      imageUrl: pageNode.topic,
                                                      siteName: pageNode.topic,
                                                      summary: pageNode.body)
                                    }
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
                NewsView(text: $bodyText)
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
            .resizable()
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
