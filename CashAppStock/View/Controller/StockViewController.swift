//
//  StockViewController.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-12.
//

import UIKit

class StockViewController: UIViewController {
    
    var stockList: [StockItem] = []
    var viewModel = StockViewModel()
    var newView = UIView()
    var whichRequest: String = ""
    
    static func nib() -> UINib {
        return UINib(nibName: "StockViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        registerCell()
        viewModel.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        typeRequest()

    }
    
    func registerCell() {
        self.tableView.register(StockTableViewCell.nib(), forCellReuseIdentifier: StockTableViewCell.identifier)
    }
    
    func typeRequest() {
        setLoading(true)
        switch whichRequest {
        case "Success Response": return viewModel.requestStocks()
        case "Empty Response": return viewModel.requestEmptyStocks()
        case "Error Response": return viewModel.requestFailStocks()
        default: break
        }
    }
    
    func setLoading(_ isLoading: Bool) {
        if isLoading {
            let loadingView = UIView(frame: UIScreen.main.bounds)
            loadingView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.center = loadingView.center
            spinner.startAnimating()
            loadingView.addSubview(spinner)
            newView.addSubview(loadingView)
        } else {
            DispatchQueue.main.async {
                self.newView.subviews.last?.removeFromSuperview()
            }
        }
    }
    
    func openAlert(_ alertType: AlertType) {
        let type = alertType.getMessage()
        let alert = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: type.buttonLabel, style: .default, handler: { action in
            
            if action.title == "OK" {
                if let navigationController = self.navigationController {
                        navigationController.popViewController(animated: true)
                    } else {
                        self.dismiss(animated: true, completion: nil)
                    }
            } else if action.title == "Try Again" {
                self.viewModel.requestStocks()
            }

        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - UI properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
}

extension StockViewController: StockViewModelDelegate {
    func errorAlert() {
        self.setLoading(false)
        DispatchQueue.main.async {
            self.openAlert(.errorAlert)
        }
    }
    
    func didFinishRequest(isEmpty: Bool) {
        guard !isEmpty else {
            self.setLoading(false)
            DispatchQueue.main.async {
                self.openAlert(.emptyAlert)
            }
            return
        }
        self.setLoading(false)
        stockList = viewModel.stockItems
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK:: TableView Delegate and DataSource
extension StockViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stockItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as? StockTableViewCell {
            cell.layer.borderWidth = 1
            cell.selectionStyle = .none
            cell.setUpCell(stockList[indexPath.row])
            
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
}

extension StockViewController: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(newView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
}
