//
//  Model.swift
//  Moonlighting
//
//  Created by Sonata Girl on 30.10.2023.
//

import Foundation

// MARK: - Incoming model
struct JobDto: Encodable {
    let salary: Double
    let profession, id: String
    let date: Date
    let employer: String
    let logo: URL?
}

extension JobDto {
    var model: JobModel {
        .init(
            salary: self.salary,
            profession: self.profession,
            id: self.id,
            date: self.date,
            employer: self.employer,
            logo: self.logo
        )
    }
}

extension Array where Element == JobDto {
    var models: [JobModel] {
        self.map { $0.model }
    }
}
