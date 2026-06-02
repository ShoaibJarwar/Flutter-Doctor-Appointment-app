# 🏥 Doctor Appointment App

A Flutter-based Doctor Appointment Management System that allows users to register, log in, browse doctors, book appointments, and view their appointment history. The application uses SQLite for local data storage and SharedPreferences for session management.

## 🚀 Features

### 🔐 User Authentication
- User Registration (Signup)
- User Login
- SQLite-based user storage
- Persistent login sessions using SharedPreferences

### 👨‍⚕️ Doctor Management
- Browse available doctors
- View doctor details
- Display specialization, experience, and ratings

### 📅 Appointment Booking
- Select a doctor
- Choose appointment date
- Choose appointment time
- Save appointments in SQLite

### 📖 Appointment History
- View all appointments for the logged-in user
- Retrieve appointment records from SQLite

### 💾 Local Storage
- SQLite Database
- SharedPreferences for session persistence

---

## 📱 Screens

- Login Screen
- Signup Screen
- Doctor List Screen
- Doctor Profile Screen
- Book Appointment Screen
- Appointment History Screen

---

## 🏗️ Project Structure

```plaintext
lib/
│
├── models/
│   ├── user_model.dart
│   ├── doctor_model.dart
│   └── appointment_model.dart
│
├── screens/
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── doctor_list_screen.dart
│   ├── doctor_profile_screen.dart
│   ├── book_appointment_screen.dart
│   └── appointment_history_screen.dart
│
├── services/
│   ├── database/
│   │   └── db_helper.dart
│   │
│   ├── doctor_service.dart
│   └── session_service.dart
│
├── routes/
│   └── app_routes.dart
│
└── main.dart
```

---

## 🗄️ Database Schema

### Users Table

| Column | Type |
|----------|----------|
| id | INTEGER PRIMARY KEY AUTOINCREMENT |
| name | TEXT NOT NULL |
| email | TEXT UNIQUE NOT NULL |
| password | TEXT NOT NULL |

### Appointments Table

| Column | Type |
|----------|----------|
| id | INTEGER PRIMARY KEY AUTOINCREMENT |
| userId | INTEGER NOT NULL |
| doctorId | INTEGER NOT NULL |
| date | TEXT NOT NULL |
| time | TEXT NOT NULL |

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.4.2
  path: ^1.9.1
  shared_preferences: ^2.5.3
```

---

## ⚙️ Installation

### Clone Repository

```bash
git clone https://github.com/ShoaibJarwar/Flutter-Doctor-Appointment-app
```

### Navigate to Project

```bash
cd doctor-appointment-app
```

### Install Dependencies

```bash
flutter pub get
```

### Run Application

```bash
flutter run
```

---

## 🎯 Learning Objectives

This project demonstrates:

- Flutter Navigation & Routing
- SQLite CRUD Operations
- SharedPreferences Session Management
- Stateful & Stateless Widgets
- Form Validation
- Local Database Design
- Model-Based Architecture

---

## 🚀 Future Improvements

- Store doctors in SQLite
- Search doctors by specialization
- Prevent duplicate bookings
- Appointment cancellation
- Push notifications
- Firebase Authentication
- REST API integration
- Dark Mode

---

## 🛠️ Built With

- Flutter
- Dart
- SQLite (sqflite)
- SharedPreferences

---

## 👨‍💻 Author

**Shoaib Akhter**

BS Information Technology Student  
Flutter & Web Development Enthusiast

---

## 📄 License

This project is licensed under the MIT License.