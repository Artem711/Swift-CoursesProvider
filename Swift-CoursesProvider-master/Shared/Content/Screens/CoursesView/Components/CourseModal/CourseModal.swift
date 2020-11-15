import SwiftUI

struct CourseModal: View {
    @State var ModalVisible = false
    var selectedCourse: CourseType = CoursesData[0]
    var namespace: Namespace.ID
    var closeFunction: (() -> ())?
    
  
    
    var body: some View {
        #if os(iOS)
        Content
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        #else
        Content
        #endif
    }
    
    private var Content: some View {
        VStack {
            ScrollView {
                CourseBlockItem(course: selectedCourse, closeFunction: closeFunction)
                    .matchedGeometryEffect(id: selectedCourse.id, in: namespace)
                    .frame(height: 300)
                
                VStack {
                    ForEach(CourseSectionsData) { item in
                        CourseRow(item: item)
                            .onTapGesture { ModalVisible = true }
                            .sheet(isPresented: $ModalVisible, content: {
                                CourseSectionDetailScreen()
                            })
                        Divider()
                    }
                }
                .padding()
            }
        }
        .background(Color("Background 1"))
        .clipShape(RoundedRectangle(cornerRadius:10, style: .continuous))
        .matchedGeometryEffect(id: "wrapper\(selectedCourse.id)", in: namespace)
        .zIndex(2)
        .frame(maxWidth: 712)
        .frame(maxWidth: .infinity)
    }
    
}


