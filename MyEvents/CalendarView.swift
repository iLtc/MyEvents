//
//  CalendarView.swift
//  MyEvents
//
//  Created by Alan Luo on 1/20/25.
//

import SwiftUI
import EventKit

struct CalendarView: View {
  let calendars = Event.getAllCalendars()
  @State private var selectedCalendars = Set<EKCalendar>()

  var body: some View {
    List(calendars, id: \.calendarIdentifier, selection: $selectedCalendars) { calendar in
      Button {
        if selectedCalendars.contains(calendar) {
          selectedCalendars.remove(calendar)
        } else {
          selectedCalendars.insert(calendar)
        }
      } label: {
        Text(calendar.title)

        if selectedCalendars.contains(calendar) {
          Image(systemName: "checkmark.circle.fill").foregroundStyle(.green)
        }
      }
    }

    Button("Save") {
      saveEvents()
    }
  }

  func saveEvents() {
    let events = Event.getEvents(for: Array(selectedCalendars))
    var results: [Event] = []

    for event in events {
      if event.isAllDay {
        continue
      }

      print("Title: \(event.title), Start: \(event.startDate), End: \(event.endDate)")

      if let start = event.startDate, let end = event.endDate {
        results.append(Event(start: start, end: end))
      }
    }

    // JSON encode
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    encoder.outputFormatting = .prettyPrinted

    if let data = try? encoder.encode(results) {
      File.save(data)
      NSApp.terminate(self)
    }
  }
}

#Preview {
    CalendarView()
}
