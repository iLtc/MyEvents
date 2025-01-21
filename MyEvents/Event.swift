//
//  Event.swift
//  MyEvents
//
//  Created by Alan Luo on 1/20/25.
//

import EventKit

struct Event: Codable {
  let start: Date
  let end: Date

  static func checkAuthorizationStatus() async -> Bool {
    let status = EKEventStore.authorizationStatus(for: .event)

    switch status {
    case .notDetermined:
      print("Access not determined")
      return await self.requestAccessToCalendar()
    case .authorized:
      print("Access granted")
      return true
    case .restricted, .denied:
      print("Access denied")
      return false
    default:
      print("Default")
      return false
    }
  }

  static func requestAccessToCalendar() async -> Bool {
    let store = EKEventStore()

    do {
      let accessGranted = try await store.requestFullAccessToEvents()

      if accessGranted {
        print("Access granted")
        return true
      } else {
        print("Access denied")
        return false
      }
    } catch {
      print("Error")
      return false
    }
  }

  static func getAllCalendars() -> [EKCalendar] {
    let store = EKEventStore()

    return store.calendars(for: .event)
  }


  static func getEvents(for calendars: [EKCalendar]) -> [EKEvent] {
    let store = EKEventStore()
    let oneWeeksAgo = Date(timeIntervalSinceNow: -604800)
    let twoWeeksAhead = Date(timeIntervalSinceNow: 1209600)
    let predicate = store.predicateForEvents(withStart: oneWeeksAgo, end: twoWeeksAhead, calendars: calendars)

    return store.events(matching: predicate)
  }
}

