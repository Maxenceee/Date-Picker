//
//  DatePreview.swift
//  Date Picker
//
//  Created by Maxence Gama on 21/02/2022.
//

import SwiftUI

let months = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]

struct DatePreview: View {
    @State private var startDate = Date()
    @ObservedObject var input = NumbersOnly()
    
    var body: some View {
        VStack {
            Text("Calculateur de date avec ajout de jours")
                .font(.title2)
                .padding()
                .multilineTextAlignment(.center)
            
            Form {
                DatePicker("Départ", selection: $startDate, displayedComponents: .date)
                    .padding()
                TextField("Nombre de jour à ajouter", text: $input.value)
                    .padding()
                    .keyboardType(.decimalPad)
                HStack {
                    Spacer()
                    Text(dateCalculatorPrev(startDate, input.value))
                        .padding(.vertical, 30)
                        .multilineTextAlignment(.center)
                        .font(.body)
                    Spacer()
                }
            }
        }
        .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
    }
    
    func dateCalculatorPrev(_ start: Date, _ adding: String) -> String {
        if (Int(adding) != nil) {
            let res = start.addingDaysTo(adding: Int(adding)!)
            
            let components = res.get(.day, .month, .year)
            
            return "\(components.day!) \(months[components.month!-1]) \(components.year!)"
        }
        return "Entrer une date"
    }
}

struct DatePreview_Previews: PreviewProvider {
    static var previews: some View {
        DatePreview()
    }
}

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
