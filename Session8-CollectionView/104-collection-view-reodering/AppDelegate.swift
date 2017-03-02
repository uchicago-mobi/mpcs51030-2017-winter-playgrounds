//
//  AppDelegate.swift
//  104-collection-view-reodering
//
//  Created by Jake Marsh on 10/14/15.
//  Copyright © 2015 Jake Marsh. All rights reserved.
//

import UIKit

struct Person {
  let name: String
  let imageName: String
}

class PersonCollectionViewCell : UICollectionViewCell {
  let imageView: UIImageView
  let nameLabel: UILabel

  let stackView: UIStackView
  var imageViewHeightConstraint: NSLayoutConstraint?

  func rankForIndex(_ index: Int) -> (rankName: String, imageSize: CGFloat) {
    switch index {
    case 0: return ("Captain", 115.0)
    case 1: return ("First Mate", 115.0)
    case 2: return ("Second Mate", 115.0)
    default: return ("Crew", 115.0)
    }
  }

  func configureForPerson(_ person: Person, index: Int) {
//    let rank = rankForIndex(index)

//    nameLabel.text = "\(rank.rankName): \(person.name)"
    nameLabel.text = person.name
    imageView.image = UIImage(named: person.imageName)

//    imageViewHeightConstraint?.constant = rank.imageSize

//    setNeedsUpdateConstraints()
//    invalidateIntrinsicContentSize()
  }
  
  override init(frame: CGRect) {
    imageView = UIImageView(frame: CGRect.zero)
    imageView.translatesAutoresizingMaskIntoConstraints = false

    nameLabel = UILabel(frame: CGRect.zero)

    stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
    stackView.axis = .vertical
    stackView.spacing = 10.0
    stackView.translatesAutoresizingMaskIntoConstraints = false

    super.init(frame: frame)

    translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false

    nameLabel.font = UIFont(name: "SourceSansPro-Semibold", size: 14.0)
    nameLabel.textAlignment = .center
    nameLabel.textColor = UIColor.white

    contentView.addSubview(stackView)

    contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: 1.0, constant: 0.0))

    imageViewHeightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 85.0)

    contentView.addConstraint(imageViewHeightConstraint!)

    for VFL in ["|[stackView]|", "V:|[stackView]|"] {
      contentView.addConstraints(
        NSLayoutConstraint.constraints(
          withVisualFormat: VFL,
          options: NSLayoutFormatOptions(rawValue: 0),
          metrics: nil,
          views: [ "stackView" : stackView ]
        )
      )
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }
  
  func startWiggling() {
    guard contentView.layer.animation(forKey: "wiggle") == nil else { return }
    guard contentView.layer.animation(forKey: "bounce") == nil else { return }

    let angle = 0.04

    let wiggle = CAKeyframeAnimation(keyPath: "transform.rotation.z")
    wiggle.values = [-angle, angle]

    wiggle.autoreverses = true
    wiggle.duration = randomInterval(0.1, variance: 0.025)
    wiggle.repeatCount = Float.infinity

    contentView.layer.add(wiggle, forKey: "wiggle")

    let bounce = CAKeyframeAnimation(keyPath: "transform.translation.y")
    bounce.values = [4.0, 0.0]
    
    bounce.autoreverses = true
    bounce.duration = randomInterval(0.12, variance: 0.025)
    bounce.repeatCount = Float.infinity

    contentView.layer.add(bounce, forKey: "bounce")
  }

  func stopWiggling() {
    contentView.layer.removeAllAnimations()
  }

  func randomInterval(_ interval: TimeInterval, variance: Double) -> TimeInterval {
    return interval + variance * Double((Double(arc4random_uniform(1000)) - 500.0) / 500.0)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()

    stopWiggling()
  }
}

class ReorderableFlowLayout : UICollectionViewFlowLayout {
  override func layoutAttributesForInteractivelyMovingItem(at indexPath: IndexPath, withTargetPosition position: CGPoint) -> UICollectionViewLayoutAttributes {
    let attributes = super.layoutAttributesForInteractivelyMovingItem(at: indexPath, withTargetPosition: position)
    
    attributes.alpha = 0.7
    attributes.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    
    return attributes
  }
}

class CrewViewController : UIViewController {
  var collectionView: UICollectionView!
  var longPressGR: UILongPressGestureRecognizer!
  var movingIndexPath: IndexPath?

  var crewMembers = [Person]()

  convenience init() {
    self.init(nibName: nil, bundle: nil)

    crewMembers.append(Person(name: "Sam Carter", imageName: "sam-carter"))
    crewMembers.append(Person(name: "Dana Scully", imageName: "dana-scully"))
    crewMembers.append(Person(name: "Rose Tyler", imageName: "rose-tyler"))
    crewMembers.append(Person(name: "Sarah Connor", imageName: "sarah-connor"))
    crewMembers.append(Person(name: "Starbuck", imageName: "starbuck"))
    crewMembers.append(Person(name: "River Tam", imageName: "river-tam"))
    crewMembers.append(Person(name: "Sarah Jane", imageName: "sarah-jane"))
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Crew Members"
    
    navigationItem.rightBarButtonItem = editButtonItem
    
    let flowLayout = ReorderableFlowLayout()

    flowLayout.sectionInset = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0)
    flowLayout.minimumInteritemSpacing = 20.0
    flowLayout.minimumLineSpacing = 20.0
    flowLayout.itemSize = CGSize(width: 85.0, height: 100.0)

    collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    collectionView.dataSource = self

    longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(CrewViewController.longPressed(_:))) // this
    collectionView.addGestureRecognizer(longPressGR)
    longPressGR.minimumPressDuration = 0.3

    collectionView.alwaysBounceVertical = true
    collectionView.backgroundColor = UIColor(rgba: "#4681A0")
    collectionView.register(PersonCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "PersonCollectionViewCell")

    view.addSubview(collectionView)

    for VFL in ["|[collectionView]|", "V:|[collectionView]|"] {
      view.addConstraints(
        NSLayoutConstraint.constraints(
          withVisualFormat: VFL,
          options: NSLayoutFormatOptions(rawValue: 0),
          metrics: nil,
          views: [ "collectionView" : collectionView ]
        )
      )
    }
  }
  
  func pickedUpCell() -> PersonCollectionViewCell? {
    guard let indexPath = movingIndexPath else { return nil }

    return collectionView.cellForItem(at: indexPath) as? PersonCollectionViewCell
  }

  func animatePickingUpCell(_ cell: PersonCollectionViewCell?) {
    UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .beginFromCurrentState], animations: { () -> Void in
      cell?.alpha = 0.7
      cell?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    }, completion: { finished in
        
    })
  }
  
  func animatePuttingDownCell(_ cell: PersonCollectionViewCell?) {
    UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .beginFromCurrentState], animations: { () -> Void in
      cell?.alpha = 1.0
      cell?.transform = CGAffineTransform.identity
    }, completion: { finished in
      cell?.startWiggling()
    })
  }

  func longPressed(_ gesture: UILongPressGestureRecognizer) {
    let location = gesture.location(in: collectionView)
    movingIndexPath = collectionView.indexPathForItem(at: location)

    if gesture.state == .began {
      guard let indexPath = movingIndexPath else { return }

      setEditing(true, animated: true)
      collectionView.beginInteractiveMovementForItem(at: indexPath)
      pickedUpCell()?.stopWiggling()
      animatePickingUpCell(pickedUpCell())
    } else if(gesture.state == .changed) {
      collectionView.updateInteractiveMovementTargetPosition(location)
    } else {
      gesture.state == .ended
        ? collectionView.endInteractiveMovement()
        : collectionView.cancelInteractiveMovement()

      animatePuttingDownCell(pickedUpCell())
      movingIndexPath = nil
    }
  }

  func startWigglingAllVisibleCells() {
    let cells = collectionView?.visibleCells as! [PersonCollectionViewCell]
    
    for cell in cells {
      if isEditing { cell.startWiggling() } else { cell.stopWiggling() }
    }
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: true)

    startWigglingAllVisibleCells()
  }

  override var preferredStatusBarStyle : UIStatusBarStyle {
    return .lightContent
  }
}

extension CrewViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return crewMembers.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCollectionViewCell", for: indexPath) as! PersonCollectionViewCell

    let person = crewMembers[indexPath.item]

    cell.configureForPerson(person, index: indexPath.item)

    if isEditing {
      cell.startWiggling()
    } else {
      cell.stopWiggling()
    }

    if indexPath == movingIndexPath {
      cell.alpha = 0.7
      cell.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    } else {
      cell.alpha = 1.0
      cell.transform = CGAffineTransform.identity
    }

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, moveItemAt source: IndexPath, to destination: IndexPath) {
    crewMembers.insert(crewMembers.remove(at: source.item), at: destination.item)
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {    
    UINavigationBar.appearance().isOpaque = true
    UINavigationBar.appearance().barTintColor = UIColor(rgba: "#4681A0")
    UINavigationBar.appearance().tintColor = UIColor.white

    UINavigationBar.appearance().titleTextAttributes = [
      NSFontAttributeName : UIFont(name: "SourceSansPro-Semibold", size: 17.0)!,
      NSForegroundColorAttributeName : UIColor.white
    ]

    UIBarButtonItem.appearance().setTitleTextAttributes([
      NSFontAttributeName : UIFont(name: "SourceSansPro-Semibold", size: 15.0)!,
      NSForegroundColorAttributeName : UIColor.white
    ], for: UIControlState())
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    // Override point for customization after application launch.
    self.window!.backgroundColor = UIColor.white
    self.window!.makeKeyAndVisible()

    let crewVC = CrewViewController()

    self.window?.rootViewController = UINavigationController(rootViewController: crewVC)
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
}

