//
//  Lesson.swift
//  Learning App
//
//  Created by Ekkehard Koch on 2022.04.08.
//

import Foundation

struct Lesson : Decodable, Identifiable {
    var id: Int
    var title: String
    var video: String
    var duration: String
    var explanation: String
}
