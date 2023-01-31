//
//  NavigationVC.swift
//  VibrateWizardLite
//
//  Created by Consultant on 1/31/23.
//

import UIKit

class LoginPageNavigationViewController: UINavigationController
{
    let loginPageViewController = LoginPageVC()
    
    init()
    {
        super.init(rootViewController: loginPageViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
