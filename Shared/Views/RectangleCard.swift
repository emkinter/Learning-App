//
//  RectangleCard.swift
//  Learning App
//
//  Created by Ekkehard Koch on 2022.04.13.
//

import SwiftUI

struct RectangleCard: View {
    var color = Color.white
    var body: some View {
        Rectangle()
            .frame(height: 48)
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
