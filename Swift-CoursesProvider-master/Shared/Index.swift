import SwiftUI

struct Index: View {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    
    @ViewBuilder
    var body: some View {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            CoursesView()
        } else {
            CoursesView()
        }
        #else
        Sidebar()
            .frame(minWidth: 1000, minHeight: 600)
        
        #endif
    }
}

struct Index_Previews: PreviewProvider {
    static var previews: some View {
        Index()
    }
}
