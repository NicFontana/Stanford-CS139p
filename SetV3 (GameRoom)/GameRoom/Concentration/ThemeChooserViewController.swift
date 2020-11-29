//
//  ThemeChooserViewController.swift
//  Concentration
//
//  Created by Niccolò Fontana on 03/10/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        title = "Choose a theme"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private var splitViewDetailConcentrationVC: ConcentrationViewController? { splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private func changeThemeAndPlay(with theme: Theme, sender: Any) {
        if let concentrationVC = splitViewDetailConcentrationVC {
            if theme != concentrationVC.theme { concentrationVC.theme = theme }
        } else if let concentrationVC = lastSeguedConcentrationVC {
            if theme != concentrationVC.theme { concentrationVC.theme = theme }
            navigationController?.pushViewController(concentrationVC, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    

    // MARK: - Navigation
    
    private var lastSeguedConcentrationVC: ConcentrationViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if let identifier = segue.identifier {
            if identifier == "Choose Theme" {
                let concentrationVC = segue.destination as! ConcentrationViewController
                var selectedTheme: Theme
                
                if let indexPath = tableView.indexPathForSelectedRow {
                    selectedTheme = Theme.number(indexPath.row)
                } else {
                    selectedTheme = Theme.randomTheme()
                }
                concentrationVC.theme = selectedTheme
                lastSeguedConcentrationVC = concentrationVC
            }
        }
    }

}

// MARK: TableView

extension ThemeChooserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Theme.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell") ?? UITableViewCell()
        cell.textLabel?.text = Theme.number(indexPath.row).rawValue
        
        return cell
    }
}

// This instead of the storyboard segue from the TableCell
extension ThemeChooserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTheme = Theme.number(indexPath.row)
        changeThemeAndPlay(with: selectedTheme, sender: tableView.cellForRow(at: indexPath) as Any)
    }
}

// MARK: SplitView

extension ThemeChooserViewController: UISplitViewControllerDelegate {
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        // Hey, I'm adapting to the fact that I am a SplitViewController on an iPhone,
        // and I want to collapse the Detail, using a NavigationController, on top of the primary (the Master),
        // should I do it?
        // ------------------------------
        // False = I did not collapse it for you, so you do it.
        // True = I collpase it for you
        if lastSeguedConcentrationVC == nil {
            return true
        }
        return false
    }
}
