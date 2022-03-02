import ComposableArchitecture
//import ConverterFeature
//import PredictionFeature
//import SettingsFeature
import SwiftUI

public struct AppView: View {
    let store: Store<AppState, AppAction>
    let viewStore: ViewStore<AppState, AppAction>

    public init(store: Store<AppState, AppAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }

    public var body: some View {
        //        Group {
        //            if viewStore.state.loading {
        //                LoadingView()
        //            } else if viewStore.state.error {
        //                ErrorView()
        //            } else {
        //                HomeView(store: store.scope(state: \.home,
        //                                            action: AppAction.home))
        //                    .padding()
        //            }
        //        }

        Text("to be continued")
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(
            store: .init(
                initialState: .init(loading: false),
                reducer: appReducer,
//                environment: AppEnvironment(beatz: .noop, defectz: .noop)
                environment: AppEnvironment()
            )
        )
    }
}
