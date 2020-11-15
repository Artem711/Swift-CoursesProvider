import SwiftUI

struct CourseRow: View {
    var item: CourseSectionType = CourseSectionsData[0]
    
    var body: some View {
        HStack (alignment: .top) {
            let ICON_SIZE:CGFloat = 48
            
            Image(item.logo)
                .renderingMode(.original)
                .frame(width: ICON_SIZE, height: ICON_SIZE)
                .imageScale(.medium)
                .background(item.color)
                .clipShape(Circle())
                
            VStack (alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
                
                Text(item.subtitle)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 5)
    }
}
