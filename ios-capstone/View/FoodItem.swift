//
//  FoodItem.swift
//  ios-capstone
//
//  Created by Akirah Dev on 10/04/23.
//  
//

import SwiftUI

struct FoodItem: View {
    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Greek Salad")
                
                Text("The famous greek salad of crispy lettuce, peppers, olives and our Chicago style feta cheese, garnished with crunchy garlic and rosemary croutons.")
                    .lineLimit(2)
                
                Text("$12.99")
            }
            
            Image("Food1")
                .resizable()
                .scaledToFit()
                .frame(width: 83, height: 83)
        }
    }
}

struct FoodItem_Previews: PreviewProvider {
    static var previews: some View {
        FoodItem()
    }
}
