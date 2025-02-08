// Update FeelingsWheelView to use the static function
import SwiftUI

struct FeelingsWheelView: View {
    let sections: [FeelingSection]
    @Binding var selectedSection: FeelingSection?
    let onSectionTapped: (FeelingSection) -> Void
    
    // Add debug state (we can remove this later)
    @State private var showDebugOverlay = false
    
    var body: some View {
        GeometryReader { geometry in
            let wheelSize = min(geometry.size.width, geometry.size.height)
            let center = CGPoint(x: geometry.size.width/2, y: geometry.size.height/2)
            
            ZStack {
                // Visual layer (SVG image)
                Image("Feelings_wheel_1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: wheelSize, height: wheelSize)
                    .rotationEffect(.degrees(180))
                
                // Interactive layer (invisible but handles touches)
                ForEach(sections) { section in
                    PieSection(
                        center: center,
                        radius: FeelingSection.radiusForRing(section.ring, wheelSize: wheelSize),
                        startAngle: section.startAngle,
                        endAngle: section.endAngle,
                        isSelected: selectedSection?.id == section.id
                    )
                    .fill(Color.clear)
                }
                
                // Highlight overlay
                if let section = selectedSection {
                    PieSection(
                        center: center,
                        radius: FeelingSection.radiusForRing(section.ring, wheelSize: wheelSize),
                        startAngle: section.startAngle,
                        endAngle: section.endAngle,
                        isSelected: true
                    )
                    .fill(Color.white.opacity(0.3))
                    //.rotationEffect(.degrees(15))
                }
                
                // Debug center marker (we can remove this later)
                if showDebugOverlay {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 4, height: 4)
                        .position(center)
                    
                    Circle()
                        .stroke(Color.blue, lineWidth: 1)
                        .frame(width: wheelSize, height: wheelSize)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { value in
                        if let section = FeelingSection.findSection(
                            at: value.location,
                            in: geometry,
                            sections: sections
                        ) {
                            onSectionTapped(section)
                        }
                    }
            )
            // Add debug toggle (we can remove this later)
            .onLongPressGesture {
                withAnimation {
                    showDebugOverlay.toggle()
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

// Define PieSection shape
struct PieSection: Shape {
    let center: CGPoint
    let radius: CGFloat
    let startAngle: Double
    let endAngle: Double
    let isSelected: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: center)
        path.addArc(
            center: center,
            radius: radius * (isSelected ? 1.1 : 1.0),
            startAngle: Angle(radians: startAngle),
            endAngle: Angle(radians: endAngle),
            clockwise: false
        )
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    FeelingsWheelView(
        sections: FeelingsWheelViewModel.preview.sections,
        selectedSection: .constant(FeelingsWheelViewModel.preview.selectedSection),
        onSectionTapped: { _ in }
    )
}
