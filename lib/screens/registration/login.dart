import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_portal/screens/registration/registration.dart';

class LoginScreen extends StatelessWidget {
  final  _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    _validate(){
      if (_formKey.currentState!.validate()) {
        final String email = _emailController.text.trim();
        final String password = _passwordController.text.trim();
        if (email.isEmpty) {
          _showSnackBar(context, "Email is required");
        }
        else if(password.isEmpty){
          _showSnackBar(context, "Password is required");
        }else{
//Login with email and password
        _auth.signInWithEmailAndPassword(email: email, password: password).then((value) async {
         final getUserData = await FirebaseFirestore.instance.collection("UserDetail");

        }).catchError((error){
          _showSnackBar(context, error.message);
        });



        }


      }
    }
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/library_logo.png",height: height*0.2),

                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor:  Color(0xff213E94)),
                    onPressed: () {
                    _validate();
                      // Perform login logic here
                    },
                    child: Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text('Create an account'),
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
