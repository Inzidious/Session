import SwiftUI

struct LoadingAnimation: View {
    @State private var opacity: Double = 0.3
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("BGRev1"))
                .ignoresSafeArea()
            
            VStack {
                Image("res_therapy")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.3)
                    .opacity(opacity)
                    .animation(
                        Animation
                            .easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true),
                        value: opacity
                    )
                    .onAppear {
                        opacity = 1.0
                    }
            }
        }
    }
}

#Preview {
    LoadingAnimation()
} 