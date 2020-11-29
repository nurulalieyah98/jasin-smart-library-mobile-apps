import 'package:smart_library/components/rounded_button.dart';
import 'package:smart_library/models/users.dart';
import 'package:smart_library/services/database.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  EditProfile({this.uid, this.title, this.hintText, this.value});

  final _formKey = GlobalKey<FormState>();

  final String uid;
  final String title;
  final String hintText;
  final String value;
  String _currentName, _currentPhone, _currentID;
  String _email;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Users>(
        stream: DatabaseService(uid: uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
              body: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: TextFormField(
                        initialValue: value,
                        validator: (value) =>
                            value.isEmpty ? 'Please enter a name' : null,
                        decoration: InputDecoration(
                          hintText: hintText,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (title == 'Edit Name') {
                            _currentName = value;
                          } else if (title == 'Edit Phone Number') {
                            _currentPhone = value;
                          } else if (title == 'Email') {
                            _email = value;
                          } else if (title == 'Edit ID') {
                            _currentID = value;
                          }
                          // else if (title == '')
                        },
                      ),
                    ),
                    RoundedButton(
                      colour: Colors.deepPurple,
                      title: 'Save',
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: uid).userInfo(
                            _email ?? snapshot.data.email,
                            _currentID ?? snapshot.data.id,
                            _currentName ?? snapshot.data.name,
                            _currentPhone ?? snapshot.data.phone,
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold();
          }
        });
  }
}
