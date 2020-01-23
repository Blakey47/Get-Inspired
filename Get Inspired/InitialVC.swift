//
//  ViewController.swift
//  Get Inspired
//
//  Created by Darragh Blake on 21/01/2020.
//  Copyright © 2020 Darragh Blake. All rights reserved.
//

import UIKit

class InitialVC: UIViewController {
    
    let quoteImage = UIImageView()
    let getInspiredLabel = UILabel()
    let enterButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    func configure() {
        configureNavigationController()
        confiureQuoteImage()
        configureGetInspiredLabel()
        configureEnterButton()
        configureAnimations()
    }
    
    func configureNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func confiureQuoteImage() {
        view.addSubview(quoteImage)
        quoteImage.image = UIImage(named: "single-quote")
        quoteImage.contentMode = .scaleAspectFit
        quoteImage.alpha = 0
        quoteImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            quoteImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            quoteImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            quoteImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            quoteImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureGetInspiredLabel() {
        view.addSubview(getInspiredLabel)
        getInspiredLabel.text = "Get Inspired!"
        getInspiredLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        getInspiredLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        getInspiredLabel.textAlignment = .center
        getInspiredLabel.alpha = 0
        getInspiredLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            getInspiredLabel.topAnchor.constraint(equalTo: quoteImage.bottomAnchor, constant: 50),
            getInspiredLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            getInspiredLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            getInspiredLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureEnterButton() {
        view.addSubview(enterButton)
        enterButton.setTitle("Proceed", for: .normal)
        enterButton.setTitleColor(.white, for: .normal)
        enterButton.backgroundColor = .black
        enterButton.layer.cornerRadius = 10
        enterButton.alpha = 0
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            enterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            enterButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureAnimations() {
        if getInspiredLabel.alpha == 0 && enterButton.alpha == 0 && quoteImage.alpha == 0 {
            UIView.animate(withDuration: 1.4, animations: {
                self.quoteImage.alpha = 1
                self.getInspiredLabel.alpha = 1
                self.enterButton.alpha = 1
            }) { (true) in
                
            }
        } else {
            UIView.animate(withDuration: 1.0, animations: {
                self.quoteImage.alpha = 0
                self.getInspiredLabel.alpha = 0
                self.enterButton.alpha = 0
            }) { (true) in
                
            }
        }
    }
    
    @objc func enterButtonPressed() {
        NetworkManager.shared.getQuoteOfTheDay { (quoteOfTheDay, errorMessage) in
            guard let quoteOfTheDay = quoteOfTheDay else {
                print(errorMessage ?? "An error was thrown.")
                return
            }
            
            print("Quote Of The Day: \(quoteOfTheDay.contents.quotes[0].quote)")
        }
        configureAnimations()
        let quoteCategoryVC = QuoteCategoryVC()
        navigationController?.pushViewController(quoteCategoryVC, animated: true)
    }


}

