//
//  ContactsPageVC.swift
//  VibrateWizardLite
//
//  Created by Consultant on 1/31/23.
//

import UIKit

class ContactsPageVC: UIViewController
{
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPurple
        title = "Contacts"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    

}
