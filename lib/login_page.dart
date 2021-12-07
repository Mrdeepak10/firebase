import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'opretaion_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

/// Entrypoint example for registering via Email/Password.
class LoginPage extends StatefulWidget {
  /// The page title.
  final String title = 'Login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool? _success;
  String _userEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        _register();
                      },
                      child: const Text("Log In"),
                    )),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    _success == null
                        ? ''
                        : (_success!
                            ? 'Successfully Logged In $_userEmail'
                            : 'Registration failed'),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Verify number"),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code for registration.
  Future<void> _register() async {
    final User? user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    print('user: $user');
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email ?? '';
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext builder) {
        return const FirebaseOperation();
      }));
    } else {
      _success = false;
    }
  }
}
