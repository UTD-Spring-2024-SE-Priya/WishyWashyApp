import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isHomepageActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.currentUser {
                    List {
                        Section {
                            HStack {
                                Text(user.initials)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(width: 72, height: 72)
                                    .background(Color(.systemGray3))
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(user.fullname)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .padding(.top, 4)
                                    
                                    Text(user.email)
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        //General 
                        Section("General") {
                            HStack {
                                Settings(imageName: "gear",
                                         title: "Version",
                                         tintColor: Color(.systemGray))
                                
                                Spacer()
                                
                                Text("1.0.0")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        //How we sign out
                        Section("Account") {
                            Button {
                                viewModel.signOut()
                            } label: {
                                Settings(imageName: "arrow.left.circle.fill", title: "Sign out", tintColor: .blue)
                            }
                            
                        }
                    }
                    
                    Button {
                        isHomepageActive = true
                    } label: {
                        Text("Go to Homepage")
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()
                    .fullScreenCover(isPresented: $isHomepageActive) {
                        // Replace "HomepageView" with the actual view you want to navigate to
                        HomePage().environmentObject(viewModel)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock AuthViewModel instance
        let viewModel = AuthViewModel()
        // Manually set some dummy user data
        viewModel.currentUser = User(id: "1", fullname: "John Doe", email: "john@example.com")
        // Wrap the ProfileView in an environment object provider
        return ProfileView().environmentObject(viewModel)
    }
}
