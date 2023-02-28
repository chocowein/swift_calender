//
//  MonthView.swift
//  Calendar
//
//  Created by sa too on 2023/02/24.
//

struct MonthView: View {
    @StateObject var month: Month
    
    var body: some View {
        VStack {
            Text(month.name)
                .font(.headline)
                .padding(.vertical)
            HStack(spacing: 0) {
                ForEach(0..<month.startingDay, id: \.self) { _ in
                    Text(" ")
                        .frame(maxWidth: .infinity)
                }
                ForEach(month.days, id: \.self) { day in
                    DayView(day: day)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}
