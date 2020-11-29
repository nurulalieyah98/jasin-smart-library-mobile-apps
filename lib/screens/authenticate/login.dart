import 'package:smart_library/models/users.dart';
import 'package:smart_library/screens/authenticate/forgot_password.dart';
import 'package:smart_library/screens/user/register_user.dart';
import 'package:smart_library/services/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_library/shared/constants.dart';
import 'package:smart_library/components/rounded_button.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String email = '', password = '', error = '', errorCode, errorMessage;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
        value: AuthService().user,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/logobaru4.png'),
                      Text(
                        'Welcome To Jasin Smart Library',
                        style: TextStyle(
                          fontSize: 15.0,
                          height: 3.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          //backgroundColor: Colors.yellowAccent[100],
                        ),
                      ),
                      // DecoratedBox(
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //       image: AssetImage('assets/uitmmelaka.png'),
                      //     ),
                      //   ),
                      // ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        validator: (val) =>
                            val.isEmpty ? 'Please enter an email' : null,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Enter email',
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Enter password',
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'First Time?',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                                text: ' Click Here',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterUser()));
                                  }),
                          ],
                        ),
                      ),
                      RoundedButton(
                        colour: Colors.deepPurple,
                        title: 'Log In',
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            dynamic result =
                                await _auth.signInWithEmailAndPassword(
                                    email.trim(), password);

                            // if (result == null) {
                            //   error = 'Wrong Email/Password';
                            // }
                            if (result == null) {
                              setState(() {
                                error = 'Wrong email/password';
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),

                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Forgot Password ?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                forgotPassword()));
                                  }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
