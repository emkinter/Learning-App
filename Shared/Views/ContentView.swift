//
//  ContentView.swift
//  Learning App
//
//  Created by Ekkehard Koch on 2022.04.11.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ContentModel
    var body: some View {
        ScrollView {
            LazyVStack {
                // Confirm that currentModule is set
                if model.currentModule != nil {
                    ForEach(0..<model.currentModule!.content.lessons.count) { index in
                       ContentViewRow(index: index)
                    }
                }
            }
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}
