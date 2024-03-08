# Final Year Project
![FoodEye Poster](FoodEye-Poster.pg)

# Features
- User Login/Logout and Register
- Home Page/Item Listings
- Pages for CRUD Functionalities
- Sorting Functionality
- Barcode Scanner
- Image-to-Text Recognition
- Categorized Item Viewing
- Push Notification

# Technologies Used
- Flutter framework with Dart on VS Code
- AVD Manager for mobile device emulation
- Google ML Kit for text recognition
- pub.dev for all libraries/dependencies

# Check Out The Project
[Simple Presentation on FoodEye](FoodEye-Slides.pdf)

# Getting Started
### Flutter SDK
- Installation guides [from the official website](https://docs.flutter.dev/get-started/install)
### Android Emulator
- Install Android Virtual Device Manager and create a emulated mobile device (API 33) ([full guide here](https://developer.android.com/studio/run/managing-avds))
### Running the project
Due to the project being local deployment, the API calls from frontend are IP reliant. This means that for the code to work, the [ASP.NET Core Web API project](https://github.com/BlueSky0322/food-eye-backend) must be hosted locally but can be accessed remotely, and the hard-coded IP Address in Flutter code must be changed depending on which IP address the backend is hosted on. 

Therefore, two things must be done: 
1. Deploy ASP .NET Core Web API project locally but with remote access using [Conveyor](https://marketplace.visualstudio.com/items?itemName=vs-publisher-1448185.ConveyorbyKeyoti2022).
2. Edit the IP address from Flutter project.
>[!NOTE]
>For setting up Conveyor with backend, check out the ASP.NET Core Web API project in [food-eye-backend](https://github.com/BlueSky0322/food-eye-backend)

#### APK installation for mobile device
1. Clone the repo:
```
git clone repo-web-url/ssh-key
```
2. Find the `http_overrides` folder and change `usbDebugURL` variable to the URL retrieved from Conveyor.
3. Recompile the code as an apk, in terminal:
  - ```
    flutter clean
    ```
  - ```
    flutter pub get
    ```
  - ```
    flutter build apk --split-per-abi
    ```
4. Access the apk file in root folder at `build > app > outputs > flutter-apk > app-arm64-v8a-release.apk`
> [!NOTE]
> For more details on building and releasing applications on Flutter, refer to the official guide on [Deployment](https://docs.flutter.dev/deployment).
5. Upload the apk in OneDrive/Google Drive, then download the reinstall the application on your device. The application should be working now.

#### Running on Android Emulator
