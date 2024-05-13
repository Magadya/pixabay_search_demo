# pixabay_search_demo

This is a **Pixabay Search Images**  applications for searching the images.

- **flutter_bloc** - we use it for the state management across the app

- Android Studio **4.1.0** or higher, or VSCode of any version
- XCode **13.4.0** or higher
- Gradle **7.0.3**
- Flutter **3.19.5**
- Dart **>=3.0.0 <4.0.0**

Here is the folder structure we have been using in this project

> lib/
> |- modules/
> |- networking/
> |- resources/
> |- main.dart

Now, let's dive into the lib folder which has the main code for the application.


modules - contains application modules that include flows/features
networking - contains the network layer of application
resources - this directory contains the constants for `theme`, `api endpoints`, `preferences` and etc.
main - this is the starting point of the application, contains main app widget and an initial setup of the app


## FAQ

1. If you have issues running the app or installing the packages, run:

```bash
flutter pub cache repair
flutter clean
flutter pub get
cd ios
rm -rf Podfile.lock Pods/ .symlinks Flutter/Flutter.podspec
pod install
pod repo update