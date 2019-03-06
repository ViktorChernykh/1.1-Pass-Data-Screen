//
//  ViewController.swift
//  Pass Data Screen
//
//  Created by Viktor on 05/03/2019.
//  Copyright © 2019 viktorsoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var buttonTag: Int?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    // MARK: - ... UIViewController Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? SecondViewController else { return }
        dvc.loginUser = loginTextField.text
        dvc.passwordUser = passwordTextField.text
        dvc.buttonTag = buttonTag
    }
    
    // Убираем клавиатуру по кнопке Done
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder() // в отставку первый реагирующий объект
    }
    
    // Убираем клавиатуру по клику где-нибудь
    @IBAction func onTapGestureRecognized(_ sender: AnyObject) {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // регистрируемся на получение уведомлений о появлении/скрытии клавиатуры
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // снимаемся с регистрации
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo    // словарик связанных значений/объектов
        // получим размер клавиатуры и преобразуем в значение cgRectValue
        let keyboardFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let fm: CGRect = UIScreen.main.bounds
        let heightHalfScreen = fm.size.height / 2

        if (heightHalfScreen - 35) < keyboardFrameSize.height {

            scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrameSize.height - heightHalfScreen + 35)
        }
    }
    
    @objc func keyboardWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
    
    // MARK: - ... @IBAction
    @IBAction func loginPressed(_ sender: UIButton) {
        buttonTag = sender.tag
        performSegue(withIdentifier: "SecondSegue", sender: nil)
    }

    @IBAction func unwind(segue: UIStoryboardSegue) {
        guard segue.identifier == "UnwindSegue" else { return }
        
        let svc = segue.source as! SecondViewController
        
        guard let title = svc.nameUser else { return }
        
        navigationItem.title = title
    }
}

