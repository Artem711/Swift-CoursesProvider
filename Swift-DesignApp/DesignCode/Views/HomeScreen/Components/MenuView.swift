import SwiftUI
import Firebase

struct MenuView: View {
    @Binding var isVisible: Bool
    @EnvironmentObject var user: UserStore
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack (spacing:16) {
                Text("Artem - 28% complete")
                    .font(.caption)
                
                Color.white
                    .frame(width: 38, height: 6 )
                    .cornerRadius(3)
                    .frame(width: 130, height: 6, alignment: .leading)
                    .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.08))
                    .cornerRadius(3)
                    .padding()
                    .frame(width: 150, height: 24)
                    .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.1))
                    .cornerRadius(12)
                
                MenuRowItem(title:"Account", icon: "gear")
                MenuRowItem(title:"Billing", icon: "creditcard")
                MenuRowItem(title:"Sign out", icon: "person.crop.circle")
                    .onTapGesture(perform: {
                        self.isVisible = false
                        user.signOut()
                    })
            }
            .frame(maxWidth: 500)
            .frame(height: 300)
            .background(BlurView(style: .systemMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 30)
            .overlay(
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 60, height: 60)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .offset(y: -150)
            )
        }
        .padding(.bottom, 30)
    }
}


struct MenuRowItem: View {
    var title: String
    var icon: String
    
    
    var body: some View {
        let ICON_SIZE = CGFloat(32)
        
        HStack(spacing:16) {
            Image(systemName:icon)
                .font(.system(size: 20, weight: .light ))
                .imageScale(.large)
                .frame(width: ICON_SIZE, height: ICON_SIZE)
                .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))
            
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .frame(width: 120,  alignment: .leading)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(isVisible: .constant(true))
    }
}
