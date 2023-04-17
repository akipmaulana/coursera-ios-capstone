//
//  ProfileScreen.swift
//  ios-capstone
//
//  Created by Akirah Dev on 17/04/23.
//  
//

import SwiftUI

struct ProfileScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrowshape.turn.up.backward.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .padding(.leading, 16)
                    }
                    
                    Spacer()
                    
                    Image("LogoIcon")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 147, height: 40)
                    
                    Spacer()
                    
                    Image("Persona")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
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
                    

                }
                .frame(maxWidth: .infinity)
                .padding(16)
                .background(Color(hex: "495E57"))
                
                ScrollView(.vertical) {
                    OnnboardingFieldView(title: "First name", text: $firstname)
                        .padding(.horizontal, 16)
                    
                    OnnboardingFieldView(title: "Last name", text: $lastname)
                        .padding(.horizontal, 16)
                    
                    OnnboardingFieldView(title: "Email", text:$email)
                        .padding(.horizontal, 16)
                    
                    OnnboardingFieldView(title: "Phone number", text: $phoneNumber)
                        .padding(.horizontal, 16)
                }
            }
            
        }
        .navigationBarBackButtonHidden()
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
