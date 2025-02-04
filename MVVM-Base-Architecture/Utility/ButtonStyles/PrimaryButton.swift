import SwiftUI

struct PrimaryButton: ButtonStyle {
    let buttonWidth: CGFloat = 150
    let buttonHeight: CGFloat = 60
    let buttonFont: String = "verdana"
    let buttonColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.custom(buttonFont, size: 20))
            .bold()
            .frame(width: buttonWidth,height: buttonHeight)
            .background(buttonColor)
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}

#Preview {
    VStack {
        Button("Tap Me") {
            print("Button Pressed")
        }
        .buttonStyle(PrimaryButton(buttonColor: .mint))
    }
    .padding()
}
