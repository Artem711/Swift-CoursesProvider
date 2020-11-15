import SwiftUI

struct CourseBlockItem: View {
    var course: CourseType = CoursesData[0]
    var closeFunction: (() -> ())?

    var body: some View {
        VStack (alignment: .leading, spacing: 4) {
            
            if closeFunction != nil {
                CloseButton()
                    .padding(.top, 26)
                    .padding(.horizontal, 7)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .onTapGesture {  closeFunction!() }}
            
            Spacer()
            HStack {
                Spacer()
                Image(course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            
            Text(course.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            
            Text(course.subtitle)
                .font(.footnote)
                .foregroundColor(Color.white)
        }
        .padding(.all)
        .background(course.color)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: course.color.opacity(0.3), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 10)
    }
}

struct CourseItem_Previews: PreviewProvider {
    static var previews: some View {
        CourseBlockItem(closeFunction: {})
    }
}
