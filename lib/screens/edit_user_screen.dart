import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../user.dart';

class EditUserScreen extends StatefulWidget {
  final User user;

  const EditUserScreen({super.key, required this.user});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing user data
    _usernameController = TextEditingController(text: widget.user.username);
    _emailController = TextEditingController(text: widget.user.email);
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
      // Create updated user from form data, keeping the same ID
      final updatedUser = User(
        id: widget.user.id,
        username: _usernameController.text,
        email: _emailController.text,
      );

      // Update in database
      await DatabaseHelper.databaseHelperInstance.updateUser(updatedUser);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User updated successfully!')),
      );

      // Go back to the list screen, and take back the true value
      Navigator.pop(context, true);
    } else {
      // Show error message if form is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please correct the errors in the form')),
      );
    }
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updateUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Update User',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
