import SwiftUI

struct FeelingSection: Identifiable {
    let id = UUID()
    let name: String
    let ring: Int
    let startAngle: Double
    let endAngle: Double
    let color: Color
    var isSelected: Bool = false
}

extension FeelingSection {
    static func findSection(at point: CGPoint, in geometry: GeometryProxy, sections: [FeelingSection]) -> FeelingSection? {
        let center = CGPoint(x: geometry.size.width/2, y: geometry.size.height/2)
        let radius = min(geometry.size.width, geometry.size.height) / 2
        
        return sections.first { section in
            section.contains(point: point, center: center, wheelRadius: radius)
        }
    }

    static func getParentEmotion(for section: FeelingSection) -> String {
        let parentEmotions = [
            (1.047197551...2.094395102, "Mad"),
            (2.094395102...3.141592654, "Scared"),
            (3.141592654...4.188790205, "Joyful"),
            (4.188790205...5.235987756, "Powerful"),
            (5.235987756...6.283185307, "Peaceful"),
            (0.0...1.047197551, "Sad")
        ]
        
        return parentEmotions.first { range, _ in
            range.contains(section.startAngle)
        }?.1 ?? "Unknown"
    }

    // Helper to check if a point is within this section
    func contains(point: CGPoint, center: CGPoint, wheelRadius: CGFloat) -> Bool {
        let dx = point.x - center.x
        let dy = point.y - center.y
        let distance = sqrt(dx*dx + dy*dy)
        var angle = atan2(dy, dx)
        
        // Normalize angle to 0...2π range
        if angle < 0 {
            angle += 2 * .pi
        }
        
        // Updated ring boundaries
        let ringInnerRadius: CGFloat
        let ringOuterRadius: CGFloat
        switch ring {
        case 1: // Inner ring
            ringInnerRadius = 0
            ringOuterRadius = wheelRadius * 0.4
        case 2: // Middle ring
            ringInnerRadius = wheelRadius * 0.4
            ringOuterRadius = wheelRadius * 0.700
        case 3: // Outer ring
            ringInnerRadius = wheelRadius * 0.700
            ringOuterRadius = wheelRadius * 0.95
        default:
            return false
        }
        
        // Check if point is within ring boundaries
        guard distance >= ringInnerRadius && distance <= ringOuterRadius else {
            return false
        }
        
        // Check if point is within angular boundaries
        if startAngle <= endAngle {
            return angle >= startAngle && angle <= endAngle
        } else {
            // Handle sections that cross 0/2π boundary
            return angle >= startAngle || angle <= endAngle
        }
    }

    static func radiusForRing(_ ring: Int, wheelSize: CGFloat) -> CGFloat {
        let radius = wheelSize / 2
        switch ring {
        case 1: return radius * 0.4
        case 2: return radius * 0.7
        case 3: return radius * 0.95
        default: return radius
        }
    }
}
