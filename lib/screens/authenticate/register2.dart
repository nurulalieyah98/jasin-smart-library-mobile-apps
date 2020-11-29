import 'package:flutter/material.dart';
import 'package:smart_library/services/auth.dart';
import 'package:smart_library/shared/constants.dart';
import 'package:smart_library/shared/loading.dart';

class Register2 extends StatefulWidget {
  final Function toggleView;
  Register2({this.toggleView});
  @override
  _Register2State createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';
  String name = '';
  String id = '';
  String phone = '';

  // Initially password is obscure
  bool _passwordVisible = false;

  // Toggles the password show status
  // void initState() {
  //   _passwordVisible = false;
  // }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.deepPurple[100],
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              backgroundColor: Colors.deepPurple[400],
              elevation: 0.0,
              title: Text('Jasin Smart Library'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/book2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Name'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an Name' : null,
                        onChanged: (val) {
                          setState(() => name = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an Email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: !_passwordVisible,
                        validator: (val) => val.length < 6
                            ? 'Enter an Password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        }),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth.registerUserInfo(
                                email, id, password, name, phone);
                            if (result == null) {
                              setState(() {
                                error = 'Please enter a valid email';
                                loading = false;
                              });
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
