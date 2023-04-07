//
//  CustomCell.swift
//  GetPRequest
//
//  Created by Nurlan Seitov on 7/4/23.
//

import UIKit
import SnapKit
import Kingfisher

class CustomCell: UITableViewCell {

    static let idCell = "CustomCell"
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.font = .boldSystemFont(ofSize: 13)
        title.numberOfLines = 2
        title.textAlignment = .justified
        return title
    } ()
    
    private lazy var descriptionLabel: UILabel = {
        let descr = UILabel()
        descr.font = .systemFont(ofSize: 11)
        descr.numberOfLines = 5
        descr.textAlignment = .justified
        return descr
    } ()
    
    private lazy var imageOfNews: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        return image
    } ()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    } ()
    
//    private lazy var authorLabel: UILabel = {
//        let author = UILabel()
//        author.font = .systemFont(ofSize: 8)
//        author.numberOfLines = 1
//        author.textAlignment = .justified
//        return author
//    } ()
//
//    private lazy var publishLabel: UILabel = {
//        let publish = UILabel()
//        publish.font = .systemFont(ofSize: 8)
//        publish.numberOfLines = 1
//        publish.textAlignment = .justified
//        return publish
//    } ()
    
    override func layoutSubviews() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        self.addSubview(imageOfNews)
        imageOfNews.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview().inset(8)
            make.height.width.equalTo(140)
        }
        
        imageOfNews.layer.cornerRadius = imageOfNews.frame.height / 2.5
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(imageOfNews.snp.left).offset(-20)
        }
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(imageOfNews.snp.left).offset(-20)
        }
        
//        self.addSubview(authorLabel)
//        authorLabel.snp.makeConstraints { make in
//            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
//            make.left.equalToSuperview().offset(10)
//            //            make.right.equalTo(imageOfNews.snp.left).offset(-20)
//        }
//
//        self.addSubview(publishLabel)
//        publishLabel.snp.makeConstraints { make in
//            make.top.equalTo(authorLabel.snp.bottom).offset(5)
//            make.left.equalToSuperview().offset(10)
//        }
        
        self.addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-2)
            make.horizontalEdges.equalToSuperview().inset(5)
            make.height.equalTo(0.3)
        }
        
    }
    
    func configure(with: Product) {
        self.titleLabel.text = with.title
        self.descriptionLabel.text = with.description
//        if with.author != nil {
//            self.authorLabel.text = with.author
//        } else {
//            self.authorLabel.text = "not available"
//            
//        }
        
//                if with.publishedAt != nil {
//                    let dateStr = with.publishedAt
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//
//                    let date = dateFormatter.date(from: dateStr ?? "0")
//                    dateFormatter.dateFormat = "yyyy-MM-dd"
//                    self.publishLabel.text = dateFormatter.string(from: date ?? "Emty")
//
//                   guard ((with.publishedAt) != nil) else {return}
//                    let dateStr = with.publishedAt
//                    let date = Date(from: dateStr).formatted(date: .long, time: .omitted)
//                }
//                else {self.publishLabel.text = "not available"}

//      self.publishLabel.text = with.publishedAt
        
        if with.thumbnail != nil {
            self.imageOfNews.kf.setImage(with: URL(string: with.thumbnail ?? "Emty"))
        } else
        { self.imageOfNews.image = UIImage(named: "not data") }
    }
}
