//
//  StickerViewModel.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 14/01/2022.
//

import Foundation
import Firebase
import SwiftyJSON
import TCMask
class StickerViewModel{
    func getSticker(completionHandler:@escaping(_ result:Bool, _ sticker:[StickerModel]?) -> Void){
        var returnSticker:[StickerModel] = []
        let db = Firestore.firestore()
        db.collection("Sticker").getDocuments(){(querySnapshot, err) in
            if let error = err{
                print("Error getting documents: \(error)")
                completionHandler(false, nil)
            }else{
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    guard let json = JSON(rawValue: document.data()) else {return}
                    let data = json["data"]
                    let holiday = StickerModel(listItem: data["holidays"].arrayValue, groupName: "Holidays")
                    let nature = StickerModel(listItem: data["nature"].arrayValue, groupName: "Nature")
                    let ecommerce = StickerModel(listItem: data["pricetag_ecommerce"].arrayValue, groupName: "Ecommerce & Price tag")
                    returnSticker.append(holiday)
                    returnSticker.append(nature)
                    returnSticker.append(ecommerce)
                }
                completionHandler(true, returnSticker)
            }
        }
    }
}
