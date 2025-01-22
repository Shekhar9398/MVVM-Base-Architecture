
import SwiftUI

extension View {
    func addShadow() -> some View {
        self.shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}
