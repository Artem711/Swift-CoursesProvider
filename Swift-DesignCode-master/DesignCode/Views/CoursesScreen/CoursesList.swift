import SwiftUI
import SDWebImageSwiftUI

struct CoursesList: View {
    @ObservedObject var store = CoursesModel()
    
    @State var isScrollable = false
    @State var isCardActive = false
    @State var ActiveIndex = -1
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    func getCardWidth(bounds: GeometryProxy) -> CGFloat {
        if bounds.size.width > 712 { return 712 }
        return bounds.size.width - 60
    }
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                Color.black.opacity(0.07)
                    .animation(.linear)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                ScrollView {
                    VStack (spacing: 30) {
                        Text("Courses")
                            .font(.largeTitle).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)
                            .padding(.top, 30)
                            .blur(radius: isCardActive ? 3 : 0)
                        
                        ForEach(store.courses.indices, id: \.self) { index in
                            let item = self.store.courses[index]
                            let isActive = self.ActiveIndex != index && self.isCardActive
                            GeometryReader { geometry in
                                CourseItem(
                                    course: item,
                                    show:   $store.courses[index].show,
                                    isCardActive: $isCardActive,
                                    index: index,
                                    ActiveIndex:  $ActiveIndex,
                                    isScrollable:  $isScrollable,
                                    bounds: bounds
                                )
                                .offset(y: item.show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(isActive ? 0 : 1)
                                .scaleEffect(isActive ? 0.5 : 1)
                                .offset(x: isActive ? bounds.size.width : 0)
                            }
                            .frame(height: self.horizontalSizeClass == .regular ? 80 : 280)
                            .frame(maxWidth: item.show ? 712 : getCardWidth(bounds: bounds))
                            .zIndex(item.show ? 1 : 0)
                        }
                    }
                    .frame(width: bounds.size.width)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
 
                }
                .disabled(isCardActive && !isScrollable ? true : false)

            }
        }
   
    }
}

struct CourseItem: View {
    var course: CoursesModel.CourseType
    @Binding var show: Bool
    @Binding var isCardActive: Bool
    
    var index: Int
    @Binding var ActiveIndex: Int
    @Binding var isScrollable: Bool
    
    var bounds: GeometryProxy
    
    func getCardCornerRadius(bounds: GeometryProxy) -> CGFloat {
        if show  && bounds.safeAreaInsets.top < 44 {
            return 0
        }
        return 30
    }
    
    var body: some View {
        ZStack (alignment: .top) {
            VStack (alignment:.leading, spacing: 30) {
                Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
                
                Text("About this course")
                    .font(.title).bold()
                
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                
                Text("Minimal coding experience required, such as in HTML and CSS. Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'll get a lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter.")
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 460 : 0 )
            .background(Color("background1"))
            .clipShape(RoundedRectangle( cornerRadius:  getCardCornerRadius(bounds: bounds) , style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity( show ? 1 : 0)
            
            VStack {
                HStack (alignment: .top) {
                    VStack (alignment: .leading, spacing: 8) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: course.logo)
                            .opacity(show  ? 0 :1)
                        
                        let ICON_SIZE: CGFloat = 36
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: ICON_SIZE, height: ICON_SIZE)
                        .background(Color.black)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .opacity(show ? 1 : 0)
                        .offset(x: 2, y: -2)
                    }
                }
                Spacer()
                WebImage(url: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 180, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: getCardCornerRadius(bounds: bounds)  , style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
            .onTapGesture(perform: {
                self.show.toggle()
                self.isCardActive.toggle()
                if self.show {
                    self.ActiveIndex = self.index
                } else {
                    self.ActiveIndex = -1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.isScrollable = true
                }
            })
            
            if isScrollable && show {
                CourseDetail(show: $show, isCardActive: $isCardActive, ActiveIndex: $ActiveIndex, isScrollable: $isScrollable, course: course, cornerRadius:   getCardCornerRadius(bounds: bounds), bounds: self.bounds)
                    .background(Color.white)
                    .animation(nil)
                    .transition(.identity)
            }
        }
        .disabled(isCardActive && !isScrollable ? true : false)
        .frame(height: show ? bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom : 280)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}



