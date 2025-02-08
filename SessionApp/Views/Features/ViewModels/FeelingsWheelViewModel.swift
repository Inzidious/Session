// Class implementation
// 2/6/2025
import SwiftUI
import SwiftData

class FeelingsWheelViewModel {
    var selectedSection: FeelingSection?
    let sections: [FeelingSection] = [
        // MARK: - Inner Ring (Core Feelings)
        FeelingSection(
            name: "Mad",
            ring: 1,
            startAngle: 1.047197551,
            endAngle: 2.094395102,
            color: Color(red: 207/255, green: 90/255, blue: 87/255)
        ),
        FeelingSection(
            name: "Scared",
            ring: 1,
            startAngle: 2.094395102,
            endAngle: 3.141592654,
            color: Color(red: 161/255, green: 190/255, blue: 149/255)
        ),
        FeelingSection(
            name: "Joyful",
            ring: 1,
            startAngle: 3.141592654,
            endAngle: 4.188790205,
            color: Color(red: 66/255, green: 111/255, blue: 135/255)
        ),
        FeelingSection(
            name: "Powerful",
            ring: 1,
            startAngle: 4.188790205,
            endAngle: 5.235987756,
            color: Color(red: 225/255, green: 177/255, blue: 106/255)
        ),
        FeelingSection(
            name: "Peaceful",
            ring: 1,
            startAngle: 5.235987756,
            endAngle: 6.283185307,
            color: Color(red: 120/255, green: 165/255, blue: 163/255)
        ),
        FeelingSection(
            name: "Sad",
            ring: 1,
            startAngle: 0,
            endAngle: 1.047197551,
            color: Color(red: 151/255, green: 110/255, blue: 155/255)
        ),

        // MARK: - Middle Ring (2nd Circle)
        // Mad Group
        FeelingSection(
            name: "Hurt",
            ring: 2,
            startAngle: 1.047197551,
            endAngle: 1.221730476,
            color: Color(red: 182/255, green: 78/255, blue: 79/255)
        ),
        FeelingSection(
            name: "Hostile",
            ring: 2,
            startAngle: 1.221730476,
            endAngle: 1.396263402,
            color: Color(red: 182/255, green: 78/255, blue: 79/255)
        ),
        FeelingSection(
            name: "Angry",
            ring: 2,
            startAngle: 1.396263402,
            endAngle: 1.570796327,
            color: Color(red: 182/255, green: 78/255, blue: 79/255)
        ),
        FeelingSection(
            name: "Rage",
            ring: 2,
            startAngle: 1.570796327,
            endAngle: 1.745329252,
            color: Color(red: 182/255, green: 78/255, blue: 79/255)
        ),
        FeelingSection(
            name: "Hateful",
            ring: 2,
            startAngle: 1.745329252,
            endAngle: 1.919862177,
            color: Color(red: 182/255, green: 78/255, blue: 79/255)
        ),
        FeelingSection(
            name: "Critical",
            ring: 2,
            startAngle: 1.919862177,
            endAngle: 2.094395102,
            color: Color(red: 182/255, green: 78/255, blue: 79/255)
        ),

        // Scared Group
        FeelingSection(
            name: "Rejected",
            ring: 2,
            startAngle: 2.094395102,
            endAngle: 2.268928028,
            color: Color(red: 139/255, green: 162/255, blue: 129/255)
        ),
        FeelingSection(
            name: "Confused",
            ring: 2,
            startAngle: 2.268928028,
            endAngle: 2.443460953,
            color: Color(red: 139/255, green: 162/255, blue: 129/255)
        ),
        FeelingSection(
            name: "Helpless",
            ring: 2,
            startAngle: 2.443460953,
            endAngle: 2.617993878,
            color: Color(red: 139/255, green: 162/255, blue: 129/255)
        ),
        FeelingSection(
            name: "Submissive",
            ring: 2,
            startAngle: 2.617993878,
            endAngle: 2.792526803,
            color: Color(red: 139/255, green: 162/255, blue: 129/255)
        ),
        FeelingSection(
            name: "Insecure",
            ring: 2,
            startAngle: 2.792526803,
            endAngle: 2.967059728,
            color: Color(red: 139/255, green: 162/255, blue: 129/255)
        ),
        FeelingSection(
            name: "Anxious",
            ring: 2,
            startAngle: 2.967059728,
            endAngle: 3.141592654,
            color: Color(red: 139/255, green: 162/255, blue: 129/255)
        ),

        // Joyful Group
        FeelingSection(
            name: "Excited",
            ring: 2,
            startAngle: 3.141592654,
            endAngle: 3.316125579,
            color: Color(red: 55/255, green: 92/255, blue: 107/255)
        ),
        FeelingSection(
            name: "Vibrant",
            ring: 2,
            startAngle: 3.316125579,
            endAngle: 3.490658504,
            color: Color(red: 55/255, green: 92/255, blue: 107/255)
        ),
        FeelingSection(
            name: "Energetic",
            ring: 2,
            startAngle: 3.490658504,
            endAngle: 3.665191429,
            color: Color(red: 55/255, green: 92/255, blue: 107/255)
        ),
        FeelingSection(
            name: "Playful",
            ring: 2,
            startAngle: 3.665191429,
            endAngle: 3.839724354,
            color: Color(red: 55/255, green: 92/255, blue: 107/255)
        ),
        FeelingSection(
            name: "Creative",
            ring: 2,
            startAngle: 3.839724354,
            endAngle: 4.01425728,
            color: Color(red: 55/255, green: 92/255, blue: 107/255)
        ),
        FeelingSection(
            name: "Aware",
            ring: 2,
            startAngle: 4.01425728,
            endAngle: 4.188790205,
            color: Color(red: 55/255, green: 92/255, blue: 107/255)
        ),

        // Powerful Group
        FeelingSection(
            name: "Proud",
            ring: 2,
            startAngle: 4.188790205,
            endAngle: 4.36332313,
            color: Color(red: 198/255, green: 154/255, blue: 95/255)
        ),
        FeelingSection(
            name: "Respected",
            ring: 2,
            startAngle: 4.36332313,
            endAngle: 4.537856055,
            color: Color(red: 198/255, green: 154/255, blue: 95/255)
        ),
        FeelingSection(
            name: "Appreciated",
            ring: 2,
            startAngle: 4.537856055,
            endAngle: 4.71238898,
            color: Color(red: 198/255, green: 154/255, blue: 95/255)
        ),
        FeelingSection(
            name: "Hopeful",
            ring: 2,
            startAngle: 4.71238898,
            endAngle: 4.886921906,
            color: Color(red: 198/255, green: 154/255, blue: 95/255)
        ),
        FeelingSection(
            name: "Important",
            ring: 2,
            startAngle: 4.886921906,
            endAngle: 5.061454831,
            color: Color(red: 198/255, green: 154/255, blue: 95/255)
        ),
        FeelingSection(
            name: "Faithful",
            ring: 2,
            startAngle: 5.061454831,
            endAngle: 5.235987756,
            color: Color(red: 198/255, green: 154/255, blue: 95/255)
        ),

        // Peaceful Group
        FeelingSection(
            name: "Nurturing",
            ring: 2,
            startAngle: 5.235987756,
            endAngle: 5.410520681,
            color: Color(red: 100/255, green: 137/255, blue: 133/255)
        ),
        FeelingSection(
            name: "Trusting",
            ring: 2,
            startAngle: 5.410520681,
            endAngle: 5.58505,
            color: Color(red: 100/255, green: 137/255, blue: 133/255)
        ),
        FeelingSection(
            name: "Loving",
            ring: 2,
            startAngle: 5.58505,
            endAngle: 5.75958,
            color: Color(red: 100/255, green: 137/255, blue: 133/255)
        ),
        FeelingSection(
            name: "Intimate",
            ring: 2,
            startAngle: 5.75958,
            endAngle: 5.9341,
            color: Color(red: 100/255, green: 137/255, blue: 133/255)
        ),
        FeelingSection(
            name: "Thoughtful",
            ring: 2,
            startAngle: 5.93411,
            endAngle: 6.1086,
            color: Color(red: 100/255, green: 137/255, blue: 133/255)
        ),
        FeelingSection(
            name: "Content",
            ring: 2,
            startAngle: 6.1086,
            endAngle: 6.2831,
            color: Color(red: 100/255, green: 137/255, blue: 133/255)
        ),
        // Sad Group
        FeelingSection(
            name: "Sleepy",
            ring: 2,
            startAngle: 0.0000,
            endAngle: 0.17453,
            color: Color(red: 124/255, green: 93/255, blue: 130/255)
        ),
        FeelingSection(
            name: "Bored",
            ring: 2,
            startAngle: 0.17453,
            endAngle: 0.3490,
            color: Color(red: 124/255, green: 93/255, blue: 130/255)
        ),
        FeelingSection(
            name: "Lonely",
            ring: 2,
            startAngle: 0.3490,
            endAngle: 0.5235,
            color: Color(red: 124/255, green: 93/255, blue: 130/255)
        ),
        FeelingSection(
            name: "Depressed",
            ring: 2,
            startAngle: 0.5235,
            endAngle: 0.6981,
            color: Color(red: 124/255, green: 93/255, blue: 130/255)
        ),
        FeelingSection(
            name: "Ashamed",
            ring: 2,
            startAngle: 0.6981,
            endAngle: 0.8726,
            color: Color(red: 124/255, green: 93/255, blue: 130/255)
        ),
        FeelingSection(
            name: "Guilty",
            ring: 2,
            startAngle: 0.8726,
            endAngle: 1.0471,
            color: Color(red: 124/255, green: 93/255, blue: 130/255)
        ),
        // MARK: - Outter Ring (Outter Circle)
        FeelingSection(
            name: "Jealous",
            ring: 3,
            startAngle: 1.04719,
            endAngle: 1.2217,
            color: Color(red: 232/255, green: 181/255, blue: 171/255)
        ),
        FeelingSection(
            name: "Shelfish",
            ring: 3,
            startAngle: 1.2217,
            endAngle: 1.3962,
            color: Color(red: 232/255, green: 181/255, blue: 171/255)
        ),
        FeelingSection(
            name: "Frustrated",
            ring: 3,
            startAngle: 1.3962,
            endAngle: 1.5707,
            color: Color(red: 232/255, green: 181/255, blue: 171/255)
        ),
        FeelingSection(
            name: "Furious",
            ring: 3,
            startAngle: 1.5707,
            endAngle: 1.7453,
            color: Color(red: 232/255, green: 181/255, blue: 171/255)
        ),
        FeelingSection(
            name: "Irritated",
            ring: 3,
            startAngle: 1.7453,
            endAngle: 1.9198,
            color: Color(red: 232/255, green: 181/255, blue: 171/255)
        ),
        FeelingSection(
            name: "Skeptical",
            ring: 3,
            startAngle: 1.9198,
            endAngle: 2.0943,
            color: Color(red: 232/255, green: 181/255, blue: 171/255)
        ),
        //Scared Section
        FeelingSection(
            name: "Bewildered",
            ring: 3,
            startAngle: 2.0943,
            endAngle: 2.2689,
            color: Color(red: 161/255, green: 190/255, blue: 141/255)
        ),
        FeelingSection(
            name: "Discouraged",
            ring: 3,
            startAngle: 2.2689,
            endAngle: 2.4434,
            color: Color(red: 161/255, green: 190/255, blue: 141/255)
        ),
        FeelingSection(
            name: "Insignifigant",
            ring: 3,
            startAngle: 2.4434,
            endAngle: 2.6179,
            color: Color(red: 161/255, green: 190/255, blue: 141/255)
        ),
        FeelingSection(
            name: "Weak",
            ring: 3,
            startAngle: 2.6179,
            endAngle: 2.7925,
            color: Color(red: 161/255, green: 190/255, blue: 141/255)
        ),
        FeelingSection(
            name: "Foolish",
            ring: 3,
            startAngle: 2.7925,
            endAngle: 2.9670,
            color: Color(red: 161/255, green: 190/255, blue: 141/255)
        ),
        FeelingSection(
            name: "Embarrased",
            ring: 3,
            startAngle: 2.9670,
            endAngle: 3.1415,
            color: Color(red: 161/255, green: 190/255, blue: 141/255)
        ),
        //Joyfull Section
        FeelingSection(
            name: "Daring",
            ring: 3,
            startAngle: 3.1415,
            endAngle: 3.3161,
            color: Color(red: 66/255, green: 111/255, blue: 135/255)
        ),
        FeelingSection(
            name: "Facinating",
            ring: 3,
            startAngle: 3.3161,
            endAngle: 3.4906,
            color: Color(red: 66/255, green: 111/255, blue: 135/255)
        ),
        FeelingSection(
            name: "Stimulating",
            ring: 3,
            startAngle: 3.4906,
            endAngle: 3.6651,
            color: Color(red: 66/255, green: 111/255, blue: 135/255)
        ),
        FeelingSection(
            name: "Ammused",
            ring: 3,
            startAngle: 3.6651,
            endAngle: 3.8397,
            color: Color(red: 66/255, green: 111/255, blue: 135/255)
        ),
        FeelingSection(
            name: "Extravagant",
            ring: 3,
            startAngle: 3.8797,
            endAngle: 4.0142,
            color: Color(red: 66/255, green: 111/255, blue: 135/255)
        ),
        FeelingSection(
            name: "Delightful",
            ring: 3,
            startAngle: 4.0142,
            endAngle: 4.1887,
            color: Color(red: 66/255, green: 111/255, blue: 135/255)
        ),
        //Powerfull Section
        FeelingSection(
            name: "Cheerful",
            ring: 3,
            startAngle: 4.1887,
            endAngle: 4.3633,
            color: Color(red: 225/255, green: 177/255, blue: 106/255)
        ),
        FeelingSection(
            name: "Sastified",
            ring: 3,
            startAngle: 4.3633,
            endAngle: 4.5378,
            color: Color(red: 225/255, green: 177/255, blue: 106/255)
        ),
        FeelingSection(
            name: "Valuable",
            ring: 3,
            startAngle: 4.5378,
            endAngle: 4.7123,
            color: Color(red: 225/255, green: 177/255, blue: 106/255)
        ),
        FeelingSection(
            name: "Worthwhile",
            ring: 3,
            startAngle: 4.7123,
            endAngle: 4.8869,
            color: Color(red: 225/255, green: 177/255, blue: 106/255)
        ),
        FeelingSection(
            name: "Intellegent",
            ring: 3,
            startAngle: 4.8869,
            endAngle: 5.0164,
            color: Color(red: 225/255, green: 177/255, blue: 106/255)
        ),
        FeelingSection(
            name: "Confident",
            ring: 3,
            startAngle: 5.0614,
            endAngle: 5.2359,
            color: Color(red: 225/255, green: 177/255, blue: 106/255)
        ),
        // Peaceful Section
        FeelingSection(
            name: "Thankful",
            ring: 3,
            startAngle: 5.2359,
            endAngle: 5.4105,
            color: Color(red: 120/255, green: 165/255, blue: 162/255)
        ),
        FeelingSection(
            name: "Sentimental",
            ring: 3,
            startAngle: 5.4105,
            endAngle: 5.5850,
            color: Color(red: 120/255, green: 165/255, blue: 162/255)
        ),
        FeelingSection(
            name: "Serene",
            ring: 3,
            startAngle: 5.5850,
            endAngle: 5.7595,
            color: Color(red: 120/255, green: 165/255, blue: 162/255)
        ),
        FeelingSection(
            name: "Responsive",
            ring: 3,
            startAngle: 5.7595,
            endAngle: 5.9341,
            color: Color(red: 120/255, green: 165/255, blue: 162/255)
        ),
        FeelingSection(
            name: "Relaxed",
            ring: 3,
            startAngle: 5.9341,
            endAngle: 6.1086,
            color: Color(red: 120/255, green: 165/255, blue: 162/255)
        ),
        FeelingSection(
            name: "Pensive",
            ring: 3,
            startAngle: 6.1086,
            endAngle: 6.2831,
            color: Color(red: 120/255, green: 165/255, blue: 162/255)
        ),
        // Sad Section
        FeelingSection(
            name: "Apathetic",
            ring: 3,
            startAngle: 0.0000,
            endAngle: 0.1745,
            color: Color(red: 151/255, green: 110/255, blue: 156/255)
        ),
        FeelingSection(
            name: "Inferior",
            ring: 3,
            startAngle: 0.1745,
            endAngle: 0.3490,
            color: Color(red: 151/255, green: 110/255, blue: 156/255)
        ),
        FeelingSection(
            name: "Inadequate",
            ring: 3,
            startAngle: 0.3490,
            endAngle: 0.5235,
            color: Color(red: 151/255, green: 110/255, blue: 156/255)
        ),
        FeelingSection(
            name: "Miserable",
            ring: 3,
            startAngle: 0.5235,
            endAngle: 0.6981,
            color: Color(red: 151/255, green: 110/255, blue: 156/255)
        ),
        FeelingSection(
            name: "Stupid",
            ring: 3,
            startAngle: 0.6981,
            endAngle: 0.8726,
            color: Color(red: 151/255, green: 110/255, blue: 156/255)
        ),
        FeelingSection(
            name: "Bashful",
            ring: 3,
            startAngle: 0.8726,
            endAngle: 1.0471,
            color: Color(red: 151/255, green: 110/255, blue: 156/255)
        ),
    ]
    
    // Add convenience initializer for previews
    static var preview: FeelingsWheelViewModel {
        let viewModel = FeelingsWheelViewModel()
        // Optionally set a default selected section for preview
        viewModel.selectedSection = viewModel.sections.first
        return viewModel
    }
}

