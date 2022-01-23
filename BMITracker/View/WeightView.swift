//
//  WeightView.swift
//  BMITracker
//
//  Created by Cesar Ibarra on 1/7/22.
//

import SwiftUI
import CoreData

struct WeightsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Weight.date, ascending: true)],
        animation: .default)
    private var weights: FetchedResults<Weight>
    
    @State var isAddWeightShowing = false
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    
    let globalHeight = OnboardingView().heightConvert
    let name = OnboardingView().name
    let idealMaximo = OnboardingView().idealMaximo
    let idealMinimo = OnboardingView().idealMinimo
    
    
    func greetingLogic() -> String {
      let hour = Calendar.current.component(.hour, from: Date())
      
      let NEW_DAY = 0
      let NOON = 12
      let SUNSET = 18
      let MIDNIGHT = 24
      
      var greetingText = "Hello" // Default greeting text
      switch hour {
      case NEW_DAY..<NOON:
          greetingText = "Good Morning"
      case NOON..<SUNSET:
          greetingText = "Good Afternoon"
      case SUNSET..<MIDNIGHT:
          greetingText = "Good Evening"
      default:
          _ = "Hello"
      }
      
      return greetingText
    }

    var body: some View {
        NavigationView {
            VStack{
                VStack {
                    Text("Your Ideal Weight Range is:")
                    Text("\(idealMinimo.toWeight)lb to \(idealMaximo.toWeight)lb")
                }
                
                
                List {
                    ForEach(weights) { weight in
                        WeightCellView(weight: weight.weight, date: weight.date ?? Date(), bmi: weight.bmi)
                            .background(weight.weight > idealMaximo ? Color("ColorRed") : (weight.weight < idealMinimo ? Color("ColorRed") : Color("ColorBlue")))
                            .cornerRadius(10)
                        
                    }
                    .onDelete(perform: deleteItems)
                    
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("\(greetingLogic()) \(name)")
                .toolbar {
                    ToolbarItem {
                        Button {
                            isAddWeightShowing = true
                        } label : {
                            Image(systemName: "plus")
                                .font(.title)
                        }
                    }
                }
                .accentColor(Color(.label))
                .sheet(isPresented: $isAddWeightShowing) {
                    AddWeightView(viewModel: AddWeightViewModel(isAddWeightShowing: $isAddWeightShowing))
                }
            }
            

        }
    }

    private func addItem() {
        withAnimation {
            let newWeight = Weight(context: viewContext)
            newWeight.weight = 162.0
            newWeight.date = Date()
            newWeight.bmi = 24.5

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { weights[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct WeightsView_Previews: PreviewProvider {
    static var previews: some View {
        WeightsView()
    }
}
