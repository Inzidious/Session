//
//  InsightsView.swift
//  SessionApp
//
//  Created by Shawn McLean on 12/3/24.
//  Updated by Ahmed Shuja on 6/5/25.
//

import SwiftUI
import Charts

struct InsightsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var metricsManager = HealthMetricsManager()
    @State private var selectedCategories: Set<MetricCategory> = [.sleep, .food, .movement]
    @State private var selectedTimeFrame: TimeFrame = .sixMonths
    @State private var selectedMood: Mood? = nil
    
    enum TimeFrame: String, CaseIterable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        case sixMonths = "6 Months"
        
        var dateRange: (Date, Date) {
            let calendar = Calendar.current
            let now = Date()
            switch self {
            case .day:
                let start = calendar.startOfDay(for: now)
                return (start, now)
            case .week:
                let start = calendar.date(byAdding: .day, value: -7, to: now) ?? now
                return (start, now)
            case .month:
                let start = calendar.date(byAdding: .month, value: -1, to: now) ?? now
                return (start, now)
            case .sixMonths:
                let start = calendar.date(byAdding: .month, value: -6, to: now) ?? now
                return (start, now)
            }
        }
    }
    
    var xAxisStride: Calendar.Component {
        switch selectedTimeFrame {
        case .sixMonths: return .month
        case .month: return .weekOfYear
        case .week, .day: return .day
        }
    }

    var xAxisLabelFormat: Date.FormatStyle {
        switch selectedTimeFrame {
        case .sixMonths: return .dateTime.month()
        case .month, .week, .day: return .dateTime.day().month()
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("ShGreen").opacity(0.4))
                .ignoresSafeArea()
            
            VStack {
                // Header
                HeaderView(dismiss: dismiss)
                
                Spacer().frame(height: 10)
                
                // Controls
                TimeFrameSelectionView(selectedTimeFrame: $selectedTimeFrame)
                CategorySelectionView(selectedCategories: $selectedCategories)
                
                Spacer().frame(height: 10)
                
                MoodFilterView(selectedMood: $selectedMood)
                
                if selectedMood != nil {
                    Button("Clear Mood Filter") {
                        selectedMood = nil
                    }
                    .padding(.leading)
                }
                
                // Chart
                let (startDate, endDate) = selectedTimeFrame.dateRange
                InsightsChartView(
                    metricsManager: metricsManager,
                    selectedCategories: selectedCategories,
                    selectedMood: selectedMood,
                    startDate: startDate,
                    endDate: endDate,
                    xAxisStride: xAxisStride,
                    xAxisLabelFormat: xAxisLabelFormat
                )
            }
        }
    }
}

// MARK: - Header View
struct HeaderView: View {
    let dismiss: DismissAction
    
    var body: some View {
        HStack {
            Button(action: { dismiss() }) {
                HStack {
                    Image(systemName: "arrow.left.circle")
                        .font(.title2)
                        .foregroundColor(Color(#colorLiteral(red: 0.8823529412, green: 0.6941176471, blue: 0.4156862745, alpha: 1)))
                        .scaleEffect(1.25)
                }
            }
            .padding(.leading, 50)
            
            Spacer()
            Image("icon_tracking")
                .resizable()
                .frame(width: 50, height: 50)
            Text("Insights")
                .font(Font.custom("OpenSans-Bold", size: 45))
            Spacer()
                .frame(width: 40)
        }
    }
}

// MARK: - Chart Data Model
struct ChartDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let value: Int
    let category: MetricCategory
}

// MARK: - Chart View
struct InsightsChartView: View {
    let metricsManager: HealthMetricsManager
    let selectedCategories: Set<MetricCategory>
    let selectedMood: Mood?
    let startDate: Date
    let endDate: Date
    let xAxisStride: Calendar.Component
    let xAxisLabelFormat: Date.FormatStyle
    
    // Computed property to prepare chart data
    private var chartData: [ChartDataPoint] {
        var dataPoints: [ChartDataPoint] = []
        
        let allEntries = metricsManager.entries.filter { $0.date >= startDate && $0.date <= endDate }
        let filteredEntries = filterEntriesByMood(allEntries)
        
        for category in selectedCategories {
            for entry in filteredEntries {
                let value: MetricLevel
                switch category {
                    case .sleep: value = entry.sleep
                    case .food: value = entry.food
                    case .movement: value = entry.movement
                    case .irritability: value = entry.irritability
                    case .menstrualCycle: value = entry.menstrualCycle
                }
                let dataPoint = ChartDataPoint(
                    date: entry.date,
                    value: value.rawValue,
                    category: category
                )
                dataPoints.append(dataPoint)
            }
        }
        
        return dataPoints
    }
    
