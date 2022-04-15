//
//  ContentModel.swift
//  Learning App
//
//  Created by Ekkehard Koch on 2022.04.06.
//

import Foundation

class ContentModel: ObservableObject {
    // MARK: - Attributes
    // List of modules
    @Published var modules = [Module]()
    // Current module and current module index
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    // Current lesson and current lesson index
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    // Current question
    @Published var currentQuestion: Question?
    // Current question index
    var currentQuestionIndex = 0
    // Current codeText
    @Published var codeText = NSAttributedString()
    // Current selected content and test
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    // Style Data
    var styleData: Data?
    // MARK: - Class initialization Method
    init() {
        // Parse local included JSON data
        getLocalData()
        // Download remote JSON file and parse data
        getRemoteData()
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
    func getRemoteData() {
        // String path
        let urlString = "https://emkinter.github.io/learningapp-data/data2.json"
        // Create a url object
        let url = URL(string: urlString)
        guard url != nil else {
            // Could not find url
            return
        }
        // Create a URLRequest object
        let request = URLRequest(url: url!)
        // Get the session and kick of the task
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            // Check if there's an error
            guard error == nil else {
                return
            }
            do {
                // Create JSON decoder
                let decoder = JSONDecoder()
                // Decode JSON
                let modules = try decoder.decode([Module].self, from: data!)
                // Append parsed module into modules array
                self.modules += modules
            }
            catch {
                
            }
        }
        // Kick of the data task
        dataTask.resume()
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
    // MARK: - Lesson navigation methods
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
        codeText = addStyling(currentLesson!.explanation)
    }
    func nextLesson() {
        // Advance currentLessonIndex
        currentLessonIndex += 1
        // Check that it is withing range
        if currentLessonIndex < currentModule!.content.lessons.count {
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        }
        else {
            currentLesson = nil
            currentLessonIndex = 0
        }
        
    }
    func hasNextLesson() -> Bool {
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    // MARK: - Question navigation methods
    func beginTest( moduleId: Int) {
        // Set the current module
        beginModule(moduleId: moduleId)
        // Set the current question
        currentModuleIndex = 0
        // If there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
    }
    func nextQuestion() {
        //Advance the question index
        currentQuestionIndex += 1
        if currentQuestionIndex < currentModule!.test.questions.count {
            // Set current question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
        else {
            currentQuestion = nil
            currentQuestionIndex = 0
        }
        //Check the it's withing the range of question
    }
    func hasNextQuestion() -> Bool {
        return (currentQuestionIndex + 1 < currentModule!.test.questions.count)
    }
    // MARK: - Code Styling
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
