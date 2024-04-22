import SwiftUI

struct FindFriendsView: View {
    @ObservedObject private var userService: UserService = UserService.shared
    @State private var searchText: String = ""
    @State private var showAlert = false // Track whether to show the alert
    @State private var refreshFlag = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TabView(title: "Friend")
                        .frame(maxWidth: .infinity) // Center the tabs
                    TabView(title: "Groups")
                        .frame(maxWidth: .infinity) // Center the tabs
                }
                .padding(.horizontal)
                
                Divider()
                
                HStack {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .onChange(of: searchText) { newValue in
                            Task {
                                do {
                                    if newValue.isEmpty {
                                        // Clear search results if search text is empty
                                        userService.searchResults = nil
                                    } else {
                                        try await userService.searchUsers(query: newValue)
                                    }
                                } catch {
                                    print("Error searching users: \(error.localizedDescription)")
                                }
                            }
                        }

                    
                    Button(action: {
                        // Perform search when button is tapped
                        Task {
                            do {
                                try await userService.searchUsers(query: searchText)
                                // Set showAlert to true to display the alert
                                showAlert = true
                            } catch {
                                print("Error searching users: \(error.localizedDescription)")
                            }
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .padding(.horizontal)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Friend Request Sent"))
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                Spacer()
                
                .padding(.top,5)
                ScrollView {
                    VStack(alignment: .leading) {
                        // Display search results
                        if let searchResults = userService.searchResults {
                            ForEach(searchResults) { user in
                                HStack {
                                    Text(user.fullname ?? "")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Button(action: {
                                        Task {
                                            do {
                                                // Call the sendFriendRequest function
                                                try await userService.sendFriendRequest(to: user)
                                                // Fetch friend requests again to update the UI
                                                try await userService.fetchFriendRequestsToMe()
                                                // Set showAlert to true to display the alert
                                                showAlert = true
                                            } catch {
                                                print("Error sending friend request: \(error.localizedDescription)")
                                            }
                                        }
                                    }) {
                                        Text("Send Invite")
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding(.bottom,30)
                            }
                        }
                    }
                    .padding()
                }
                .navigationBarHidden(true)
                .padding(.top)
                Divider()
                
                // Display friend requests sent to you
                VStack(alignment: .leading, spacing: 15) {
                    Text("Friend Requests Sent to You")
                        .font(.headline)
                        .padding(.horizontal)
                    ForEach(userService.friendsRequestsToMe) { user in
                        // Display each friend request
                        if let currentUserID = userService.currentUser?.id, user.id != currentUserID {
                            FriendLookView(user: user)
                        }
                    }
                }
                .padding(.horizontal)

                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 400)
                
                // Homepage and Profile buttons
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: HomePage()) {
                            Image(systemName: "house.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                        }
                        .navigationBarBackButtonHidden(true) // Hide back button for Home
                        
                        Spacer()
                        
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
        .onAppear {
            // Fetch friend requests sent to the current user when the view appears
            Task {
                do {
                    try await userService.fetchFriendRequestsToMe()
                } catch {
                    print("Error fetching friend requests: \(error.localizedDescription)")
                }
            }
        }
        .onReceive(userService.$friendsRequestsToMe) { _ in
            // This closure will be triggered whenever `friendsRequestsToMe` changes
            // You can put code here to handle the refresh of your view
            // For example, you can update the view state or trigger a function call
            refreshFlag.toggle() // Toggles `refreshFlag` to trigger a refresh
        }
    }
}

struct TabView: View {
    private var title: String
    init(title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .font(.subheadline)
            .padding(.horizontal, 50)
            .padding(.vertical, 10)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10), style: FillStyle())
    }
}

#if DEBUG
struct FindFriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FindFriendsView()
    }
}
#endif
