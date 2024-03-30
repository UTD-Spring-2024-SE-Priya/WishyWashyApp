import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    //Fields we are looking for
    @Published var email = ""
    @Published var password = ""
    
    func signIn() {
   
        //Generic Testcase: look to se if both fields are empty
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password entered")
            return}
        // Testcase2 : invalid password
        guard isValidPassword(password) else {
            print("Invalid password entered")
            return
        }
            // Testcase 3: No password was entered
        guard !password.isEmpty else {
            print("No password entered")
                return
        }
        
        // TestCase 4: invalid email
        guard isValidEmail(email) else {
            print("Invalid email entered")
            return
        }
        
        
        // Testcase 7: no email was entered
        guard !email.isEmpty else {
                    print("No email entered")
                    return
                }
                
       //Authenticate using Firebase and the fields gathered, if sucess then message will show otherwise error message
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    //Validation methods
    private func isValidEmail(_ email: String) -> Bool {
        // Contains @ and.
        return email.contains("@") && email.contains(".")
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        // characters must be greater than 8
        return password.count >= 8
    }
}

struct SignInEmailView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    
    var body: some View {
        VStack {
     
            
            
            Text("Welcome Back ")
            .font(Font.custom("Inter", size: 14))
            .lineSpacing(21)
            .foregroundColor(.black)
            
            Text("Email Address")
            .font(Font.custom("Outfit", size: 14).weight(.medium))
            .foregroundColor(.black)
            TextField("Email....", text: $viewModel.email)
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
            
            
            
            SecureField("Password... ", text: $viewModel.password)
                            .padding(EdgeInsets(top: 15, leading: 16, bottom: 15, trailing: 16))
                            .frame(width: 300, height: 44)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.50)
                                    .stroke(Color(red: 0.91, green: 0.91, blue: 0.91), lineWidth: 0.50)
                            )
            Button {
                //Button to validate and move onto the next page
                viewModel.signIn()
            } label: {
                Text("Sign in ")
                    .font(Font.custom("Inter", size: 16).weight(.medium))
                    .lineSpacing(24)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 14, leading: 24, bottom: 14, trailing: 24))
                    .frame(width: 343, height: 52)
                    .background(.black)
                    .cornerRadius(8)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
                    )
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Wishy Washy ")
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignInEmailView()
        }
    }
}

//Imag
