//
//  Job.swift
//  Moonlighting
//
//  Created by Sonata Girl on 30.10.2023.
//

import Foundation

// MARK: - Job model

struct JobModel: Hashable, Identifiable {
    let id: String
    let logo: URL?
    let profession: String
    let employer: String
    let salary: Double
    let date: String
    var isSelected: Bool
    var logoData: Data?
   
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: JobModel, rhs: JobModel) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Convert from dto method

extension JobModel {
    init(from dto: JobDto, logoData: Data?) {
        self.id = dto.id
        self.logo = dto.logo
        self.profession = dto.profession
        self.employer = dto.employer
        self.salary = dto.salary
        self.date = dto.date
        self.logoData = logoData
        self.isSelected = false
    }
}

// MARK: - Date convert methods

extension JobModel {
    var dateFromString: Date? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.date(from: date)
    }
    
    var dateDay: String {
        guard let date = dateFromString else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        return formatter.string(from: date)
    }
    
    var dateTime: String {
        guard let date = dateFromString else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

typealias JobsModel = [JobModel]
