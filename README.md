### Quiz Master - Flutter Quiz App

A gamified quiz application built with Flutter, offering an engaging learning experience through interactive quizzes and rewards.

---

### Features

- **📱 Clean, Intuitive Interface**: Material Design 3 for a modern user experience.
- **🎮 Gamification Elements**: Points, coins, and achievements to motivate users.
- **📊 Progress Tracking**: View your stats and performance over time.
- **🌟 Animated Feedback**: Smooth transitions and engaging animations.
- **💾 Local Progress Persistence**: Save and resume your progress anytime.
- **⚡ Real-Time Score Updates**: Stay updated with your performance instantly.
- **🏆 High Score Tracking**: Challenge yourself to beat your best scores.
- **📱 Responsive Design**: Optimized for all screen sizes and orientations.

---

### Screenshots

[https://drive.google.com/drive/folders/1mg7oP9yYY2OWALTMBjMP_LQxwHuHO0wF]

---

### Video Demo

[https://drive.google.com/file/d/1ltWlUnH-45epXiKLoUrLUbIm4ANfwF5M/view?usp=drivesdk]

---

### Apk

[https://drive.google.com/file/d/1mJ1cWjlKoMtDbB2vrAjfWy-NLuk93Pfm/view?usp=drivesdk]

---

### Technical Implementation

- **State Management**: Powered by Flutter Bloc for predictable and scalable state management.
- **API Integration**: REST API integration with robust error handling.
- **Local Storage**: Utilizes `SharedPreferences` for saving progress locally.
- **UI Framework**: Built using the Material 3 design system for a sleek and modern look.
- **Animations**: Includes custom animations for an immersive user experience.

---

### Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone [https://github.com/Shavukarusasikumar/QuizApp.git]
   ```

2. **Flutter Version**:
   ```bash
   3.24.3
   ```
3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run the App**:
   ```bash
   flutter run
   ```

---

### Project Structure

```plaintext
lib/
├── blocs/         # Business Logic Components
├── models/        # Data Models
├── repositories/  # Data Layer
├── services/      # Services Layer
├── View/          # UI Screens
└── main.dart      # App Entry Point
```

---

### Dependencies

- `flutter_bloc: ^8.1.3`
- `http: ^1.1.0`
- `shared_preferences: ^2.2.2`
- `google_fonts: ^6.1.0`

---

### API Integration

The app fetches quiz data from a REST API endpoint:  
**URL**: `https://api.jsonserve.com/Uw5CrX`

---

### Contributing

Contributions are welcome! Feel free to submit issues or enhancement requests.