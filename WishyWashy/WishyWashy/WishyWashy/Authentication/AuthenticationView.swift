import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 240, height: 400)
                    .background(Color.gray.opacity(0.5)) // Placeholder background color
                
                Image("WishyWashy Logo")
                    .resizable()
                    .frame(width: 240, height: 400)
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
            
            Text("The Decider App \nfor indecisive friends")
                .font(Font.custom("Inter", size: 16).weight(.medium))
                .lineSpacing(0)
                .foregroundColor(.black)
            
            // Button to move to the next view (changed destination)
            NavigationLink(
                destination: SignUpEmailView(), // Changed destination to SignUpEmailView
                label: {
                    Text("Let's Get Started")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray4))
                        .cornerRadius(10)
                }
            )
            .padding()
            
            Spacer()
        }
        .navigationTitle("WishyWashy")
        .font(Font.custom("Inter", size: 24).weight(.semibold))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AuthenticationView()
        }
    }
}

