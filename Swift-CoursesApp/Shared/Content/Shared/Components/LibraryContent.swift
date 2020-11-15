import SwiftUI

struct LibraryContent: LibraryContentProvider {
    @LibraryContentBuilder
    var views: [LibraryItem] {
        LibraryItem(CloseButton(), category: .control)
    }
    
    @LibraryContentBuilder
    func modifiers(base: Image) -> [LibraryItem] {
        LibraryItem(base.CardStyle(), category: .effect)
    }
}
 
extension View {
    func CardStyle(color: Color = Color.black, cornerRadius: CGFloat = 22) -> some View {
        return self
            .background(color)
            .cornerRadius(cornerRadius)
            .shadow(radius: 20)
    }
}
