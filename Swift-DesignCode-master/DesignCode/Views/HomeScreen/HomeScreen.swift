import SwiftUI

struct HomeScreen: View {
    @State var ProfileVisible = false
    @State var ViewState = CGSize.zero
    @State var ContentVisible = false
    
    @EnvironmentObject var user: UserStore
    
    
    
    var body: some View {
        ZStack {
            Color("background2")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            
            HomeBackground(ProfileVisible: $ProfileVisible)
                .offset(y: ProfileVisible ? -450 : 0)
                .rotation3DEffect(
                    .degrees(ProfileVisible ? Double(ViewState.height / 10) - 10 : 0),
                    axis: (x: 10, y: 0, z: 0))
                .scaleEffect(ProfileVisible ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            
            HomeView(ProfileVisible: $ProfileVisible, ContentVisible: $ContentVisible, ViewState: $ViewState)
            
            
            MenuView(isVisible: $ProfileVisible)
                .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.001))
                .offset(y: ProfileVisible ? 0 : screen.height)
                .offset(y: ViewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture(perform: {self.ProfileVisible.toggle()})
                .gesture(DragGesture()
                            .onChanged { value in
                                self.ViewState = value.translation
                            }.onEnded{ value in
                                if self.ViewState.height > 50 {
                                    self.ProfileVisible = false
                                }
                                self.ViewState = .zero
                            })
            
            
            if user.showLoginView {
                LoginView()
            }
            
            if ContentVisible {
                let ICON_SIZE: CGFloat =  36
                BlurView(style: .systemMaterial)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                CertificatesView()
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width: ICON_SIZE, height: ICON_SIZE)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }
                    Spacer()
                }
                .offset(x: -16, y: 16)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                .onTapGesture(perform: {
                    self.ContentVisible = false
                })
            }
        }.onAppear(perform:         user.listen)
        
    }
}



struct HomeBackground: View {
    @Binding var ProfileVisible: Bool
    
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [Color("background2"), Color("background1")]),
                           startPoint: .top, endPoint: .bottom)
                .frame(height: 200)
            Spacer()
        }
        .background(Color("background1"))
        .clipShape(RoundedRectangle(cornerRadius: ProfileVisible ? 30 : 0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
    }
}
