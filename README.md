## Trending GitHub Repositories App

This Flutter app displays the most trending GitHub repositories created in the last day, week, or month. The user can filter the list by timeframe, view repository details, and add repositories to their favorites for offline access.

## Architecture

The app follows the MVVM (Model-View-ViewModel) pattern for separation of concerns and easier testing. The app state is managed using Provider, which allows for a clean and scalable way to handle state changes and dependency injection. The application is divided into the following layers:

- **View:** Flutter widgets that display the UI.
- **ViewModel:** Handles the business logic and interacts with the model to get data.
- **Model:** Data handling and API interaction logic.

Navigation between screens is handled using Flutter's Navigator class with named routes.

## Technical Choices

- **HTTP Package:** Used for making REST API requests to GitHub's API to retrieve trending repositories.
- **Cached Network Image:** This package was chosen to handle caching of avatar images to optimize network usage and performance.
- **Infinite Scrolling:** Implemented by detecting when the user reaches the end of the list and loading more repositories from the API.

## Features

- Display trending repositories filtered by timeframe (day, week, month).
- Infinite scrolling for large datasets.
- Repository details page with additional information.
- Caching of avatar images to reduce network calls.
- Favorite repositories stored locally for offline access.
- User-friendly UI that works on both Android and iOS devices.

- ## Future Improvements
- **Search Functionality:** While the app allows filtering by timeframes, implementing a search function across all repositories could provide a better user experience.
- **Offline Support:** Although favorites can be accessed offline, adding more comprehensive offline support (e.g., caching the entire repository list) would improve the app's usability without an internet connection.
- **Testing:** I would add unit and widget tests to ensure the stability and reliability of the app.
