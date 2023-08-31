//
//  MealDate.swift
//  SmartBite
//
//  Created by Teboho Mohale on 2023/06/28.
//

import SwiftUI
struct MealDate: View {
  @State private var selectedDate = Date()
  @State private var isCalendarPresented = false
  @State private var hoveredDate: Date? = nil
  let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
  let currentDate = Date()
  let calendar = Calendar.current
  @State private var isDatePickerPresented = false
  var body: some View {
    VStack(spacing: 0) {
      NavigationView {
        VStack(spacing: 0) {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
              ForEach(-7..<1) { index in
                let date = calendar.date(byAdding: .day, value: index, to: currentDate)
                let weekday = calendar.component(.weekday, from: date ?? Date())
                Button(action: {
                  selectedDate = date ?? Date()
                    isDatePickerPresented.toggle()
                }) {
                  RoundedRectangle(cornerRadius: 40)
                    .fill(isCurrentDay(date: date) ? Color.blue.opacity(0.9) : (hoveredDate == date ? Color.pink.opacity(0.9) : Color.clear))
                    .frame(width: 55, height: 90)
                    .overlay(
                      VStack {
                        Text(daysOfWeek[weekday - 1])
                          .font(.headline)
                          .foregroundColor(isCurrentDay(date: date) ? .white : .black)
                        Circle()
                          .fill(Color.white)
                          .frame(width: 40, height: 40)
                          .overlay(
                          Text(getDayOfMonth(date: date))
                              .font(.subheadline)
                              .foregroundColor(isCurrentDay(date: date) ? .black : .black)
                          )
                      }
                    )
                }
                .padding(.top)
                .onHover { isHovered in
                  hoveredDate = isHovered ? date : nil
                }
              }
            }
          }
        }
      }
      .fullScreenCover(isPresented: $isDatePickerPresented) {
        CustomDatePicker(currentDate: $selectedDate, isDatePresented: $isDatePickerPresented)
      }
    }
        .frame(height: 170)
  }
  func getDayOfMonth(date: Date?) -> String {
    guard let date = date else { return "" }
    let calendar = Calendar.current
    let dayOfMonth = calendar.component(.day, from: date)
    return "\(dayOfMonth)"
  }
  func isCurrentDay(date: Date?) -> Bool {
    guard let date = date else { return false }
    return calendar.isDate(date, inSameDayAs: currentDate)
  }
}
struct MealDate_Previews: PreviewProvider {
  static var previews: some View {
    MealDate()
  }
}
