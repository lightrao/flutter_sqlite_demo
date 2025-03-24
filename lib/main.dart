import 'package:flutter/material.dart';
import 'database_helper.dart'; 
import 'screens/user_list_screen.dart'; // Import the new UserListScreen

void main() async {
  // Initialize the database and insert users
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.databaseHelperInstance.initDb();
  await DatabaseHelper.databaseHelperInstance.initializeUsers();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Management',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UserListScreen(), // Use the decoupled UserListScreen
    );
  }
}
