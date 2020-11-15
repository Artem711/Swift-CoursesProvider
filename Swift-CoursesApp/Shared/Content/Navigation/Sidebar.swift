import SwiftUI

struct Sidebar: View {
    var body: some View {
        NavigationView {
            #if os(iOS)
            Content
                .navigationTitle("Learn")
                .toolbar {
                    ToolbarItem (placement: .navigationBarTrailing) { Image(systemName: "person.crop.circle") }
                }
            #else
            Content
                .frame(minWidth: 200, idealWidth: 250, maxWidth: 300)
                .toolbar {
                    ToolbarItem (placement: .automatic) { Button(action: {}, label: {Image(systemName: "person.crop.circle")})}
                }
            #endif
        }
    }
    
    private var Content: some View {
        List {
            NavigationLink (destination: CoursesView()) {
                Label { Text("Courses") } icon: {Image(systemName: "book.closed") .foregroundColor(.accentColor)}
            }
            Label { Text("Tutorials") } icon: {Image(systemName: "list.bullet.rectangle") .foregroundColor(.accentColor)}
            Label { Text("Livestreams") } icon: {Image(systemName: "tv") .foregroundColor(.accentColor)}
            Label { Text("Certificates") } icon: {Image(systemName: "mail.stack") .foregroundColor(.accentColor)}
            Label { Text("Search") } icon: {Image(systemName: "magnifyingglass") .foregroundColor(.accentColor)}
        }
        .listStyle(SidebarListStyle())
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
     }
}
