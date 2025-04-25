import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboardOnTap() -> some View {
        self.modifier(HideKeyboardOnTapModifier())
    }
}

private struct HideKeyboardOnTapModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .gesture(
                TapGesture().onEnded {
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder),
                        to: nil, from: nil, for: nil
                    )
                }
            )
    }
}
#endif
