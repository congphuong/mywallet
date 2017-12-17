//
//  VerifyVC.swift
//  MyWallet
//
//  Created by congphuong on 12/13/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import UIKit
import LocalAuthentication
class VerifyVC:UIViewController {
    
    let kMsgShowFinger = "Show me your finger 👍"
    let kMsgShowReason = "Try to verify transfer!"
    let kMsgFingerOK = "Login successful! ✅"
    
    @IBOutlet weak var lbStk: UILabel!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var txtNote: UITextView!
    @IBOutlet weak var verifybt: UIButton!
    var code:String = ""
    var stk = ""
    var username = ""
    var amount = ""
    var note = ""
    
    var context = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        lbStk.text = stk
        lbUsername.text = username
        lbAmount.text = amount
        txtNote.text = note
    }
    
    @IBAction func btVerify(_ sender: Any) {
        updateUI()
    }
    func updateUI() {
        var policy: LAPolicy?
        // Depending the iOS version we'll need to choose the policy we are able to use
        if #available(iOS 9.0, *) {
            // iOS 9+ users with Biometric and Passcode verification
            policy = .deviceOwnerAuthentication
        } else {
            // iOS 8+ users with Biometric and Custom (Fallback button) verification
            context.localizedFallbackTitle = "Fuu!"
            policy = .deviceOwnerAuthenticationWithBiometrics
        }
        
        var err: NSError?
        
        // Check if the user is able to use the policy we've selected previously
        guard context.canEvaluatePolicy(policy!, error: &err) else {
            print("touchID off")
            // Print the localized message received by the system
            print(err!.localizedDescription)
            return
        }
        
        // Great! The user is able to use his/her Touch ID 👍
        print("touchID on")
        print("show your finger")
        
        loginProcess(policy: policy!)
    }
    
    private func loginProcess(policy: LAPolicy) {
        // Start evaluation process with a callback that is executed when the user ends the process successfully or not
        context.evaluatePolicy(policy, localizedReason: kMsgShowReason, reply: { (success, error) in
            DispatchQueue.main.async {
                
                guard success else {
                    guard let error = error else {
                        self.showUnexpectedErrorMessage()
                        return
                    }
                    switch(error) {
                    case LAError.authenticationFailed:
                        print("There was a problem verifying your identity.")
                    case LAError.userCancel:
                        print("Authentication was canceled by user.")
                        // Fallback button was pressed and an extra login step should be implemented for iOS 8 users.
                    // By the other hand, iOS 9+ users will use the pasccode verification implemented by the own system.
                    case LAError.userFallback:
                        print("The user tapped the fallback button (Fuu!)")
                    case LAError.systemCancel:
                        print("Authentication was canceled by system.")
                    case LAError.passcodeNotSet:
                        print("Passcode is not set on the device.")
                    case LAError.biometryNotAvailable:
                        print("Touch ID is not available on the device.")
                    case LAError.biometryNotEnrolled:
                        print("Touch ID has no enrolled fingers.")
                    // iOS 9+ functions
                    case LAError.biometryLockout:
                        print("There were too many failed Touch ID attempts and Touch ID is now locked.")
                    case LAError.appCancel:
                        print("Authentication was canceled by application.")
                    case LAError.invalidContext:
                        print("LAContext passed to this call has been previously invalidated.")
                    // MARK: IMPORTANT: There are more error states, take a look into the LAError struct
                    default:
                        print("Touch ID may not be configured")
                        break
                    }
                    return
                }
                
                // Good news! Everything went fine 👏
                print(self.kMsgFingerOK)
                self.exchange()
            }
        })
    }
    
    func exchange(){
        API.tranferqr(code: self.code, completionHandler: {(data,responese,error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                    guard let status = responseJSON["status"] as? Int else {
                        DispatchQueue.main.async {
                        self.verifybt.isHidden = true
                        }
                        
                        return
                    }
                    print(status)
                    
                }
                
                
            }
        })
    }
    
    private func showUnexpectedErrorMessage() {
        print("touchID off")
        print("Unexpected error! 😱")
    }
    
}
