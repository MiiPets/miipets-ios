import Foundation

enum LandingScreen {
    case sitter
    case profile
}

protocol LandingScreenViewModelling { }

class LandingScreenViewModelResolver {
    
    static func viewmodel(for landingScreen: LandingScreen, sitterDelegate: SitterLandingDelegate? = nil) -> LandingScreenViewModelling? {
        switch landingScreen {
        case .sitter:
            guard let sitterDelegate = sitterDelegate else {
                fatalError("The SitterViewModel requires a delegate on initialisation")
            }
            return SitterViewModel(delegate: sitterDelegate)
        default:
            return nil
        }
    }
}
