import SwiftUI
import MapKit

//Front end and button to add 
struct PlaceListView: View {
    
    let landmarks: [Landmark]
    var onTap: (Landmark) -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                EmptyView()
            }.frame(width: UIScreen.main.bounds.size.width, height: 60)
                .background(Color.gray)
                .onTapGesture {
                    // Handle tap on header if needed
                }
            
            List {
                ForEach(self.landmarks, id: \.id) { landmark in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(landmark.name)
                                .fontWeight(.bold)
                            Text(landmark.title)
                        }
                        Spacer()
                        Button(action: {
                            // Call onTap closure with the selected landmark
                            self.onTap(landmark)
                        }) {
                            Text("Add")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }.animation(nil)
        }.cornerRadius(10)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(landmarks: [], onTap: { _ in })
    }
}
