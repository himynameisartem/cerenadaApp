//
//  ProductCardManager.swift
//  cerenadaApp
//
//  Created by Артем Кудрявцев on 01.12.2022.
//

import UIKit
import Alamofire

protocol ProductCardManagerDelegate {
    func updateInterface(_: ProductCardClient, with data: ProductCard)
}

class ProductCardClient {
    
    var delegate: ProductCardManagerDelegate?

    func request(id: Int) {
            
    let url = "https://cerenada.ru/wp-json/wc/v3/products/\(id)/?consumer_key=ck_92c8b3a8dad21a0c0c63ca32162d1de98741e8b7&consumer_secret=cs_50ddecfd1e1624327a381add4d7fb7b7464b98ae"
    
    AF.request(url).response { responce in
        switch responce.result {
        case .success(let data) :
            do {
                let jsonData = try JSONDecoder().decode(ProductCard.self, from: data!)
                self.delegate?.updateInterface(self, with: jsonData)
//                print(jsonData)
                self.delegate?.updateInterface(self, with: jsonData)
            } catch {
                print("MatchesParseError")
            }
        case .failure(let error):
            print(error.localizedDescription)
            
        }
    }
}
}
