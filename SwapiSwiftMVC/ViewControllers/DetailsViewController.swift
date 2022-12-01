//
//  DetailsViewController.swift
//  SwapiSwiftMVC
//
//  Created by mac on 14/09/22.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var result: Result?
    var titlesArray = ["Details","Physical Attributes","Films"]
    var physicalAttributes = [PhysicalAttributes]()
    var filmAttributes = [PhysicalAttributes]()
    @IBOutlet weak var tableView: UITableView!
    
    func getPhysicalAttributes() {
        physicalAttributes.append(PhysicalAttributes(title: "Height", subtitle: result?.height ?? "N/A"))
        physicalAttributes.append(PhysicalAttributes(title: "Mass", subtitle: result?.mass ?? "N/A"))
        physicalAttributes.append(PhysicalAttributes(title: "Hair Color", subtitle: result?.hairColor ?? "N/A"))
        physicalAttributes.append(PhysicalAttributes(title: "Skin Color", subtitle: result?.skinColor ?? "N/A"))
        physicalAttributes.append(PhysicalAttributes(title: "Eye Color", subtitle: result?.eyeColor ?? "N/A"))
        physicalAttributes.append(PhysicalAttributes(title: "Gender", subtitle: result?.gender ?? "N/A"))
    }
    func getFilmAttributes(){
        result?.films.forEach({ url in
            ApiServices.sharedInstance.alomofireGet(URL: url) { data in
                do{
                    let jsonString = String(data: data, encoding: .utf8)
    //                print(jsonString)
                    let movie = try FilmResponse(jsonString!)
    //                peopleResponse.
                    self.filmAttributes.append(PhysicalAttributes(title: movie.title, subtitle: movie.openingCrawl))
                    DispatchQueue.main.async {self.tableView.reloadData()}
                } catch {
                    print("Parse Error \(error)")
                }
            } onError: { error in
                print(error)
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.result?.name
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        getPhysicalAttributes()
        getFilmAttributes()
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return physicalAttributes.count
        } else {
            // for section = 2
            return filmAttributes.count ?? 0
        }
        return 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titlesArray[section]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        var cell = UITableViewCell()
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomDetailsHorizontalCell", for: indexPath) as! CustomDetailsHorizontalCell
            cell.titleText.text = "Birth Year"
            cell.subTitleText.text = "\(result?.birthYear ?? "")"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomDetailsHorizontalCell", for: indexPath) as! CustomDetailsHorizontalCell
            cell.titleText.text = "\(physicalAttributes[indexPath.row].title)"
            cell.subTitleText.text = "\(physicalAttributes[indexPath.row].subtitle)"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomDetailsVerticalCell", for: indexPath) as! CustomDetailsVerticalCell
            cell.titleText.text = filmAttributes[indexPath.row].title
            cell.subTitleText.text = filmAttributes[indexPath.row].subtitle
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

         //For Header Background Color
//         view.tintColor = .black

        // For Header Text Color
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .systemBlue
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
