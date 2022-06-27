import ComposableArchitecture

public struct PlayerState: Equatable {
    //    var loading: Bool

    public init(loading: Bool) {
        //        self.loading = loading
    }
}

public enum PlayerAction {
    case play
    case stop
}

public struct PlayerEnvironment {
    public init() {
    }
}

let playerReducer = Reducer<PlayerState, PlayerAction, PlayerEnvironment> { _, action, _ in
    switch action {
        
    case .play:
        return .none
    case .stop:
        return .none
    }
}
