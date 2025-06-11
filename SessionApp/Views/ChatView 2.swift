//
//  ChatView.swift
//  SessionApp
//
//  Created by Shawn McLean on 5/9/25.
//

import SwiftUI
import SendbirdChatSDK
import SendbirdSwiftUI

func InitUser()
{
    SBUGlobals.currentUser = SBUUser(userId:"Mike")
    //SBUGlobals.accessToken = "20adecb99c6fc8cdbcd4b554eaefe88eef4d4f3e"
}

extension NSNotification.Name {
    static let ehNotification: NSNotification.Name = .init(rawValue: "eh_notification")
}

var shareLink:String = ""

class CustomChannelHeader: SBUGroupChannelModule.Header {
    func tapped(){
        let finalString = "https://www.example.com?" + shareLink
        let urlToShare = URL(string: finalString)
        let activityViewController = UIActivityViewController(activityItems: [urlToShare!], applicationActivities: nil)
        
        print(finalString)
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        
        //NotificationCenter.default.post(name: .ehNotification, object: nil)
        
    }
    override func setupViews() {
        super.setupViews()
        print("inside")
        // Hide the right and left buttons
        self.rightBarButton?.image = nil
        self.rightBarButton?.title = "Invite"
        self.rightBarButton?.action = #selector(tapped)
        //self.rightBarButton = nil
        
        //self.rightBarButton
        //self.
        //self.leftBarButton?.isEnabled = false;
        //self.
    }
}

func InitializeChat()
{
    let APP_ID = "8B5EF721-C8DF-4E84-AAF1-4D8CBD6527CF"    // Specify your Sendbird application ID.
            
            SendbirdUI.initialize(
                applicationId: APP_ID
            ) { params in
                // This is the builder block where you can modify the initParameter.
                //
                // [example]
                // params.needsSynchronous = false
                //params.session
            } startHandler: {
                // This is the origin.
                // Initialization of SendbirdSwiftUI has started.
                // We recommend showing a loading indicator once started.
            } migrationHandler: {
                // DB migration has started.
            } completionHandler: { error in
                // If DB migration is successful, proceed to the next step.
                // If DB migration fails, an error exists.
                // We recommend hiding the loading indicator once done.
            }
    
    InitUser()
}

class Cus {
    var query: OpenChannelListQuery?

    func createQuery() {
        self.query = OpenChannel.createOpenChannelListQuery()
    }

    func loadNextPage() {
        self.query?.loadNextPage { channels, error in
            guard error == nil else {
                print("in error: ", error)
                return
            }

            if let chanunw = channels
            {
                print("Size: ", chanunw.count)
            }
            // A list of open channels is retrieved.
        }
    }
}

class Two {
    var query: PublicGroupChannelListQuery?

    func createQuery() {
        self.query = GroupChannel.createPublicGroupChannelListQuery { params in
                    params.includeEmptyChannel = true
                }
    }

    func loadNextPage() {
        self.query?.loadNextPage { channels, error in
            guard error == nil else {
                print("in error: ", error)
                return
            }

            // A list of open channels is retrieved.
        }
    }
}

struct SecondView: View {

    func action2(){
        var cl = Cus()
        cl.createQuery()
        cl.loadNextPage()
    }
    
    func action(){
        
        let params = PublicGroupChannelListQueryParams()
        params.includeEmptyChannel = true
        
        var pquery = GroupChannel.createPublicGroupChannelListQuery(params: params)
        
        pquery.loadNextPage { channels, error in
            guard error == nil else {
                print("in error: ", error)
                return
            }
            
            if let chanunw = channels
            {
                let channel = chanunw[0]
                print("Public: ", channel.isPublic)
                print("Size: ", chanunw.count)
            }
        }
    }
    
    var body: some View {
        
        Button()
        {
            InitializeChat()
        }
    label:
        {
            Text("Init")
        }
        
        Button()
        {
            action2()
        }
    label:
        {
            Text("Hello")
        }
    }
}

