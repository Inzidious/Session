import SwiftUI

struct SectionView: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(content)
                .font(.body)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    SectionView(
        title: "Sample Title",
        content: "This is a sample content for the preview."
    )
} 
