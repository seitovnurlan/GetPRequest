//
//  ViewController.swift
//  GetPRequest
//
//  Created by Nurlan Seitov on 6/4/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

   public var b: Bool = false
   public var c: Bool = false
    public var str1: String = ""
    public var str2: String = ""
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
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
       
        navigationController?.pushViewController(PostRequestPage(), animated: true)
//        dismiss(animated: true, completion: nil)
//        navigationController?.popToRootViewController(animated: true)
        
    }
    @objc private func postRightButtonTapped() {

        showAlert(with: "POST Request", message: "Enter the data for the request")
        
    }
    private func showAlert(with title: String, message: String) {
       
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { [self] (_: UIAlertAction!) in
            
            //  title
            let text1 = alert.textFields?.first?.text
            
            let text2 = alert.textFields?[1].text
                
            chektextField(textField1: text1 ?? "Emty", textField2: text2 ?? "Emty")
               
                alert.addTextField(configurationHandler: { [self] (textField) in
                        if self.b {
                            textField.placeholder = " Empty string!"
                            textField.layer.borderWidth = 2
                            textField.layer.borderColor = UIColor.red.cgColor
//                            self.b = false
                            print("uslovie b= \(self.b) text1 empty!")
                        } else
                        {
                            str1 = text1!
                            textField.text = str1
        //                    textField.placeholder = " Input ID"
                        }
                })
            
            alert.addTextField(configurationHandler: { [self] (textField) in
                if self.c  {
                        textField.placeholder = " Empty string!"
                        textField.layer.borderWidth = 2
                        textField.layer.borderColor = UIColor.red.cgColor
//                        self.c = false
                        print("uslovie c= \(self.c) text1 empty!")
                    } else
                    {
                        str2 = text2!
                        textField.text = str2
    //                    textField.placeholder = " Input ID"
                    }
            })
            if self.b || self.c {
                self.showAlert(with: "POST Request", message: "Enter the data for the request")
                
                self.present(alert, animated: true, completion: nil)
            }
            else {
                ApiManager.shared.postRequest(id: Int(str1) ?? 0, title: str2) { result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            
                            self.showAlertRequest(with: "Success", message: "With status code: \(data)")
                        }
                    case .failure(let error):
                        self.showAlertRequest(with: "Error", message: "With status code: \(error)")
                        break
                    }
                }
                
            }
        }))
        alert.addTextField(configurationHandler: { (textField) in
                if (self.b) {
                    textField.placeholder = " Empty string or not a valid number!"
                    textField.layer.borderWidth = 2
                    textField.layer.borderColor = UIColor.red.cgColor
                    self.b = false
                } else
                {
                    
                    textField.text = self.str1
                    textField.placeholder = " Input ID"
                }
                
            })
        alert.addTextField(configurationHandler: { [self] (textField) in
                if self.c {
                    textField.placeholder = " Empty string!"
                    textField.layer.borderWidth = 2
                    textField.layer.borderColor = UIColor.red.cgColor
                    self.c = false
                } else
                {
                    
                    textField.text = self.str2
                    textField.placeholder = " Input Product Title"
                    
                }
            })
       
                        
        present(alert, animated: true, completion: nil)
    }
    
    private func chektextField(textField1 : String, textField2 : String) {
        
        if (textField1.isEmpty) || (Int(textField1) == nil) {
            self.b = true
            print("b= \(b) text1 empty!")
        }
        if (textField2.isEmpty ) {
            self.c = true
                print("c= \(c) text2 empty!")
            }
    }
    private func showAlertRequest(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default))
        present(alert, animated: true)
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
