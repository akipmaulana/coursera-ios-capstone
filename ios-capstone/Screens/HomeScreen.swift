//
//  HomeScreen.swift
//  ios-capstone
//
//  Created by Akirah Dev on 09/04/23.
//  
//

import SwiftUI

struct HomeScreen: View {
    
    var typeFood: [String] = [
        "Starters",
        "Main",
        "Desserts",
        "Drinks",
        "A La Carte",
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    HStack {
                        Image("")
                            .frame(width: 64, height: 64)
                            .hidden()
                        
                        Spacer()
                        
                        Image("LogoIcon")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 147, height: 40)
                        
                        Spacer()
                        
                        NavigationLink {
                            ProfileScreen()
                        } label: {
                            Image("Persona")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .frame(width: 64, height: 64)
                        }
                    }
                    .padding(.top, -16)
                    
                    VStack(alignment: .leading) {
                        Text("Little Lemon")
                            .font(.system(size: 32, weight: .medium))
                            .foregroundColor(Color(hex: "F4CE14"))
                            .padding(.bottom, 4)
                        
                        Text("Chicago")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(.white)
                        
                        HStack(alignment: .top, spacing: 6) {
                            
                            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .medium))
                        
                            Image("FoodHero")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(width: 147, height: 152)
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Reserve a table")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(hex: "F4CE14"))
                        .cornerRadius(16)

                    }
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(Color(hex: "495E57"))
                    
                    VStack(alignment: .leading) {
                        Text("Order for Delivery!".uppercased())
                            .font(.system(size: 20, weight: .bold))
                            
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(typeFood, id: \.self) { food in
                                    Text(food)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 12)
                                        .background(Color(hex: "EDEFEE"))
                                        .cornerRadius(16)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 16)
                
                    ScrollView(.vertical) {
                        FoodItem()
                        
                        FoodItem()
                        
                        FoodItem()
                        
                        FoodItem()
                    }
                    .padding(.horizontal, 16)
                }
                
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
