//
//  ViewController.swift
//  SwapiSwiftMVC
//
//  Created by mac on 13/09/22.
//

import UIKit
import SwiftyJSON
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var peopleResponse: PeopleResponse?
    @IBOutlet weak var tableView: UITableView!
    var resultArray = [Result]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.roundCorners(UIRectCorner.allCorners, radius: 20.0)
        fetchCharacterData(url: Constants.PEOPLE_URL)
    }
    func fetchCharacterData(url: String){
        ApiServices.sharedInstance.alomofireGet(URL: url) { data in
            do{
                let jsonString = String(data: data, encoding: .utf8)
//                print(jsonString)
                self.peopleResponse = try PeopleResponse(jsonString!)
//                peopleResponse.
                self.resultArray.append(contentsOf: self.peopleResponse?.results ?? [Result]())
                DispatchQueue.main.async {self.tableView.reloadData()}
            } catch {
                print("Parse Error \(error)")
            }
        } onError: { error in
            print(error)
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "customStarWarsCell") as! CustomStarWarsCell
        cell.swapiLabel.text = resultArray[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = self.resultArray.count - 1
        if indexPath.row == lastElement {
                       // handle your logic here to get more items, add it to dataSource and reload tableview
            if self.peopleResponse?.next != "" {
                fetchCharacterData(url: (self.peopleResponse?.next)!)
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.result = resultArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }

}

