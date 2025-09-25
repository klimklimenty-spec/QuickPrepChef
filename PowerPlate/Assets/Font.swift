
import SwiftUI

extension Font {
    static func montserrat(size: CGFloat, weight: Montserrat) -> Font {
        .custom(weight.rawValue, size: size)
    }
}

enum Montserrat: String {
    case bold = "Montserrat-Bold"
    case medium = "Montserrat-Medium"
}
