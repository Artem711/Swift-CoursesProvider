import SwiftUI
import SDWebImageSwiftUI

struct CourseDetail: View {
    @Binding var show: Bool
    @Binding var isCardActive: Bool
    @Binding var ActiveIndex: Int
    @Binding var isScrollable: Bool
    
    var course: CoursesModel.CourseType
    var cornerRadius: CGFloat
    
    var bounds: GeometryProxy
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(course.title)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text(course.subtitle)
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                        Spacer()
                        ZStack {
                            let ICON_SIZE: CGFloat = 36
                            VStack {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .frame(width: ICON_SIZE, height: ICON_SIZE)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                self.show = false
                                self.isCardActive = false
                                self.ActiveIndex = -1
                                self.isScrollable = false
                            }
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
                .frame(maxWidth: show ? .infinity : bounds.size.width - 60)
                .frame(height: show ? 460 : 280)
                .background(Color(course.color))
                .clipShape(RoundedRectangle(cornerRadius: self.cornerRadius,
                                            style: .continuous))
                .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
                
                VStack(alignment: .leading, spacing: 30.0) {
                    Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
                    
                    Text("About this course")
                        .font(.title).bold()
                    
                    Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                    
                    Text("Minimal coding experience required, such as in HTML and CSS. Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'll get a lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter.")
                }
                .padding(30)
                .padding(.bottom, 80)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


