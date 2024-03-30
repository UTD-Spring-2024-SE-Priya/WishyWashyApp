import SwiftUI

struct SwiftUIView: View {
    // Group name, friend name, if the friend is coming and list of friends
    @State private var groupName = ""
    @State private var friendName = ""
    @State private var friendConfirm = false
    @State private var friends: [String] = []

    var body: some View {
        VStack {
            // Input for Group Name
            TextField("Enter group name(more than 5 characters) ", text: $groupName)
                .padding()

            // Input for Friend
            TextField("Enter friend name(no numbers)", text: $friendName)
                .padding()

            // Toggle for Y/N answer
            Toggle("Confirmed Invitation", isOn: $friendConfirm)
        
                .padding()

            // Button for confirmation
            Button("Send Invitation ", action: sendInvitation)
            
                .padding()

            // Display list of friends
            List(friends, id: \.self) { friend in
                Text(friend)
            }
            .padding()
        }
    }

    private func sendInvitation() {
        // Testcase 2: Is the invitation confirmed
        if !friendConfirm {
            print("Error: Invitation not confirmed")
            return
        }

        // Testcase 3: Fake Friend
        if friendName.contains(where: { $0.isNumber }) {
            print("Error: Friend name must not contain any numbers")
            return
        }

        // Testcase 5: No friend name
        if friendName.isEmpty {
            print("Error: No friend name")
            return
        }

        // Testcase 7: Invalid Group name
        if groupName.count != 5 {
            print("Error: Invalid group name (must have exactly 5 letters)")
            return
        }

        // Testcase 13: No Group name
        if groupName.isEmpty {
            print("Error: No group name")
            return
        }



        // Add friend to the list
        friends.append(friendName)
        friendName = "" // Clear friendName after adding

        // Determine the confirmation status message
      
        if friendConfirm {
                    print("Invitation sent to \(friends.last ?? "") for group \(groupName). Confirmation status: Confirmed")
                } else {
                    print("Invitation sent to \(friends.last ?? "") for group \(groupName). Confirmation status: Not Confirmed")
                }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

