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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLoading(true)
        
        setupView()
        registerCell()
        viewModel.requestStocks()
        viewModel.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func registerCell() {
        self.tableView.register(StockTableViewCell.nib(), forCellReuseIdentifier: StockTableViewCell.identifier)
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
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
    
    func openAlert() {
        let message = UIAlertController(title: "Attention", message: "There are no items in the Stock", preferredStyle: .alert)
        self.present(message, animated: true, completion: nil)
    }
}

extension StockViewController: StockViewModelDelegate {
    func didFinishRequest(isEmpty: Bool) {
        guard !isEmpty else {
            self.setLoading(false)
            DispatchQueue.main.async {
                self.openAlert()
            }
            return print("Empty List")
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
