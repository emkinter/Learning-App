//
//  Module.swift
//  Learning App
//
//  Created by Ekkehard Koch on 2022.04.08.
//

import Foundation

struct Module : Decodable, Identifiable {
    var id: Int
    var category: String
    var content: Content
    var test: Test
}
