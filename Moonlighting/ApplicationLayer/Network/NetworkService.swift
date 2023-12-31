//
//  APIController.swift
//  Moonlighting
//
//  Created by Sonata Girl on 30.10.2023.
//

import Foundation

// MARK: - Network service protocol

protocol NetworkServiceProtocol {
    func getJobsRequest(completion: @escaping (Result<JobsDto, Error>) -> Void)
    func loadImageData(from url: URL, completion: @escaping (Data?) -> Void)
}

// MARK: - Api settings

enum ApiType {
    case getJobs
 
    static var baseURL: String {
        return ""
    }
    
    private var path: String {
        switch self{
        case.getJobs: return "jobs"
        }
    }
    
    var urlString: String {
        return ApiType.baseURL + path
    }
}

// MARK: - Network service

final class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    private let api = ApiType.self
    private let decoder = JSONDecoder()
    private let imageCache = NSCache<NSString, ImageDataWrapper>()
    
    func getJobsRequest(completion: @escaping (Result<JobsDto, Error>) -> Void) {
//        guard let url = URL(string: api.getJobs.urlString) else { return }
         
        guard let path = Bundle.main.path(forResource: "JSON", ofType: "json") else { return }
        let jsonDecoder = JSONDecoder()
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                let jobsModels = try! jsonDecoder.decode(JobsDto.self, from: data)
                completion(.success(jobsModels))
            }
        }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse,
//                  response.statusCode == 200 else { return }
//            
//            guard let data = data else { return }
//            do {
//                let jobsModels = try self.decoder.decode(JobsDto.self, from: data)
//                completion(.success(jobsModels))
//            } catch let error {
//                completion(.failure(error))
//            }
//        }.resume()
    }

    func loadImageData(from url: URL, completion: @escaping (Data?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage.imageData)
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            self.imageCache.setObject(ImageDataWrapper(imageData: data), forKey: url.absoluteString as NSString)
            completion(data)
        }.resume()
    }
}
