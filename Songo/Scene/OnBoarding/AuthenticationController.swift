//
//  AuthenticationController.swift
//  Fungoverso
//
//  Created by Frederico Lacis de Carvalho on 13/07/21.
//

import AuthenticationServices
import CryptoKit
import FirebaseAuth

/// Protocol for classses that need to observe the currentUser from the AuthenticationController
protocol UserObserver {
    func didUpdateUser()
    func didUpdateUserCollectedAnnotations(annotations: [AnnotationModel])
}

class AuthenticationController: NSObject {
    
    //MARK: - Injected Properties
    private var userRepository: UserRepository
    
    //MARK: - Properties
    private var currentUser: UserModel? {
        didSet {
            notifyUserObservers()
            saveUserDefaults()
        }
    }
    
    private var currentNonce: String?
    
    private var performSignInCompletionHandler: ((AuthenticationError?) -> Void)?
    
    private var userObservers: [UserObserver] = []

    private weak var window: UIWindow?

    public lazy var userMissingInformationAlert: UIAlertController = UIAlertController(title: "Encontramos um problema...", message: "Ocorreu um erro durante a autorização do seu usuário. Se você alguma vez já efetuou o login usando o seu IDApple neste dispositivo você deve primeiro cancelar o uso desse ID em Configurações > ID Apple > Senha e Segurança > Apps que usam o ID Apple > Cogu > Parar de usar o ID Apple. Depois efetue novamente o login pelo Cogu.", preferredStyle: .alert)
    
    public lazy var signInFailed = UIAlertController(title: NSLocalizedString("Algo deu errado", comment: "AuthenticationController: Title of alert when the signIn fails."),
                                                     message: NSLocalizedString("Por favor, tente novamente.", comment: "AuthenticationController: Try again message on the fail signIn alert."),
                                                     preferredStyle: .alert)
    
    enum AuthenticationError: Error {
        case noAuthData
        case missingUserInformation
        case userNotLoggedIn
        case unableToUpdateUser
        case signInCanceled
        case firebaseAuthError
        case signInWithAppleFailed
        case unableToCreateUserDocument
        case unableToReadUserDocument
    }
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        super.init()
        
        //Retrieve the user's Id and try to load first from UserDefaults and then from Firebase
        if let currentUserId = Auth.auth().currentUser?.uid {
            loadUserDefaults(id: currentUserId)
            updateCurrentUser(with: currentUserId)
        }
        
        userMissingInformationAlert.addAction(UIAlertAction(title: "Me leve para as Configurações", style: .default, handler: handleUserLoginFailedAlert))
        userMissingInformationAlert.addAction(UIAlertAction(title: "Ignorar", style: .default, handler: .none))
        signInFailed.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "AuthenticationController: Dismiss error message."), style: .default, handler: .none))
    }
    
}

// MARK: - Public Methods
extension AuthenticationController {
    
    /// If there is a cached user, returns it
    /// - Returns: The the current `UserModel`
    public func getCurrentUser() -> UserModel? {
        return currentUser
    }
    
    /// Performs the SignInWithApple authentication method
    /// - Parameters:
    ///   - presenterWindow: The window that will display the SignInWithApple overlay
    ///   - completionHandler:  Asynchronously returns `nil` (if signIn was successfull) or an `Error`
    public func performSignIn(presenterWindow: UIWindow? = nil, completionHandler: @escaping (AuthenticationError?) -> Void) {
        self.window = presenterWindow
        self.performSignInCompletionHandler = completionHandler
        
        // Code that will be run only on simualtor
        #if targetEnvironment(simulator)
            if _isDebugAssertConfiguration() {
                signInFakeUser()
                return
            }
        #endif
        
        let request = createAppleIDRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        
        authorizationController.performRequests()
    }
    
