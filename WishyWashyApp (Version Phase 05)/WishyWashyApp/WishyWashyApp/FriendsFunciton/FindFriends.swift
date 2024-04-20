import Foundation
import Firebase

class FindFriendsViewModel: ObservableObject {
    @Published var searchResults: [String] = []
    @Published var searchQuery: String = ""
    @Published var showFriendRequestSentMessage = false
    @Published var friendRequests: [FriendRequest] = []
    @Published var friends: [String] = []
    
    private let db = Firestore.firestore()
    // Dynamically assign currentUserID based on the ID of the currently logged-in user
    private var currentUserID: String {
        if let currentUser = Auth.auth().currentUser {
            return currentUser.uid
        } else {
            // Handle the case where there's no logged-in user
            return ""
        }
    }
    
    struct FriendRequest: Identifiable{
        let id: String
        let senderID: String
        var senderName: String
    }
    
    func searchFriends(query: String) {
        db.collection("users")
            .whereField("fullname", isGreaterThanOrEqualTo: query)
            .whereField("fullname", isLessThanOrEqualTo: query + "\u{f8ff}") // Unicode character to get range queries
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error searching for friends: \(error.localizedDescription)")
                    self.searchResults = []
                    return
                }
                
                var results: [String] = []
                for document in snapshot?.documents ?? [] {
                    if let name = document.data()["fullname"] as? String {
                        results.append(name)
                    }
                }
                self.searchResults = results
            }
    }
    
    func sendFriendRequest(to userID: String) {
        let requestID = UUID().uuidString
        let requestRef = db.collection("friendRequests").document(requestID)
        let request = [
            "senderID": currentUserID,
            "receiverID": userID, // Use the receiver's ID
            "senderName": "Your Name", // Assuming you want to include sender's name
            "status": "pending"
        ] as [String : Any]
        
        requestRef.setData(request) { error in
            if let error = error {
                print("Error sending friend request: \(error.localizedDescription)")
            } else {
                print("Friend request sent to \(userID)")
                self.showFriendRequestSentMessage = true
            }
        }
    }
    
    func fetchFriendRequests() {
        db.collection("friendRequests")
            .whereField("receiverID", isEqualTo: currentUserID)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching friend requests: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                DispatchQueue.main.async {
                    self.friendRequests = documents.compactMap { document in
                        let data = document.data()
                        guard let senderID = data["senderID"] as? String,
                              let senderName = data["senderName"] as? String else {
                            return nil
                        }
                        
                        return FriendRequest(id: document.documentID, senderID: senderID, senderName: senderName)
                    }
                }
            }
    }
    
    func acceptFriendRequest(_ request: FriendRequest) {
        let friendRef = db.collection("friends").document(currentUserID)
        friendRef.setData([request.senderID: true], merge: true) { error in
            if let error = error {
                print("Error accepting friend request: \(error.localizedDescription)")
            } else {
                print("\(request.senderName) is now your friend.")
                self.deleteFriendRequest(request)
            }
        }
    }
    
    func declineFriendRequest(_ request: FriendRequest) {
        deleteFriendRequest(request)
    }
    
    private func deleteFriendRequest(_ request: FriendRequest) {
        db.collection("friendRequests").document(request.id).delete { error in
            if let error = error {
                print("Error deleting friend request: \(error.localizedDescription)")
            } else {
                print("Friend request deleted.")
            }
        }
    }
    
    func fetchFriends() {
        db.collection("friends")
            .document(currentUserID)
            .addSnapshotListener { snapshot, error in
                guard let document = snapshot else {
                    print("Error fetching friends: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if let data = document.data() {
                    let friendIDs = Array(data.keys)
                    self.friends = friendIDs
                }
            }
    }
}
