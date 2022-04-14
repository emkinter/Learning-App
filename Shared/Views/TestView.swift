//
//  TestView.swift
//  Learning App
//
//  Created by Ekkehard Koch on 2022.04.14.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model:ContentModel
    var body: some View {
        if model.currentQuestion != nil {
            VStack {
                // Question niumber
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                // Question
                CodeTextView()
                // Answer
                // Button
            }
            .accentColor(.black)
            .padding()
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
