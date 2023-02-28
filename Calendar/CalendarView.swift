//
//  CalendarView.swift
//  Calendar
//
//  Created by sa too on 2023/02/24.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var calendar: Calendar
    
    var body: some View {
        VStack {
            HStack {
                ForEach(calendar.daysOfTheWeek, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                }
            }
            ForEach(calendar.months, id: \.self) { month in
                MonthView(month: month)
            }
        }
    }
}
