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
}

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:pusher_client/pusher_client.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late PusherClient pusher;
//   // late Channel channel;
//   late Channel privateChannel ;
//   //  late Channel channel;
//   @override
//   void initState() {
//     super.initState();

//     // String token = getToken();

//     pusher = PusherClient(
//       "d472b6d313e1bef33bb2",
//       PusherOptions(
//         // if local on android use 10.0.2.2
//         host: 'https://theeventspotter.com',
//         encrypted: false,
//         cluster: 'ap2',
//         auth: PusherAuth(
//           'https://theeventspotter.com/api/broadcasting/auth',
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization':
//                 'Bearer 22|hVEyexcCrrAqD0UTERUQgLqwgoO3R08nUjDQtFdI',
//           },
//         ),
//       ),
//       enableLogging: true,
//     );

//     //  channel = pusher.subscribe("chat");
//         privateChannel = pusher.subscribe('chat');
//     pusher.onConnectionStateChange((state) {
//       log("previousState: ${state!.previousState}, currentState: ${state.currentState}");
//     });

//     pusher.onConnectionError((error) {
//       log("error: ${error!.message}");
//     });

//     // channel.bind('send', (event) {
//     //   log(event!.data.toString());
//     // });

//     privateChannel.bind('send', (event) {
//       log(event!.userId.toString());
//     });

//     // channel.bind('order-filled', (event) {
//     //   log("Order Filled Event" + event!.data.toString());
//     // });
//   }

//   // String getToken() => "super-secret-token";

// ignore_for_file: import_of_legacy_library_into_null_safe

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Example Pusher App'),
//         ),
//         body: Center(
//             child: Column(
//           children: [
//             ElevatedButton(
//               child: Text('Unsubscribe Private Orders'),
//               onPressed: () {
//                 pusher.subscribe('chat');
//               },
//             ),
//             ElevatedButton(
//               child: Text('Unbind Status Update'),
//               onPressed: () {
//                 // channel.unbind('status-update');
//               },
//             ),
//             ElevatedButton(
//               child: Text('Unbind Order Filled'),
//               onPressed: () {
//                 // channel.unbind('order-filled');
//               },
//             ),
//             ElevatedButton(
//               child: Text('Bind Chat Update'),
//               onPressed: () {
//                 privateChannel.bind('oldMsgs', (PusherEvent? event) {
//                   log("Status Update Event" + event!.data.toString());
//                 });
//               },
//             ),
//             ElevatedButton(
//               child: Text('Trigger Client Typing'),
//               onPressed: () {
//                privateChannel.trigger('send', {'data':'MOD'});
//               },
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }
///////////////////////////////////////////////////////////////////////////////////////////////
// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:event_spotter/models/ChatModel.dart';
// import 'package:flutter/material.dart';
// import 'package:pusher_client/pusher_client.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late PusherClient pusher;
//   late Channel channel;
//   Dio dio = Dio();
//   var id = '';
//   final chatStream = StreamController<dynamic>();
//   TextEditingController _username = TextEditingController();

//   @override
//   initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       getID().then((result) {
//         id = result;
//       });
//       print('asdf' + id);
//     });
//     pusher = PusherClient(
//       "d472b6d313e1bef33bb2",
//       PusherOptions(
//         host: 'https://theeventspotter.com',
//         encrypted: true,
//         cluster: 'ap2',
//         auth: PusherAuth(
//           'https://theeventspotter.com/api/broadcasting/auth',
//           headers: {
//             'Authorization':
//                 'Bearer 47|EMO7Fv6MPq7tx7IL3QntIfWYg6YINeYHtWDOrHox',
//             'Content-type': 'application'
//           },
//         ),
//       ),
//       enableLogging: true,
//     );
//     // pusher.connect();
//     channel = pusher.subscribe("chat-message.32" + id);

//     pusher.onConnectionStateChange((state) {
//       log("previousState: ${state!.previousState}, currentState: ${state.currentState}");
//     });

