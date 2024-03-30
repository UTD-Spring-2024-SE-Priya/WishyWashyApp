import SwiftUI



//View Model for signup page
@MainActor
final class SignUpViewModel: ObservableObject {
    
    //Input values retrieved from the user
    @Published var email = ""
    @Published var password = ""
    @Published var retypedPwd = ""
    
    func signUp() {
        // Testcases from Phase 3
        
        //Testcase :Check and see if both email and password are empty
        guard !email.isEmpty || (!password.isEmpty && !retypedPwd.isEmpty) else {
               print ("Please fill in both email and password")
               return //returns message
           }
        
        // Testcase 2 : If password and retyped password do not match
        guard password == retypedPwd else {
            print("mismatched password ")
            return
        }
        // Testcase 3 : Check if password is valid
        guard isValidPassword(password) else {
            print("Invalid password entered")
            return
        }
        
     
        //TestCase 5: No password
        guard !password.isEmpty else {
            print("No password entered")
            return
        }
        
        // Testcase 7 : Check if password is valid
        guard isValidPassword(password) else {
            print("Invalid password entered")
            return
        }
        
        
        //TestCase 13: No email
        guard !email.isEmpty else {
            print("No email entered")
            return
        }
        

        
        
        
        
     //Extra Testcases that are deemed necessary for testing purposes
        // Testcase: If password is too short
        guard password.count >= 8 && password == retypedPwd else {
            print("Password is too short or does no match ")
            return
        }
        
  
        
        // Perform sign-up,
        Task {
            do {
                //Code to connect to Firebase to Authenticate
                let returnedUserData = try await AuthenticationManager.shared.signUp(email: email, password: password, confirmPassword: retypedPwd)
                //If authenticated, write sucess
                print("Success")
                print(returnedUserData)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    // Validation functions for email and password
    private func isValidEmail(_ email: String) -> Bool {
        //If email contains @ and . then valid email
        return email.contains("@") && email.contains(".")
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        //if password greater than or equal to 8 characters
        return password.count >= 8
    }
}

    
    struct SignUpEmailView: View {
        @StateObject private var viewModel = SignUpViewModel()
        
        var body: some View {
            VStack {
                Text("Create an account")
                    .font(Font.custom("Inter", size: 18).weight(.semibold))
                    .lineSpacing(27)
                    .foregroundColor(.black)
                
                Text("Enter your email to sign up for this app")
                    .font(Font.custom("Inter", size: 14))
                    .lineSpacing(19.60)
                    .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                
                //Input Fields for email
                TextField("Email@ domain.com", text: $viewModel.email)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .frame(width: 305, height: 40)
                    .background(.white)
                    .cornerRadius(8)
                    .overlay(
                    RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.50)
                    .stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 0.50)
                    )
                
                Text("Password")
                    .font(Font.custom("Outfit", size: 14).weight(.medium))
                    .foregroundColor(.black)
                //Input Fields for Password
                SecureField("Password... 8 characters long", text: $viewModel.password)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .frame(width: 305, height: 40)
                    .background(.white)
                    .cornerRadius(8)
                    .overlay(
                    RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.50)
                    .stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 0.50)
                    )
                
                Text("Retype in your Password")
                    .font(Font.custom("Outfit", size: 14).weight(.medium))
                    .foregroundColor(.black)
                //Input Fields for Retyped Password
                SecureField("Retype your Password... ", text: $viewModel.retypedPwd)
                    .padding(EdgeInsets(top: 15, leading: 16, bottom: 15, trailing: 16))
                    .frame(width: 300, height: 44)
                    .cornerRadius(8)
                    .overlay(
                    RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.50)
                    .stroke(Color(red: 0.91, green: 0.91, blue: 0.91), lineWidth: 0.50)
                    )
                
                Button {
                    //This is our complete this page button 
                    viewModel.signUp()
                } label: {
                    Text("Sign In with Email")
                        .font(Font.custom("Inter", size: 14).weight(.medium))
                        .lineSpacing(19.60)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        .frame(width: 327, height: 40)
                        .background(.black)
                        .cornerRadius(8)
                }
                
                
                
                //This will direct user to Sign in
                HStack {
                    Text("Already have an account?")
                        .font(Font.custom("Outfit", size: 14))
                        .foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.50))
                    
                    // Navigation link to sign-in view
                               NavigationLink(destination: SignInEmailView()) {
                                   Text("Log in")
                                       .font(Font.custom("Outfit", size: 14))
                                       .foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.50))
                               }
                    
                           }
                       }
            .padding()
            .navigationTitle("Sign Up")
        }
    }
    
    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                SignUpEmailView()
            }
        }
    }

