# NovVoyage - A Traveling Booking App 

A modern, smooth, and fully functional **Travel Booking App** built with **Flutter**.  
Users can explore trips, customize itineraries, add traveler details, and confirm bookings with a polished UI and smooth animations.

---

## Features

- Explore curated travel packages with beautiful images
- Customize itineraries for each package
- Add multiple travelers with validation for name & age
- Review and confirm bookings before submission
- Booking confirmation screen with smooth animations
- State management using **Flutter BLoC**
- Modern UI with cards, gradients, and responsive design
- Supports dynamic online images for packages

---

## Screenshots

### Explore Trips
![Explore Trips](screenshots/explore_trips.png)

### Customize Itinerary
![Customize Itinerary](screenshots/customize_itinerary.png)

### Traveler Details
![Traveler Details](screenshots/traveler_details.png)

### Review & Confirm
![Review & Confirm](screenshots/review_confirm.png)

### Booking Success
![Booking Success](screenshots/booking_success.png)

## Getting Started

### Prerequisites

- Flutter SDK >= 3.0  
- Android Studio or VS Code with Flutter plugin installed  
- Internet connection (to load package images)

---

### Installation

1. Clone the repository:

```bash
git clone <https://github.com/InsaneCoder789/NavVoyage>
```

2. Install dependencies:

```flutter pub get```

3. Run the app:

```flutter run```

- Folder Structure

```
lib/
 ├── blocs/           # BLoC files for state management
 │    ├── booking_bloc.dart
 │    ├── booking_event.dart
 │    └── booking_state.dart
 ├── models/          # Data models (Package, Traveler)
 │    └── package_model.dart
 ├── screens/         # All UI screens
 │    ├── select_package_screen.dart
 │    ├── customize_itinerary_screen.dart
 │    ├── traveler_details_screen.dart
 │    ├── review_confirm_screen.dart
 │    └── booking_success_screen.dart
 ├── theme/           # App theme & colors
 │    └── app_theme.dart
 └── main.dart        # Entry point`
 ```

- Dependencies

1. flutter_bloc – For state management

2. bloc – Core BLoC functionality

3. flutter/material.dart – Flutter UI components

4. flutter/cupertino.dart – Optional, for iOS-styled widgets

- All images are loaded online using NetworkImage

## How It Works

- Select a Package – Users can browse travel packages and see package details.

- Customize Itinerary – Modify or add activities for the selected package.

- Traveler Details – Add traveler names and ages with validation.

- Review & Confirm – Check summary of the package, itinerary, and travelers.

- Booking Success – Confirm booking with an animated success screen.

## Notes

Currently uses mock data for travel packages. Easy to replace with API calls.

UI is fully responsive, using modern Flutter widgets and smooth animations.

The app is structured for scalability and clean architecture.
