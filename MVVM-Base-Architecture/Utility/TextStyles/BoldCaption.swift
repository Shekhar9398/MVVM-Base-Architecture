import SwiftUI

struct BoldCaption: ViewModifier {
    let textFont: String = "Verdana"
    let textSize: CGFloat = 14
    let textColor: Color

    func body(content: Content) -> some View {
        content
            .font(.custom(textFont, size: textSize))
            .foregroundColor(textColor)
            .bold()
    }
}

extension View {
    func boldCaption(color: Color = .primary) -> some View {
        self.modifier(BoldTitle(textColor: color))
    }
}

#Preview {
        Text("Custom Caption")
        .boldCaption(color: .gray)
}
