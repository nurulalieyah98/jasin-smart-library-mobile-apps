import 'package:flutter/material.dart';
import 'package:smart_library/components/rounded_button.dart';
import 'package:smart_library/wrapper.dart';
import 'package:smart_library/services/auth.dart';
import 'package:smart_library/shared/constants.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '',
      password = '',
      error = '',
      samePassword = '',
      name = '',
      phone = '',
      id = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'Register',
                        style: TextStyle(
                          fontSize: 18.0,
                          height: 2.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        validator: (val) =>
                            val.isEmpty ? 'Enter Matric ID in Digit' : null,
                        onChanged: (value) {
                          id = value;
                        },
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Enter your Matric ID',
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        validator: (val) =>
                            val.isEmpty ? 'Enter an name' : null,
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Enter your name',
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        validator: (val) =>
                            val.length < 6 ? 'Enter an email' : null,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Enter your email',
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        validator: (val) =>
                            val.length < 10 ? 'Enter 10-11 digit number' : null,
                        onChanged: (value) {
                          phone = value;
                        },
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Enter your phone number',
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
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
                          hintText: 'Enter your password',
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (value) {
                          samePassword = value;
                        },
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Re-enter the password',
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RoundedButton(
                        colour: Colors.deepPurple,
                        title: 'Register',
                        onPressed: () async {
                          if (_formKey.currentState.validate() &&
                              samePassword == password) {
                            dynamic result = await _auth.registerUserInfo(
                                email.trim(), password, id, name, phone);
                            if (result == null) {
                              setState(() {
                                error = 'Please supply valid email';
                              });
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Wrapper(),
                                ),
                              );
                            }
                          } else {
                            setState(() {
                              error = 'Password is not match';
                            });
                          }
                        },
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
