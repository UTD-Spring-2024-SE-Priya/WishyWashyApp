import SwiftUI
import MapKit

struct RestaurantView: View {
    
    //How we find and look for Locations and Add them
    @ObservedObject var locationManager = LocationManager()
    @State private var landmarks: [Landmark] = []
    @State private var search: String = ""
    @State private var tapped: Bool = false
    @State private var selectedLandmark: Landmark?
    
    private func getNearbyLandmarks() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map { Landmark(placemark: $0.placemark) }
            }
        }
    }
    
    func calculateOffset() -> CGFloat {
        if self.landmarks.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 4
        } else if self.tapped {
            return 100
        } else {
            return UIScreen.main.bounds.size.height
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            MapView(landmarks: landmarks)
                .frame(width: 400, height: 400)
                .padding(.top,100)
            
            TextField("Search", text: $search, onEditingChanged: { _ in }) {
                self.getNearbyLandmarks()
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .offset(y: 44)
            
            PlaceListView(landmarks: self.landmarks) { landmark in
                self.selectedLandmark = landmark // Store the selected landmark
                self.tapped.toggle()
            }
            .animation(.spring())
            .offset(y: calculateOffset())
        }
        
        // Display the selected choice
        if let selectedLandmark = selectedLandmark {
            VStack {
                Text("Selected Choice:")
                Text(selectedLandmark.name)
            }
            .padding()
        }
    }
}

struct RestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView()
    }
}


//Choice shows, jsut front end issues

//Same code can be applied to activites 
