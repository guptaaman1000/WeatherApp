//
//  RESTNetworkClient.swift
//  CoreModule
//
//  Created by Aman Gupta on 18/10/19.
//

import Foundation
import RxSwift

final public class RESTNetworkClient: NetworkClientType {
    
    private let requestBuilder = RequestBuilder()
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<Response: Decodable>(_ request: Request) -> Single<Response> {
        
        let urlRequest: URLRequest
        
        do {
            urlRequest = try requestBuilder.buildRequest(request: request)
        } catch let error {
            if error is DataError {
                return Single.error(error as! DataError)
            } else {
                return Single.error(DataError.invalidURL)
            }
        }
        
        return Single<Response>.create { [weak self] single in
            
            guard let self = self else {
                return Disposables.create()
            }
            
            let request = self.session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                if let response = response, response.isSuccess {
                    
                    if response.httpStatusCode == 204 {
                        
                        single(.error(DataError.noContent))
                        
                    } else if data != nil {
                        
                        do {
                            let decoder = JSONDecoder()
                            let formattedResponse = try decoder.decode(Response.self, from: data!)
                            single(.success(formattedResponse))
                        } catch {
                            single(.error(DataError.failedToMapObject))
                        }
                        
                    } else {
                        
                        let error = DataError.badResponse(code: response.httpStatusCode, desc: response.description)
                        single(.error(error))
                    }
                    
                } else {
                    
                    single(.error(DataError.unKnown))
                }
            })
            
            request.resume()
            return Disposables.create { request.cancel() }
        }
    }
}
