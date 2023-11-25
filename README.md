# SwiftUIAppTemplate

## Layers
* **Domain Layer** = Entities + Use Cases + Repositories Interfaces
* **Data Repositories Layer** = Repositories Implementations + APIEndpoint + Persistence DB
* **Presentation Layer (MVVM)** = ViewModels + Views
 
## Includes
* SwiftUI
* Pagination
* Unit Tests (not yet)
* UI Tests (not yet)

## Infrastructure
Infrastructure contains networking interface and default network service using Alamofire. You can create your own network service.

## How to use app
The network will request the animal api. If getting successful responses, they will be stored persistently.

## Requirements
* Xcode Version 15.0+  Swift 5.0+
