//
//  GetRequestFullInfo.swift
//  GetPRequest
//
//  Created by Nurlan Seitov on 7/4/23.
//

import UIKit
import SnapKit
import Kingfisher

class GetRequestFullInfo: UIViewController {
    
 var item: Product? = nil
    
    let labelTitleName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    } ()
    
    let labelDescr: UILabel = {
        let labeld = UILabel()
        labeld.numberOfLines = 6
        labeld.font = .systemFont(ofSize: 14)
        labeld.textAlignment = .justified
        labeld.textColor = .black
        return labeld
    } ()
    
    let authorLabl: UILabel = {
        let authorl = UILabel()
        authorl.font = .systemFont(ofSize: 8)
        authorl.numberOfLines = 1
        authorl.textAlignment = .justified
        return authorl
    } ()
    
    let publishLab: UILabel = {
        let publ = UILabel()
        publ.font = .systemFont(ofSize: 8)
        publ.numberOfLines = 1
        publ.textAlignment = .justified
        return publ
    } ()
    
    let imagView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 16
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.gray.cgColor
        image.clipsToBounds = true
        return image
        
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
       // title = "Extended information"
        configData()
        setupConstrain()
    }
    
    public func configData(){
        labelTitleName.text = item?.title
        labelDescr.text = item?.description
        
//        if item?.author != nil {authorLabl.text = item?.author}
//        else {authorLabl.text = "not available"}
//
//        publishLab.text = item?.publishedAt
//
        if item?.thumbnail != nil {
            let url = URL(string: (item?.thumbnail ?? "Emty"))
            imagView.kf.setImage(with: url)}
        else {imagView.image = UIImage(named: "not data")}
    }
    
    public func setupConstrain() {
        view.addSubview(labelTitleName)
        labelTitleName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(140)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(30)
        }
        
        view.addSubview(labelDescr)
        labelDescr.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(labelTitleName.snp.bottom).offset(20)
            make.height.equalTo(120)
//            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        view.addSubview(authorLabl)
        authorLabl.snp.makeConstraints { make in
            make.top.equalTo(labelDescr.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)

        }
        
        view.addSubview(publishLab)
        publishLab.snp.makeConstraints { make in
            make.top.equalTo(authorLabl.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)

        }
        view.addSubview(imagView)
        imagView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(publishLab.snp.bottom).offset(30)
            make.height.equalTo(250)
        }
    }
        
}
