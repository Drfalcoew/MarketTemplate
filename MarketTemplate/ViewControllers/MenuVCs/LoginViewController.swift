//
//  LoginViewController.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/2/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    var colorPalette : [UIColor] = [UIColor.gray, UIColor.black]
    
    var infoBlackView = UIView()
    
    //var user: [User] = []
    
    //let infoView = InfoViewController()
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    let firstView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 1.0, alpha: 0.5)
        view.alpha = 0
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    let forgotPassword: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(r: 215, g: 222, b: 227)
        btn.setTitle("Forgot password?", for: UIControl.State.normal)
        btn.layer.cornerRadius = 2
        btn.setTitleColor(UIColor(r: 75, g: 115, b: 148), for: UIControl.State.normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(forgotPasswordView), for: .touchUpInside)
        return btn
    }()
    
    let infoButton: UIButton = {
        let btn = UIButton(type: .infoDark) as UIButton
        btn.alpha = 0
        btn.tintColor = UIColor.white
        btn.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        return btn
    }()
    
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.alpha = 0
        return view
    }()
    
    let exitFeedback: UIButton = {
        let btn = UIButton()
        btn.layer.masksToBounds = true
        btn.setImage(UIImage(named: "tab_3"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.zPosition = 11
        btn.addTarget(self, action: #selector(dismissViews), for: .touchUpInside)
        return btn
    }()
    
    let feedbackView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor.init(white: 1.0, alpha: 0.7)
        view.layer.masksToBounds = true
        view.alpha = 0
        view.isHidden = true
        return view
    }()
    
    let forgotPassView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor.init(white: 1.0, alpha: 0.7)
        view.layer.masksToBounds = true
        view.alpha = 0
        view.isHidden = true
        return view
    }()
    
    let exitForgotPass: UIButton = {
        let btn = UIButton()
        btn.layer.masksToBounds = true
        btn.setImage(UIImage(named: "tab_3"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.zPosition = 11
        btn.addTarget(self, action: #selector(dismissViews), for: .touchUpInside)
        return btn
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 75, g: 115, b: 148)
        button.setTitle("Login", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 2
        button.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
       /* let controller: UIViewController = SupportViewController() as UIViewController
        feedbackView.addSubview(controller.view)
        controller.view.frame = feedbackView.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controller.didMove(toParentViewController: self)
        addChildViewController(controller) */
      
        /*let controllerA: UIViewController = ForgotPasswordViewController() as UIViewController
        forgotPassView.addSubview(controllerA.view)
        controllerA.view.frame = forgotPassView.bounds
        controllerA.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controllerA.didMove(toParentViewController: self)
        addChildViewController(controllerA)*/

        infoBlackView.isHidden = true
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: false)
        
        nameTextField.inputAccessoryView = toolbar
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
        
        /*NotificationCenter.default.addObserver(self, selector: #selector(LoginController.displayFeedbackAlert), name: NSNotification.Name(rawValue: "feedbackAlert"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.feedbackHandler), name: NSNotification.Name(rawValue: "feedbackHandler"), object: nil) */
        infoBlackView.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        
        view.addSubview(backgroundView)
        view.addSubview(firstView)
        view.addSubview(infoButton)
        view.addSubview(bottomView)
        view.addSubview(infoBlackView)
        view.addSubview(feedbackView)
        view.addSubview(forgotPassView)
       
        
        firstView.addSubview(inputsContainerView)
        firstView.addSubview(loginRegisterButton)
        firstView.addSubview(loginRegisterSegmentedControl)
        firstView.addSubview(mainLogo)
        firstView.addSubview(subLabel)
        firstView.addSubview(forgotPassword)
        
        forgotPassView.addSubview(exitForgotPass)
        feedbackView.addSubview(exitFeedback)
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        let bVTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissViews))
        
        infoBlackView.addGestureRecognizer(bVTap)
        
        setupInputsConstraints()
        setupmainLogo()
        setupBackground()
    }
    
    @objc func handleMore(){
        //infoView.infoView()
    }
    
    func displayAlert(_ userMessage: String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func displayFeedbackAlert(){
        
        dismissViews()
        
        let myAlert = UIAlertController(title: "Successfully Submitted", message: "Thank you for your feedback!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func displayAlertWithOutCancel(_ userMessage: String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    var nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = ""
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = tf.text?.removeWhitespaces()
        return tf
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.keyboardType = .emailAddress
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = tf.text?.removeWhitespaces()
        return tf
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.text = tf.text?.removeWhitespaces()
        return tf
    }()
    
    
    @objc func handleLoginRegister() {
        print("In handleLoginRegister")
        
        
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            if (passwordTextField.text == "" || emailTextField.text == ""){
                displayAlert("One or more text fields are empty")
                return
            }
            else {
                handleLogin()
            }
        } else {
            if (passwordTextField.text == "" || emailTextField.text == "" || nameTextField.text == ""){
                displayAlert("One or more text fields are empty")
                return
            }
            else {
                handleRegister()
            }
        }
    }
    
    
    func handleRegister() {
        let viewController: UIViewController? = ViewController()
        print("In handleRegister")
        view.endEditing(true)
        displayAlertWithOutCancel("Registering")
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        let values = ["name": name, "email": email]

    }
    
    
    
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        
//        let loggedUser = User(uid: uid, email: self.emailTextField.text!, name: self.nameTextField.text!)
//        self.user.append(loggedUser)
 
    }
    
    
    @objc func handleLoginRegisterChange(){
        
        emailTextField.text = ""
        nameTextField.text = ""
        passwordTextField.text = ""
        
        dismissKeyboard()
        
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            nameTextField.placeholder = ""
            
        }
        else {
            nameTextField.placeholder = "Name"
            
        }
        
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: UIControl.State())
        
        // change height of inputContainerView, but how???
        //inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 1 ? 15 : 10
        
        // change height of nameTextField
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 1 ? 1/3 : 0)
        nameTextFieldHeightAnchor?.isActive = true
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 1 ? 1/3 : 1/2)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 1 ? 1/3 : 1/2)
        passwordTextFieldHeightAnchor?.isActive = true
    }

    @objc func forgotPasswordView() {
        
        
        infoBlackView.alpha = 0
        forgotPassView.isHidden = false
        infoBlackView.isHidden = false
        infoBlackView.layer.zPosition = 9
        forgotPassView.layer.zPosition = 10
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            self.forgotPassView.alpha = 1
            self.infoBlackView.alpha = 1
        }, completion: nil)
        // Send to View
    }
    
    @objc func dismissViews() {
        UIView.animate(withDuration: 0.5, animations: {
            self.infoBlackView.alpha = 0
            self.feedbackView.alpha = 0
            self.forgotPassView.alpha = 0
        }) { (true) in
            self.infoBlackView.isHidden = true
            self.feedbackView.isHidden = true
            self.forgotPassView.isHidden = true
        }
    }
    
    func feedbackHandler() {
        

        infoBlackView.alpha = 0
        feedbackView.isHidden = false
        infoBlackView.isHidden = false
        infoBlackView.layer.zPosition = 9
        feedbackView.layer.zPosition = 10
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            self.feedbackView.alpha = 1
            self.infoBlackView.alpha = 1
        }, completion: nil)
    }
   
    let mainLogo: UIImageView = {
        let ml = UIImageView()
        ml.image = UIImage(named: "image_Fiesta")
        ml.layer.masksToBounds = true
        ml.layer.cornerRadius = 2
        ml.translatesAutoresizingMaskIntoConstraints = false
        return ml
    }()
    
    let subLabel: UILabel = {
        let ml = UILabel()
        ml.text = "Please login or register"
        ml.font = UIFont (name: "Baskerville", size: 19)
        ml.textAlignment = .center
        ml.textColor = UIColor(r: 26, g: 62, b: 91)
        ml.translatesAutoresizingMaskIntoConstraints = false
        return ml
    }()
    
    
    
    
    func handleLogin() {
        print("in Handle Login")
        let viewController : UIViewController? = ViewController()
        
        view.endEditing(true)
        
        displayAlertWithOutCancel("Logging In")
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        
        print("successfully logged in")
        self.dismiss(animated: true, completion: nil)
        //successfully logged in our user
        UIView.animate(withDuration: 0.5, animations: {
            self.firstView.alpha = 0
            self.infoButton.alpha = 0
            self.bottomView.alpha = 0
        }) { (true) in
            self.dismiss(animated: false, completion: {
                if viewController != nil {
                    UserDefaults.standard.set(false, forKey: "Guest")
                    UserDefaults.standard.synchronize()
                    self.dismiss(animated: false, completion: {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController")
                        self.present(controller, animated: false, completion: nil)
                    })
                }
                else {
                    self.displayAlert("Crashed")
                }
            })
        }
    }
    
    
    func setupInputsConstraints() {
        
        
        infoBlackView.frame = view.frame
        
        
        
        forgotPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        forgotPassword.bottomAnchor.constraint(equalTo: firstView.bottomAnchor, constant: -24).isActive = true
        forgotPassword.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        forgotPassword.heightAnchor.constraint(equalTo: firstView.heightAnchor, multiplier: 1/11).isActive = true
        
        
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.bottomAnchor.constraint(equalTo: forgotPassword.topAnchor, constant: -12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalTo: firstView.heightAnchor, multiplier: 1/11).isActive = true
        
        
        inputsContainerView.bottomAnchor.constraint(equalTo: loginRegisterButton.topAnchor, constant: -12).isActive = true
        inputsContainerView.centerXAnchor.constraint(equalTo: firstView.centerXAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: firstView.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalTo: firstView.heightAnchor, multiplier: 1/4)
        inputsContainerViewHeightAnchor?.isActive = true
        
        //var num = view.frame.width / 2
        
        
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalTo: firstView.heightAnchor, multiplier: 1/13).isActive = true
        
        feedbackView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        feedbackView.frame = CGRect(x: view.frame.width / 10, y: view.frame.height / 20 * 3, width: view.frame.width / 10 * 8, height: view.frame.height / 10 * 7)
       
        exitFeedback.topAnchor.constraint(equalTo: feedbackView.topAnchor, constant: 10).isActive = true
        exitFeedback.leftAnchor.constraint(equalTo: feedbackView.leftAnchor, constant: 10).isActive = true
        exitFeedback.heightAnchor.constraint(equalToConstant: 40).isActive = true
        exitFeedback.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        forgotPassView.frame = CGRect(x: view.frame.width / 10, y: view.frame.height / 20 * 7, width: view.frame.width / 10 * 8, height: view.frame.height / 10 * 3)
        
        exitForgotPass.topAnchor.constraint(equalTo: forgotPassView.topAnchor, constant: 10).isActive = true
        exitForgotPass.leftAnchor.constraint(equalTo: forgotPassView.leftAnchor, constant: 10).isActive = true
        exitForgotPass.heightAnchor.constraint(equalToConstant: 40).isActive = true
        exitForgotPass.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        if (view.frame.height <= 400){
            bottomViewHeightAnchor = bottomView.heightAnchor.constraint(equalToConstant: 32)
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            print("<= 400")
        } else if (view.frame.height > 400 && view.frame.height <= 720) {
            bottomViewHeightAnchor = bottomView.heightAnchor.constraint(equalToConstant: 50)
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            print(">400&&<=720")
        } else if (view.frame.height > 720){
            bottomViewHeightAnchor = bottomView.heightAnchor.constraint(equalToConstant: 90)
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            print(">720")
        }
        
        bottomViewHeightAnchor?.isActive = true
        
 
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        //need x, y, width, height constraints
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0)
        nameTextFieldHeightAnchor?.isActive = true
        
        //need x, y, width, height constraints
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //need x, y, width, height constraints
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
        
        emailTextFieldHeightAnchor?.isActive = true
        
        //need x, y, width, height constraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //need x, y, width, height constraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
        passwordTextFieldHeightAnchor?.isActive = true
                
        
        
        
        infoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: UIApplication.shared.statusBarFrame.height + ((UIApplication.shared.statusBarFrame.height)/2)).isActive = true
        
        infoButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        
        
        
       

        
    }
    
    
    
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor(r: 75, g: 115, b: 148)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    var bottomViewHeightAnchor: NSLayoutConstraint?
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            self.firstView.alpha = 1.0
            self.infoButton.alpha = 1.0
            self.bottomView.alpha = 1.0
        }, completion: nil)
    }
    
   

    func setupBackground(){
        
        backgroundView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        backgroundView.widthAnchor.constraint(equalToConstant: (view.frame.height * 0.5625)).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        firstView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        firstView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        firstView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
        
    }
    
    
    func setupmainLogo(){

        mainLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLogo.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 0).isActive = true
        mainLogo.widthAnchor.constraint(equalTo: firstView.widthAnchor, multiplier: 1).isActive = true
        mainLogo.heightAnchor.constraint(equalTo: mainLogo.widthAnchor, multiplier: 1/3).isActive = true
        
        subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subLabel.topAnchor.constraint(equalTo: mainLogo.bottomAnchor, constant: -5).isActive = true
        subLabel.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -8).isActive = true
        subLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
  
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
        
    }
}

extension String {
    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
