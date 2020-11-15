import SwiftUI
import Firebase

struct LoginView: View {
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 2)
    @State private var isLoading = false
    @State private var isSuccess = false
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack (alignment: .top) {
                Color("background2")
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)
                
                HeaderView()
                FormView(email: $email, password: $password)
                    .onAppear { self.kGuardian.addObserver() }
                    .onDisappear { self.kGuardian.removeObserver() }
                
                if kGuardian.slide <= 0 {
                    FooterView(isLoading: $isLoading, isSuccess: $isSuccess, email: $email, password: $password)
                }
                
            }
            .offset(y: -(kGuardian.slide / 7))
            .animation(kGuardian.slide > 0 ?  .easeInOut(duration: 0.5) :  nil)
            .onTapGesture(perform: { HideKeyboard() })
            
            if isLoading {
                LoadingView()
            }
            
            if isSuccess {
                SuccessView()
            }
        }
    }
    
    private struct HeaderView: View {
        @State var ViewState = CGSize.zero
        @State var isAnimating = false
        @State var isDragging = false
        
        @EnvironmentObject var user: UserStore
        
        var body: some View {
            VStack {
                GeometryReader { geometry in
                    Text("Learn design & code. \nFrom scratch.")
                        .font(.system(size: geometry.size.width / 10, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 375, maxHeight: 100)
                .padding(.horizontal, 16)
                .offset(x: ViewState.width / 15, y: ViewState.height / 15)
                
                Text("80 hours of courses for Swift UI, React and design tools.")
                    .font(.subheadline)
                    .frame(width: 250)
                    .offset(x: ViewState.width / 20, y: ViewState.height / 20)
                
                Spacer()
            }
            .multilineTextAlignment(.center)
            .padding(.top, 100)
            .frame(height: 477)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -150, y: -200)
                        .rotationEffect(.degrees( isAnimating ? 360+90 : 90))
                        .blendMode(.plusDarker)
                        .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                        .onAppear { self.isAnimating = true }
                    
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -200, y: -250)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0), anchor: .leading)
                        .blendMode(.overlay)
                        .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                    
                    
                    let ICON_SIZE: CGFloat =  36
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "xmark")
                                .frame(width: ICON_SIZE, height: ICON_SIZE)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .padding(.horizontal, 11)
                                .padding(.top, 3)
                        }
                        Spacer()
                    }
                    .padding()
                    . onTapGesture(perform: {
                        self.user.showLoginView = false
                    })
                }
            )
            .background(
                Image(uiImage: #imageLiteral(resourceName: "Card3"))
                    .offset(x: ViewState.width / 25, y: ViewState.height / 25), alignment: .bottom)
            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .scaleEffect(isDragging ? 0.9 : 1)
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            .rotation3DEffect(.degrees(5),axis: (x: ViewState.width, y: ViewState.height, z: 0))
            .gesture(
                DragGesture()
                    .onChanged({ (value) in
                        self.ViewState = value.translation
                        self.isDragging = true
                    })
                    .onEnded({ (value) in
                        self.ViewState = .zero
                        self.isDragging = false
                    })
            )
        }
    }
    
    private struct FormView: View {
        @Binding var email: String
        @Binding var password: String
        
        var body: some View {
            VStack {
                LoginTextField(value: $email, field: "Your email", icon: "person.crop.circle.fill")
                    .keyboardType(.emailAddress)
                Divider().padding(.leading, 80)
                LoginTextField(value: $password, field: "Password", icon: "lock.fill", isSecure: true)
            }
            .frame(height: 136)
            .frame(maxWidth: 712)
            .background(BlurView())
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
            .padding(.horizontal)
            .offset(y: 460)
        }
        
        private struct LoginTextField: View {
            @Binding var value: String
            var field: String
            var icon: String
            
            var isSecure: Bool = false
            
            var body: some View {
                HStack {
                    let ICON_SIZE: CGFloat = 44
                    Image(systemName: self.icon)
                        .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                        .frame(width: ICON_SIZE, height: ICON_SIZE)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                        .padding(.leading)
                    
                    
                    let INPUT_SIZE: CGFloat = 44
                    if self.isSecure {
                        SecureField(self.field.uppercased(), text: self.$value)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: INPUT_SIZE)
                    } else {
                        TextField(self.field.uppercased(), text: self.$value)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: INPUT_SIZE)
                    }
                }
                .padding(.vertical, 1)
            }
        }
    }
    
    private struct FooterView: View {
        @Binding var isLoading: Bool
        @Binding var isSuccess: Bool
        
        @Binding var email: String
        @Binding var password: String
        
        @State var ShowAlert = false
        @State var AlertMessage = "Something went wrong"
        
        @EnvironmentObject var user: UserStore
        
        func LoginFn() {
            HideKeyboard()
            self.isLoading = true
            
            user.signIn(email: self.email, password: self.password) { (result, error) in
                self.isLoading = false
                if error != nil {
                    self.AlertMessage = error?.localizedDescription ?? ""
                    self.ShowAlert = true
                } else {
                    self.isSuccess = true
                    self.user.isAuth = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.email = ""
                        self.password = ""
                        self.isSuccess = false
                        self.user.showLoginView = false
                    }
                }
            }
        }
        
        var body: some View {
            HStack {
                Text("Forgot password?")
                    .font(.subheadline)
                Spacer()
                
                let BUTTON_COLOR = Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                Button(action: { self.LoginFn() }) {
                    Text("Login")
                        .foregroundColor(.black)
                }
                .padding(12)
                .padding(.horizontal, 30)
                .background(BUTTON_COLOR)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: BUTTON_COLOR.opacity(0.3), radius: 20, x: 0, y: 20)
                .alert(isPresented: $ShowAlert, content: {
                    Alert(title: Text("Error"), message: Text(self.AlertMessage), dismissButton: .default(Text("OK")))
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding()
            .padding(.bottom, 15)
        }
    }
}





