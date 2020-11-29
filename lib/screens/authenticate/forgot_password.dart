import 'package:smart_library/models/users.dart';
import 'package:smart_library/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_library/shared/constants.dart';
import 'package:smart_library/components/rounded_button.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String email = '', password = '', error = '';

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: AuthService().user,
      child: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/resetpassword.jpg',
                  height: 130,
                  width: 150,
                  alignment: Alignment.center,
                ),
                Text(
                  'Enter your email and link will send to',
                  style: TextStyle(
                    fontSize: 15.0,
                    height: 5.0,
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

                RoundedButton(
                  colour: Colors.deepPurple,
                  title: 'Reset Password',
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.resetPassword(email);

                      // if (result == null) {
                      //   error = 'Wrong Email';
                      // } else if (result = !null) {
                      //   error = "Success! Please check your email";
                      // }

                      if (result == null) {
                        setState(() {
                          error = 'Success! Please check your email';
                        });
                      } else {
                        error = 'Wrong Email';
                      }
                    }
                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
