
import Foundation
import LocalAuthentication


enum ObtainResult: Error {
    case failure(error: Error)
    case success(result: Bool)
    case featureFailure
}

enum BiometryType {
    case faceId
    case touchId
    case dontSupportBiometry
}

class LocalAuthorizationService {
    
    // Контекст LocalAuthentication
    private let laContext = LAContext()
    
    // Получатель ошибок
    private var error: NSError?
    
    func authorizeIfPossible(_ authorizetionFinished: @escaping (ObtainResult) -> Void) {
        
        // Проверка на доступ к биометрии
        if laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            print(laContext.biometryType.rawValue)

            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To access data") { (success, error) in
                if let error = error {
                    print("Try another method, \(error.localizedDescription)")
                    authorizetionFinished(.failure(error: error))
                    return
                }
                authorizetionFinished(.success(result: success))
                print("Auth: \(success)")
            }
        } else {
            authorizetionFinished(.featureFailure)
        }
    }
    
    func usedBiometryType () -> BiometryType {
        var type: BiometryType = .dontSupportBiometry
        
        if laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            switch laContext.biometryType.rawValue {
            case 2:
                type = .faceId
            case 1:
                type = .touchId
            case 0:
                type = .dontSupportBiometry
            default:
                type = .dontSupportBiometry
            }
        }
        return type
    }
}
