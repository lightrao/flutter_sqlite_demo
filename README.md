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
- Complete CRUD operations:
  - **Create**: Add new users through a form interface
  - **Read**: View all users in a list with their details
  - **Update**: Edit existing user information
  - **Delete**: Remove individual users or clear all users

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

- `lib/main.dart` - Entry point of the application
- `lib/database_helper.dart` - SQLite database management implementation
- `lib/user.dart` - User model class with data mapping methods
- `lib/screens/` - UI components organized by functionality:
  - `user_list_screen.dart` - Displays the list of users with edit/delete options
  - `add_user_screen.dart` - Form for adding new users
  - `edit_user_screen.dart` - Form for updating existing users

## How It Works

The application demonstrates a complete user management system:

1. When the app starts, it initializes a SQLite database and creates a user table if it doesn't exist
2. Sample user data is loaded into the database
3. The main screen displays a list of all users from the database
4. Users can:
   - View the list of all users
   - Add new users via the "+" button in the app bar
   - Edit a user by tapping the edit (pencil) icon
   - Delete a single user by tapping the delete (trash) icon
   - Clear all users at once using the floating action button

5. The database helper includes implementations for:
   - Creating new users
   - Reading user data
   - Updating existing users
   - Deleting individual users
   - Deleting all users

## Architecture

The application follows a simple architecture:

- **Data Layer**: User model and DatabaseHelper for SQLite operations
- **UI Layer**: Screens for displaying and modifying user data
- **Business Logic**: Handled within screen classes for this simple demo

## Dependencies

The project uses the following key dependencies:

- `sqflite`: For SQLite database operations
- `path`: For managing database file paths

## License

[Your License Information]

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Last Updated

March 24, 2025
