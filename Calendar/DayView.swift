//
//  DayView.swift
//  Calendar
//
//  Created by sa too on 2023/02/24.
//

struct DayView: View {
    @StateObject var day: Day
    
    var body: some View {
        Text("\(day.number)")
            .foregroundColor(day.color)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
    }
}
