import SwiftUI

struct HomeView: View {
    @Binding var ProfileVisible: Bool
    @Binding var ContentVisible: Bool
    @Binding var ViewState: CGSize
    @State var isScrollable = false

    @State var UpdateShown = false
    
    /////////////////////////////////////////////////////////////////////////////////
    
    @ObservedObject var store = CoursesModel()
    
    @State var isCardActive = false
    @State var ActiveIndex = -1
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    func getAngleMultiplier(bounds: GeometryProxy) -> Double {
        if bounds.size.width > 500 { return 80}
        else { return 20 }
    }
    
    func getCardWidth(bounds: GeometryProxy) -> CGFloat {
        if bounds.size.width > 712 { return 712 }
        return  bounds.size.width - 60
    }
    
    var body: some View {
        let isIpad = self.horizontalSizeClass == .regular

        GeometryReader { bounds in
            ScrollView  {
                VStack {
                    HStack {
                        Text("Watching").font(.system(size: 28, weight: .bold))
                        Spacer()
                        AvatarButton(ProfileVisible: $ProfileVisible)
                        
                        let ICON_SIZE = CGFloat(36)
                        Button(action: {self.UpdateShown.toggle()}) {
                            Image(systemName: "bell")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                                .frame(width: ICON_SIZE, height: ICON_SIZE )
                                .background(Color("background3"))
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.1), radius: 1, x: 0, y: 1)
                                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 10, x: 0, y: 10)
                        }
                        .sheet(isPresented: $UpdateShown ) {
                            UpdatesList()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.leading, 14)
                    .padding(.bottom, 15)
                    .blur(radius: self.isCardActive ? 20 : 0)
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        WatchRingsView()
                            .padding(.horizontal, 30)
                            .padding(.bottom, 23)
                            .onTapGesture(perform: {
                                self.ContentVisible = true
                            })
                    }
                    .blur(radius: self.isCardActive ? 20 : 0)
                    
                    
                    let CARD_SIZE = CGFloat(275)
                    ScrollView (.horizontal, showsIndicators:false) {
                        HStack (spacing: 30) {
                            ForEach(CardsData) { item in
                                GeometryReader { geometry in
                                    CardItem(card: item, height:CARD_SIZE, width: CARD_SIZE)
                                        .rotation3DEffect(.degrees(Double(geometry.frame(in: .global).minX - 30) / -getAngleMultiplier(bounds:bounds)),
                                                          axis: (x: 0, y: 10, z: 0))
                                }.frame(width:CARD_SIZE, height:CARD_SIZE)
                            }
                        }
                        .padding(30)
                        .padding(.bottom, 30)
                    }
                    .offset(y: -30)
                    .blur(radius: self.isCardActive ? 20 : 0)

                    HStack {
                        Text("Courses")
                            .font(.title).bold()
                        Spacer()
                    }
                    .padding(.leading, 30)
                    .offset(y: -40)
                    .blur(radius: self.isCardActive ? 20 : 0)
                    
                     VStack (spacing: 30) {
                         ForEach(store.courses.indices, id: \.self) { index in
                            let item = self.store.courses[index]
                            let isActive = self.ActiveIndex != index && self.isCardActive
                            GeometryReader { geometry in
                                CourseItem(
                                    course: item,
                                    show:  $store.courses[index].show,
                                    isCardActive: $isCardActive,
                                    index: index,
                                    ActiveIndex:  $ActiveIndex,
                                    isScrollable: $isScrollable,
                                    bounds: bounds
                                )
                                .offset(y: item.show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(isActive ? 0 : 1)
                                .scaleEffect(isActive ? 0.5 : 1)
                                .offset(x: isActive ? bounds.size.width : 0)
                            }
                            .frame(height: isIpad ? 80 : 280)
                            .frame(maxWidth: item.show ? 712 : getCardWidth(bounds: bounds))
                            .zIndex(item.show ? 1 : 0)
                        }
                    }
                     .padding(.bottom, isIpad ? 220 : 0)
                    .offset(y: -35)
                    
                    Spacer()
                }
                .frame(width: bounds.size.width)
                .offset(y: ProfileVisible ? -450 : 0)
                .rotation3DEffect(
                    .degrees(ProfileVisible ? Double(ViewState.height / 10) - 10 : 0),
                    axis: (x: 10, y: 0, z: 0))
                .scaleEffect(ProfileVisible ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
                        .disabled(isCardActive && !isScrollable ? true : false)

            
        }
    }
    
    
    private struct AvatarButton: View {
        @Binding var ProfileVisible: Bool
        @EnvironmentObject var user: UserStore
        
        let AVATAR_SIZE = CGFloat(36)
        var body: some View {
            VStack {
                if user.isAuth {
                    Button(action: {self.ProfileVisible.toggle()}) {
                        Image("Avatar")
                            .resizable()
                            .frame(width: AVATAR_SIZE, height: AVATAR_SIZE )
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }
                } else {
                    let ICON_SIZE = CGFloat(36)
                    Button(action: {user.showLoginView.toggle() }) {
                        Image(systemName: "person")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.primary)
                            .frame(width: ICON_SIZE, height: ICON_SIZE )
                            .background(Color("background3"))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    
                }
            }
        }
    }

    private struct CardItem: View {
        var card: CardType
        var height: CGFloat
        var width: CGFloat
        
        var body: some View {
            VStack {
                HStack (alignment:.top) {
                    Text(card.title)
                        .font(.system(size: 24, weight: .bold))
                        .frame(width: 160, alignment: .leading)
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    
                    Spacer()
                    card.logo
                }
                
                Text(card.text.uppercased()).frame(maxWidth: .infinity, alignment: .leading)
                card.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 210)
            }
            .padding(.top, 20)
            .padding(.horizontal)
            .frame(width: width, height: height )
            .background(card.color)
            .cornerRadius(30)
            .shadow(color: card.color.opacity(0.45), radius: 20, x: 0, y: 20)
        }
    }

}

let CardsData = [
    CardType(title: "Prototype designs in SwiftUI", text: "18 Sections",
             logo: Image("Logo1"), image: Image("Card1") , color: Color("card1")),
    CardType(title: "Build SwiftUI App", text: "20 Sections",
             logo: Image("Logo1"), image: Image("Card2") , color: Color("card2")),
    CardType(title: "SwiftUI Advanced", text: "24 Sections",
             logo: Image("Logo1"), image: Image("Card3") , color: Color("card4")),
    CardType(title: "Learn SwiftUI", text: "16 Sections",
             logo: Image("Logo1"), image: Image("Card4") , color: Color("card5"))
]

struct CardType: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: Image
    var image: Image
    var color: Color
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 
 
struct WatchRingsView: View {
    var body: some View {
        HStack (spacing: 15) {
            HStack(spacing: 12) {
                RingView(color1: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), color2: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), CIRCLE_SIZE: 44, percentage: 68, show: .constant(true))
                VStack (alignment: .leading) {
                    Text("6 minutes left").bold().modifier(FontModifier(style: .subheadline))
                    Text("Watched 10 minutes today").modifier(FontModifier(style: .caption))
                }
            }
            .padding(8)
            .padding(.horizontal, 5)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12) {
                RingView(color1: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), color2: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)), CIRCLE_SIZE: 32, percentage: 54, show: .constant(true))
            }
            .padding(8)
            .padding(.horizontal, 5)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12) {
                RingView(color1: Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), color2: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), CIRCLE_SIZE: 32, percentage: 32, show: .constant(true))
            }
            .padding(8)
            .padding(.horizontal, 5)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
        }
    }
}
