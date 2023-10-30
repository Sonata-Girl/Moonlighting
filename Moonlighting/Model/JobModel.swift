//
//  Job.swift
//  Moonlighting
//
//  Created by Sonata Girl on 30.10.2023.
//

import Foundation

struct JobModel: Decodable {
    let salary: Double
    let profession, id: String
    let date: Date
    let employer: String
    let logo: URL?
}

typealias JobModels = [JobModel]
