import SwiftUI

struct UpdateDetails: View {
    var update: UpdateItemType
    var body: some View {
        List {
            VStack (spacing: 20) {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
            }.navigationBarTitle(update.title)
        }.listStyle(GroupedListStyle())
    }
}

struct UpdateDetails_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetails(update: UpdatesListData[0])
    }
}
