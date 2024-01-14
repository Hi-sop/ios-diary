//
//  Diary.swift
//  Diary
//
//  Created by Hisop on 2024/01/03.
//

import Foundation

final class Diary {
    let title: String
    let body: String
    let createdAt: Int
    
    init(title: String, body: String, createdAt: Int) {
        self.title = title
        self.body = body
        self.createdAt = createdAt
    }
}
