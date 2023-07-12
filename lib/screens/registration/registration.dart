import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController = TextEditingController();

  bool showProgress = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address.';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.lightBlueAccent,
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showProgress,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(

              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/library_logo.png",height: height*0.2),
                    TextFormField(
                      controller: _emailController,
                      validator: _validateEmail,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: _validatePassword,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(

                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                      ),
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {

                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            showProgress=true;
                          });
                          final String email = _emailController.text.trim();
                          final String password = _passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            return;
                          }

                          try {
                            UserCredential userCredential =
                            await _auth.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                            print('Registered user: ${userCredential.user}');
                            bool isRegistrationSuccessful = true;

                            if (isRegistrationSuccessful) {
                              setState(() {
                                showProgress=false;
                              });

                              _showSnackBar(context, 'User registered successfully!');
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                      (route) => false);

                            } else {
                            }

                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              showProgress=false;
                            });

                            if (e.code == 'weak-password') {
                              _showSnackBar(context, "The password provided is too weak.");
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  'The account already exists for that email.',
                                  style: TextStyle(color: Colors.white),
                                ),
                                duration: Duration(seconds: 1),
                              ));
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: const Text('Register'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Already have an account? Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}