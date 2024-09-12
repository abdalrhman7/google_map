# Google Map with Bloc State Management and Clean Architecture

This is a Flutter application integrating Google Maps with various features like location search, drawing routes, and displaying travel distance and time. The app also shows the weather based on the user's current location and includes address management using Shared Preferences. The project is developed using Clean Architecture principles and Bloc for state management, with Dio and Retrofit used for API communication.

## Features 🎯
- **Search Location (Egypt):** Users can search for any location within Egypt on the map.
- **Draw Route:** Draws a line between the user's current location and the searched location.
- **Display Distance and Time:** Shows the distance and estimated time to reach the searched location.
- **Weather Information:** Displays the current temperature based on the user's current location.
- **Manage Addresses:** Users can manage and store addresses locally using `SharedPreferences`.
- **Connectivity Check:** Uses `connectivity_plus` to notify users when the internet connection is lost.

## API Integration

- **Dio & Retrofit:**
  - Used for network requests, providing an easy and efficient way to interact with APIs.
  
- **Google Maps API:**
  - Handles map-related features like location search, route drawing, and distance calculation.

## Bloc for State Management

Bloc is used for managing the state across the application, ensuring efficient handling of the application’s business logic and UI interaction.

## Connectivity Handling

The app uses `connectivity_plus` to detect and alert users when there is no internet connection, ensuring users are informed of any network issues.
