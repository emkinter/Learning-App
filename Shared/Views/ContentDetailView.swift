//
//  ContentDetailView.swift
//  Learning App
//
//  Created by Ekkehard Koch on 2022.04.11.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        VStack {
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            else {
                Text("Video Not Available.")
            }
            // Description
            CodeTextView()
            
            // Show next lesson button if there is a next lesson
            if model.hasNextLesson() {
                Button (action:{
                    //Advance lesson
                    model.nextLesson()
                }, label: {
                    ZStack {
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .bold()
                            .foregroundColor(Color.white)
                    }
                })
            }
            else {
                Button (action:{
                    // Take the user back to the homeview
                    model.currentContentSelected = nil
                }, label: {
                    ZStack {
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        Text("Complete")
                            .bold()
                            .foregroundColor(Color.white)
                    }
                })
            }
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
