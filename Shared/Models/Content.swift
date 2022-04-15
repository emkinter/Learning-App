//
//  Content.swift
//  Learning App
//
//  Created by Ekkehard Koch on 2022.04.08.
//

import Foundation
import SwiftUI

struct Content: Decodable, Identifiable {
    var id: Int
    var image: String
    var forgroundColor: String
    var backgroundColor: String
    var time: String
    var description: String
    var lessons: [Lesson]
}