#Preview {
    var _ = InitializeChat()
    //OpenChannelListView()
    //SecondView()
    //GroupMainView()
    GroupsView()
    //OpenChannelListView()
}

func createChannel()
{
    let params = GroupChannelCreateParams()
    params.name = "Second Public channel"
    params.isPublic = true
    //params.userIds = ["Ahmed"]

    GroupChannel.createChannel(params: params) { channel, error in
        guard error == nil else {
            print("error crearting")
            return
        }

        // A group channel with the specified users is successfully created.
        // Through the channel parameter of the callback method,
        // you can get the channel's data from the result object
        // that the Sendbird server has passed to the callback method.
    }

}

struct GroupMainView : View {
    @StateObject var provider: OpenChannelListViewProvider
        
        init() {
            //SBUModuleSet.GroupChannelListModule.HeaderComponent = CustomChannelListHeader.self
            //let qParams = GroupChannel.createPublicGroupChannelListQuery();

            // Set the membership filter to exclude yourself
            //qParams.publicMembershipFilter = /GroupChannelListQuery.MembershipFilter.NOT_JOINED;

            
            
                
                        // Through the channels parameter of the callback method,
                        // which the Sendbird server has passed a result list to,
                        // a list of group channels that partially match "Sendbird"
                        // in their names is returned.
                
            
            /*let qParams = GroupChannelListQueryParams()
            qParams.includeEmptyChannel = true
            //qParams.publicChannelFilter = .public
            qParams.order = .chronological
            let query = GroupChannel.createMyGroupChannelListQuery(params: qParams)
            let collection = SendbirdChat.createGroupChannelCollection(query: query)
            // Call hasNext first to check if there are more channels to load.
            if collection?.hasNext == true {
                collection?.loadMore(completionHandler: { channels, error in
                    guard error == nil else {
                        //print("Error")
                        return
                    }
                    // Add channels to your data source.
                    if let chanunw = channels
                    {
                        let channel = chanunw[0]
                        //print("Public: ", channel.isPublic)
                        //print("Size: ", chanunw.count)
                    }
                })
            }*/
            
            // Set your custom list query parameters
            let params = OpenChannelListQueryParams()
            //params.order = .channelNameAlphabetical
            //params.publicChannelFilter = .public
            //params.includeEmptyChannel = true
            //params.publicChannelFilter = .public
            
            //GroupChannel.createGroupChannelListQuery()
            
            //PublicChannelListViewProvider(
            
            let channelListQuery = OpenChannel.createOpenChannelListQuery(params: params)
            _provider = StateObject(wrappedValue: OpenChannelListViewProvider(channelListQuery: channelListQuery))
            
            //createChannel()

        }
        
        var body: some View {
            VStack
            {
                OpenChannelListView(
                    provider: provider,
                    headerItem: {
                        .init()
                        .titleView { config in
                            Text("\(provider.channels.count) channels")
                        }
                    }
                )
            }.onAppear()
            {
                
            }
        }
}

struct AddNewGroupView : View {
    @StateObject var provider = CreateGroupChannelViewProvider()
    
    var body: some View {
        CreateGroupChannelView(provider: provider)
          .onAppear {
            provider.setup()
          }
      }
}



struct GroupsView: View {
    @State private var selectedTab = 1 // 0: Browse, 1: My Groups, 2: My Feed
    @StateObject var provider: OpenChannelListViewProvider
    @StateObject var groupprovider: GroupChannelListViewProvider
    @State var addGroupSheet:Bool = false
    //@ObservedObject var viewController: UIKitToSwiftUIViewController
    
