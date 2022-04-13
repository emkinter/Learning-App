//
//  ContentModel.swift
//  Learning App
//
//  Created by Ekkehard Koch on 2022.04.06.
//

import Foundation

class ContentModel: ObservableObject {
    // List of modules
    @Published var modules = [Module]()
    // Current module and current module index
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    // Current lesson and current lesson index
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    // Current lesson explanation
    @Published var lessonDescription = NSAttributedString()
    // Current selected content and test
    @Published var currentContentSelected: Int?
    // Style Data
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    // MARK: - Data methods
    func getLocalData() {
        // Get a url to the JSON file
        let jsonURL = Bundle.main.url(forResource: "data", withExtension: "json")
        do {
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonURL!)
            // Try to decode the JSON into an array of modules
            let jsonDecoder = JSONDecoder()
            do {
                let modules = try jsonDecoder.decode([Module].self, from: jsonData)
                //Assign parse modules to modules property
                self.modules = modules
            }
            catch {
                //TODO log error
                print("Could not parse local data")
            }
            
        }
        catch {
            //TODO log error
            print("Could not parse local data")
        }
        let styleURL = Bundle.main.url(forResource: "style", withExtension: "html")
        do {
            //Read the file into a data object
            let styleData = try Data(contentsOf: styleURL!)
            self.styleData = styleData
        }
        catch {
            // log error
            print("Could not parse style data")
        }
    }
    // MARK: - Module navigation methods
    func beginModule( moduleId: Int) {
        // Find the index for this moduleId
        for index in 0..<modules.count {
            if modules[index].id == moduleId {
                currentModuleIndex = index
                break
            }
        }
        // set the current module
        currentModule = modules[currentModuleIndex]
    }
    //MARK: - Lesson navifation methods
    func beginLesson( lessonIndex: Int) {
        // Check to make sure lesson indes is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else {
            currentLessonIndex = 0
        }
        // set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        lessonDescription = addStyling(currentLesson!.explanation)
    }
    func nextLesson() {
        // Advance currentLessonIndex
        currentLessonIndex += 1
        // Check that it is withing range
        if currentLessonIndex < currentModule!.content.lessons.count {
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
        }
        else {
            currentLesson = nil
            currentLessonIndex = 0
        }
        
    }
    func hasNextLesson() -> Bool {
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    //MARK: - Code Styling
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        // Add the styling data
        if styleData != nil {
            data.append(styleData!)
        }
        // Add the html data
        data.append(Data(htmlString.utf8))
        // Convert to attributed string
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
        }
        return resultString
    }
}
