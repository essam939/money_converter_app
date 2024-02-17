# Flutter Currency App README

## Project Building Instructions

To build the project, follow these steps:

1. Clone the repository to your local machine.
2. Make sure you have Flutter installed. If not, follow the instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install).
3. Navigate to the project directory using the command line.
4. Run `flutter pub get` to install dependencies.
5. Connect a device or start an emulator.
6. Run `flutter run` to build and launch the app on your device/emulator.

## Adapted Design Pattern: MVVM

For the app architecture, we've chosen the Model-View-ViewModel (MVVM) design pattern. This pattern separates the UI logic from the business logic, providing a more organized and maintainable codebase. Here's why we chose MVVM:

- **Separation of Concerns:** MVVM separates the presentation layer (View) from the business logic (ViewModel) and the data (Model), making it easier to manage and test each component independently.
- **Reusability:** With MVVM, Views and ViewModels are decoupled, allowing for easier reuse of ViewModels across different Views.
- **Support for Testing:** MVVM facilitates unit testing since ViewModel, which contains the application's logic, can be tested independently of the UI.

## Adapted Image Loader Library: CachedNetworkImage

We've opted for the CachedNetworkImage library for loading images in the app. Here's why:

- **Caching:** CachedNetworkImage automatically caches images locally, improving performance and reducing bandwidth consumption by loading images from the cache when possible.
- **Error Handling:** It provides built-in error handling, allowing graceful degradation when an image fails to load.
- **Ease of Use:** CachedNetworkImage is easy to integrate into Flutter apps and requires minimal setup.

## Used Database: SQFlite

For database management in the app, we've chosen SQFlite, which is a lightweight, simple, and efficient SQLite plugin for Flutter. Here's why:

- **Native Integration:** SQFlite offers native SQLite database support for Flutter, providing efficient and reliable data storage.
- **Asynchronous Operations:** It supports asynchronous database operations, ensuring smooth performance even when dealing with large datasets or complex queries.
- **Community Support:** SQFlite is widely used in the Flutter community, ensuring ample resources and support for troubleshooting and development.
