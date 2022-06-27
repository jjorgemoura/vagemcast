import ComposableArchitecture
import SwiftUI

public struct PlayerView: View {
    let store: Store<PlayerState, PlayerAction>
    let viewStore: ViewStore<PlayerState, PlayerAction>

    public init(store: Store<PlayerState, PlayerAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }

    public var body: some View {
        Text("to be continued")
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(
            store: .init(
                initialState: .init(loading: false),
                reducer: playerReducer,
                environment: PlayerEnvironment()
            )
        )
    }
}
