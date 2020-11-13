//
//  SearchCell.swift
//  ru_hire_ios
//
//  Created by Владислав on 11.11.2020.
//

import UIKit

class SearchCell: UITableViewCell {

    var nameOrganizationLabel = UILabel()
    var innOrganizationLabel = UILabel()
    var errorLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameOrganizationLabel = UILabel(frame: CGRect(x: 20 , y: 0, width: contentView.frame.width/1.6, height: 50))
        nameOrganizationLabel.textColor = .black
        nameOrganizationLabel.numberOfLines = 0
        nameOrganizationLabel.lineBreakMode = .byWordWrapping
        nameOrganizationLabel.font = UIFont.systemFont(ofSize: 14)

        innOrganizationLabel = UILabel(frame: CGRect(x: self.frame.width / 1.3 , y: 0, width: contentView.frame.width/3 , height: 50))
        innOrganizationLabel.textColor = .black
        innOrganizationLabel.font = UIFont.systemFont(ofSize: 14)
        
        
        errorLabel = UILabel(frame: CGRect(x: 0 , y: 0, width: contentView.frame.width , height: contentView.frame.height))
        errorLabel.textColor = .black
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont.systemFont(ofSize: 14)
        errorLabel.isHidden = true
        
        contentView.addSubview(errorLabel)
        contentView.addSubview(nameOrganizationLabel)
        contentView.addSubview(innOrganizationLabel)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
