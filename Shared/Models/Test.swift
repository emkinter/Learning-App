//
//  Test.swift
//  Learning App
//
//  Created by Ekkehard Koch on 2022.04.08.
//

import Foundation

struct Test: Decodable, Identifiable {
    var id: Int
    var image: String
    var time: String
    var description: String
    var questions: [Question]
}
