import SwiftUI

struct DecisionsView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Title
                Text("Decisions")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)  // Add padding at the top to move the title closer to the top of the screen
                
                Spacer()
                
                VStack(spacing: 20) {
                    // Subtitle for past decisions
                    Text("View Past Decisions")
                        .font(.subheadline)
                    
                    // Row with buttons for Food and Activities decisions
                    HStack(spacing: 20) {
                        // Food (Decisions) button
                        NavigationLink(destination: RestaurantView()) {
                            Text("Food (Decisions)")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .navigationBarBackButtonHidden(true) // Hide back button
                        
                        // Activities (Decisions) button
                        NavigationLink(destination: ActivitiesView()) {
                            Text("Activities (Decisions)")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .lineLimit(1)  // Ensures the text stays on one line
                        }
                        .navigationBarBackButtonHidden(true) // Hide back button
                    }
                    
                    // Subtitle for previous ratings
                    Text("Previous Ratings")
                        .font(.subheadline)
                    
                    // Row with buttons for Food and Activities ratings
                    HStack(spacing: 20) {
                        // Food (Ratings) button
                        NavigationLink(destination: Text("Food (Ratings)")) {
                            Text("Food (Ratings)")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .navigationBarBackButtonHidden(true) // Hide back button
                        
                        // Activities (Ratings) button
                        NavigationLink(destination: Text("Activities (Ratings)")) {
                            Text("Activities (Ratings)")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            
                        }
                        .navigationBarBackButtonHidden(true) // Hide back button
                    }
                    Spacer()
                }
            }
        }
    }
}

struct DecisionsView_Previews: PreviewProvider {
    static var previews: some View {
        DecisionsView()
    }
}
