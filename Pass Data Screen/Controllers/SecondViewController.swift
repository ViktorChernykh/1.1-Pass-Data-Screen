//
//  SecondViewController.swift
//  Pass Data Screen
//
//  Created by Viktor on 05/03/2019.
//  Copyright © 2019 viktorsoft. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    let login = "viktor"
    let password = "12345"
    let name = "Chernych Viktor"
    
    var loginUser: String?
    var passwordUser: String?
    var nameUser: String?
    var buttonTag: Int?
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showMessage()
    }
    
    func showMessage() {
        
        switch buttonTag {
        case 0:
            let resalt = checkUser(login: loginUser, password: passwordUser)
            if resalt {
                self.title = "\(loginUser!)!"
                welcomeLabel.text = "Wecome \(loginUser!)!"
            } else {
                self.title = "User undefined!"
                welcomeLabel.text = "Invalid login or password!"
            }
        case 1:
            self.title = "Восстановление имени"
            welcomeLabel.text = "Ответьте на \n контрольный вопрос"
        case 2:
            self.title = "Восстановление пароля"
            welcomeLabel.text = "Ответьте на \n контрольный вопрос"
        default:
            return
        }
    }
    
    func checkUser(login: String?, password: String?) -> Bool {
        guard let _ = login, let _ = password else { return false }
        if self.login == loginUser && self.password == passwordUser {
            nameUser = name
            return true
        } else {
            return false
        }
    }
    @IBAction func unwindPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "UnwindSegue", sender: nil)
    }


}
