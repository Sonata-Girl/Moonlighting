//
//  SavingModel.swift
//  Moonlighting
//
//  Created by Sonata Girl on 05.11.2023.
//

import UIKit

class SelectedCellSavingModel: Codable {
    var id: String
    var employer: String
    var profession: String
    var salary: Double
    
    // MARK: Init
    
    init(jobModel: JobModel) {
        self.id = jobModel.id
        self.employer = jobModel.employer
        self.profession = jobModel.profession
        self.salary = jobModel.salary
    }
    
    init() {
        self.id = ""
        self.employer = ""
        self.profession = ""
        self.salary = 0
    }
    
    // MARK: Codable methods
    
    public enum CodingKeys: String, CodingKey {
        case id, employer, profession, salary
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.employer = try container.decode(String.self, forKey: .employer)
        self.profession = try container.decode(String.self, forKey: .profession)
        self.salary = try container.decode(Double.self, forKey: .salary)
    }
    
    func encode(to encoder: Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.employer, forKey: .employer)
        try container.encode(self.profession, forKey: .profession)
        try container.encode(self.salary, forKey: .salary)
    }
}


// MARK: - Codable UserDefaults methods

extension UserDefaults {
    func set<T: Encodable>(encodable: T, forKey key:String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}

typealias SelectedCellsSavingModel = [SelectedCellSavingModel]
