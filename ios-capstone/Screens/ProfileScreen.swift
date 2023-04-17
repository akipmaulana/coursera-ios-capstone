//
//  ProfileScreen.swift
//  ios-capstone
//
//  Created by Akirah Dev on 17/04/23.
//  
//

import SwiftUI
import CoreData

struct ProfileScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.email, ascending: true)],
        animation: .default)
    private var user: FetchedResults<User>
    
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    
    @State private var notificationOrderStatus: Bool = true
    @State private var notificationPasswordChange: Bool = true
    @State private var notificationSpecialOffer: Bool = true
    @State private var notificationNewsletter: Bool = true
    
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
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Personal Information")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        AvatarSectionView()
                        
                        VStack(alignment: .leading) {
                            Text("First name")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.gray)
                            
                            TextField("Fill your first name", text:$firstname)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.default)
                            
                        }
                        .padding(.top, 16)
                        
                        VStack(alignment: .leading) {
                            Text("Last name")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.gray)
                            
                            TextField("Fill your last name", text: $lastname)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.default)
                            
                        }
                        .padding(.top, 16)
                        
                        VStack(alignment: .leading) {
                            Text("Email")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.gray)
                            
                            TextField("Fill your email", text: $email)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.emailAddress)
                            
                        }
                        .padding(.top, 16)
                        
                        VStack(alignment: .leading) {
                            Text("Phone number")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.gray)
                            
                            TextField("Fill your phone nnumber", text: $phoneNumber)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.phonePad)
                            
                        }
                        .padding(.top, 16)
                        
                        VStack(alignment: .leading, spacing: 24) {
                        
                            Text("Personal Information")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            PersonalInformationPreferrences(
                                toogle: $notificationOrderStatus,
                                title: "Order Status"
                            )
                            
                            PersonalInformationPreferrences(
                                toogle: $notificationPasswordChange,
                                title: "Password Changes"
                            )
                            
                            PersonalInformationPreferrences(
                                toogle: $notificationSpecialOffer,
                                title: "Special Offers"
                            )
                            
                            PersonalInformationPreferrences(
                                toogle: $notificationNewsletter,
                                title: "Newsletter"
                            )
                        }
                        .padding(.vertical, 16)
                        
                        Button {
                            deleteAllUser()
                            deleteAllState()

                            NavigationUtil.popToRootView()
                        } label: {
                            Text("Log out")
                                .foregroundColor(.black)
                                .font(.title3)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color(hex: "#F4CE14"))
                        .cornerRadius(8)
                        
                        HStack {
                            Button {
                                firstname = user.first?.firstname ?? ""
                                lastname = user.first?.lastname ?? ""
                                phoneNumber = user.first?.phone ?? ""
                                email = user.first?.email ?? ""
                            } label: {
                                Text("Discard Changes")
                                    .foregroundColor(.gray)
                                    .font(.title3)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hex: "#495E57"), lineWidth: 2)
                            })
                            
                            Button {
                                deleteAllUser()
                                
                                let user = User(context: viewContext)
                                user.email = email
                                user.firstname = firstname
                                user.lastname = lastname
                                user.phone = phoneNumber
                                
                                try? viewContext.save()
                                
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Save Changes")
                                    .foregroundColor(.white)
                                    .font(.title3)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color(hex: "#495E57"))
                            .cornerRadius(8)
                        }
                        .padding(.vertical, 16)
                        
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer()
                
            }
            
        }
        .navigationBarBackButtonHidden()
        .task {
            firstname = user.first?.firstname ?? ""
            lastname = user.first?.lastname ?? ""
            phoneNumber = user.first?.phone ?? ""
            email = user.first?.email ?? ""
        }
    }
    
    private func deleteAllUser() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = User.fetchRequest()
        let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try? viewContext.execute(batchDelete)
    }
    
    private func deleteAllState() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = AppState.fetchRequest()
        let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try? viewContext.execute(batchDelete)
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}

struct AvatarSectionView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Avatar")
                .fontWeight(.semibold)
                .foregroundColor(Color.gray)
            
            HStack(spacing: 16) {
                
                Image("Persona")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                
                Button {
                    
                } label: {
                    Text("Change")
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                }
                .background(Color(hex: "495E57"))
                .cornerRadius(8)
                
                Button {
                    
                } label: {
                    Text("Remove")
                        .foregroundColor(Color(hex: "495E57"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                }
                .border(Color(hex: "495E57"))
                
                Spacer()
                
            }
        }
        .padding(.top, 16)
    }
}

struct PersonalInformationPreferrences: View {
    
    
    @Binding var toogle: Bool
    let title: String
    
    var body: some View {
        HStack {
            Button {
                toogle.toggle()
            } label: {
                Image(
                    systemName: toogle ? "checkmark.square.fill" : "checkmark.square"
                )
                .resizable()
                .scaledToFill()
                .frame(width: 24, height: 24)
            }
            .tint(.green)
            
            Text(title)
        }
    }
}

struct NavigationUtil {
    static func popToRootView() {
        findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .popToRootViewController(animated: true)
    }
static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
return nil
    }
}
