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
    func beginModule ( moduleId: Int) {
        // Find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleId {
                currentModuleIndex = index
                break
            }
        }
        // set the current module
        currentModule = modules[currentModuleIndex]
    }
    
}
