import SwiftUI
import Firebase

@main
struct WishyWashyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                //Will start from Authentication view and push forward 
                AuthenticationView()
            }
        }
    }
}

//Code from Firebase- retrieved from the Firebase Github
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
