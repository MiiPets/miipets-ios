import Foundation

// MARK: - Domain

enum Domain: String {
    case profile = "profile"
    case services = "services"

    var domainError: String {
        switch self {
        case .profile:
            return "MiiPets.Profile"
        case .services:
            return "MiiPets.Services"
        }
    }
}

// MARK: - Networker

protocol Networker {

    func get<Model: Decodable>(endpoint: String,
                               model: Model.Type,
                               domain: Domain,
                               completion: @escaping (_ data: Model?, _ error: Error?) -> ())

    func post<RequestBody: Encodable, ResponseModel: Decodable>(endpoint: String,
                                                                body: RequestBody,
                                                                model: ResponseModel.Type,
                                                                domain: Domain,
                                                                completion: @escaping (_ data: ResponseModel?, _ error: Error?) -> ())
}

// MARK: - MiiNetwork

class MiiNetwork {

    private static var _networker: Networker?

    static var networker: Networker {
        guard let networker = _networker else {
            return resolveNetworkingSolution()
        }

        return networker
    }

    private static func resolveNetworkingSolution() -> Networker {
        _networker = NetworkingClient()
        return _networker!
    }
}

// MARK: - NetworkingClient

fileprivate class NetworkingClient {

    private let baseURL: String = "www.miipets.com"

    private func resolveCompleteEndpoint(with domain: Domain, endpoint: String) -> String {
        return "\(baseURL)/\(domain.rawValue)/\(endpoint)"
    }
}

extension NetworkingClient: Networker {

    func get<Model>(endpoint: String, model: Model.Type, domain: Domain, completion: @escaping (Model?, Error?) -> ()) where Model : Decodable {
        completion(nil, nil)
    }

    func post<RequestBody, ResponseModel>(endpoint: String,
                                          body: RequestBody,
                                          model: ResponseModel.Type,
                                          domain: Domain,
                                          completion: @escaping (ResponseModel?, Error?) -> ()) where RequestBody : Encodable, ResponseModel : Decodable {
        completion(nil, nil)
    }
}
