import SwiftUI

struct BoldTitle: ViewModifier {
    let textFont: String = "Verdana"
    let textSize: CGFloat = 22
    let textColor: Color

    func body(content: Content) -> some View {
        content
            .font(.custom(textFont, size: textSize))
            .foregroundColor(textColor)
            .bold()
    }
}

extension View {
    func boldTitle(color: Color = .primary) -> some View {
        self.modifier(BoldTitle(textColor: color))
    }
}

#Preview {
        Text("Custom Title")
            .boldTitle(color: .gray)
}
