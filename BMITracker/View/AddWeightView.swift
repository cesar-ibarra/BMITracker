//
//  AddWeightView.swift
//  BMITracker
//
//  Created by Cesar Ibarra on 1/7/22.
//

import SwiftUI

struct AddWeightView: View {
    
    @ObservedObject var viewModel: AddWeightViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.isAddWeightShowing.wrappedValue = false
                } label: {
                    Text("Cancel")
                        .font(.title3)
                        .frame(width: 80, height: 30)
                }
                
                Spacer()
                
                Button {
                    viewModel.saveWeight()
                    viewModel.isAddWeightShowing.wrappedValue = false
                } label: {
                    Text("Done")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 80, height: 30)
                }
                .disabled(viewModel.isValidForm())
            }
            .padding()
            
            Form {
                TextField("Weight", text: $viewModel.weight)
                    .keyboardType(.decimalPad)
                DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
            }
        }//: VSTACK
    }
}
