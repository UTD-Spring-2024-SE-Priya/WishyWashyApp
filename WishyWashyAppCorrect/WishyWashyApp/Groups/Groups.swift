import SwiftUI
import Firebase
import FirebaseFirestoreSwift
// Controller
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

// Controller
class FriendGroupManager {
    private let db = Firestore.firestore()
    
    
    // Add a hardcoded friend
    func addHardcodedFriend(completion: @escaping (Error?) -> Void) {
        let hardcodedFriendData: [String: Any] = [
            "name": "Wajih",
            // Add other fields for the friend document here if needed
        ]
        
        db.collection("friends").document("wtw03CylB4qPccuG8rBA").setData(hardcodedFriendData) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func fetchFriends(completion: @escaping ([(id: String, name: String)]?, Error?) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "Auth", code: -1, userInfo: [NSLocalizedDescriptionKey: "No logged-in user"]))
            return
        }
        
        db.collection("friends")
            .document(currentUserID)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let document = snapshot, document.exists else {
                    completion([], nil) // Return an empty array if no friends found
                    return
                }
                
                if let data = document.data() {
                    let friends = data.map { ($0.key, $0.value as? String ?? "") }
                    completion(friends, nil)
                } else {
                    completion([], nil) // Return an empty array if no friends found
                }
            }
    }

    func searchFriendsByName(_ name: String, completion: @escaping ([(id: String, name: String)]?, Error?) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "Auth", code: -1, userInfo: [NSLocalizedDescriptionKey: "No logged-in user"]))
            return
        }
        
        db.collection("friends")
            .document(currentUserID)
            .collection("friends") // Assuming "friends" is the name of the subcollection containing friend data
            .whereField("name", isEqualTo: name) // Assuming "name" is the field containing friend names
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let documents = snapshot?.documents, !documents.isEmpty else {
                    completion([], nil) // Return an empty array if no friends found
                    return
                }
                
                let friends = documents.compactMap { document -> (id: String, name: String)? in
                        let id = document.documentID
                        guard let name = document.data()["name"] as? String else {
                            return nil
                        }
                        return (id, name)
                }
                
                completion(friends, nil)
            }
    }

    func addFriendsToGroup(friends: [String], groupID: String, completion: @escaping (Error?) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "Auth", code: -1, userInfo: [NSLocalizedDescriptionKey: "No logged-in user"]))
            return
        }
        
        let batch = db.batch()
        
        for friendID in friends {
            let friendData: [String: Any] = [
                "friendID": "Wajih", // Assuming "Wajih" is the value for the friendID field
                // Add other fields for the friend document here if needed
            ]
            
            let friendRef = db.collection("friends").document("wtw03CylB4qPccuG8rBA") // Use the specified document ID
            batch.setData(friendData, forDocument: friendRef)
            
            let groupMemberRef = db.collection("groups").document(groupID).collection("members").document(friendID)
            batch.setData([currentUserID: true], forDocument: groupMemberRef)
        }
        
        batch.commit { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}

struct Groups: View {
    // Group name, friend name, if the friend is coming and list of friends
    @State private var groupName = ""
    @State private var friendName = ""
    @State private var friends: [(id: String, name: String)] = []
    @State private var searchResults: [(id: String, name: String)] = [] // Store search results
    @State private var isSearching = false // Track search state
    @State private var isGroupSelected = false // Track whether a group is selected

    // Instantiate FriendGroupManager
    private let friendGroupManager = FriendGroupManager()

    var body: some View {
        VStack {
            // Input for Group Name
            TextField("Enter group name(more than 5 characters) ", text: $groupName)
                .padding()

            // Search bar for Friend
            FriendSearchBar(text: $friendName, isSearching: $isSearching, searchResults: $searchResults)

            if isSearching {
                // Display search results
                List(searchResults, id: \.id) { friend in
                    Button(action: {
                        friendName = friend.name // Select friend from search results
                        isSearching = false // Close search
                    }) {
                        Text(friend.name)
                    }
                }
            } else {
                // Display list of friends
                List(friends, id: \.id) { friend in
                    Text(friend.name)
                }
                .padding()
            }

            // Check if group name is entered and friends are found
            if !groupName.isEmpty && !friends.isEmpty {
                // Button for adding friends to the group
                Button("Add Friends to Group", action: addFriendsToGroup)
                    .padding()
                    .foregroundColor(.black) // Set button color to black
                    .background(Color.yellow) // Set button background color to yellow
                    .cornerRadius(8) // Round button corners
            }
        }
        .onAppear(perform: fetchFriends) // Fetch friends when the view appears
    }
    
    // Fetch friends from Firestore
    private func fetchFriends() {
        friendGroupManager.fetchFriends { friendIDs, error in
            if let error = error {
                print("Error fetching friends: \(error.localizedDescription)")
                return
            }
            
            if let friendIDs = friendIDs {
                self.friends = friendIDs
            }
        }
        
        // Add the hardcoded friend
        friendGroupManager.addHardcodedFriend { error in
            if let error = error {
                print("Error adding hardcoded friend: \(error.localizedDescription)")
            }
        }
    }
    
    // Add friends to the group
    private func addFriendsToGroup() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("No logged-in user")
            return
        }

        // Assuming you have a valid group ID stored in the groupName variable
        let groupID = groupName

        // Call the addFriendsToGroup method of FriendGroupManager
        friendGroupManager.addFriendsToGroup(friends: [friendName], groupID: groupID) { error in
            if let error = error {
                print("Error adding friends to group: \(error.localizedDescription)")
            } else {
                print("Friends added to group successfully")
            }
        }
    }
}

struct Groups_Previews: PreviewProvider {
    static var previews: some View {
        Groups()
    }
}

struct FriendSearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    @Binding var searchResults: [(id: String, name: String)]

    var body: some View {
        HStack {
            TextField("Search for friend", text: $text)
                .padding(.leading, 20)
                .padding(.vertical, 10)
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.horizontal)
                .onTapGesture {
                    isSearching = true
                }

            if isSearching {
                Button(action: {
                    isSearching = false
                    text = ""
                    searchResults = []
                    hideKeyboard()
                }) {
                    Text("Cancel")
                        .padding(.trailing, 10)
                }
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

// Helper function to hide keyboard
func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

//Can find friend however Firebase was giving difficulty, will be switching to new firebase 
