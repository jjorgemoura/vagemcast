// import Beatz
// import Defectz
import ComposableArchitecture
//import ConverterFeature
import MetricKit
//import PredictionFeature
//import SettingsFeature

let metricLogger = MXMetricManager.makeLogHandle(category: "App Store")

public struct AppState: Equatable {
    var loading: Bool

    public init(loading: Bool) {
        self.loading = loading
    }
}

public enum AppAction {
    case appDelegate(AppDelegateAction)
}

public struct AppEnvironment {
    public init() {
    }
}

let appReducerCore = Reducer<AppState, AppAction, AppEnvironment> { _, _, _ in
    mxSignpost(.begin, log: metricLogger, name: "appReducer")

//    switch action {
//
//    }

    mxSignpost(.end, log: metricLogger, name: "appReducer")
    return .none
}

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    appDelegateReducer.pullback(state: \.self,
                                action: /AppAction.appDelegate,
                                environment: { _ in AppDelegateEnvironment() }),

    appReducerCore
)
