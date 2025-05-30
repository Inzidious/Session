import SwiftUI
import PhotosUI

@MainActor
struct PhotoPickerView: View {
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        NavigationView {
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                VStack(spacing: 20) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("Select a Photo")
                        .font(.title2)
                        .bold()
                    
                    Text("Choose a photo from your library")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Add Photo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .onChange(of: selectedItem) { oldValue, newValue in
            if let newItem = newValue {
                Task {
                    await loadImage(from: newItem)
                }
            }
        }
    }
    
    private func loadImage(from item: PhotosPickerItem) async {
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                selectedImage = image
                dismiss()
            }
        } catch {
            print("Error loading image: \(error)")
        }
    }
}

 
