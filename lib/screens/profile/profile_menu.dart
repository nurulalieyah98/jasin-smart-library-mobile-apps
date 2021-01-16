// import 'package:smart_library/components/card_profile.dart';
// // import 'package:smaart_library/screens/profile/edit_address.dart';
// import 'package:flutter/material.dart';
// import 'user_profile.dart';

// class ProfileMenu extends StatelessWidget {
//   ProfileMenu({this.uid});

//   final String uid;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Account Settings'),
//       ),
//       body: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 15.0,
//           ),
//           Text('My Account'),
//           SizedBox(
//             height: 15.0,
//           ),
//           CardProfile(
//             title: 'My Profile',
//             data: '',
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => UserProfile(
//                     uid: uid,
//                   ),
//                 ),
//               );
//             },
//           ),
//           Text('Settings'),
//           SizedBox(
//             height: 15.0,
//           ),
//           CardProfile(
//             title: 'Delete Account',
//             data: '',
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => UserProfile(
//                     uid: uid,
//                   ),
//                 ),
//               );
//             },
//           ),
//           // CardProfile(
//           //   title: 'Delete Account',
//           //   data: '',
//           //   onPressed: () {
//           //     Navigator.push(
//           //       context,
//           //       MaterialPageRoute(
//           //         builder: (context) => UserProfile(uid: uid),
//           //       ),
//           //     );
//           //   },
//           // ),
//         ],
//       ),
//     );
//   }
// }
