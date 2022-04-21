//
//  ContentView.swift
//  Date Picker
//
//  Created by Maxence Gama on 17/03/2021.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "BarItem")
    }
    
    @State private var selection: Tab = .dategap
    
    enum Tab {
        case dategap
        case datepreview
    }
    
    var body: some View {
        
        TabView(selection: $selection) {
            DatesGap()
                .tabItem {
                    Label("Gap", systemImage: "calendar.badge.clock")
                }
                .tag(Tab.dategap)

            DatePreview()
                .tabItem {
                    Label("Preview", systemImage: "calendar.circle.fill")
                }
                .tag(Tab.datepreview)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Date {

    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {

        let currentCalendar = Calendar.current

        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }

        return end - start
    }
    
    func addingDaysTo(adding: Int) -> Date {

        let currentCalendar = Calendar.current
        
        var dayComponent = DateComponents()
        dayComponent.day = adding
        let nextDate = currentCalendar.date(byAdding: dayComponent, to: self)

        return nextDate!
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
