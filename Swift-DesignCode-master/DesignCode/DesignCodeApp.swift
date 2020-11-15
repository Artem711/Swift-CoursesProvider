import SwiftUI
import Firebase

@main
struct DesignCodeApp: App {
    init() {
        FirebaseApp.configure()
      }
    
    var body: some Scene {
        WindowGroup {
            TabBar()
        }
    }
}

