# Flutter E-Commerce Frontend

This is a Flutter-based frontend for the Django eCommerce backend. It provides a seamless shopping experience with authentication, product browsing, cart management, and checkout.

## Features
- User authentication (JWT-based login/register)
- Product listing and search
- Product details page
- Shopping cart and checkout
- Order history
- Profile management
- Dark mode support

## Tech Stack
- **Frontend**: Flutter
- **State Management**: Provider / Riverpod / Bloc (choose one)
- **Networking**: Dio / HTTP package
- **Local Storage**: SharedPreferences / Hive
- **Backend**: Django REST API
- **Deployment**: Google Play Store, App Store

## Setup Instructions

### Prerequisites
- Flutter SDK installed
- Android Studio or Xcode (for iOS)
- Django backend running

### Clone the Repository
```sh
git clone https://github.com/your-repo/flutter-ecommerce.git
cd flutter-ecommerce
```

### Environment Configuration
Create a `.env` file or configure the `config.dart` file:
```dart
const String BASE_URL = "https://your-backend-api.com/api";
```

### Install Dependencies
```sh
flutter pub get
```

### Run the App
```sh
flutter run
```

### API Integration
Modify `services/api_service.dart`:
```dart
import 'package:dio/dio.dart';

class ApiService {
  static final Dio _dio = Dio(BaseOptions(baseUrl: BASE_URL));
  
  static Future<Response> getProducts() async {
    return await _dio.get("/products");
  }
}
```

### Build & Release
#### Android
```sh
flutter build apk
```
#### iOS
```sh
flutter build ios
```

## Contributing
1. Fork the repository
2. Create a feature branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -m "Add feature"`)
4. Push to the branch (`git push origin feature-branch`)
5. Open a Pull Request

## License
This project is licensed under the MIT License.
