//
//  CalendarModel.swift
//  Calendar
//
//  Created by sa too on 2023/02/24.
//

// Calendar.swift

class Calendar: ObservableObject {
    @Published
    var months: [Month] = []
    var daysOfTheWeek = ["月", "火", "水", "木", "金", "土", "日"]
    
    init() {
        for monthIndex in 1...12 {
            let month = Month(monthIndex: monthIndex)
            months.append(month)
        }
    }
}

// Month.swift

class Month: Identifiable, Equatable {
    let id = UUID()
    let monthIndex: Int
    var name: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M月"
        return formatter.string(from: firstDayOfMonth)
    }
    var days: [Day] = []
    var startingDay: Int {
        let weekday = Calendar.current.component(.weekday, from: firstDayOfMonth)
        return weekday - 2 // 月曜日からスタートするため、1を引く
    }
    var firstDayOfMonth: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let dateString = "\(Calendar.current.component(.year, from: Date())) \(monthIndex) 01"
        return formatter.date(from: dateString)!
    }
    var lastDayOfMonth: Date {
        let dateComponents = DateComponents(year: Calendar.current.component(.year, from: firstDayOfMonth),
                                             month: monthIndex,
                                             day: 0)
        return Calendar.current.date(from: dateComponents)!
    }
    
    init(monthIndex: Int) {
        self.monthIndex = monthIndex
        for dayIndex in 1...lastDayOfMonth.day {
            let day = Day(number: dayIndex, color: colorFor(dayIndex))
            days.append(day)
        }
    }
    
    static func == (lhs: Month, rhs: Month) -> Bool {
        lhs.id == rhs.id
    }
    
    private func colorFor(_ dayIndex: Int) -> Color {
        let weekday = (startingDay + dayIndex) % 7
        switch weekday {
        case 5:
            return .blue // 土曜日
        case 6:
            return .red // 日曜日
        default:
            return .black // 平日
        }
    }
}

// Day.swift

class Day: Identifiable, Equatable {
    let id = UUID()
    let number: Int
    let color: Color
    
    init(number: Int, color: Color) {
        self.number = number
        self.color = color
    }
    
    static func == (lhs: Day, rhs: Day) -> Bool {
        lhs.id == rhs.id
    }
}
