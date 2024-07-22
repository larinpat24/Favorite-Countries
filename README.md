# Favorite-Countries

Love to travel? Well the handy Favorites-Countries App has you covered. Favorite countries and make notes so that you can keep your travel dream list all in one place and make it a REALITY!

If you think that's great, be sure to stick around, future updates will delight [Check out Future Section for more!)

Safe and Happy Travels ✈️🧳🌎~

---

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Key Requirements](#key-requirements)
4. [Installation](#installation)
5. [Usage](#usage)
6. [Screenshots](#screenshots)
7. [Testing](#testing)
8. [Technologies](#technologies)
9. [Architecture](#architecture)
10. [Design Choices](#design-choices)
11. [Future](#future)
12. [Contact](#contact)

---

## Introduction

The purpose of this favorite country tracker, is to allow users to create and manage their own list of their favorite countries, with the goal of inspiring and motivating them to chase their travel dreams.

```markdown
Simple iOS project, designed to showcase my skills in Swift and iOS development.
```

## Features
There are three core scenes in this application, and the main goals are to allow users to manage their own Favorite's list (Home Scene), search for new Countries to add to favorites (Search Country Scene), create favorites countries(Country Details Scene), and see their data persist through app launches. Data must also flow scene to scene seamlessly. 

- Home Scene
- Search Country Scene
- Country Details Scene

## Key Requirements
1. Home scene
   - Displays a scrollable list of the user’s favorite countries
   - Includes an “Add Country” button, which launches a sequence of modal scenes for adding new favorites countries to the list. Tapping on + leads to 2.
   - Contents of the list should persist between sessions on the app*

2. Search Country Scene
   - Searchable list of countries
   - Consume API: ```
https://api.worldbank.org/v2/countries?format=json ```
   - Note: Must Filter out non countries, such as regions
   - Tapping on an item leads to 3.
  
 3. Country Details Scene
   - Includes a textbox to allow the user to enter text about their favorite things about the country
   - Add Button, dismisses 2. and 3. and pops to the root view (Home Scene), and creates a new "FavoriteCountry" item in the user's favorite countries list

## Installation
1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/your-repo-name.git
    ```

2. Navigate to the project directory:
    ```sh
    cd Favorite-Countries
    ```

3. Open the project in Xcode:
    ```sh
    open Favorite Countries.xcworkspace
    ```

4. Install dependencies (if any):
    ```sh
    # CocoaPods
    Ex:pod install
    # Swift Package Manager
    Ex: swift package resolve
    ```

5. Build and run the project in Xcode.

## Usage
![TakeHomeFavoriteCountriesDemo](https://github.com/larinpat24/Favorite-Countries/assets/39777051/bd772948-9346-49f0-966f-2f82854f022d)

## Screenshots
App Icon: 

![Screenshot 2024-07-04 at 1 00 50 PM](https://github.com/larinpat24/Favorite-Countries/assets/39777051/51eae78f-b1cf-452b-bf73-a3be43338a0e)

Launch Screen:

![Screenshot 2024-07-04 at 1 01 33 PM](https://github.com/larinpat24/Favorite-Countries/assets/39777051/89a8ae63-32b1-43db-965d-cdd8baab0755)

Home Scene [Empty View]

![Screenshot 2024-07-04 at 1 01 58 PM](https://github.com/larinpat24/Favorite-Countries/assets/39777051/fcb28dd6-9b65-4bee-91af-3a92ef77a6c2)

Home Scene (Favorite Countries List View)

![Screenshot 2024-07-04 at 1 03 01 PM](https://github.com/larinpat24/Favorite-Countries/assets/39777051/9866df69-e49f-4ada-8e60-9d75963fa478)

Search Country Scene

![Screenshot 2024-07-04 at 1 02 37 PM](https://github.com/larinpat24/Favorite-Countries/assets/39777051/934dafb3-7431-4524-9650-22f7128121f3)

Countries Details Scene

![Screenshot 2024-07-04 at 1 04 00 PM](https://github.com/larinpat24/Favorite-Countries/assets/39777051/14428e6b-cd31-490e-9df1-bede44b651fb)


## Testing
1. Open the project in Xcode.
2. Press `Command+U` to run the tests.
3. Alternatively, you can run the tests from the Xcode menu: `Product` > `Test`.

For this project, some unit tests were written, with the focus being testing the networking layer:
![Screenshot 2024-07-04 at 12 08 51 PM](https://github.com/larinpat24/Favorite-Countries/assets/39777051/73132b8d-9b9d-4d1b-b25d-96089e9c85f0)

Future tests that can be written to expand this include:
1. Unit Tests:
- Test ViewModels,example: ```FavoriteCountryListViewModel```
   - Refactor the ```FavoriteCountryDataBase```, and use Dependency Injection, to test a ```MockFavoriteCountryDataBase```. Can use this mock to test viewModels functions that call the DB, such as ```fetchCountries()``` or ```deleteItems()```
   - Test if the ```favoriteCountries``` is empty, if state reflects correctly (ex, ```showEmptyState``` shoudl be true)
- Test ```FavoriteCountryDataBase``` and make it generic so can use a ```MockFavoriteCountryDataBase```
2. UI Tests
- Test Navigation. Example, a) tapping + button on HomeScene should lead to Country Search Scene, b) tapping on an item in Search Country Scene should present Country Details Scene, c) tapping "Add as Favorite Country" should dismiss all modals and pop the user back to root (Home Scene).
- Test View Elements, Example, a) Home Scene should have a plus button to present Search Country Scene Modally, b) Country Details Scene should have a text field for the user to enter details about their favorite country, c) Search Country Scene should have a search bar for searching countries, d) country items should appear in the list while searching; etc.

## Technologies
- Xcode
- Swift
- SwiftUI
- Cocoapods (SwiftGen)

## Architecture
- This iOS Application is designed using MVVM (Model-View-ViewModel)
   - The Model represents data we get back from the service or our persisted favorited countries.
   - The View is aimed to be agnostic to business logic and be "dummy views" aka just know how to present
   - The ViewModel contains the business logic, such as calling the SwiftData database for capturing persistance for scenarios like deleting favorite countries, adding/creating favorite countries, fetching favorite countries, as well as making the network call, and setting the data model with data from the API call. Since the Views observe their ViewModels, via the new @Obervable macro, once the data changes, SwiftUI re-renders its views accordingly, and there is Swifty State management 😃

Examples:

![Screenshot 2024-07-04 at 12 32 55 PM](https://github.com/larinpat24/Favorite-Countries/assets/39777051/b3480e18-11f6-4524-91d3-cf08e1f32f3d)

## Design Choices
1. **Architecture Pattern:**
    - I chose MVVM vs MV, MVC or another pattern because 1) I am most familar with it from my last job, and 2) It sets code up VERY WELL for Testing later, which is an important part of the SLDC.

2. **Networking:**
    - I used URLSession and async/wait for network requests since 1) Swift Currency is much more better than the old way of using ```completionHandler: @escaping (Result<T, NetworkError>)```, 2) the call site becomes much cleaner, 3) the code is safer, 4) and we can use ```@MainActor```, which handles setting properties that will cause a UI re-render for us on the main thread.

3. **Data Persistence:**
    - I chose SwiftData for data persistence of the ```@FavoriteCountry``` items because I wanted to 1) try a new technology since I have never worked with SwiftData before, and 2) Wanted to challenge myself and implement it using MVVM versus its typical MV implementation using ```@Query```. 2) As a result, I was able to learn how to create the ```FavoriteCountryDataBase```, which can be refactored as well and made more generic and reusable. Most important it keeps the MVVM architecture, and therefore our code remains testable.

4. **UI Framework:**
    - I used SwiftUI for the user interface due to 1) Having the most experience with it, and 2) Apple states it is the future of iOS App Development, and in every WWDC they are making it better and better. There are many benefits to it from State Management (Reactive Programming), Declarative Synatax, Cross-Platform Compatibility, Modern Features (Combine), and more.

5. **Other Choices:**
    - Implemented Pagination so that all the data from the API is not loaded at once, and rather on a as needed basis (more perfomative)
    - Added some Empty States, and Loading States for user feedback
    - Added some Error Handling for user feedback
    - Utilized Cocoapods and SwiftGen because 1) My previous team used it and I saw first hand how easy it can be. 2) It makes the code more type safe and structures. Things are strings for example, can be automatically generated from Localizable.String files, which is very nice, as well as other resources such as Assets (Colors, Images), and more. I also decided to use Cocoapods over Swift Packet Manager because it id 1) Mature and widely used (reliable), integrates well with version control, I have famliarity with it since my previous team used it, and has an extensive library support.

  ## Future
  Some ways this project can be carries on in the future include:
  - Ensuring compatibility (already there, but could be improved) for:
       - Dark Mode 
       - Landscape 
       - Accessibility
       - Screen Sizes (biggest and smallest)
       - iPad
   - Localized Strings, add compatibility with SwiftGen (currently only generated files for Colors and Images)
   - More robust Unit, UI, and Integration Testing
   - Better Performance (more caching)
   - Different Designs

 ## Contact
Created by Niral Patel - niralp@student.fdu.edu

It has been a pleasure working on this project, and I hope you enjoy it~
Feel free to contact me for any questions or suggestions, or just to give feedback!




     




