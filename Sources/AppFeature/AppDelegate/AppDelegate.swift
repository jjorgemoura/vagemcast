import ComposableArchitecture
import MetricKit
import SwiftUI

public enum AppDelegateAction {
    case appStartupCompleted
    case didChangeScenePhase(ScenePhase)
    case didFinishLaunching
    case didReceiveDiagnosticPayload([MXDiagnosticPayload])
    case didReceiveMetricPayload([MXMetricPayload])
}

public struct AppDelegateEnvironment {}

let appDelegateReducer = Reducer<AppState, AppDelegateAction, AppDelegateEnvironment> { _, action, _ in
    switch action {
    case .appStartupCompleted:
        return .none

    case let .didChangeScenePhase(scenePhase):
        switch scenePhase {
        case .background:
            print("Scene Phase is -> Background")
        case .inactive:
            print("Scene Phase is -> Inactive")
        case .active:
            print("Scene Phase is -> Active")
        @unknown default:
            print("Scene Phase is -> NEW STATE!!!!")
        }
        return .none

    case .didFinishLaunching:
        // load stored app state from user defaults
        return .none

    case .didReceiveMetricPayload(let payloads):
        let dataPayload = payloads.map { String(data: $0.jsonRepresentation(), encoding: .utf8) }
        dataPayload.forEach { print($0 ?? "ERROR!!") }

        return .none

    case .didReceiveDiagnosticPayload(let payloads):
        let dataPayload = payloads.map { String(data: $0.jsonRepresentation(), encoding: .utf8) }
        dataPayload.forEach { print($0 ?? "ERROR!!") }

        return .none
    }
}
