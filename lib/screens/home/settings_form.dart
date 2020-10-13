import 'package:flutter/material.dart';
import 'package:smart_library/models/user.dart';
import 'package:smart_library/services/database.dart';
import 'package:smart_library/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:smart_library/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  //final List<String> sugars = ['0','1','2','3','4','5'];

  // form values
  String _currentName;
  String _currentID;
  String _currentPhone;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update Your Profile',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  //dropdown
                  // DropdownButtonFormField(
                  //   decoration: textInputDecoration,
                  //   value: _currentSugar ?? '0',
                  //   items: sugars.map((sugar){
                  //     return DropdownMenuItem(
                  //       value: sugar,
                  //       child: Text('$sugar sugars'),
                  //     )
                  //   }).toList(),
                  //   onChanged: (val) => SetState(() => _currentSugar = val),
                  //),
                  TextFormField(
                    initialValue: userData.id,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter ID' : null,
                    onChanged: (val) => setState(() => _currentID = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.phone,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter number phone' : null,
                    onChanged: (val) => setState(() => _currentPhone = val),
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentID ?? userData.id,
                            _currentName ?? userData.name,
                            _currentPhone ?? userData.phone);
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
