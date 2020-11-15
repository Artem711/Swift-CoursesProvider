import SwiftUI

struct UpdatesList: View {
    @ObservedObject var store = UpdatesStore()
    
   private func addUpdate() {
        store.updates.append(
            UpdateItemType(image: "Card1", title: "New Item", text: "Text", date: "Jan 1"))
    }
    
    let IMAGE_SIZE = CGFloat(80)
    var body: some View {
        NavigationView {
            List {
                ForEach(store.updates) { update in
                    NavigationLink(destination: UpdateDetails(update:update)) {
                        HStack {
                            Image(update.image)
                                .resizable()
                                .aspectRatio(contentMode:.fit)
                                .frame(width: IMAGE_SIZE, height: IMAGE_SIZE)
                                .background(Color.black)
                                .cornerRadius(20)
                                .padding(.trailing, 4)
                            
                            
                            VStack (alignment:.leading, spacing: 8) {
                                Text(update.title)
                            
                                Text(update.date)
                                    .font(.caption)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                 
                }
                .onDelete { index in
                    self.store.updates.remove(at:index.first!)
                }
                .onMove { (source:IndexSet, destination:Int) in
                    self.store.updates.move(fromOffsets: source, toOffset:destination)
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle(Text("List View"))
            .navigationBarItems(leading: Button(action:addUpdate) {Text("Add update")},
                                trailing:EditButton())
            
        }
    }
}


