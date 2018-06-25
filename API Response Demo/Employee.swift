//
//  Employee.swift
//  API Response Demo
//
//  Created by Ashwin Dinesh on 25/06/18.
//  Copyright © 2018 Ashwin Dinesh. All rights reserved.
//

import Foundation

struct Employee {
    
    let id: String
    let name: String
    let age: NSInteger
    let salary: Double
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json: [String:Any]) throws {
        guard let id = json["id"] as? String
        else {
            throw SerializationError.missing("Missing id")
        }
        
        guard let name = json["name"] as? String
        else {
            throw SerializationError.missing("Missing name")
        }
        
        guard let age = json["age"] as? NSInteger
        else {
            throw SerializationError.missing("Missing age")
        }
        
        guard let salary = json["salary"] as? Double
        else {
                throw SerializationError.missing("Missing salary")
        }
        
        self.id = id
        self.name = name
        self.age = age
        self.salary = salary
    }
    
    static let basepath = "https://gist.githubusercontent.com/ashwindmk/7fc3da64a5aab125794cbd5e5b870add/raw/employees.json"
    
    static func fetch(completion: @escaping ([Employee]) -> ()) {
        let request = URLRequest(url: URL(string: basepath)!)
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                var employeesArray:[Employee] = []
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let employeesObjectArray = json["employees"] as? [[String: Any]] {
                            for employeeObject in employeesObjectArray {
                                if let employee = try? Employee(json: employeeObject) {
                                    employeesArray.append(employee)
                                }
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
                completion(employeesArray)
            }
        }
        
        task.resume()
    }
    
}
