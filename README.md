# Stanford-CS139p

My [Stanford CS193p](https://cs193p.sites.stanford.edu) iPhone Application Development ([Winter 2017](https://itunes.apple.com/us/course/developing-ios-11-apps-with-swift/id1309275316)) assignments solutions.

## Concentration

The goal of this assignment is to recreate the *Concentration* game demonstration given in lecture and then make some small enhancements.

<p align="center">
    <img width="200px" src="Screenshots/concentration-portrait.png" alt="concentration-portrait"/>
    <img height="200px" src="Screenshots/concentration-landscape.png" alt="concentration-landscape"/>
</p>

### Things to learn

- Swift
- MVC
- ```UIViewController``` subclass
- ```UILabel``` and ```UIButton```
- Target/Action (```@IBAction```)
- Outlets (```@IBOutlet```) and Outlet Collections functions and properties (instance variables) ```let``` versus ```var```
- ```didSet```
- ```for in``` (and ```..<CountableRange``` syntax)
- ```Array<Element>``` and ```Dictionary<Key, Value>```
- ```[Element]``` and ```[Key: Value]``` syntax
- Initialization of struct and class
- ```viewDidLoad```
- Optionals (including implicitly-unwrapped Optionals)
- ```??``` optional defaulting operator
- ```// TODO```
- ```arc4random()```
- Type conversion (e.g. from ```UInt``` to ```Int```)
- ```StackView``` and (simple) Autolayout

## Set V1

The goal of this assignment is to implement a game of solo (i.e. one player) [Set](https://en.wikipedia.org/wiki/Set_(card_game)) completely from scratch by myself.

<p align="center">
    <img width="200px" src="Screenshots/setv1-portrait.png" alt="setv1-portrait"/>
    <img height="200px" src="Screenshots/setv1-landscape.png" alt="setv1-landscape"/>
</p>

### Things to learn

- All the things from Assignment 1, but from scratch this time. 
- Closures
- ```extension```
- Using ```struct``` to declare constants
- ```Equatable```
- ```enum```

## Set V2 (Custom Views and Multiplayer)

The goal of this assignment is to gain the experience of building my own custom view, including handling custom multitouch gestures.
Starting with the code of Set V1.

<p align="center">
    <img width="200px" src="Screenshots/setv2-portrait-initial.png" alt="setv2-portrait-initial"/>
    <img height="200px" src="Screenshots/setv2-portrait-1p.png" alt="setv2-portrait-1p"/>
    <img height="200px" src="Screenshots/setv2-landscape-2p.png" alt="setv2-landscape-2p"/>
</p>

### Things to learn

- Creating a custom ```UIView``` with a ```draw(CGRect)``` method
- Gestures
- Understanding the ```UIView``` hierarchy
- Creating ```UIView```s in code (rather than in Interface Builder)
- Drawing with Core Graphics and ```UIBezierPath```