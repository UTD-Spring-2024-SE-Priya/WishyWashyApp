import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    Image("Logo")
                        .resizable()
                        .frame(width: 350, height: 300)
                        .offset(x: -5, y: -150)
                        .padding(.top, -15)
                    HStack(spacing: 30) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 0, height: 0)
                                .background()
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
                        NavigationLink(destination: FriendsView()) {
                            Text("Friends       ")
                                .font(Font.custom("Inter", size: 16).weight(.medium))
                                .lineSpacing(24)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(EdgeInsets(top: 14, leading: 24, bottom: 14, trailing: 24))
                    .frame(width: 250, height: 56)
                    .padding(.leading, 50)
                    .padding(.trailing, 50)
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
                    .frame(width: 250, height: 56)
                    .padding(.leading, 50)
                    .padding(.trailing, 50)
                    .background(Color.black)
                    .cornerRadius(8)
                    .offset(x: -16.50, y: 124)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1)
                    
                    HStack(spacing: 8) {
                        NavigationLink(destination: DecisionsView()) {
                            Text("Decisions")
                                .font(Font.custom("Inter", size: 16).weight(.medium))
                                .lineSpacing(24)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(EdgeInsets(top: 14, leading: 24, bottom: 14, trailing: 24))
                    .frame(width: 250, height: 56)
                    .padding(.leading, 50)
                    .padding(.trailing, 50)
                    .background(.black)
                    .cornerRadius(8)
                    .offset(x: -16.50, y: 218)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1)
                }
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        // Home Button
                        NavigationLink(destination: HomePage()) {
                            Image(systemName: "house.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                        }
                        .navigationBarBackButtonHidden(true) // Hide back button for Home
                        
                        Spacer()
                        
                        // Profile Settings Button
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                        }
                        .navigationBarBackButtonHidden(true)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomePagePreviews : PreviewProvider{
    static var previews : some View {
        HomePage()
    }
}
