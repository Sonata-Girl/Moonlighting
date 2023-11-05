//
//  JobDto.swift
//  Moonlighting
//
//  Created by Sonata Girl on 02.11.2023.
//

import Foundation

// MARK: - Job dto model

struct JobDto: Decodable {
    let id: String
    let logo: URL?
    let profession: String
    let employer: String
    let salary: Double
    let date: String
}

// MARK: - Convert JobDto to JobsModel methods

extension JobDto {
    var model: JobModel {
        .init(from: self, logoData: nil)
    }
}

extension Array where Element == JobDto {
    var models: JobsModel {
        self.map { $0.model }
    }
}

typealias JobsDto = [JobDto]
