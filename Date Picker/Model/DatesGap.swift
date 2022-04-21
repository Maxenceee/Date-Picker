//
//  DatesGap.swift
//  Date Picker
//
//  Created by Maxence Gama on 21/02/2022.
//

import SwiftUI

struct DatesGap: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var body: some View {
        VStack {
            Text("Calculateur d'écart entre deux dates")
                .font(.title2)
                .padding()
                .multilineTextAlignment(.center)
            
            Form {
                DatePicker("Départ", selection: $startDate, displayedComponents: .date)
                    .padding()
                DatePicker("Fin", selection: $endDate, displayedComponents: .date)
                    .padding()
                HStack {
                    Spacer()
                    Text(dateCalculator(startDate, endDate))
                        .padding(.vertical, 30)
                        .multilineTextAlignment(.center)
                        .font(.body)
                    Spacer()
                }
            }
        }
    }
    
    private func dateCalculator(_ start: Date, _ end: Date) -> String {
        let diff = end.interval(ofComponent: .day, fromDate: start)
        
        let result: String
        
        if diff != 0 {
            result = String(diff) + " jours d'écart entre ces deux dates"
        } else {
            result = "Séléctionner au moins une date"
        }
        
        return result
    }
}

struct DatesGap_Previews: PreviewProvider {
    static var previews: some View {
        DatesGap()
    }
}
