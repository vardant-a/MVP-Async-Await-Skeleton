# MVP project for request

The simple MVP project (utilizing SOLID principles) is based on using UITableView to display data. It incorporates two custom cells to provide visual diversity in presenting the data. When there is no data available, a Skeleton Cell is shown instead of empty cells, creating a placeholder effect. After an asynchronous data request implemented using async/await, the information is displayed in the table, providing a more comprehensive data representation for the user.

##
### UITableView

A standard UIKit component for displaying data with pagination (loading additional content while scrolling) and pull-to-refresh functionality added.

##
### UITableViewCell

Custom cells have been implemented:
- ComicCell - a cell for displaying content retrieved from the network. In the scope of the test project, it utilized 2 UILabels, with one cell responsible for content display.
- SkeletonCell - a placeholder cell shown when the user has not yet received data from the network.

## 
### Skeleton

Addition to UIView (applicable to all elements). 
AddSkeletonLayer, the method creates an animated layer applied to an element, is used to create mock objects that have not received content to display.

## 
### Networking operations

The async/await method is implemented to obtain data using the [MARVEL API](https://developer.marvel.com), the request consists of the main part, as well as the hash part (the encrypted part of the request using time, public key, private key), the MD5. NetworkMonitor encryption method to monitor the user's network status, at the time of the request to the server, in the absence of access to the network, the user will receive a notification.

