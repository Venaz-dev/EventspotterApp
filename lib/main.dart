// import 'package:event_spotter/pages/signin.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//       .then((_) {
//     runApp(const MaterialApp(
//       home: LoginScreen(),
//       debugShowCheckedModeBanner: false,
//     ));
//   });
// }

import 'package:event_spotter/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    ));
  });

// }'https://theeventspotter.com/api/send', data: formData);
//     print(response.data.toString());
//   }
// }
}


// showAlertDialog(BuildContext context) {
//     // set up the button
//     Widget okButton = TextButton(
//       child: Text("OK"),
//       onPressed: () {},
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text("My title"),
//       content: Text("This is my message."),
//       actions: [
//         okButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }