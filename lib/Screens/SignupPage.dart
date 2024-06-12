import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admob/v1.dart';

class SignUpPage extends StatefulWidget {
  static String id = 'signup';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String username;
  late String email;
  late String password;
  late String confirmPassword;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  User? _user;

  @override
  void initState() {
    super.initState();
    try {
      _auth.authStateChanges().listen((event) {
        setState(() {
          _user = event;
        });
      });
    } catch (e) {
      print("Error in authStateChanges: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: screenWidth * 0.40,
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Create your Account',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      username = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'E.g. johndoe@email.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    obscureText: _isPasswordObscured,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordObscured = !_isPasswordObscured;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    obscureText: _isConfirmPasswordObscured,
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Retype your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordObscured =
                                !_isConfirmPasswordObscured;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (password != confirmPassword) {
                          // Handle password mismatch error
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Passwords do not match'),
                            ),
                          );
                          return;
                        }
                        // Sign up using Firebase Auth
                        await _auth
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        )
                            .then((_) {
                          // Handle successful signup
                          Navigator.pop(context); // Navigate back to login page
                        }).catchError((error) {
                          // Handle signup errors
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error.toString()),
                            ),
                          );
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFF3E38F5),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                          const Size(
                            double.infinity,
                            50,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
