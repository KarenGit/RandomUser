//
//  Helper.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

import UIKit

class Helper {
    static func downloadImage(from link: String, complition: ((UIImage)-> ())?) -> UIImage? {
      if link == "" { return nil }
      let fileManager = FileManager()
      var imagePath: String = ""
      
      let urlMD5 = link.md5
      var folderName: String!
      let directory: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
      
      folderName = "Common"
      
      let path: String = directory + "/" + folderName
      imagePath = (path as NSString).appendingPathComponent(urlMD5!) + ".png"
      
      if fileManager.fileExists(atPath: path) {
        if fileManager.fileExists(atPath: imagePath) {
          if let complition = complition {
            let image = UIImage(contentsOfFile: imagePath)
            complition(image!)
            return image
          }
          return nil
        }
      } else {
        do {
          try fileManager.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
          print(error.localizedDescription)
        }
      }
      let spString: String = link.addingPercentEncoding( withAllowedCharacters: CharacterSet.urlQueryAllowed)!
      guard let url = URL(string: spString) else { return nil }
      let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard
          let httpURLResponse = response as? HTTPURLResponse , httpURLResponse.statusCode == 200,
          let mimeType = response?.mimeType , mimeType.hasPrefix("image"),
          let data = data , error == nil,
          let image = UIImage(data: data)
          else {
            return
        }
        DispatchQueue.main.sync() { () -> Void in
          fileManager.createFile(atPath: imagePath, contents: data)
          if complition != nil {
            complition!(image)
          }
        }
      }
      task.resume()
      return nil
    }
}
