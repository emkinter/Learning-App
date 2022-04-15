//
//  ContentView.swift
//  Shared
//
//  Created by Ekkehard Koch on 2022.04.06.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                ScrollView {
                    LazyVStack {
                        VStack(spacing: 20) {
                            ForEach(model.modules){ module in
                                // MARK: Learning Card
                                NavigationLink(
                                    destination:
                                        ContentView()
                                        .onAppear(perform: {
                                            model.beginModule(moduleId: module.id)
                                        }),
                                    tag: module.id,
                                    selection: $model.currentContentSelected)
                                {
                                    HomeViewRow(image: module.content.image,
                                                forgroundColor: module.content.forgroundColor,
                                                backgroundColor: module.content.backgroundColor,
                                                title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                }
                                // MARK: Test Card
                                NavigationLink(destination:
                                                TestView()
                                                .onAppear(perform: { model.beginTest(moduleId: module.id)
                                                }),
                                               tag: module.id,
                                               selection: $model.currentTestSelected)
                                {
                                    HomeViewRow(image: module.test.image,
                                                forgroundColor: module.test.forgroundColor,
                                                backgroundColor: module.test.backgroundColor,
                                                title: "\(module.category) Test",
                                                description: module.test.description,
                                                count: "\(module.test.questions.count) Questions",
                                                time: module.test.time)
                                }
                                
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .accentColor(.black)
                    .padding()
                }
            }
            .navigationTitle("Get Started")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
