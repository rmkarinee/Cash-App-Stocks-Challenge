//
//  StockViewController.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-12.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel = StockViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - UI properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .none
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var successButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 102/255.0, green: 255/255.0, blue: 102/255.0, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Success Response", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var emptyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 102/255.0, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Empty Response", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Error Response", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    
    @objc private func buttonPressed(sender: UIButton) {
        let vc = StockViewController(nibName: "StockViewController", bundle: nil)
        vc.whichRequest = sender.currentTitle ?? ""
        self.present(vc, animated: false)
    }
}

extension ViewController: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(successButton)
        stackView.addArrangedSubview(emptyButton)
        stackView.addArrangedSubview(errorButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 300),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
}
