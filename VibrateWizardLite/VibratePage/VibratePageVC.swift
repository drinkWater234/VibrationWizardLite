//
//  VibratePageVC.swift
//  VibrateWizardLite
//
//  Created by Consultant on 1/31/23.
//

import UIKit
import Combine

class VibratePageVC: UIViewController
{
    let vm = VibratePageVM()
    var subs = Set<AnyCancellable>()
    
    let vibrateButton = UIButton()
    let contactName: String
    let contactID: String
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = false
        title = contactName
        view.backgroundColor = .white
        configVibrateButton()
    }
    
    init(contactID: String, contactName: String)
    {
        self.contactName = contactName
        self.contactID = contactID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configVibrateButton()
    {
        vibrateButton.translatesAutoresizingMaskIntoConstraints = false
        vibrateButton.setTitle("Vibrate", for: .normal)
        vibrateButton.backgroundColor = UIColor.orange
        view.addSubview(vibrateButton)
        
        NSLayoutConstraint.activate([
            vibrateButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            vibrateButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            vibrateButton.widthAnchor.constraint(equalToConstant: view.frame.width - 30),
            vibrateButton.heightAnchor.constraint(equalToConstant: view.frame.width - 30)
        ])
        
        vibrateButton.layer.cornerRadius = vibrateButton.frame.width / 2
        vibrateButton.addTarget(self, action: #selector(buttonPressedAndHeld), for: .touchDown)
        vibrateButton.addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
    }
    
    @objc
    func buttonPressedAndHeld()
    {
        vibrateButton.backgroundColor = UIColor.purple
        vm.buttonHeld.send((true, contactID))
    }
    
    @objc
    func buttonReleased()
    {
        vibrateButton.backgroundColor = UIColor.orange
        vm.buttonHeld.send((false, contactID))
    }
    
    

}
