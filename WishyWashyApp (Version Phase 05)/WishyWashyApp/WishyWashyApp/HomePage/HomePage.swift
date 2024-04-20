import SwiftUI

//Starting Page
struct HomePage: View {
    var body: some View {
        NavigationView {
            ZStack() {
                Group {
                    Image("Logo")
                        .resizable()
                        .frame(width: 300, height: 200)
                        .offset(x:-5, y: -150)
                    
                    HStack(alignment: .top, spacing: 8) {
                        HStack(spacing: 10) {
                            NavigationLink(destination: ProfileView()){
                                Text("Profile Settings")
                                    .font(Font.custom("Inter", size: 14).weight(.medium))
                                    .lineSpacing(19.60)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(EdgeInsets(top: 6, leading: 14, bottom: 6, trailing: 14))
                        .background(Color(red: 0.18, green: 0.43, blue: 1))
                        .cornerRadius(20)
                    }
                    .frame(width: 239, height: 56)
                    .offset(x: -120, y: -278)
                    
                    
                    
                    HStack(spacing: 30) {
                        ZStack() {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 0, height: 0)
                                .background(
                                )
                        }
                        .frame(width: 24, height: 24)
                        Text("WishyWashy Dashboard")
                            .font(Font.custom("Inter", size: 20).weight(.semibold))
                            .lineSpacing(28)
                            .foregroundColor(.black)
                        
                    }
                    
                    .padding(EdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 77))
                    .offset(x: 0, y: -334)
                    
                    Text(" ")
                        .font(Font.custom("Inter", size: 16).weight(.medium))
                        .lineSpacing(24)
                        .foregroundColor(.black)
                        .offset(x: -19.50, y: -25)
                    HStack(spacing: 8) {
                        NavigationLink(destination: FriendsView()){
                            Text("Friends")
                                .font(Font.custom("Inter", size: 16).weight(.medium))
                                .lineSpacing(24)
                                .foregroundColor(.white)
                        }
                    }
                                       .padding(EdgeInsets(top: 14, leading: 24, bottom: 14, trailing: 24))
                                       .frame(width: 312, height: 56)
                                       .background(Color.black)
                                       .cornerRadius(8)
                                       .offset(x: -16.50, y: 36)
                                       .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1)
                                       
                    HStack(spacing: 8) {
                        NavigationLink(destination: Groups()) {
                            Text("Groups")
                                .font(Font.custom("Inter", size: 16).weight(.medium))
                                .lineSpacing(24)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(EdgeInsets(top: 14, leading: 24, bottom: 14, trailing: 24))
                    .frame(width: 312, height: 56) // Same frame as other buttons
                    .background(Color.black) // Same background color
                    .cornerRadius(8) // Same corner radius
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1) // Same shadow
                    .offset(x: -16.50, y: 124)
                    
                    HStack(spacing: 8) {
                        NavigationLink(destination: PreviousDecisionsView()) {
                            Text("Decisions")
                                .font(Font.custom("Inter", size: 16).weight(.medium))
                                .lineSpacing(24)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(EdgeInsets(top: 14, leading: 24, bottom: 14, trailing: 24))
                    .frame(width: 312, height: 56)
                    .background(.black)
                    .cornerRadius(8)
                    .offset(x: -16.50, y: 218)
                    .shadow(
                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
                    )
                }
            }
        }
    }
}

struct HomePagePreviews : PreviewProvider{
    static var previews : some View {
        HomePage()
    }
}
