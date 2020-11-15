import SwiftUI

struct RingView: View {
    var color1 = Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
    var color2 = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
    var CIRCLE_SIZE: CGFloat = 88
   
    var percentage: CGFloat = 88
    @Binding var show: Bool
    var body: some View {
        let multiplier = CIRCLE_SIZE / 44
        let progress = 1 - (percentage / 100)
        let STROKE_LINE_WIDTH = 5 * multiplier
        
       return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.2), style: StrokeStyle(lineWidth: STROKE_LINE_WIDTH))
                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
            
            Circle()
                .trim(from: show ? progress : 1, to: 1)
                .stroke(LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .topTrailing, endPoint: .bottomLeading),
                        style: StrokeStyle(lineWidth: STROKE_LINE_WIDTH, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                .rotationEffect(.degrees(90))
                .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                .shadow(color: color2.opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
                 
            Text("\(Int(percentage))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
                .onTapGesture(perform: {
                    self.show.toggle()
                })
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true))
    }
}
