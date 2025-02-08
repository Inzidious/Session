import SwiftUI
import SwiftData

// Extracted views for better organization
struct FeelingDetailView: View {
    let item: Item
    
    var body: some View {
        VStack(spacing: 20) {
            Text(item.feeling)
                .font(.system(size: 40))
                .bold()
            
            Text("Recorded at")
                .font(.caption)
            
            Text(item.timestamp, format: Date.FormatStyle(date: .complete, time: .standard))
                .font(.headline)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

