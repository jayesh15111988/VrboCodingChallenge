#  Goal 
Goal of this project was to consume the data returned by Seat Geek API search API, display it in the appropriate scroll view subclass and allow users to view more details on it

# Deliverables
The completed project contains the following functionalities
1. Ability to search by specific event name
2. Displaying the available events matching the search string in the table view
3. Support for showing more event details on the next page

# Xcode version used
I used Xcode 11.1 (11A1027) to write and run the application 

# Running the app
App uses a single third-party dependency through Cocoapods. However, the dependency is included as a part of project bundle and there is no need to run `pod install` again. Project should be good to build and run once it's extracted from the attached zip file

# Extras and Optionals
The app allows users to favorite certain events. However, this is a limited feature. 

1. Users can only favorite items in the given list of fixed search term
2. If the user enters another search keyword or clears the list, favorited are lost
3. If an item is favorited on the list page, the favorite status is carried on to the details page
4. This is an in-memory operation. If the app restarts, favorited will be lost

# Architecture
I used MVVM (Model-View-ViewModel) software architecture to design this project. 
1. View - Used to display user-visible elements. Mostly dumb part of the architecture. All the information is pulled from the view model
2. Model - The object models received from the network (Conforming to Decodable protocol). This is a raw data and view model is responsible for converting it into user displayable format
3. ViewModel - The real brain of application. It applies the business logic and data transformations needed to convert raw models into view models which make more sense when displayed on the screen

# Third-party libraries
I am using only one third-party library called  `PINRemoteImage`. This is a framework for downloading images from the server and assign them to image views. It's a lightweight, easy to use and well-maintained

# Third-party images
I am using a few icons from third-party sources too. They include icons for displaying favorite/unfavorite items as well as generic placeholder images

# Testing
The app is designed with unit testing in mind. I tried to make sure ViewModel - Which houses the brain of the application and applying viewModel to view operation are well tested.

For the part which is not tested could either be UI tested or mocked (For example, network utility which in unit tests is mocked)

# Future work
Some part has been left unimplemented in the interest of time. However, they can definitely be implemented in the future as an extension to current work

1. Better architecture for favoriting events
2. Persisting favorited between successive launches
3. Scroll view support on details page in case we want to display additional information other than just location and date and time of the event

### API Errors
The app is designed to handle and display appropriate error messages to the user if something goes wrong. The error logic handles following cases,

1. Invalid URL
3. Malformed content

If any of the above-mentioned errors occur, an appropriate error message is displayed to the user.

### Device and Orientation support
For starter, the app only supports iPhone - both portrait and landscape orientations. In the future, given the designs, we can also extend the current implementation to support iPad devices 
