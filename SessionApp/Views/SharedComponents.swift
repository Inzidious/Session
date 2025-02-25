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
    @State private var isShowingFeelingsWheel = false
    @State private var isShowingBodySheet = false
    @State private var isShowingReminderSheet = false
    @State private var bodyValue = "None"
    
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
                
                // Helper tools row
                HStack(spacing: 20) {
                    // Feelings Wheel Button
                    Button {
                        isShowingFeelingsWheel = true
                    } label: {
                        VStack {
                            Image("feelings_wheel_icon")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("Emotions")
                                .font(.custom("OpenSans-Regular", size: 12))
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 2)
                    
                    // Body Picker Button
                    Button {
                        isShowingBodySheet = true
                    } label: {
                        VStack {
                            Image("body_picker")
                                .resizable()
                                .frame(width: 30, height: 40)
                            Text("Body")
                                .font(.custom("OpenSans-Regular", size: 12))
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 2)
                    
                    // Add Reminder Button
                    Button {
                        isShowingReminderSheet = true
                    } label: {
                        VStack {
                            Image(systemName: "bell.badge.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                            Text("Reminder")
                                .font(.custom("OpenSans-Regular", size: 12))
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 2)
                }
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
        .sheet(isPresented: $isShowingFeelingsWheel) {
            FeelingsWheelContainerView(onFeelingSelected: { feeling in
                entry += feeling.isEmpty ? feeling : "\n" + feeling
                isShowingFeelingsWheel = false
            })
        }
        .sheet(isPresented: $isShowingBodySheet) {
            BodyImage(bodyvalue: $bodyValue)
        }
        .sheet(isPresented: $isShowingReminderSheet) {
            CreateReminderView()
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

struct boxStackViewClear: View {
    var bodyText = ""
    var answerText = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Main white container
            VStack(alignment: .leading, spacing: 8) {
                // Question text
                Text(bodyText)
                    .foregroundColor(.black)
                    .font(.custom("OpenSans-Regular", size: 18))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .fixedSize(horizontal: false, vertical: true) // Allows text to wrap properly
                
                // Answer text (if exists)
                if !answerText.isEmpty {
                    Text(answerText)
                        .font(.custom("OpenSans-Regular", size: 14))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 12)
                }
            }
            .frame(width: 260)  // Narrower to avoid spiral
            .frame(minHeight: 50)  // Taller minimum height
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.1), lineWidth: 1)
            )
            .shadow(
                color: Color.black.opacity(0.15),
                radius: 4,
                x: 0,
                y: 2
            )
        }
        .padding(.leading, 60)  // More padding to avoid spiral
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