    /// Signs out the current user from the app
    /// - Parameter completionHandler: Asynchronously returns `nil` (if the sign out was successfull) or an `Error`
    public func performSignOut(completionHandler: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            currentUser = nil
            deleteUserDefaults()
            completionHandler(nil)
        } catch {
            completionHandler(error)
        }
    }
    
    /// SHOULD NOT EXIST HERE. It notifies the map when a user created annotation is removed in the CollectionViewController
    /// - Parameter annotations: The array of annotations removed that were created by the user
    public func notifyChangeInAnnotations(annotations: [AnnotationModel]) {
        for observer in userObservers {
            observer.didUpdateUserCollectedAnnotations(annotations: annotations)
        }
    }
    
    /// Updates the user with the given user model
    /// - Parameters:
    ///   - updatedUser: The user model with modifications
    ///   - completionHandler: Asynchronously returns `nil` (if the update was successfull) or an `Error`
    public func updateUser(_ updatedUser: UserModel, completionHandler: @escaping (AuthenticationError?) -> Void) {
        guard let currentUser = currentUser,
              let currentUserID = currentUser.id,
              let updatedUserID = updatedUser.id,
              currentUserID == updatedUserID
        else {
            completionHandler(.userNotLoggedIn)
            return
        }
        
        self.currentUser = updatedUser
        
        userRepository.update(updatedUser) { _, error in
            if error != nil {
                completionHandler(.unableToUpdateUser)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    /// Updates the user profile image with the given `UIImage`
    /// - Parameters:
    ///   - image: The `UIImage` to be uploaded
    ///   - completionHandler: Asynchronously returns `nil` (if the update was successfull) or an `Error`
    public func updateUserProfileImage(with image: UIImage, completionHandler: @escaping (AuthenticationError?) -> Void) {
        guard let currentUser = currentUser else {
            completionHandler(.userNotLoggedIn)
            return
        }
        
        userRepository.changeImage(for: currentUser, with: image) { updatedUser, error in
            if error != nil {
                completionHandler(.unableToUpdateUser)
            } else {
                self.currentUser = updatedUser
                completionHandler(nil)
            }
        }
    }
    
    /// Deletes the user and all its data on firebase
    ///   - completionHandler: Asynchronously returns `nil` (if the deletion was successfull) or an `Error`
    public func deleteCurrentUser(completionHandler: @escaping (Error?) -> Void) {
        self.performSignIn() { error in
            if let error = error {
                completionHandler(error)
            } else {
                guard let currentFirebaseUser = Auth.auth().currentUser,
                      let currentUser = self.currentUser
                else {
                    completionHandler(AuthenticationError.userNotLoggedIn)
                    return
                }
                
                /// TODO: Delete users annotations when deleting the user
                
                currentFirebaseUser.delete() { error in
                    if let error = error {
                        completionHandler(error)
                    } else {
                        self.currentUser = nil
                        self.deleteUserDefaults()
                        self.userRepository.delete(currentUser) { error in
                            if let error = error {
                                completionHandler(error)
                            } else {
                                completionHandler(nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
}

// MARK: - Authorization Controller Delegate
extension AuthenticationController: ASAuthorizationControllerDelegate {
    
    // SignIn with Apple complete
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        guard let nonce = currentNonce else { return }
        guard let appleIDToken = appleIDCredential.identityToken else { return }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else { return }
        guard let completionHandler = self.performSignInCompletionHandler else { return }
        
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
        
        Auth.auth().signIn(with: credential) { authData, error in
            if error != nil {
                // Error on signIn
                completionHandler(.firebaseAuthError)
                return
            }
            
            guard let authData = authData,
                  let additionalUserInfo = authData.additionalUserInfo else {
                // Error: No authData provided
                completionHandler(AuthenticationError.noAuthData)
                return
            }
            
            if additionalUserInfo.isNewUser {
                // Create a new user item on Firestore
                self.createNewUser(appleIDCredential: appleIDCredential, authData: authData)
            } else {
                // User loggedIn successfully
                self.updateCurrentUser(with: authData.user.uid)
            }
        }
        
    }
    
    // Error on SignIn with Apple
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        guard let completionHandler = performSignInCompletionHandler else { return }
        
        if let error = error as? ASAuthorizationError {
            if error.code == .canceled {
                // The signIn was canceled by the user
                completionHandler(.signInCanceled)
                return
            }
        }
        
        completionHandler(.signInWithAppleFailed)
    }
    
}

// MARK: - Authorization Controller Presentation Context Providing
extension AuthenticationController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return window ?? UIWindow()
    }
    
}

// MARK: - Private Helper Methods
extension AuthenticationController {
    
    /// Send the user to the configurations app
    private func handleUserLoginFailedAlert(sender: UIAlertAction) {
        guard let url = URL(string: "App-prefs:root=ACCOUNTS_AND_PASSWORDS") else { return }
        if UIApplication.shared.canOpenURL(url) {
            // can open succeeded.. opening the url
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /// Creates and returns an `ASAuthorizationAppleIDRequest` with `.fullName` and `.email` scope
    private func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce
        
        return request
    }
    
    /// Creates a new user on Firestore
    /// - Parameters:
    ///   - appleIDCredential: The `ASAuthorizationAppleIDCredential` received from SingInWithApple
    ///   - authData: The `AuthDataResult` received from Firebase Auth
    private func createNewUser(appleIDCredential: ASAuthorizationAppleIDCredential, authData: AuthDataResult) {
        guard let currentFirebaseUser = Auth.auth().currentUser else { return }
        guard let completionHandler = self.performSignInCompletionHandler else { return }
        guard let userFullName = appleIDCredential.fullName,
              let userGivenName = userFullName.givenName,
              let userEmail = appleIDCredential.email else {
            currentFirebaseUser.delete()
            completionHandler(AuthenticationError.missingUserInformation)
            return
        }
        
        // Joins the first and last name of the user
        // If the last name was not provided, trims the whitespace left after the first name
        // let userName = "\(userGivenName) \(userFullName.familyName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
        let userName = userGivenName
        
        let newUser = UserModel(id: authData.user.uid, name: userName, email: userEmail)
        
        self.userRepository.create(newUser) { user, error in
            if error != nil {
                completionHandler(.unableToCreateUserDocument)
            } else if let user = user {
                self.currentUser = user
                completionHandler(nil)
            }
        }
    }
    
    /// Fetches the current user by its id and updates the reference
    /// - Parameter id: The id of the current user provided by `Auth`
    private func updateCurrentUser(with id: String) {
        self.userRepository.read(id: id) { user, error in
            if error != nil {
                self.currentUser = nil
                self.performSignInCompletionHandler?(.unableToReadUserDocument)
            } else if let user = user {
                self.currentUser = user
                self.performSignInCompletionHandler?(nil)
            }
        }
    }
    
    /// Saves the currentUser object for later use
    private func saveUserDefaults() {
        guard let currentUser = currentUser  else { return }
        guard let userId = currentUser.id else { return }
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.setObject(currentUser, forKey: userId)
        } catch {
            ///TODO: Handle Error
        }
    }
    
    /// Deletes the currentUser object from local memory
    private func deleteUserDefaults() {
        guard let userId = currentUser?.id else { return }
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: userId)
        currentUser = nil
    }
    
    /// Loads the currentUser value stored in the UserDefaults for faster and offline app response
    /// - Parameter id: The last loaded currentUser's Id, probably loaded from the Keychain
    private func loadUserDefaults(id: String) {
        let userDefaults = UserDefaults.standard
        do {
            let user = try userDefaults.getObject(forKey: id, castTo: UserModel.self)
            self.currentUser = user
        } catch {
            ///TODO: Handle Error
        }
    }
    
    // MARK: - Crypto Nonce Methods
    // Method gotten from the Firebase documentation
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    // Method gotten from the Firebase documentation
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
}

//MARK: - UserObserver Methods
extension AuthenticationController {
    //MARK: Private
    /// Function from the UserObserver protocol for notifying all observers that the currentUser property was updated
    private func notifyUserObservers() {
        for observer in userObservers {
            observer.didUpdateUser()
        }
    }
    
    //MARK: Public
    /// Public function for adding an observer for when the currentUser property is updated
    /// - Parameter observer: The UIViewController to be added as observer for when the currentUser property updates
    public func addUserObserver(observer: UserObserver) {
        guard let parameterObserver = observer as? UIViewController else { return }
        for userObserver in userObservers {
            guard let userObserver = userObserver as? UIViewController else { continue }
            if parameterObserver === userObserver { return }
        }
        userObservers.append(observer)
    }
}

//MARK: - Testing Methods Only For Simulator
#if targetEnvironment(simulator)
extension AuthenticationController {
    
    /// Method used only for loggin in on simulator, where is not possible to SignInWithApple
    private func signInFakeUser() {
        if _isDebugAssertConfiguration() {
            guard let performSignInCompletionHandler = self.performSignInCompletionHandler else { return }
            let fakeEmail = "developer@developer.developer"
            let fakePassword = "Bmv2R@V3ue_z_g@aRkKeqUEp"
            Auth.auth().signIn(withEmail: fakeEmail, password: fakePassword) { authData, error in
                guard error == nil else {
                    // Error on signIn
                    performSignInCompletionHandler(.firebaseAuthError)
                    return
                }
                
                guard let authData = authData else {
                    // Error: No authData provided
                    performSignInCompletionHandler(.noAuthData)
                    return
                }
                
                // User loggedIn successfully
                self.updateCurrentUser(with: authData.user.uid)
                
            }
        }
    }
    
}
#endif
