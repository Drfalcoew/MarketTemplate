//
//  LoginViewController.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/2/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseFirestore
import FirebaseAuth


class LoginViewController: UIViewController {
    
    var user: User?
    var delivery : Bool?
    var colorPalette : [UIColor] = [UIColor.gray, UIColor.black]
    var infoBlackView = UIView()
    var db : Firestore?
    
    var bottomViewHeightAnchor: NSLayoutConstraint?
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
       
    let googleBtnContainer : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .white
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.layer.cornerRadius = 5
        btn.setTitle("Sign in with Google", for: .normal)
        btn.setTitleColor(UIColor(r: 75, g: 80, b: 120), for: .normal)
        btn.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
        return btn
    }()
    
    let googleSignInIcon : GIDSignInButton = {
        let btn = GIDSignInButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.style = .iconOnly
        return btn
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
        btn.backgroundColor = UIColor.white
        btn.setTitle("Forgot password?", for: UIControl.State.normal)
        btn.layer.cornerRadius = 2
        btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 18)
        btn.setTitleColor(UIColor(r: 75, g: 80, b: 120), for: UIControl.State.normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(handleForgotPassword(sender:)), for: .touchUpInside)
        return btn
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
    
    lazy var loginRegisterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        btn.setTitle("Login", for: UIControl.State())
        btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 2
        btn.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: UIControl.State())
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor(r: 75, g: 115, b: 148)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        self.title = Attributes().name
        
        infoBlackView.isHidden = true
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(userLoggedIn), name: Notification.Name("UserLoggedIn"), object: nil)
        /*
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: false)
        
        nameTextField.inputAccessoryView = toolbar
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
        */
        
        view.addSubview(forgotPassView)
        view.addSubview(googleBtnContainer)
        self.googleBtnContainer.addSubview(googleSignInIcon)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(subLabel)
        view.addSubview(forgotPassword)
                
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        
        setupDatabase()
        setupConstraints()
    }
    
    func setupDatabase() {
        db = Firestore.firestore()
        let settings = db?.settings
        //settings?.areTimestampsInSnapshotsEnabled = true
        db?.settings = settings!
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
    
    @objc func handleGoogleSignIn() {
        googleBtnContainer.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 0.5,
                                   delay: 0,
                                   usingSpringWithDamping: CGFloat(0.5),
                                   initialSpringVelocity: CGFloat(1.0),
                                   options: UIView.AnimationOptions.allowUserInteraction,
                                   animations: {
                                    self.googleBtnContainer.transform = CGAffineTransform.identity
            }) { (true) in
                GIDSignIn.sharedInstance()?.presentingViewController = self
                GIDSignIn.sharedInstance().signIn()
            }
    }
    
    @objc func handleLoginRegister() {
        loginRegisterButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                    
        UIView.animate(withDuration: 0.5,
                                   delay: 0,
                                   usingSpringWithDamping: CGFloat(0.5),
                                   initialSpringVelocity: CGFloat(1.0),
                                   options: UIView.AnimationOptions.allowUserInteraction,
                                   animations: {
                                    self.loginRegisterButton.transform = CGAffineTransform.identity
            }) { (true) in
                if self.loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
                    if (self.passwordTextField.text == "" || self.emailTextField.text == ""){
                        self.displayAlert("One or more text fields are empty")
                    return
                }
                else {
                    self.handleLogin()
                }
            } else {
                    if (self.passwordTextField.text == "" || self.emailTextField.text == "" || self.nameTextField.text == ""){
                        self.displayAlert("One or more text fields are empty")
                    return
                }
                else {
                    self.handleRegister()
                }
            }
        }
    }
    
    @objc func handleForgotPassword(sender: UIButton) {
        
        forgotPassword.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
    
        UIView.animate(withDuration: 0.5,
                                   delay: 0,
                                   usingSpringWithDamping: CGFloat(0.5),
                                   initialSpringVelocity: CGFloat(1.0),
                                   options: UIView.AnimationOptions.allowUserInteraction,
                                   animations: {
                                    self.forgotPassword.transform = CGAffineTransform.identity
            }) { (true) in
                //self.navigationController?.customPush(viewController: MenuViewController())
        }
    }
    
    @objc func handleRegister() {
        view.endEditing(true)
        displayAlert("Registering..")
        
        
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            self.dismiss(animated: true, completion: {
                self.errorAlert(error: "One or more text fields are empty.")
            })
            return
        }
        //print ("email: \(email), password: \(password), name: \(name)")
        
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error as Any)
                
                self.dismiss(animated: true, completion: {
                    self.errorAlert(error: error?.localizedDescription ?? "An unknown error occured. Please try again.")
                })
                /*self.dismiss(animated: true, completion: {
                    self.displayAlert((error?.localizedDescription)!)
                })*/
                
            }
            
            guard let uid = user?.user.uid else {
                return
            }
            
            //successfully authenticated user
            
            
            let values = ["name": name, "email": email, "rep": 0.0] as [String : Any]
            self.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
            
            
            // dismissing register alert

            self.dismiss(animated: true, completion: {
                self.handleLogin()
            })
        })
    }

    
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        db?.collection("users").document(uid).setData([
            "userName" : values["name"] ?? "Could not load userName",
            "email" : values["email"] ?? "Could not load email",
            "completed" : 0,
            "premium" : false
            //"rep" : values["rep"] ?? 0.0
        ])
        
        print(values)
        
        let loggedUser = User(uid: uid, email: self.emailTextField.text!, userName: self.nameTextField.text!, rep: 0.0)
        self.user = loggedUser
    }
    
    
    @objc func userLoggedIn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                self.dismiss(animated: true) {
                    if self.delivery == true {
                        self.navigationController?.customPush(viewController: Checkout_Delivery())
                    } else {
                        self.navigationController?.customPopToRoot()
                    }
            }
        }
    }
    
    func errorAlert(error: String) {
        let myAlert = UIAlertController(title: "Error!", message: error, preferredStyle: UIAlertController.Style.alert)
        let oK = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        
        myAlert.addAction(oK)
        present(myAlert, animated: true, completion: nil)
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
   
   
    
    let subLabel: UILabel = {
        let ml = UILabel()
        ml.text = "Please login or register"
        ml.font = UIFont (name: "Helvetica Neue", size: 34)
        ml.textAlignment = .center
        ml.textColor = UIColor(r: 75, g: 80, b: 120)
        ml.adjustsFontSizeToFitWidth = true
        ml.minimumScaleFactor = 0.5
        ml.translatesAutoresizingMaskIntoConstraints = false
        return ml
    }()
    
    func handleLogin() {
        displayAlertWithOutCancel("Logging In")
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is invalid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
           if error != nil {
               print(error as Any)
               self.dismiss(animated: true, completion: {
                   self.errorAlert(error: error?.localizedDescription ?? "An unknown error occured. Please try again.")
               })
               
               //self.dismiss(animated: true, completion: {
                   //self.displayAlert("Incorrect Login")
               //})
               return
           }
           self.dismiss(animated: true, completion: {
               self.navigationController?.customPopToRoot()
           })
           //successfully logged in our user
       })
    }
    
    
    func setupConstraints() {
        infoBlackView.frame = view.frame
        
        subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        subLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        subLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/7).isActive = true
        
        inputsContainerView.topAnchor.constraint(equalTo: loginRegisterSegmentedControl.bottomAnchor, constant: 10).isActive = true
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        inputsContainerViewHeightAnchor?.isActive = true
                                
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 10).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        
        googleBtnContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        googleBtnContainer.topAnchor.constraint(equalTo: loginRegisterButton.bottomAnchor, constant: 10).isActive = true
        googleBtnContainer.widthAnchor.constraint(equalTo: self.inputsContainerView.widthAnchor, multiplier: 1).isActive = true
        googleBtnContainer.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/10).isActive = true

        googleSignInIcon.leftAnchor.constraint(equalTo: googleBtnContainer.leftAnchor, constant: 5).isActive = true
        googleSignInIcon.heightAnchor.constraint(equalToConstant: 48).isActive = true
        googleSignInIcon.widthAnchor.constraint(equalToConstant: 48).isActive = true
        googleSignInIcon.centerYAnchor.constraint(equalTo: self.googleBtnContainer.centerYAnchor, constant: 0).isActive = true
        
        forgotPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        forgotPassword.topAnchor.constraint(equalTo: googleBtnContainer.bottomAnchor, constant: 10).isActive = true
        forgotPassword.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        forgotPassword.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        

                
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/13).isActive = true
        
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
        }
    
   @objc func dismissKeyboard() {
       view.endEditing(true)
   }
   
}

extension String {
    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
