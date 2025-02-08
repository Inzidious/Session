import SwiftUI
import SwiftData

struct addEditorSheet: View {
    @EnvironmentObject var globalCluster: PromptCluster
    var promptEntry: PromptEntry
    var currentSession: SessionEntry?
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    
    @State private var entry: String = ""
    @State private var data: Date = .now
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Question display
                Text(promptEntry.promptQuestion)
                    .font(.custom("OpenSans-Regular", size: 20))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                
                // Text input area
                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Response")
                        .font(.custom("OpenSans-Regular", size: 16))
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    TextEditor(text: $entry)
                        .font(.custom("OpenSans-Regular", size: 18))
                        .frame(minHeight: 200)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemBackground))
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
                .padding(.horizontal)
                
                // Date picker
                VStack(alignment: .leading, spacing: 8) {
                    Text("Date")
                        .font(.custom("OpenSans-Regular", size: 16))
                        .foregroundColor(.secondary)
                    
                    DatePicker("", selection: $data, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemBackground))
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.custom("OpenSans-Regular", size: 17))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveEntry()
                        dismiss()
                    }
                    .font(.custom("OpenSans-Regular", size: 17))
                    .foregroundColor(.blue)
                }
            }
        }
        .onAppear {
            if let e = globalCluster.selectedEntry.journalEntry {
                entry = e.promptAnswer
            }
        }
    }
    
    private func saveEntry() {
        if let currentEntry = promptEntry.journalEntry {
            currentEntry.promptAnswer = entry
            globalCluster.promptEntries[globalCluster.selectedEntry.promptID].promptAnswer = entry
        } else {
            let newEntry = JournalEntry(
                promptId: globalCluster.selectedEntry.promptID,
                promptAnswer: entry,
                sessionID: currentSession!.sessionID,
                sessionEntry: currentSession
            )
            
            if(globalCluster.selectedEntry.promptID >= 0 && globalCluster.selectedEntry.promptID < 5) {
                globalCluster.promptEntries[globalCluster.selectedEntry.promptID].promptAnswer = entry
            }
            
            context.insert(newEntry)
        }
    }
}

struct boxStackViewNoTitle: View
{
    var bodyText = ""
    var iconName = "tram.circle.fill"
    var boxHeight = 200.0;
    var backColor = Color.red
    var answerText = ""
    
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .frame(width:350, height:boxHeight)
                .foregroundColor(backColor)
                .cornerRadius(10)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x:10, y:10)
            
            HStack
            {
                Image(systemName: iconName)
                
                VStack
                {
                    Text(bodyText)
                        .foregroundColor(.black)
                        .font(Font.custom("OpenSans-Regular", size:20))
                        .padding(10)
                        .frame(width:250, alignment: .bottomLeading)
                        .multilineTextAlignment(.leading)
                    
                    Text(answerText)
                }
                
                Image(systemName: "arrow.right")
            }
            
        }.frame(maxWidth:.infinity, alignment: .center)
    }
}

struct boxStackViewClear: View
{
    var bodyText = ""
    var iconName = "tram.circle.fill"
    var boxHeight = 200.0;
    var backColor = Color.red
    var answerText = ""
    
    var body: some View
    {
        VStack(spacing: 8) {
            ZStack {
                Rectangle()
                    .frame(width: 220, height: 40)
                    .foregroundColor(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                Text(bodyText)
                    .foregroundColor(.black)
                    .font(Font.custom("OpenSans-Regular", size: 16))
                    .padding(8)
                    .frame(width: 200, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            
            if !answerText.isEmpty {
                Text(answerText)
                    .font(Font.custom("OpenSans-Regular", size: 14))
                    .foregroundColor(.gray)
                    .frame(width: 200, alignment: .leading)
            }
        }
        .padding(.horizontal)
    }
}

extension View {
    func PPrint(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}

private func lastLocationPosition() -> Int? {
    var fetchDescriptor = FetchDescriptor<SessionEntry>()
    fetchDescriptor.propertiesToFetch = [\SessionEntry.sessionID]
    do {
        return nil //locations.map({ $0.sessionID }).max()
    } catch let error {
        print("*** cannot fetch locations: \(error.localizedDescription)")
        return nil
    }
}
