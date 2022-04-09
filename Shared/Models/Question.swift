//
//  Question.swift
//  Learning App
//
//  Created by Ekkehard Koch on 2022.04.08.
//

import Foundation

struct Question: Decodable, Identifiable {
    var id: Int
    var content: String
    var correctIndex: Int
    var answers: [String]
}
