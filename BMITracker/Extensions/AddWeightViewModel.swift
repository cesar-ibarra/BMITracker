//
//  AddWeightViewModel.swift
//  BMITracker
//
//  Created by Cesar Ibarra on 1/7/22.
//

import SwiftUI
import CoreData



final class AddWeightViewModel: ObservableObject {
    
    @Published var weight = ""
    @Published var date = Date()
    @Published private var height = 0
    @Published private var bmi = 0.0
    
    var isAddWeightShowing: Binding<Bool>
    
    init(isAddWeightShowing: Binding<Bool>) {
        self.isAddWeightShowing = isAddWeightShowing
    }
    
    func saveWeight() {
        
        let globalHeight = OnboardingView().heightConvert
        print("Result \(globalHeight)")
        
        bmi = calcBMI(weight: Double(weight)!, height: Double(globalHeight))
        print(bmi.toWeight)

        let newWeight = Weight(context: PersistenceController.shared.container.viewContext)
        newWeight.id = UUID().uuidString
        newWeight.weight = Double(weight) ?? 0.0
        newWeight.date = date
        newWeight.bmi = bmi

        PersistenceController.shared.save()
    }
    
    //Calculate BMI
        func calcBMI (weight: Double, height: Double) -> Double {
            let bmi = (weight * 703) / (height * height)
            return bmi
        }
    
    private let personFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    
    func isValidForm() -> Bool {
        return weight.isEmpty
    }
    
}
