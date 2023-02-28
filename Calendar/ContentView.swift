//
//  ContentView.swift
//  Calendar
//
//  Created by sa too on 2023/02/24.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            headerView
            weekdayView
            calendarGridView
        }
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {
                selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate)!
            }, label: {
                Image(systemName: "chevron.left")
            })
            
            Text("\(selectedDate, formatter: DateFormatter.yearMonth)")
            
            Button(action: {
                selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate)!
            }, label: {
                Image(systemName: "chevron.right")
            })
        }
    }
    
    private var weekdayView: some View {
        HStack {
            ForEach(Calendar.current.shortWeekdaySymbols, id: \.self) { weekday in
                Text(weekday)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 8)
        .border(Color.gray)
    }
    
    private var calendarGridView: some View {
        let daysInMonth = Calendar.current.range(of: .day, in: .month, for: selectedDate)!
        let monthStartDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: selectedDate))!
        let monthEndDate = Calendar.current.date(byAdding: .day, value: daysInMonth.count-1, to: monthStartDate)!
        let startDateOffset = Calendar.current.component(.weekday, from: monthStartDate) - 1
        let endDateOffset = 7 - Calendar.current.component(.weekday, from: monthEndDate)
        let daysToShow = daysInMonth.count + startDateOffset + endDateOffset
        let daysArray = (0..<daysToShow).map {
            let dayOffset = $0 - startDateOffset
            let date = Calendar.current.date(byAdding: .day, value: dayOffset, to: monthStartDate)
            return date
        }
        
        return LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 7), spacing: 10) {
                    ForEach(daysArray, id: \.self) { date in
                        if let date = date {
                            let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
                            let isWithinDisplayedMonth = Calendar.current.isDate(date, equalTo: selectedDate, toGranularity: .month)
                            let isSaturday = Calendar.current.component(.weekday, from: date) == 7
                            let isSunday = Calendar.current.component(.weekday, from: date) == 1
                            
                            Button(action: {
                                selectedDate = date
                            }, label: {
                                Text("\(Calendar.current.component(.day, from: date))")
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(isWithinDisplayedMonth ? (isSaturday ? .blue : (isSunday ? .red : .primary)) : .secondary)
                                    .background(isSelected ? Color.blue : Color.clear)
                                    .clipShape(Circle())
                                    .padding(.vertical, 8)
                            })
                        } else {
                            Text("")
                                .hidden()
                        }
                    }
                }
        .padding(.horizontal, 10)
    }
}

extension DateFormatter {
    static let yearMonth: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        return formatter
    }()
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
