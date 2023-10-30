//
//  APIController.swift
//  Moonlighting
//
//  Created by Sonata Girl on 30.10.2023.
//

import Foundation

enum ApiType {
    case getJobs
 
    static var baseURL: String{
        return "http://185.174.137.159/"
    }
    
    private var path: String{
        switch self{
        case.getJobs: return "jobs"
        }
    }
    
    var urlString: String {
        return ApiType.baseURL + path
    }
}

// MARK: - Api Controller

final class ApiController {
   private let api = ApiType.self
    private let decoder = JSONDecoder()
   
    func getJobsRequest(
        page: Int,
        completion: @escaping (Result<JobModels, Error>) -> Void) {
        guard let url = URL(string: api.baseURL) else { return }
        var request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Error: \(error.localizedDescription)")
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            do {
                let jobsModels = try self.decoder.decode(JobModels.self, from: data)
                completion(.success(jobsModels))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
