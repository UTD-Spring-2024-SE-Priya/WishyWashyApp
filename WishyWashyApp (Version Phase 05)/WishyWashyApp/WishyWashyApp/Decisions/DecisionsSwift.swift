
import SwiftUI

struct DecisionsView: View {
    var body: some View {
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
                    Button(action: {
                        // Add action for Food (Decisions) button
                    }) {
                        Text("Food (Decisions)")
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    // Activities (Decisions) button
                    Button(action: {
    
                    }) {
                        Text("Activities (Decisions)")
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .lineLimit(1)  // Ensures the text stays on one line
                    }
                }
                
                // Subtitle for previous ratings
                Text("Previous Ratings")
                    .font(.subheadline)
                
                // Row with buttons for Food and Activities ratings
                HStack(spacing: 20) {
                    // Food (Ratings) button
                    Button(action: {
                        // Add action for Food (Ratings) button
                    }) {
                        Text("Food (Ratings)")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    // Activities (Ratings) button
                    Button(action: {
                        // Add action for Activities (Ratings) button
                    }) {
                        Text("Activities (Ratings)")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                Spacer()
            }
        }
        .padding()
    }
}

struct DecisionsView_Previews: PreviewProvider {
    static var previews: some View {
        DecisionsView()
    }
}
