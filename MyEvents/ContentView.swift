//
//  ContentView.swift
//  MyEvents
//
//  Created by Alan Luo on 1/20/25.
//

import SwiftUI

struct ContentView: View {
  @State private var isAuthorized: Bool = false

  var body: some View {
      VStack {
        if isAuthorized {
          CalendarView()
        } else {
          Image(systemName: "lock")
            .imageScale(.large)
            .foregroundStyle(.tint)
          Text("Please grant access to your calendar")
        }
      }
      .padding()
      .onAppear {
        Task {
          isAuthorized = await Event.checkAuthorizationStatus()
        }
      }
  }
}

#Preview {
    ContentView()
}
