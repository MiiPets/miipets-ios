import Foundation

protocol Cacher {

    func fetch<T: Decodable>(_ objectType: T.Type, primaryKey: String?) -> T?

    func addOrUpdate<T: Decodable>(_ object: T, primaryKey: String?, completion: @escaping (_ error: Error?) -> ())

    func delete<T: Decodable>(_ object: T, completion: @escaping (_ error: Error?) -> ())

    func delete<T: Decodable>(_ objectType: T.Type, with primaryKey: String?, completion: @escaping (_ error: Error?) -> ())
}

class MiiCache {

    private static var _cacher: Cacher?

    static var cacher: Cacher {
        guard let cacher = _cacher else {
            return resolveCachingSolution()
        }

        return cacher
    }

    private static func resolveCachingSolution() -> Cacher {
        _cacher = SomeCacher()
        return _cacher!
    }
}

fileprivate class SomeCacher: Cacher {

    /// We should remove this once we actually start performing service calls and caching
    private enum ModelName: String {
        case services = "services"

        static func responseFileName<T: Decodable>(for objectType: T.Type) -> ModelName? {
            if objectType == Services.self {
                return .services
            }
            return nil
        }
    }

    func fetch<T>(_ objectType: T.Type, primaryKey: String?) -> T? where T : Decodable {
        let bundle = Bundle(for: MiiCache.self)

        guard let file = bundle.url(forResource: ModelName.responseFileName(for: objectType)?.rawValue, withExtension: "json")?.path else { return nil }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: file)) else { return nil }

        do {
            return try JSONDecoder().decode(objectType, from: data)
        } catch let error {
            debugPrint("Error trying to decode model: \(error.localizedDescription)")
            return nil
        }
    }

    func addOrUpdate<T>(_ object: T, primaryKey: String?, completion: @escaping (_ error: Error?) -> ()) where T : Decodable {
        completion(nil)
    }

    func delete<T>(_ object: T, completion: @escaping (_ error: Error?) -> ()) where T : Decodable {
        completion(nil)
    }

    func delete<T>(_ objectType: T.Type, with primaryKey: String?, completion: @escaping (_ error: Error?) -> ()) where T : Decodable {
        completion(nil)
    }
}
