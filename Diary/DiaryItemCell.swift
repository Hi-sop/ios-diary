//
//  DiaryItemCell.swift
//  Diary
//
//  Created by Hisop on 2024/01/03.
//

import UIKit

class DiaryItemCell {
    private var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private var date: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    private var description: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    func configureLabelName(title: String, date: String, description: String) {
        self.title.text = title
        self.date.text = date
        self.description.text = description
    }
}

//DiaryItemCell()
//DiaryItemCell.anyMethod(title: UILabel)