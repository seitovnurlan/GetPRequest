//
//  ViewController.swift
//  GetPRequest
//
//  Created by Nurlan Seitov on 6/4/23.
//

import UIKit

class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let view = UITableView()
        return view
    } ()
    
//    private var tableView = UITableView()
    var data: [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        
        setupViews()
        setupTableViewConfigue()
        setupViewConstraints()
        
        
    }
    private func setupTableViewConfigue() {
        
        view.backgroundColor = .systemGreen
//        view.backgroundColor = .white
//        title = "Some news"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.reloadData()
    }
    
    private func setupViewConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            // make.leading.trailing.top.bottom.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(100)
            make.bottom.equalTo(view.snp.bottom).inset(35)
            make.leading.trailing.equalToSuperview()
            loadApi()
        }
    }
    
    private func loadApi() {
        
        ApiManager.shared.getRequest { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let `self` else {return}
                    self.data = data.products ?? []
                    self.tableView.reloadData()
//                    let vc = GetRequestPage()
//                    vc.data = data.products ?? []
//                     self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupViews() {
        createCustomNavigationBar()
        
        let postRightButton = createCustomButton(
            imageName: "arrowshape.zigzag.right",
            selector: #selector(postRightButtonTapped)
        )
        let putRightButton = createCustomButton(
            imageName: "repeat",
            selector: #selector(putRightButtonTapped)
        )
        let customTitleView = createCustomTitleView(contactName: "GetPRequest", contactDescription: "Apple app", contactImage: "playstore"
        )
        navigationItem.rightBarButtonItems = [putRightButton, postRightButton]
        navigationItem.titleView = customTitleView
    }
    
    @objc private func putRightButtonTapped() {
       
        navigationController?.pushViewController(ViewController(), animated: true)
    }
    @objc private func postRightButtonTapped() {

        // navigationController?.pushViewController(PostRequestPage(), animated: true)
        showAlert(with: "POST Request", message: "Enter the data for the request")
        
    }
    private func showAlert(with title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        { (action) in
//
//            let text = alert.textFields?.first?.text
//        }
       
//        alert.addAction(.init(title: "Ok", style: .default))
        
//        alert.addTextField( configurationHandler: { (textField1) in
//            textField1.placeholder = "Input ID"
//        },
//
//        alert.addTextField( configurationHandler: { (textField2) in
//            textField2.placeholder = "Input Product Title"
//        },
               
        alert.addTextField(configurationHandler: nil)
        alert.addAction(alertOkAction)
        present(alert, animated: true, completion: nil)
        }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
      return  data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomCell
        let value = data[indexPath.row]
        
        cell?.configure(with: value)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       //return 145
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let thirdVC = GetRequestFullInfo()
        thirdVC.item = data[indexPath.row]
        self.navigationController?.pushViewController(thirdVC, animated: true)
    }
}
