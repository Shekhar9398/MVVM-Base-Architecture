import SwiftUI

struct GrowingButton: ButtonStyle {
    let buttonColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(buttonColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    VStack {
        Button("Tap Me") {
            print("Button Pressed")
        }
        .buttonStyle(GrowingButton(buttonColor: .pink))
    }
    .padding()
}
