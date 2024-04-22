import SwiftUI

struct FriendLookView: View {
    @StateObject private var userService = UserService.shared
    private var user: User
    @State private var isAccepted: Bool = false
    @State private var isDeclined: Bool = false

    init(user: User) {
        self.user = user
    }

    var body: some View {
        if !isDeclined {
            HStack {
                VStack(alignment: .leading) {
                    Text(user.fullname ?? "")
                        .font(.headline)
                        .fontWeight(.semibold)
                    HStack {
                        Button {
                            Task {
                                do {
                                    // Accept action
                                    try await userService.acceptFriendRequest(from: user)
                                    isAccepted = true
                                } catch {
                                    print("Error accepting friend request: \(error.localizedDescription)")
                                }
                            }
                        } label: {
                            Text("Accept")
                                .foregroundColor(.white)
                                .frame(width: 120, height: 32)
                                .background(.green)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .disabled(isAccepted || isDeclined)

                        Divider()

                        Button {
                            Task {
                                do {
                                    // Decline action
                                    try await userService.rejectFriendRequest(from: user)
                                    isDeclined = true
                                } catch {
                                    print("Error rejecting friend request: \(error.localizedDescription)")
                                }
                            }
                        } label: {
                            Text("Decline")
                                .foregroundColor(.white)
                                .frame(width: 120, height: 32)
                                .background(.red)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .disabled(isAccepted || isDeclined)
                    }
                }
            }
            .padding(.horizontal)
            .opacity(isAccepted ? 0.5 : 1.0)
            .onAppear {
                // Refresh data when the view appears
                refreshData()
            }
        } else {
            EmptyView() // Hide the view if the friend request is declined
        }
    }
    
    // Function to refresh data
    private func refreshData() {
        // Reset isDeclined state to ensure proper refreshing
        isDeclined = false
    }
}