//     pusher.onConnectionError((error) {
//       log("error: ${error!.message}");
//     });

//     channel.bind('status-update', (event) {
//       log(event!.data!);
//     });

//     channel.bind('order-filled', (event) {
//       log("Order Filled Event" + event!.data.toString());
//     });
//     channel.bind('send', (event) {
//       log("SEND Event" + event!.data.toString());
//       // Map<String, dynamic> model = event.data as Map<String, dynamic>;
//       // model = jsonDecode(model!.toString());
//       // ChatModel models = ChatModel.fromJson(model);
//       chatStream.sink.add(event.data);
//     });
//   }

//   String getToken() => "super-secret-token";

//   Future<String> getID() async {
//     dio.options.headers["Authorization"] =
//         "Bearer 47|EMO7Fv6MPq7tx7IL3QntIfWYg6YINeYHtWDOrHox";
//     var response = await dio.get('https://theeventspotter.com/api/getUserId');
//     print('response is ${response.data}');
//     id = response.data;
//     return id;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Example Pusher App'),
//         ),
//         body: Center(
//             child: Column(
//           children: [
//             ElevatedButton(
//               child: Text('Subscribe Chat Orders'),
//               onPressed: () {
//                 pusher.subscribe('chat');
//               },
//             ),
//             ElevatedButton(
//               child: Text('Unsubscribe Private Orders'),
//               onPressed: () {
//                 pusher.unsubscribe('private-orders');
//               },
//             ),
//             ElevatedButton(
//               child: Text('Unbind Status Update'),
//               onPressed: () {
//                 channel.unbind('status-update');
//               },
//             ),
//             ElevatedButton(
//               child: Text('Unbind Order Filled'),
//               onPressed: () {
//                 channel.unbind('order-filled');
//               },
//             ),
//             ElevatedButton(
//               child: Text('Bind Status Update'),
//               onPressed: () {
//                 channel.bind('send', (PusherEvent? event) {
//                   log("Status Update Event" + event!.data.toString());
//                 });
//               },
//             ),
//             ElevatedButton(
//               child: Text('Trigger Client Typing'),
//               onPressed: () {
//                 channel.trigger('client-istyping', {'name': 'Bob'});
//               },
//             ),
//             StreamBuilder(
//                 stream: chatStream.stream,
//                 builder: (context, AsyncSnapshot<dynamic> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     print('waiting');
//                   }
//                   if (snapshot.connectionState == ConnectionState.done) {}
//                   print('Everything works fine');
//                   if (snapshot.hasData) {
//                     ChatModel ss =
//                         ChatModel.fromJson(jsonDecode(snapshot.data));
//                     return Expanded(child: Text(ss.data.content));
//                   }
//                   return Text('Loading');
//                 }),
//             Column(
//               children: [
//                 Padding(padding: EdgeInsets.only(top: 10)),
//                 Container(
//                   margin: EdgeInsets.only(left: 16.0),
//                   child: TextFormField(
//                     controller: _username,
//                     decoration: InputDecoration(
//                         hintText: 'Send Message ',
//                         filled: true,
//                         prefixIcon: Icon(
//                           Icons.account_box,
//                           size: 28.0,
//                         ),
//                         suffixIcon: IconButton(
//                             icon: Icon(Icons.send),
//                             onPressed: () {
//                               // channel.trigger('send', {'jj':_username.text});
//                               postMessage();
//                             })),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         )),
//       ),
//     );
//   }

//   postMessage() async {
//     print("Inside post Message ");
//     dio.options.headers["Authorization"] =
//         "Bearer 47|EMO7Fv6MPq7tx7IL3QntIfWYg6YINeYHtWDOrHox";
//     FormData formData = new FormData.fromMap({
//       "to_user": 2,
//       "message": _username.text,
//     });
//     var response =
//         await dio.post('https://theeventspotter.com/api/send', data: formData);
//     print(response.data.toString());
//   }
// }
