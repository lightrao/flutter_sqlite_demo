# Flutter SQLite Demo

A demonstration Flutter application showcasing SQLite database integration for user management.

## Overview

This project is a simple Flutter application that demonstrates how to implement local database functionality using SQLite in Flutter. It showcases basic CRUD (Create, Read, Update, Delete) operations through a user management interface.

## Features

- SQLite database integration with Flutter
- Singleton pattern for database connection management
- User data model with database mapping
- Display list of users from SQLite database
- Database initialization with sample data
- Implementations for Create, Read, Update, and Delete operations

## Screenshots

*[Add screenshots of your application here]*

## Requirements

- Flutter SDK (latest stable version recommended)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android/iOS emulator or physical device

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/flutter_sqlite_demo.git
   ```

2. Navigate to the project directory:
   ```
   cd flutter_sqlite_demo
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

4. Run the application:
   ```
   flutter run
   ```

## Project Structure

- `lib/main.dart` - Entry point of the application with UI implementation
- `lib/database_helper.dart` - SQLite database management implementation
- `lib/user.dart` - User model class with data mapping methods

## How It Works

The application demonstrates a simple user management system:

1. When the app starts, it initializes a SQLite database and creates a user table if it doesn't exist
2. Sample user data is loaded into the database
3. The main screen displays a list of all users from the database
4. The database helper includes implementations for:
   - Creating new users
   - Reading user data
   - Updating existing users
   - Deleting users

## Dependencies

The project uses the following key dependencies:

- `sqflite`: For SQLite database operations
- `path`: For managing database file paths

## License

[Your License Information]

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
