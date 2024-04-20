import SwiftUI

struct FriendsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Friends title text
                Text("Friends")
                    .font(.custom("Inter", size: 16))
                    .lineSpacing(24)
                    .foregroundColor(.black)
                    .offset(x: -3, y: -300) // Adjust positioning as needed

                // Action buttons with proper destinations
                VStack(spacing: 20) {
                    NavigationLink(destination: FindFriendsView()) {
                        ActionButton(text: "Find Your Friend")
                    }
                   
                    NavigationLink(destination: Groups()) {
                        ActionButton(text: "Groups")
                    }
                }
                .offset(y:-160)

                // Placeholder image for the friends section (replace with actual content)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 350, height: 280)
                    .background(
                        Image("Logo")
                            .resizable()
                    )
                    .offset(x: -5, y: 100) // Adjust positioning as needed

                // Friends category buttons
                CategoryButtons()
                    .offset(x: -10, y: -345) // Adjust positioning as needed
                
                
                // Homepage button
                             NavigationLink(destination: HomePage()) {
                                 ActionButton(text: "Homepage")
                                     .offset(y: 300) // Adjust positioning as needed
                             }
                         }

            .frame(width: 375, height: 812)
            .background(Color.white)
            .navigationBarTitle("", displayMode: .inline) // Hide navigation bar title
            .navigationBarBackButtonHidden(true) // Hide navigation back button
            
        }
    }
}

// Struct for action buttons with centered text
struct ActionButton: View {
    let text: String

    var body: some View {
        Text(text)
            .font(Font.custom("Inter", size: 16).weight(.medium))
            .lineSpacing(24)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .center) // Center text horizontally
            .padding(EdgeInsets(top: 14, leading: 24, bottom: 14, trailing: 24))
            .background(Color.black)
            .cornerRadius(8)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, x: 0, y: 1)
    }
}

// Struct for individual button items within the category buttons
struct ButtonItem: View {
    let text: String
    let backgroundColor: Color
    let textColor: Color

    var body: some View {
        Text(text)
            .font(Font.custom("Inter", size: 14).weight(.medium))
            .lineSpacing(19.60)
            .foregroundColor(textColor)
            .padding(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
            .background(backgroundColor)
            .cornerRadius(20)
    }
}

struct Friends_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}

// Struct for friends category buttons with navigation links
struct CategoryButtons: View {
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
          
            // Friends Tab button with navigation (replace destination if needed)
            NavigationLink(destination: FindFriendsView()) {
                ButtonItem(text: "Find Friend", backgroundColor: Color(red: 0.96, green: 0.96, blue: 0.96), textColor: .black)
            }
            // Group button with navigation (replace destination if needed)
            NavigationLink(destination: Groups()) {
                ButtonItem(text: "Group", backgroundColor: Color(red: 0.96, green: 0.96, blue: 0.96), textColor: .black)
            }
        }
        .padding(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
    }
}
