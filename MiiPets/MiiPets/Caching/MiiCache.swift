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

    func fetch<T>(_ objectType: T.Type, primaryKey: String?) -> T? where T : Decodable {
        return nil
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
