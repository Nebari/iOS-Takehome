//
//  ViewController.swift
//  WeatherWonder
//
//  Created by Nathan Birkholz on 1/14/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {

// MARK: Properties

  @IBOutlet weak var tableView: UITableView!

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  var forecasts : [Forecast]?
  var networkController : NetworkController!

// MARK: Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.dataSource =  self
    self.tableView.delegate = self
    self.navigationController?.delegate = self
    self.networkController = NetworkController()
      self.tableView.registerNib((UINib(nibName: "WeatherCell", bundle: NSBundle.mainBundle())), forCellReuseIdentifier: "FORECAST_CELL")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.activityIndicator.startAnimating()
    self.networkController.getJSONForForecasts({ (forecasts) -> (Void) in
      self.forecasts = forecasts
      self.tableView.reloadData()
      self.activityIndicator.stopAnimating()
    })
  }

// MARK: UITableView

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.forecasts?.count ?? 0
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let forecastForRow = self.forecasts?[indexPath.row] as Forecast!
    let cell = self.tableView.dequeueReusableCellWithIdentifier("FORECAST_CELL", forIndexPath: indexPath) as WeatherCell
      // Keep images consistent in tableView
    let currentTag = cell.tag + 1
    cell.tag = currentTag
    cell.forecastImage.image = self.getImageForCell(forecastForRow.forecastType)
    cell.forecastLabel.text = forecastForRow.forecastDay
    return cell
  }

  func getImageForCell(weatherString: String) -> UIImage {
    switch weatherString {
      case "rainy":
        return UIImage(named: "Rainy")!
      case "cloudy":
        return UIImage(named: "Cloudy")!
      case "sunny":
        return UIImage(named: "Sunny")!
      default:
        return UIImage(named: "Sunny")!
    }
  }

// MARK: Transition

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.performSegueWithIdentifier("SHOW_DETAIL", sender: self)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "SHOW_DETAIL" {
      let detailVC = segue.destinationViewController as DetailViewController
      let indexPathForForecast = self.tableView.indexPathForSelectedRow() as NSIndexPath!
      let detailForecast = self.forecasts?[indexPathForForecast.row]
      let cell = self.tableView.cellForRowAtIndexPath(indexPathForForecast) as WeatherCell
      let image = cell.forecastImage.image
      detailVC.forecastForDetail = detailForecast
      detailVC.forecastDetailImage = image
    }
  }

  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if fromVC == self && toVC.isKindOfClass(DetailViewController) {
      let transitionVC = AnimateToDetailVCController()
      return transitionVC
    } else {
      return nil
    }
  }

} // End