    // Helper method to filter entries by mood
    private func filterEntriesByMood(_ entries: [HealthMetricEntry]) -> [HealthMetricEntry] {
        guard let selectedMood = selectedMood else { return entries }
        return entries.filter { $0.feeling == selectedMood.rawValue }
    }

    var body: some View {
        Chart(chartData) { dataPoint in
            LineMark(
                x: .value("Date", dataPoint.date),
                y: .value("Level", dataPoint.value)
            )
            .foregroundStyle(by: .value("Category", dataPoint.category.shortDisplayName))
            .symbol(by: .value("Category", dataPoint.category.shortDisplayName))
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: xAxisStride)) { value in
                AxisGridLine()
                AxisValueLabel(format: xAxisLabelFormat)
            }
        }
        .chartYAxis {
            AxisMarks(values: .automatic) { value in
                AxisGridLine()
                AxisValueLabel {
                    if let intValue = value.as(Int.self) {
                        Text(MetricLevel(rawValue: intValue)?.description ?? "")
                    }
                }
            }
        }
        .chartXScale(domain: startDate...endDate)
        .frame(height: 300)
        .padding(.horizontal, 32)
        .padding(.bottom)
    }
}

// MARK: - Category Selection View
struct CategorySelectionView: View {
    @Binding var selectedCategories: Set<MetricCategory>
    
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 35)
                Text("Select Variables")
                    .font(Font.custom("OpenSans-Soft-Bold", size: 25))
                Spacer()
            }
            HStack {
                ForEach(MetricCategory.allCases, id: \.self) { category in
                    CategoryButton(
                        category: category,
                        isSelected: selectedCategories.contains(category)
                    ) {
                        toggleCategory(category)
                    }
                }
            }
        }
    }
    
    private func toggleCategory(_ category: MetricCategory) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}

struct CategoryButton: View {
    let category: MetricCategory
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 70, height: 40)
                    .foregroundColor(isSelected ? Color("ShGreen") : Color(.black).opacity(0.2))
                Text(category.shortDisplayName)
                    .font(Font.custom("OpenSans-Soft-Bold", size: 20))
                    .foregroundColor(isSelected ? .white : .black)
            }
        }
    }
}

// MARK: - Time Frame Selection View
struct TimeFrameSelectionView: View {
    @Binding var selectedTimeFrame: InsightsView.TimeFrame
    
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 35)
                Text("Select Time Frame")
                    .font(Font.custom("OpenSans-Soft-Bold", size: 25))
                Spacer()
            }
            HStack {
                ForEach(InsightsView.TimeFrame.allCases, id: \.self) { timeFrame in
                    TimeFrameButton(
                        timeFrame: timeFrame,
                        isSelected: selectedTimeFrame == timeFrame
                    ) {
                        selectedTimeFrame = timeFrame
                    }
                }
            }
        }
    }
}

struct TimeFrameButton: View {
    let timeFrame: InsightsView.TimeFrame
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: timeFrame == .sixMonths ? 90 : 60, height: 40)
                    .foregroundColor(isSelected ? Color("ShGreen") : Color(.black).opacity(0.2))
                Text(timeFrame.rawValue)
                    .font(Font.custom("OpenSans-Soft-Bold", size: 20))
                    .foregroundColor(isSelected ? .white : .black)
            }
        }
    }
}

// MARK: - Mood Filter View
struct MoodFilterView: View {
    @Binding var selectedMood: Mood?

    var body: some View {
        HStack {
            ForEach(Mood.allCases, id: \.self) { mood in
                MoodButton(
                    mood: mood,
                    isSelected: selectedMood == mood
                ) {
                    selectedMood = (selectedMood == mood) ? nil : mood
                }
            }
        }
        .padding(.horizontal)
    }
}

struct MoodButton: View {
    let mood: Mood
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(mood.description)
                    .font(.caption)
                    .padding(8)
                    .background(isSelected ? Color.blue.opacity(0.7) : Color.gray.opacity(0.2))
                    .foregroundColor(isSelected ? .white : .black)
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    InsightsView()
}