# Cat Card App

The Cat Card App is a Flutter application that allows users to explore different cat breeds and view detailed information about each breed. It utilizes the Cat API to fetch data and images of cat breeds.

## Files

The project includes the following files:

- `cat_card_detail.dart`: This file contains the `CatCardDetail` widget, which represents the detailed view of a cat breed. It displays the cat's name, image, description, adaptability, affection level, and other characteristics. It also includes a progress bar to visualize the characteristics and additional information such as temperament and life span.

- `main.dart`: This is the entry point of the application. It contains the main function that runs the app and the `CatCardApp` widget, which sets up the app's structure and navigation.

- `cat_card.dart`: This file includes the `CatCard` widget, which represents a card displaying basic information about a cat breed. It includes the cat's name and image. This widget is used to display the cat cards in the main view.

- `api_service.dart`: This file contains the functions responsible for making API requests to the Cat API. It includes two functions: `fetchBreeds` and `fetchBreedsImages`. The `fetchBreeds` function fetches the list of cat breeds, while `fetchBreedsImages` retrieves the image URL for a specific cat breed.

- `pubspec.yaml`: This file defines the project's dependencies and configurations. It includes the necessary dependencies for Flutter, HTTP requests, and JSON encoding/decoding.

## Getting Started

To run the Cat Card App locally and explore the cat breeds, follow these steps:

1. Clone the repository: `git clone https://github.com/your-username/cat-card-app.git`
2. Navigate to the project directory: `cd cat-card-app`
3. Install the dependencies: `flutter pub get`
4. Run the app on an emulator or connected device: `flutter run`

## Dependencies

The Cat Card App relies on the following dependencies:

- `flutter/material.dart`: The core Flutter framework for building UI components.
- `percent_indicator/linear_percent_indicator.dart`: A Flutter library for displaying linear progress indicators.
- `http/http.dart`: A package for making HTTP requests.
- `dart:convert`: A package for encoding and decoding JSON data.

For detailed information about all the dependencies used in the app, refer to the `pubspec.yaml` file.

## API Integration

The Cat Card App integrates with the Cat API to fetch data and images of cat breeds. It uses the following API endpoints:

- `GET /v1/breeds`: Retrieves the list of cat breeds.
- `GET /v1/images/{id}`: Retrieves the image URL for a specific cat breed.

To make API requests, an API key is required. Ensure that you have a valid API key from the Cat API and update the `x-api-key` header in the code with your key.


## Contact

For any questions, feedback, or inquiries, please

 contact [farith.comas@gmail.com].

Happy exploring cat breeds with the Cat Card App!