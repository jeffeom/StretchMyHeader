//
//  MasterViewController.swift
//  StretchMyHeader
//
//  Created by Jeff Eom on 2016-08-02.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController{
    
    //MARK: Properties
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    var news = [NewsItem]()
    
    let kTableHeaderHeight: CGFloat = 200.0
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(MasterViewController.insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        //MARK: TableView Constants
        
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        
        tableView.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0.0, y: -kTableHeaderHeight)
        
        updateHeaderView()
        
        
        //MARK: Date
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        
        dateLabel.text = formatter.stringFromDate(NSDate())
        
        
        //MARK: NewsItems
        
        var newsItem1 = NewsItem()
        newsItem1.category = NewsItem.Categories.World
        newsItem1.category?.Color()
        newsItem1.headline = "Climate change protests, divestments meet fossil fuels realities"
        
        var newsItem2 = NewsItem()
        newsItem2.category = NewsItem.Categories.Americas
        newsItem2.category?.Color()
        newsItem2.headline = "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"
        
        var newsItem3 = NewsItem()
        newsItem3.category = NewsItem.Categories.Europe
        newsItem3.category?.Color()
        newsItem3.headline = "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"
        
        var newsItem4 = NewsItem()
        newsItem4.category = NewsItem.Categories.MiddleEast
        newsItem4.category?.Color()
        newsItem4.headline = "Airstrikes boost Islamic State, FBI director warns more hostages possible"
        
        var newsItem5 = NewsItem()
        newsItem5.category = NewsItem.Categories.Africa
        newsItem5.category?.Color()
        newsItem5.headline = "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"
        
        var newsItem6 = NewsItem()
        newsItem6.category = NewsItem.Categories.AsiaPacific
        newsItem6.category?.Color()
        newsItem6.headline = "Despite UN ruling, Japan seeks backing for whale hunting"
        
        var newsItem7 = NewsItem()
        newsItem7.category = NewsItem.Categories.World
        newsItem7.category?.Color()
        newsItem7.headline = "South Africa in $40 billion deal for Russian nuclear reactors"
        
        var newsItem8 = NewsItem()
        newsItem8.category = NewsItem.Categories.Europe
        newsItem8.category?.Color()
        newsItem8.headline = "'One million babies' created by EU student exchanges"
        
        news = [newsItem1, newsItem2, newsItem3, newsItem4, newsItem5, newsItem6, newsItem7, newsItem8]
        
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        tableView.frame = CGRectMake(150, 100, tableView.frame.width-200, tableView.frame.height-200)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = segue.destinationViewController as! DetailViewController
                controller.detailItem = object
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MyCustomTableViewCell
        
        let theCategory: NewsItem.Categories = news[indexPath.row].category!
        
        myCell.categoryLabel.text = theCategory.rawValue
        myCell.categoryLabel.textColor = theCategory.Color()
        myCell.headlineLabel.text = news[indexPath.row].headline
        
        return myCell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // MARK: HeaderView Function
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func updateHeaderView(){
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.size.width, height: kTableHeaderHeight)
        print("=====")
        print("bounds: \(tableView.bounds)")
        print("frame: \(tableView.frame)")
        print("=====")
        if tableView.contentOffset.y < -kTableHeaderHeight {
            // contentOffset = visible area
            headerRect.origin.y = tableView.contentOffset.y
            print("The offset is \(tableView.contentOffset.y)")
            headerRect.size.height = -tableView.contentOffset.y
            print("The size height is \(-tableView.contentOffset.y)")
        }
        
        headerView.frame = headerRect
    }
    
}

