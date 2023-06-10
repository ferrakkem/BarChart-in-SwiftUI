//
//  ContentView.swift
//  BartChart
//
//  Created by Ferrakkem Bhuiyan on 2023-03-21.
//

import SwiftUI
import Charts

struct ContentView: View {
    let viewMonths: [ViewMonth] = [
        .init(date: Date.from(year: 2023, month: 1, day: 1), viewCount: 295000),
        .init(date: Date.from(year: 2023, month: 2, day: 1), viewCount: 98000),
        .init(date: Date.from(year: 2023, month: 3, day: 1), viewCount: 99000),
        .init(date: Date.from(year: 2023, month: 4, day: 1), viewCount: 165000),
        .init(date: Date.from(year: 2023, month: 5, day: 1), viewCount: 65000),
        .init(date: Date.from(year: 2023, month: 6, day: 1), viewCount: 125000),
        .init(date: Date.from(year: 2023, month: 7, day: 1), viewCount: 85000),
        .init(date: Date.from(year: 2023, month: 8, day: 1), viewCount: 95000),
        .init(date: Date.from(year: 2023, month: 9, day: 1), viewCount: 545000),
        .init(date: Date.from(year: 2023, month: 10, day: 1), viewCount: 235000),
        .init(date: Date.from(year: 2023, month: 11, day: 1), viewCount: 535000),
        .init(date: Date.from(year: 2023, month: 12, day: 1), viewCount: 135000),
    ]
    
    var body: some View {
        VStack {
            Text("YouTube Views")
            
            
            Text("Total: \(viewMonths.reduce(0, { $0 + $1.viewCount }))")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
            
            Chart {
                ForEach(viewMonths) { viewMonth in
                    BarMark(
                        x: .value("Month", viewMonth.date, unit: .month),
                        y: .value("Views", viewMonth.viewCount))
                }
                .foregroundStyle(Color.red.gradient)
                .cornerRadius(10)
                
                RuleMark(y: .value("Gola", 80000))
                    .foregroundStyle(.brown)
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                    .annotation(alignment: .leading) {
                        Text("Goal")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
            }
            .frame(height: 180)
            .chartXAxis {
                AxisMarks(values: viewMonths.map {$0.date}) { date in
                    AxisValueLabel(format: .dateTime.month(.narrow))
                }
            }

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ViewMonth: Identifiable {
    let id = UUID()
    let date: Date
    let viewCount: Int
}


extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}
