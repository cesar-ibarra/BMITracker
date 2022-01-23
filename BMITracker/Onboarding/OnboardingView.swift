//
//  OnboardingView.swift
//  BMITracker
//
//  Created by Cesar Ibarra on 1/7/22.
//

import SwiftUI

struct Settings {
    static let heightKey = "heightConvert"
    static let nameKey = "name"
    static let maxIdealKey = "idealMaximo"
    static let minIdealKey = "idealMinimo"
}

struct OnboardingView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @AppStorage(Settings.heightKey) var heightConvert = 0
    
    @AppStorage(Settings.nameKey) var name = ""
    @AppStorage(Settings.maxIdealKey) var idealMaximo = 0.0
    @AppStorage(Settings.minIdealKey) var idealMinimo = 0.0
    @State private var weight = ""
    @State private var heightFt = ""
    @State private var heightIn = ""
    @State private var height = ""
    @State private var date = Date()
//    @State private var heightConvert = 0
    @State private var bmi = 0.0
    
    
    
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                // MARK: - HEADER
                Spacer()
                
                VStack(spacing: 10) {
                    Text("BMI Tracker.")
                        .font(.system(size: 40))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
                    Each new day is a new opportunity
                    to improve yourself.
                    """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }//: HEADER
                
                // MARK: - CENTER
                ZStack {
                    ZStack{
                        Circle()
                            .stroke(.white.opacity(0.2), lineWidth: 40)
                            .frame(width: 260, height: 260, alignment: .center)
                        Circle()
                            .stroke(.white.opacity(0.2), lineWidth: 80)
                            .frame(width: 260, height: 260, alignment: .center)
                        
                        Image("character-3")
                            .resizable()
                            .scaledToFit()
                        
                        VStack {
                            TextField("Name", text: $name, onEditingChanged: { _ in
                                self.name = self.name.uppercased()
                            })
                                .textFieldStyle(.roundedBorder)
                                .font(.system(size: 20))
                                .multilineTextAlignment(.center)
                            TextField("Weight", text: $weight)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                                .font(.system(size: 20))
                                .multilineTextAlignment(.center)
                            
                            HStack{
                            TextField("Height Ft", text: $heightFt)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.system(size: 20))
                                    .multilineTextAlignment(.center)
                            TextField("Height In", text: $heightIn)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.system(size: 20))
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding()
                        
                        
                    }//: ZSTACK
                }//: ZSTACK
                
                Spacer()
                
                // MARK: - FOOTER
                ZStack{
                    //: PARTS OF THE CUSTOM BUTTON
                    
                    //: 1. BACKGROUND (STATIC)
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    //: 2. CALL-TO-ACTION (STATIC)
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                }//: ZSTACK FOOTER
                .frame(height: 80, alignment: .center)
                .padding()
                .onTapGesture {
                    saveProfile()
                    saveWeight()
                    isOnboardingViewActive = false
                }
            }//: VSTACK
        }//: ZSTACK
    }
    
    func saveProfile() {
        
        
        heightConvert = (Int(heightFt)! * 12) + Int(heightIn)!
        print(heightConvert)
        
        idealMaximo = pesoIdealMaximo(height: Double(heightConvert))
        print(idealMaximo.toWeight)
        idealMinimo = pesoIdealMinimo(height: Double(heightConvert))
        print(idealMinimo.toWeight)
        
        let newProfile = Profile(context: PersistenceController.shared.container.viewContext)

        newProfile.id = UUID().uuidString
        newProfile.name = name
        newProfile.height = Int32(heightConvert)
        newProfile.maxIdealWeight = Double(idealMaximo.toWeight) ?? 0.0
        newProfile.minIdealWeight = Double(idealMinimo.toWeight) ?? 0.0


        PersistenceController.shared.save()
    }
    
    
    func saveWeight() {
        bmi = calcBMI(weight: Double(weight)!, height: Double(heightConvert))
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
    
    func pesoIdealMaximo (height: Double) -> Double {
           let pesoIdealMaximo = (24.99 * (height * height)) / 703
           return pesoIdealMaximo
       }
       
       func pesoIdealMinimo (height: Double) -> Double {
           let pesoIdealMinimo = (18.5 * (height * height)) / 703
           return pesoIdealMinimo
       }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
