import SwiftUI

struct CoursesList: View {
    @ViewBuilder
    
    var body: some View {
        #if os(iOS)
        Content
            .listStyle(InsetGroupedListStyle())
        #else
        Content
            .frame(minWidth: 800, minHeight: 600)
        #endif
    }
    
    private var Content: some View {
        List(0 ..< 20) { item in
            CourseRow()
        }
        .navigationTitle("Courses")
    }
}
