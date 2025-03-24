import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../user.dart';
import 'add_user_screen.dart';
import 'edit_user_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  /// Fetches all users from the database and updates the state.
  ///
  /// This method retrieves all user records from the SQLite database
  /// through the DatabaseHelper, converts them to User objects,
  /// and updates the UI by calling setState.
  Future<void> _fetchUsers() async {
    // Query the database for all user records
    final userMaps =
        await DatabaseHelper.databaseHelperInstance.queryAllUsers();

    // Update the state with the new user list
    setState(() {
      // Convert each map to a User object and store in _users list
      _users = userMaps.map((userMap) => User.fromMap(userMap)).toList();
    });
  }

  // Function to clear all users
  Future<void> _clearAllUsers() async {
    // Show confirmation dialog
    bool confirm =
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Clear All Users'),
              content: Text('Are you sure you want to delete all users?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false;

    // If user confirmed, delete all users
    if (confirm) {
      await DatabaseHelper.databaseHelperInstance.deleteAllUsers();
      _fetchUsers(); // Refresh the list
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('All users deleted')));
    }
  }

  // Function to delete a single user
  Future<void> _deleteUser(int? userId) async {
    if (userId == null) return;

    // Show confirmation dialog
    bool confirm =
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete User'),
              content: Text('Are you sure you want to delete this user?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false;

    // If user confirmed, delete the user
    if (confirm) {
      await DatabaseHelper.databaseHelperInstance.deleteUser(userId);
      _fetchUsers(); // Refresh the list
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('User deleted')));
    }
  }

  // Navigate to edit user screen
  Future<void> _navigateToEditUser(User user) async {
    // Wait for the result from the edit user screen
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditUserScreen(user: user)),
    );

    // If user was updated, refresh the list
    if (result == true) {
      _fetchUsers();
    } else {
      // If user was not updated, show a message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('User not updated')));
    }
  }

  // Navigate to add user screen
  Future<void> _navigateToAddUser() async {
    // Wait for the result from the add user screen
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddUserScreen()),
    );

    // If user was added, refresh the list
    if (result == true) {
      _fetchUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GFG User List'),
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddUser,
            tooltip: 'Add User',
          ),
        ],
      ),
      body:
          _users.isEmpty
              ? Center(child: Text('No users found'))
              : ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_users[index].username),
                    subtitle: Text(_users[index].email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _navigateToEditUser(_users[index]),
                          tooltip: 'Edit User',
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteUser(_users[index].id),
                          tooltip: 'Delete User',
                        ),
                      ],
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearAllUsers,
        backgroundColor: Colors.red,
        tooltip: 'Clear All Users',
        child: Icon(Icons.delete),
      ),
    );
  }
}
