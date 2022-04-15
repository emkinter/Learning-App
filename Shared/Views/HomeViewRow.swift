//
//  HomeViewRow.swift
//  Learning App
//
//  Created by Ekkehard Koch on 2022.04.11.
//

import SwiftUI

struct HomeViewRow: View {
    var image: String
    var forgroundColor: String
    var backgroundColor: String
    var title: String
    var description: String
    var count: String
    var time: String
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            HStack {
                // Image
                Image(systemName: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(forgroundColor))
                    .background(Color(backgroundColor))
                Spacer()
                // Text
                VStack(alignment: .leading, spacing: 10) {
                    // Headline
                    Text(title)
                        .bold()
                    // Description
                    Text(description)
                        .padding(.bottom, 20)
                        .font(.caption)
                    // Icons
                    HStack {
                        // Number of lessons/questions
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(count)
                            .font(Font.system(size:10))
                        Spacer()
                        // Time
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(time)
                            .font(Font.system(size:10))
                    }
                }
                    .padding(.leading, 20)
            }
                .padding(.horizontal, 20)
        }
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", forgroundColor: "Color.gray", backgroundColor: "Color.black", title: "Learn Swift", description: "some description", count: "10 lesson", time: "3 hours")
    }
}
