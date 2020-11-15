import SwiftUI

struct LoadingView: View {
    var body: some View {
        let ANIMATION_SIZE: CGFloat = 200
        VStack {
            LottieView(filename: "loading")
                .frame(width: ANIMATION_SIZE, height: ANIMATION_SIZE)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
