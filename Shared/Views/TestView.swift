//
//  TestView.swift
//  Learning App
//
//  Created by Ekkehard Koch on 2022.04.14.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model:ContentModel
    @State var selectedAnswerIndex: Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack (alignment: .leading) {
                // Question niumber
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                // Question
                CodeTextView()
                    .padding(.horizontal, 20)
                // Answer
                ScrollView {
                    VStack {
                        ForEach (0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            Button {
                                // Track the selected index
                                selectedAnswerIndex = index
                            } label: {
                                ZStack{
                                    // Answers not submitted
                                    if submitted == false {
                                        RectangleCard(color: index == selectedAnswerIndex ? Color.gray : Color.white)
                                            .frame(height: 48)
                                    }
                                    else {
                                        // Anser was submitted
                                        if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                            // User has selected right answer
                                            // Show green button
                                            RectangleCard(color: Color.green)
                                                .frame(height: 48)
                                        }
                                        else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                            // User has selected wrong answer
                                            // Show red button
                                            RectangleCard(color: Color.red)
                                                .frame(height: 48)
                                        }
                                        else if index == model.currentQuestion!.correctIndex{
                                            // This button is the correct answer
                                            // show a green background
                                            RectangleCard(color: Color.green)
                                                .frame(height: 48)
                                        }
                                        else {
                                            //
                                            RectangleCard(color: Color.white)
                                                .frame(height: 48)
                                        }
                                    }
                                    Text(model.currentQuestion!.answers[index])
                                }
                            }
                            .disabled(submitted)
                        }
                    }
                    .accentColor(Color.black)
                    .padding()
                }
                // Submit button
                Button {
                    // Check if answer has been submitted
                    if submitted == true {
                        // Anser the already been submnitted, move to nexet question
                        model.nextQuestion()
                        // Reset properties
                        submitted = false
                        selectedAnswerIndex = nil
                    }
                    else {
                        // change submitted state to true
                        submitted = true
                        // Check the answer and increment the counter if correct
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                            numCorrect += 1
                        }
                    }
                } label: {
                    ZStack {
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        Text(buttonText)
                            .bold()
                            .foregroundColor(Color.white)
                    }
                    .padding()
                }
                .disabled(selectedAnswerIndex == nil)
            }
            .accentColor(.black)
            .padding()
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            ProgressView()
        }
    }
    
    var buttonText : String {
        if submitted == true {
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
                // This is the last question
                return "Finish"
            }
            else {
                // There is a next question
                return "Next"
            }
        }
        else {
            // Submit the result
            return "Submit"
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
