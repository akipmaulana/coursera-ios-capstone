//
//  OnboardingScreen.swift
//  ios-capstone
//
//  Created by Akirah Dev on 16/04/23.
//  
//

import SwiftUI
import CoreData

struct OnboardingScreen: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \AppState.onboarding, ascending: true)],
        animation: .default)
    private var state: FetchedResults<AppState>
    
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var navigate: Bool = false
    
    var body: some View {
        NavigationView {
            
            ZStack {
                VStack {
                    
                    HStack(alignment: .center) {
                        Image("LogoIcon")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 147, height: 40)
                        
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
                    
                    NavigationLink(isActive: $navigate) {
                        HomeScreen()
                    } label: {
                        Button {
                            deleteAllState()
                            
                            let state = AppState(context: viewContext)
                            state.onboarding = true
                            
                            let user = User(context: viewContext)
                            user.email = email
                            user.firstname = firstname
                            user.lastname = lastname
                            user.phone = phoneNumber

                            do {
                                try viewContext.save()
                                navigate = true
                            } catch {
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                            
                        } label: {
                            Text("Save & Next")
                                .font(.title2)
                                .foregroundColor(Color(hex: "F4CE14"))
                                .padding(.vertical, 8)
                        }

                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "495E57"))
                }
                
            }
        }
        .task {
            navigate = state.first?.onboarding ?? false
        }
    }
    
    private func deleteAllState() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = AppState.fetchRequest()
        let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try? viewContext.execute(batchDelete)
    }
}

struct OnnboardingFieldView: View {
    
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("\(title.capitalized) *")
            
            TextField("Fill your name", text: $text)
                .textFieldStyle(.roundedBorder)
        }
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}
