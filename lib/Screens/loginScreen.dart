import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheet/Provider/UserProvider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'HomePage.dart';
import 'SignupPage.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isObscured = true;
  User? _user;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Getting the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Consumer<getName>(
        builder: (BuildContext context, value, Widget? child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: screenWidth * 0.40, // 40% of the screen width
            height: double.infinity, // Cover the entire height of the screen
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Hi, Welcome back  ',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons
                              .waving_hand_rounded, // Replace with your desired icon
                          size: 16,
                          color: CupertinoColors
                              .systemYellow, // Match the icon size with the text size
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
                      obscureText: _isObscured,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value ?? false;
                                  });
                                }),
                            const Text('Remember Me'),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Implement forgot password functionality
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          UserCredential v =
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);

                          if (v != null) {
                            User? u = v.user;
                            value!.getname(u!.uid);
                            Navigator.pushNamed(context, HomePage.id);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF3E38F5)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Adjust the value to make it more rectangular
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(double.infinity,
                                  50)), // Increase the height as desired
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Not registered yet?'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignUpPage.id);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.transparent, // Background color
                            shadowColor:
                                Colors.transparent, // Removes the shadow
                          ),
                          child: const Text(
                            'Create an account',
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
