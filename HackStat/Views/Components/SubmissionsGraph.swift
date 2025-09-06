//
//  SubmissionsGraph.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 06/09/2025.
//

import SwiftUI

struct SubmissionsGraph: View {
    let submissions: [Submission]
    
    private let weeksToShow = 52
    private let daysInWeek = 7
    private let cellSize: CGFloat = 15
    private let cellSpacing: CGFloat = 4
    
    private var calendar: Calendar {
        var cal = Calendar.current
        cal.firstWeekday = 1
        return cal
    }
    
    private var submissionsByDate: [Date: Int] {
        let grouped = Dictionary(grouping: submissions, by: { calendar.startOfDay(for: $0.date) })
        return grouped.mapValues { $0.reduce(0) { $0 + $1.submissionsCount } }
    }
	
	private var submissionsCount: Int {
		submissions.reduce(0) { $0 + $1.submissionsCount }
	}
    
    private var dateCells: [Date] {
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let daysToAlignToStartOfWeek = (weekday - calendar.firstWeekday + daysInWeek) % daysInWeek
        let startDateOfCurrentWeek = calendar.date(byAdding: .day, value: -daysToAlignToStartOfWeek, to: today)!
        
        let startDate = calendar.date(byAdding: .weekOfYear, value: -(weeksToShow - 1), to: startDateOfCurrentWeek)!
        
        var dates = [Date]()
        for i in 0..<(weeksToShow * daysInWeek) {
            if let date = calendar.date(byAdding: .day, value: i, to: startDate) {
                dates.append(date)
            }
        }
        return dates
    }

    var body: some View {
        let dates = dateCells
        let today = calendar.startOfDay(for: Date())

		VStack(alignment: .leading, spacing: 5) {
			Text("\(submissionsCount) submissions in the last year")
				.bold()
				.padding(.vertical)
			
			ScrollView(.horizontal) {
				HStack(alignment: .top, spacing: cellSpacing) {
					ForEach(0..<weeksToShow, id: \.self) { week in
						VStack(spacing: cellSpacing) {
							ForEach(0..<daysInWeek, id: \.self) { day in
								let index = week * daysInWeek + day
								if index < dates.count {
									let date = dates[index]
									let count = submissionsByDate[calendar.startOfDay(for: date)] ?? 0
									
									Rectangle()
										.fill(date > today ? Color.clear : colorFor(count: count))
										.frame(width: cellSize, height: cellSize)
										.cornerRadius(3)
								}
							}
						}
					}
				}
			}
		}
	}

    private func colorFor(count: Int) -> Color {
        switch count {
        case 0:
            return Color(.systemGray5)
        case 1...2:
            return .accentColor.opacity(0.4)
        case 3...5:
            return .accentColor.opacity(0.7)
        case 6...:
            return .accentColor
        default:
            return .clear
        }
    }
}

#Preview {
    SubmissionsGraph(submissions: Submission.mockSubmissions)
}
