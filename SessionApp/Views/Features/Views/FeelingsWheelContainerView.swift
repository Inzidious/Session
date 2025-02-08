import SwiftUI
import SwiftData

struct FeelingsWheelContainerView: View {
    @State private var viewModel = FeelingsWheelViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    var onFeelingSelected: (String) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                FeelingsWheelView(
                    sections: viewModel.sections,
                    selectedSection: $viewModel.selectedSection,
                    onSectionTapped: { section in
                        viewModel.selectedSection = section
                        onFeelingSelected(section.name)
                        addSelectedFeeling()
                    }
                )
                
                if let selectedSection = viewModel.selectedSection {
                    Text(selectedSection.name)
                        .font(.title2)
                        .padding()
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

