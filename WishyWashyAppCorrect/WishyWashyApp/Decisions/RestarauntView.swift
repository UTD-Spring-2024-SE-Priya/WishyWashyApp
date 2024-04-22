import SwiftUI
import MapKit

struct RestaurantView: View {
    
    @ObservedObject var locationManager = LocationManager()
    @State private var landmarks: [Landmark] = []
    @State private var showScrollView: Bool = false
    @State private var selectedChoices: [String] = [] // Default choices
    @State private var randomIndex: Int?
    
    private func getNearbyRestaurants() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "restaurants"
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else { return }
            
            let mapItems = response.mapItems
            var updatedLandmarks: [Landmark] = []
            if let userLocation = self.locationManager.location {
                for mapItem in mapItems {
                    var landmark = Landmark(placemark: mapItem.placemark)
                    let landmarkLocation = CLLocation(latitude: landmark.coordinate.latitude, longitude: landmark.coordinate.longitude)
                    landmark.distanceFromUser = userLocation.distance(from: landmarkLocation)
                    
                    // Print out the calculated distance for debugging
                    print("Distance to \(landmark.name ?? ""): \(landmark.distanceFromUser ?? 0) meters")
                    
                    updatedLandmarks.append(landmark)
                }
            } else {
                // If user location is not available, add landmarks without distance
                updatedLandmarks = mapItems.map { Landmark(placemark: $0.placemark) }
            }
            self.landmarks = updatedLandmarks
        }
    }


    
    var body: some View {
        NavigationView {
            VStack {
                if !showScrollView {
                    // Section: Show Restaurants Button
                    Button(action: {
                        self.showScrollView.toggle()
                    }) {
                        ZStack(alignment:.leading){
                            Text("Search Restaurants")
                                .font(Font.custom("Inter", size: 16))
                                .lineSpacing(24)
                                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                                .padding(.top,10)
                                .padding(.bottom,10)
                                .padding(.horizontal, 80)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1))
                            Image(systemName: "magnifyingglass")
                                .font(.title)
                                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                                .padding(.leading, 10)
                        }
                    }
                    .disabled(selectedChoices.count >= 4)
                }
                
                // Section: Display selected choices
                if !selectedChoices.isEmpty {
                    VStack {
                        Text("Selected Choices")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        ForEach(selectedChoices, id: \.self) { choice in
                            HStack {
                                Text(choice)
                                
                                Spacer()
                                Button(action: {
                                    // Remove the selected choice
                                    if let index = self.selectedChoices.firstIndex(of: choice) {
                                        self.selectedChoices.remove(at: index)
                                    }
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                                .disabled(selectedChoices.count == 1)
                                
                                // Add button to open Apple Maps
                                Button(action: {
                                    if let landmark = landmarks.first(where: { $0.name == choice }) {
                                        let latitude = landmark.coordinate.latitude
                                        let longitude = landmark.coordinate.longitude
                                        let coordinates = "\(latitude),\(longitude)"
                                        let urlString = "http://maps.apple.com/?daddr=\(coordinates)"
                                        if let url = URL(string: urlString) {
                                            UIApplication.shared.open(url)
                                        }
                                    }
                                }) {
                                    Image(systemName: "map")
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding()
                        
                        Button(action: {
                            // Submit the choices and display them
                            randomIndex = Int.random(in: 0..<selectedChoices.count)
                        }) {
                            Text("Submit")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                
                
                // Section: Scroll view to choose restaurants
                if showScrollView {
                    ScrollView {
                        LazyVStack(spacing: 2) {
                            ForEach(landmarks, id: \.id) { landmark in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(landmark.name ?? "")
                                            .fontWeight(.bold)
                                        Text(landmark.title ?? "")
                                        if let distance = landmark.distanceFromUser {
                                            Text("Distance: \(String(format: "%.2f meters", distance))")
                                                .font(.footnote)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        // Check if the choice is already selected
                                        guard !self.selectedChoices.contains(landmark.name ?? "") else {
                                            return // Exit if the choice is already selected
                                        }
                                        
                                        // Add choice to selectedChoices array
                                        let restaurantName = landmark.name ?? ""
                                        self.selectedChoices.append(restaurantName)
                                        
                                        // Disable the add button if 4 choices are made
                                        if self.selectedChoices.count >= 4 {
                                            self.showScrollView = false
                                        }
                                    }) {
                                        Image(systemName: "plus.circle")
                                            .foregroundColor(self.selectedChoices.count >= 4 ? .gray : .blue) // Disable button if 4 choices are made
                                            .font(.title)
                                    }
                                    .disabled(self.selectedChoices.count >= 4) // Disable button if 4 choices are made
                                    
                                }
                                .padding(.horizontal)
                                .padding(.vertical,8)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            }
                        }
                        .padding(.horizontal) // Adjust horizontal padding
                        .padding(.bottom, 40)
                    }
                }
                
                // Section: Display randomly selected choice
                // Section: Display randomly selected choice
                if let randomIndex = randomIndex, randomIndex < landmarks.count {
                    VStack {
                        Text("Randomly Selected Choice: \(selectedChoices[randomIndex])")
                            .font(.headline)
                            .padding()
                        Button(action: {
                            let landmark = landmarks[randomIndex]
                            let latitude = landmark.coordinate.latitude
                            let longitude = landmark.coordinate.longitude
                            let coordinates = "\(latitude),\(longitude)"
                            let urlString = "http://maps.apple.com/?daddr=\(coordinates)"
                            if let url = URL(string: urlString) {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .frame(height: 200) // Adjust height as needed
                                .overlay(
                                    MapView(landmark: landmarks[randomIndex]) // Pass the randomly selected landmark
                                )
                        }
                    }
                }

                
                // Section: Home and Profile Buttons
                if !showScrollView {
                    HStack {
                        Spacer()
                        // Home Button
                        NavigationLink(destination: HomePage()) {
                            Image(systemName: "house.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 30) // Adjust the width and height as needed
                                .foregroundColor(.black)
                        }
                        .padding(.vertical, 8)
                        .padding(.trailing, 8)
                        .navigationBarBackButtonHidden(true)
                        
                        Spacer()
                        
                        // Profile Settings Button
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 30) // Adjust the width and height as needed
                                .foregroundColor(.black)
                        }
                        .padding(.vertical, 8)
                        .padding(.trailing, 8)
                        .navigationBarBackButtonHidden(true)
                        
                        Spacer()
                    }
                    .padding(.leading, 70)
                }
                
            }
            .navigationBarTitle("Restaurants")
            .onAppear {
                // Fetch nearby restaurants when the view appears
                self.getNearbyRestaurants()
                    
            }
        }
    }
}

struct RestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView()
    }
}
