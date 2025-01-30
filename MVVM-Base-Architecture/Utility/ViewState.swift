
import SwiftUI

enum ViewState<T>{
    case idle
    case loading
    case data(model: T)
    case error(errorMessage: String)
}
