import SwiftUI
import SwiftData

struct FeelingsWheelContainerView: View {
    @State private var viewModel = FeelingsWheelViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @Environment(\.dismiss) private var dismiss
    @State private var showConfirmation = false
    @State private var selectedFeeling = ""
    
    var onFeelingSelected: (String) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                FeelingsWheelView(
                    sections: viewModel.sections,
                    selectedSection: $viewModel.selectedSection,
                    onSectionTapped: { section in
                        viewModel.selectedSection = section
                        selectedFeeling = section.name
                        showConfirmation = true
                        
                        // Add haptic feedback
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        
                        // Delay dismissal to show feedback
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            onFeelingSelected(section.name)
                            addSelectedFeeling()
                            dismiss()
                        }
                    }
                )
                
                if showConfirmation {
                    Text("Selected: \(selectedFeeling)")
                        .font(.title3)
                        .foregroundColor(.green)
                        .padding()
                        .transition(.scale.combined(with: .opacity))
                        .animation(.easeInOut, value: showConfirmation)
                }
                
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            FeelingDetailView(item: item)
                        } label: {
                            FeelingRowView(item: item)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Feelings Wheel")
        }
    }
    
    private func addSelectedFeeling() {
        guard let feeling = viewModel.selectedSection?.name else { return }
        withAnimation {
            let newItem = Item(timestamp: Date(), feeling: feeling)
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview("Container Empty") {
    FeelingsWheelContainerView(onFeelingSelected: { _ in })
        .modelContainer(for: Item.self, inMemory: true)
}

