import SwiftUI

struct BoldHeadline: ViewModifier {
    let textFont: String = "Verdana"
    let textSize: CGFloat = 18
    let textColor: Color

    func body(content: Content) -> some View {
        content
            .font(.custom(textFont, size: textSize))
            .foregroundColor(textColor)
            .bold()
    }
}

extension View {
    func boldHeadline(color: Color = .primary) -> some View {
        self.modifier(BoldTitle(textColor: color))
    }
}

#Preview {
        Text("Custom headline")
        .boldHeadline(color: .gray)
}