    init() {
        SBUModuleSet.GroupChannelModule.HeaderComponent = CustomChannelHeader.self
        let params = OpenChannelListQueryParams()
        let channelListQuery = OpenChannel.createOpenChannelListQuery(params: params)
        _provider = StateObject(wrappedValue: OpenChannelListViewProvider(channelListQuery: channelListQuery))
        
        let groupparams = GroupChannelListQueryParams()
        groupparams.includeEmptyChannel = true
        let groupchannelListQuery = GroupChannel.createMyGroupChannelListQuery(params: groupparams)
            _groupprovider = StateObject(wrappedValue: GroupChannelListViewProvider(channelListQuery: groupchannelListQuery))
            
            //groupListQuery: groupListQuery))
        
        //createChannel()

    }
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Tabs
                Picker("", selection: $selectedTab) {
                    Text("Browse").tag(0)
                    Text("My Groups").tag(1)
                    Text("My Feed").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                // Content
                if selectedTab == 1 {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            // Groups I manage
                            Section(header: HStack {
                                Text("Groups I manage").font(.headline)
                                Spacer()
                                Button(action: {
                                    //AddNewGroupView()
                                    //CreateGroupChannelView()
                                    addGroupSheet = true
                                }) {
                                    Image(systemName: "plus")
                                }
                            }) {
                                // If no managed groups
                                Text("You don't manage any groups yet.\nPassionate about a particular topic? Create a public or private group today.")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .padding(.vertical)
                            }
                            Divider()

                            // Groups I've joined
                            Section(header: Text("Groups I've joined").font(.headline)) {
                                GroupChannelListView(provider: groupprovider).groupChannelView{
                                    channelURL, startingPoint, messageListParams in
                                    // Customize the messageListParams.
                                    messageListParams?.previousResultSize = 30
                                    messageListParams?.replyType = .onlyReplyToChannel
                                    messageListParams?.includeParentMessageInfo = true
                                    
                                    return GroupChannelView(
                                        provider: GroupChannelViewProvider(
                                            channelURL: channelURL,
                                            startingPoint: startingPoint,
                                            messageListParams: messageListParams
                                        ),
                                        
                                        headerItem: {
                                            .init()
                                            .titleLabel { config  in
                                                Text(config.channel.name)
                                                .padding().onAppear(){shareLink=channelURL}
                                            }
                                        },
                                        listItem: {
                                                                .init()
                                                                .adminMessageView { config in
                                                                                                Text("Hi")
                                                                         .padding()
                                                                         .background(Color.yellow)
                                                                                            }
                                                                .channelStateBanner { config in
                                                                    HStack {
                                                                        Spacer()
                                                                        Text("Channel state goes here")
                                                                        Spacer()
                                                                    }
                                                                    
                                                                }
                                                            }
                                        
                                    )
                                    /*
                                    .channelSettingsView { channelURL in
                                        return Text("Hi")
                                        /*let pro = GroupChannelSettingsViewProvider(channelURL: channelURL)
                                        return GroupChannelSettingsView(provider:pro,
                                                                        listItem: {
                                            .init()
                                            .channelInfo { config in
                                                
                                                let urlToShare = URL(string: "https://www.example.com")
                                                let activityViewController = UIActivityViewController(activityItems: [urlToShare!], applicationActivities: nil)
                                                
                                                
                                                VStack {
                                                    ShareLink(item: URL(string: "https://www.example.com")!) {
                                                        Label("Share", systemImage: "square.and.arrow.up")
                                                    }
                                                    
                                                    
                                                }
                                            }
                                        }
                                        )
                                        //return GroupChannelSettingsView(provider:pro)*/
                                    }*/
                                }
                                    
                                    .frame(minHeight: 300)
                            }
                        }
                        .padding()
                    }
                } else if selectedTab == 0
                {
                    OpenChannelListView(
                        provider: provider
                        
                    )
                }
                
                else {
                    // Implement Browse and My Feed as needed
                    Text("Coming soon…")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("Groups")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented:$addGroupSheet){
                //AddNewGroupView()
                CreateGroupChannelCustomView()
                //CreateGroupChannelView()
            }
        }.onReceive(NotificationCenter.default.publisher(for: .ehNotification)) { _ in
            
           print("Notified")
        }
    }
    
}

