import UIKit

protocol NetworkManagerProtocol {
    func requestForRundomJoke(completion: @escaping ((Result<RundomJokeModel, Error>) -> Void))
}

final class NetworkManager: NetworkManagerProtocol {

    func requestForRundomJoke(completion: @escaping ((Result<RundomJokeModel, Error>) -> Void)) {
        guard let url = URL(string: "https://icanhazdadjoke.com/slack") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some Error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }

                do {
                    let rundomJoke = try JSONDecoder().decode(RundomJokeModel.self, from: data)
                    completion(.success(rundomJoke))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
