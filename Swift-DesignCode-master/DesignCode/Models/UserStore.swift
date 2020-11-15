import SwiftUI
import Combine
import Firebase


class UserStore: ObservableObject {
    @Published var isAuth = false
    @Published var showLoginView = false
 
    var didChange = PassthroughSubject<UserStore, Never>()
       var session: User? { didSet { self.didChange.send(self) }}
       var handle: AuthStateDidChangeListenerHandle?

       func listen () {
            handle = Auth.auth().addStateDidChangeListener { (auth, user) in
               if let user = user {
                    print("Got user: \(user)")
                   self.session = User(
                       uid: user.uid,
                       displayName: user.displayName,
                    email: user.email
                   )
                self.isAuth = true
               } else {
                    self.session = nil
               }
           }
       }
    
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }

    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }

    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.isAuth = false
            self.session = nil
            return true
        } catch {
            return false
        }
    }

}

class User {
    var uid: String
    var email: String?
    var displayName: String?

    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }

}
