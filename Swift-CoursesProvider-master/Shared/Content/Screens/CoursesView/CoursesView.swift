import SwiftUI

struct CoursesView: View {
    @State var selectedCourse: CourseType? = nil
    @State var isDisabled = false
    @Namespace var namespace
    @Namespace var SectionsNamespace

    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    
    func closeModal() {
        withAnimation(.spring()) {
            selectedCourse = nil
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { isDisabled = false }
        }
    }
    
    var body: some View {
        ZStack {
            #if os(iOS)
            if horizontalSizeClass == .compact {
                TabBar
            } else {
                Sidebar
            }
            #else
            Sidebar()
            #endif
            
            if selectedCourse != nil {
                #if os(iOS)
                CourseModal(selectedCourse: selectedCourse!, namespace: namespace, closeFunction: closeModal)
                    .background(VisualEffectBlur(blurStyle: .systemMaterial).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
                #else
                CourseModal(selectedCourse: selectedCourse!, namespace: namespace, closeFunction: closeModal)
                    .background(VisualEffectBlur().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
                #endif
            }
            
        }
        .navigationTitle("Courses")
    }
    
   private var TabBar: some View {
        TabView {
            NavigationView {Content}.tabItem {
                Image(systemName: "book.closed")
                Text("Courses")
            }
            
            NavigationView {NeumorphicView()}
                .tabItem {
                    Image(systemName: "tv")
                    Text("Neumorphic")
                }
            
            
        }
    }
    
    @ViewBuilder
    private var Sidebar: some View {
        #if os(iOS)
        NavigationView {
            List {
                NavigationLink (destination: Content) {
                    Label { Text("Courses") } icon: {Image(systemName: "book.closed") .foregroundColor(.accentColor)}
                }
                
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Learn")
            .toolbar {
                ToolbarItem (placement: .navigationBarTrailing) { Image(systemName: "person.crop.circle") }
            }
            
            Content
        }
        #endif
    }
    
    private var Content: some View {
        ScrollView {
            VStack (spacing: 0) {
                LazyVGrid (
                    columns: [GridItem(.adaptive(minimum: 160), spacing: 16)],
                    spacing: 16
                ) {
                    ForEach(CoursesData) { item in
                        VStack {
                            CourseBlockItem(course: item)
                                .matchedGeometryEffect(id: item.id, in: namespace, isSource: selectedCourse == nil)
                                .frame(height: 200)
                                .onTapGesture { withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                                    selectedCourse = item
                                    isDisabled = true
                                }}
                                .disabled(isDisabled)
                        }
                        .matchedGeometryEffect(id: "wrapper\(item.id)", in: namespace, isSource: selectedCourse == nil)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                
                Text("Latest sections")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                LazyVGrid (columns: [GridItem(.adaptive(minimum: 240))]) {
                    ForEach(CourseSectionsData) { item in
                        #if os(iOS)
                        NavigationLink (destination: CourseModal(namespace: SectionsNamespace)) {
                            CourseRow(item: item)
                        }
                        .padding(.horizontal)
                        #else
                        CourseRow(item: item)
                        #endif
                    }
                }
                .padding(.horizontal)

            }
        }
        .zIndex(1)
        .navigationTitle("Courses")
    }
    
}


