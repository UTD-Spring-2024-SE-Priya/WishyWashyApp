//
//  LoginView .swift
//  WishyWashyApp
//
//  Created by Wajih Anwar on 4/8/24.
//

import SwiftUI

struct LoginView_: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel : AuthViewModel

    
    var body: some View {
        NavigationStack{
            VStack{
                //image
                
                
                Text("WishyWashy ")
                    .font(Font.custom("Inter", size: 24).weight(.semibold))
                    .foregroundColor(.black)
                    .padding(.bottom,8)
                
                Image("Logo")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.clear)
                    .frame(width:350, height:250)
                    .padding(.bottom,50)
                
                
                //form fields
                VStack(spacing: 24){
                    InputView(text: $email, title: "Email Address", placeholder: "name@example.com")

                        .autocapitalization(.none)
                    
                    
                    InputView(text : $password, title:"Password", placeholder:"Enter your password", isSecureField: true)
                    
                    
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                
                
                
                //Sign in button
                
                //Sign in button
               
                Button {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                        
                    }
                } label: {
                    HStack {
                        Text("Sign in ")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color.black) // Change background color to black
                .disabled(!formIsValid) // Disable the button based on form validity
                .opacity(formIsValid ? 1.0 : 0.5) // Adjust opacity based on form validity
                .cornerRadius(10)
                .padding(.top, 24)
                


                
                Spacer()
                
                //Sign up Button
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                }label: {
                    HStack {
                        Text("Dont have an account? ")
                        Text("Sign up")
                        
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .font(.system(size:15))
                }
             
                
            }
        }
    }
    }
extension LoginView_: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
            && email.contains("@")
            && !password.isEmpty
            && password.count >= 6 // Adjusted count to be greater than 6
    }
}


struct LoginView_Previews : PreviewProvider{
    static var previews : some View {
        LoginView_()
    }
}
