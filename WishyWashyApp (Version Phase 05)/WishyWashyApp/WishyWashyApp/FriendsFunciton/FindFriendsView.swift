import SwiftUI
import Firebase // Assuming you're using Firebase for the backend

struct FindFriendsView: View {
  @StateObject var viewModel = FindFriendsViewModel() // Create a single instance of ViewModel for data management
  @State private var searchText = ""

  var body: some View {
    NavigationView {
      VStack {
        TextField("Search", text: $searchText)
          .padding()
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .onChange(of: searchText) { newValue in
            viewModel.searchFriends(query: newValue)
          }

        if !searchText.isEmpty {
          List {
            Section(header: Text("Search Results")) {
              ForEach(viewModel.searchResults, id: \.self) { result in
                SearchResultRow(username: result) {
                  viewModel.sendFriendRequest(to: result)
                }
              }
            }
          }
          .listStyle(GroupedListStyle())
        }

       

          Section(header: Text("Friend Requests Received")) {
              ForEach(viewModel.friendRequests) { request in
                  HStack {
                      Text("\(request.senderName) wants to be your friend")
                      Spacer()
                      Button(action: {
                          viewModel.acceptFriendRequest(request)
                      }) {
                          Text("Accept")
                              .padding(.horizontal)
                              .foregroundColor(.white)
                              .background(Color.green)
                              .cornerRadius(8)
                      }
                      .buttonStyle(BorderlessButtonStyle())
                      Button(action: {
                          viewModel.declineFriendRequest(request)
                      }) {
                          Text("Decline")
                              .padding(.horizontal)
                              .foregroundColor(.white)
                              .background(Color.red)
                              .cornerRadius(8)
                      }
                      .buttonStyle(BorderlessButtonStyle()) //
                  }
                  .padding(.horizontal)
              }
          }
          .onAppear {
              viewModel.fetchFriendRequests()
          }

          // Friends Section
          Section(header: Text("Your Friends")) {
              ForEach(viewModel.friends, id: \.self) { friend in
                  Text(friend)
              }
          }
          .onAppear { // Call fetchFriends on appear to fetch initial friends
              viewModel.fetchFriends()
          }

        Spacer() 
      }
      .navigationBarTitle("Find Friends", displayMode: .inline)
      .alert(isPresented: $viewModel.showFriendRequestSentMessage) {
        Alert(title: Text("Friend Request Sent"))
      }
    }
  }
}

struct FindFriendsView_Previews: PreviewProvider {
  static var previews: some View {
    FindFriendsView()
  }
}

// Custom Search Result Row with Add Button
struct SearchResultRow: View {
  let username: String
  let addAction: () -> Void // Action to perform when add button is tapped

  var body: some View {
    HStack {
      Text(username)
      Spacer()
      Button(action: addAction) {
        Text("Add")
          .padding(.horizontal)
          .foregroundColor(.white)
          .background(Color.blue)
          .cornerRadius(8)
      }
      .buttonStyle(BorderlessButtonStyle()) // Remove default button style
    }
  }
}
//Notes for the TA
//Friend Request functionality does work however unable to pull up all friend requests that have been sent to user.However when checking firebase, it can be seen that the friend requests are there and are able to be accepted//

// It seems to relate to crashing of App due to unknown reason, will be looked and fixed prior to presentation next week// 


// It is due to the memory issue found on our computer, looking to fix it asap// 
