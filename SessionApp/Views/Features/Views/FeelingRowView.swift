import SwiftUI
import SwiftData

struct FeelingRowView: View {
    let item: Item
    
    var body: some View {
        HStack {
            Text(item.feeling)
                .font(.headline)
            Spacer()
            Text(item.timestamp, format: .dateTime.hour().minute())
                .foregroundStyle(.secondary)
        }
    }
}

