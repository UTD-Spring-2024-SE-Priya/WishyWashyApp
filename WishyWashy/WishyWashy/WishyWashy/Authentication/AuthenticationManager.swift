

import Foundation
import FirebaseAuth


//Structure to hold user data
struct dataModel {
    let uid: String
    let email: String?
    
    //ideas for later
    //profile photo?
    //Name?
    //Gender?
    
    //Initialize dataModel with Firebase
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}

//Authentication manager usde for user authentication,essentially our controller
final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() {}
    
    
    //Sign Up
    func signUp(email: String, password: String, confirmPassword: String) async throws -> dataModel {
           let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
           return dataModel(user: authResult.user)
       }
    
    
    
    //Sign In
    func createUser(email: String, password: String) async throws -> dataModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return dataModel(user: authDataResult.user)
    }
}

// Possible authentication errors
enum AuthenticationError: Error {
    case passwordsDoNotMatch
}
