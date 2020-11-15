import SwiftUI

struct CertificatesView: View {
    @State var openCards = false
    @State var showPanel = false
    
    @State var ViewState = CGSize.zero
    @State var PanelState = CGSize.zero
    
     var body: some View {
        ZStack {
            let MAX_PANEL_HEIGHT = CGFloat(-100)
            TitleView()
                .blur(radius: openCards ? 20 : 0)
                .opacity(showPanel ? 0.4 : 1)
                .offset(y: 0)
                .animation(Animation.default.delay(0.1))
            
       
            CardsList(MAX_PANEL_HEIGHT:MAX_PANEL_HEIGHT,openCards: $openCards, showPanel: $showPanel, ViewState: $ViewState, PanelState: $PanelState)
            
            GeometryReader { bounds in
                BottomPanelView(show: $showPanel)
                    .offset(x:0, y: showPanel ? bounds.size.height / 1.8 : bounds.size.height)
                    .offset(y: PanelState.height)
                    .blur(radius: openCards ? 20 : 0)
                    .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration:0.8))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.PanelState = value.translation
                                if self.PanelState.height < MAX_PANEL_HEIGHT {
                                    self.PanelState.height  = MAX_PANEL_HEIGHT
                                }
                                
                            }
                            .onEnded { value in
                                if self.PanelState.height > 140 {
                                    self.showPanel = false
                                }
                                
                                self.PanelState = .zero
                            }
                        
                )
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        
    }
    
    private struct TitleView: View {
        var body: some View {
            VStack {
                HStack {
                    Text("Certificates")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding()
                
                Image("Background1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 375)
                
                Spacer()
            }
        }
    }
    
    private struct BottomPanelView: View {
        @Binding var show: Bool
        
        var body: some View {
            VStack(spacing:20) {
                Rectangle()
                    .frame(width: 40, height: 5)
                    .cornerRadius(3)
                    .opacity(0.1)
                
                Text("This certificate is proof that Artem has achieved the UI Design course with approval from a Design Code instructor.")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .lineSpacing(4)
                
                HStack(spacing: 25) {
                    RingView(color1: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), color2: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)),  percentage: 78, show: $show)
                    
                    VStack (alignment: .leading, spacing: 8) {
                        Text("Swift UI").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("12 of 12 sections completed\n 10 hours spent so far")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .lineSpacing(4)
                    }
                    .padding(20)
                    .background(Color("background3"))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                }
                
                Spacer()
            }
            .padding(.top, 8)
            .padding(.horizontal , 20)
            .frame(maxWidth: 712)
            .background(BlurView(style: .systemThinMaterial))
            .cornerRadius(30)
            .shadow(radius: 20)
            .frame(maxWidth: .infinity)
        }
    }
    
    private struct CardsList: View {
        var MAX_PANEL_HEIGHT: CGFloat
        @Binding var openCards: Bool
        @Binding var showPanel: Bool
        
        @Binding var ViewState: CGSize
        @Binding var PanelState: CGSize
        
        var body: some View {
            ZStack {
                BackCardView()
                    .frame(maxWidth: showPanel ? 300 : 340)
                    .frame(height: 220)
                    .background(Color("card4"))
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .offset(x:0, y:openCards ? -400 : -40)
                    .offset(x: ViewState.width, y: ViewState.height)
                    .offset(y:showPanel ? -180 : 0 )
                    .scaleEffect(showPanel ? 1 : 0.9)
                    .rotationEffect(.degrees(openCards ? 0 : 10))
                    .rotationEffect(.degrees(showPanel ? -10 : 0))
                    .rotation3DEffect(.degrees(showPanel ? 0 : 10),axis: (x: 10, y: 0, z: 0))
                    .blendMode(.hardLight)
                    .animation(.easeInOut(duration: 0.35))
                
                BackCardView()
                    .frame(maxWidth:   340)
                    .frame(height: 220)
                    .background(Color("card3"))
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .offset(x:0, y: openCards ? -200 : -20)
                    .offset(x: ViewState.width, y: ViewState.height)
                    .offset(y:showPanel ? -140 : 0 )
                    .scaleEffect(showPanel ? 1 :0.95)
                    .rotationEffect(.degrees(openCards ? 0 : 5))
                    .rotationEffect(.degrees(showPanel ? -5 : 0))
                    .rotation3DEffect(.degrees(showPanel ? 0 : 5),axis: (x: 10, y: 0, z: 0))
                    .blendMode(.hardLight)
                    .animation(.easeInOut(duration: 0.3))
                
                 CardView()
                    .frame(maxWidth: showPanel ? 375 : 340)
                    .frame(height: 220)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: showPanel ? 30 : 20, style: .continuous))
                    .shadow(radius: 20)
                    .offset(x: ViewState.width, y: ViewState.height)
                    .offset(y: showPanel ? MAX_PANEL_HEIGHT : 0)
                    .blendMode(.hardLight)
                    .animation(.spring(response: 0.45, dampingFraction: 0.6, blendDuration: 0))
                    .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        self.showPanel.toggle()
                    })
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if !showPanel {
                                    self.ViewState = value.translation
                                    self.openCards = true
                                }
                            }
                            .onEnded { value in
                                self.ViewState = .zero
                                self.openCards = false
                            }
                        
                    )
                
            }
        }
        
        private struct CardView: View {
            var body: some View {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("UI Design")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Text("Certificate")
                                .foregroundColor(Color("accent"))
                        }
                        Spacer()
                        Image("Logo1")
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    
                    Spacer()
                    Image("Card1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 110, alignment: .top)
                }
                
            }
        }
        
        private struct BackCardView: View {
            var body: some View {
                VStack {
                    Spacer()
                }
                
            }
        }
    }
}
 

 
 
 

 
 
