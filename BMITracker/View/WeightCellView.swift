//
//  WeightCellView.swift
//  BMITracker
//
//  Created by Cesar Ibarra on 1/7/22.
//

import SwiftUI

struct WeightCellView: View {
    
    let weight: Double
    let date: Date
    let bmi: Double
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("\(weight.toWeight) lbs")
                    .font(.title)
                Text("BMI \(bmi.toWeight)")
                    .font(.title3)
            }
            Spacer()
            Text(date.longDate)
                .font(.subheadline)
        }
        .padding()
        .foregroundColor(.white)
    }
}

struct WeightCellView_Previews: PreviewProvider {
    static var previews: some View {
        WeightCellView(weight: 164.2, date: Date(), bmi: 24.4)
    }
}

