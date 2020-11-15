import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            HomeScreen().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            CoursesList().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Courses")
            }
        }
        .environmentObject(UserStore())
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .previewDevice("iPhone 11")
//            .environment(\.colorScheme, .dark)
        
    }
}

let screen = UIScreen.main.bounds
