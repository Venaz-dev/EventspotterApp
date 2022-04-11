import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:event_spotter/widgets/topmenu.dart';

class ChatScreen extends StatefulWidget {
  String name;
  String id;
  // StreamController<dynamic> chatStream;
  ChatScreen({
    Key? key,
    required this.name,
    required this.id,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isMe = true;
  late Channel channel;
  final StreamController<bool> isLoading = StreamController<bool>();
  final TextEditingController _writemessage = TextEditingController();
  late List<Map<String, dynamic>> chatList = [];
  late SharedPreferences _sharedPreferences;
  StreamController<dynamic> chatStream1 = StreamController<dynamic>.broadcast();
  late String _token;
  String sendMessageUrl = "https://theeventspotter.com/api/send";
  String getMessagesUrl =
      "https://theeventspotter.com/api/load-latest-messages";
  late String _id;
  String getMessageUrl = "https://theeventspotter.com/api/fetch-old-messages";
  late String _id1;
  late String _name;
  late String masseageId;

  bool isMaddy = true;

  late PusherClient pusher;
  final Dio _dio = Dio();
  _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      height: 70.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 2,
          )
        ],
        //  borderRadius: BorderRadius.only(
        //    topLeft: Radius.circular(20) , topRight : Radius.circular(20)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              maxLines: null,
              controller: _writemessage,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            height: 35,
            width: 35,
            decoration: const BoxDecoration(
                color: Color(0XFF3BADB7), shape: BoxShape.circle),
            child: Align(
              alignment: Alignment.center,
              child: StreamBuilder<bool>(
                  stream: isLoading.stream,
                  initialData: false,
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                        icon: snapshot.data!
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: Color(0xFF3BADB7)))
                            : const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                        iconSize: 20.0,
                        color: const Color(0XFF3BADB7),
                        onPressed: () {
                          Map<String, dynamic> ssq = {
                            'content': _writemessage.text,
                            'toUserId': widget.id.toString(),
                          };
                          chatStream1.sink.add(jsonEncode(ssq));
                          isLoading.sink.add(true);
                          // setState(() {});
                          sendMessage(_writemessage.text);
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    intiliaziePusher();
    getSharepref();
    chatList.clear();

    getMessages();
    chatStream1.stream.listen((event) {
      chatList.add(jsonDecode(event));
    });

    super.initState();
  }

  @override
  void dispose() {
    _writemessage.dispose();
    channel.unbind('send');
    isLoading.close();
    chatStream1.sink.close();
    chatStream1.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: const Color(0XFF17796F),
      //   title: Text(
      //     widget.name,
      //     style: const TextStyle(
      //       fontSize: 28.0,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   elevation: 0.3,
      // ),
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(height: 60),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: double.infinity,
                      // decoration: const BoxDecoration(
                      //     image: DecorationImage(
                      //         image: AssetImage(
                      //             'Assets/images/chat_background.jpeg'),
                      //         fit: BoxFit.cover)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: StreamBuilder<dynamic>(
                                      stream: chatStream1.stream,
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text('error');
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return SizedBox(
                                              height: size.height * 0.7,
                                              child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: Color(
                                                              0XFF3BADB7))));
                                        }

                                        return Column(
                                            children: List.generate(
                                                chatList.length, (index) {
                                          return !(chatList[index]['content'] !=
                                                      null) ||
                                                  chatList[index]['content']
                                                          .toString() !=
                                                      ""
                                              ? Container(
                                                  child: chatList[index]
                                                              ['toUserId'] ==
                                                          _id
                                                      ? recieverBubble(
                                                          size,
                                                          chatList[index]
                                                              ['content']!)
                                                      : senderBubble(
                                                          size,
                                                          chatList[index]
                                                              ['content']!))
                                              // ChatBubble(
                                              //     clipper: ChatBubbleClipper6(
                                              //       type: chatList[index]
                                              //                   ['toUserId'] ==
                                              //               _id
                                              //           ? BubbleType
                                              //               .receiverBubble
                                              //           : BubbleType.sendBubble,
                                              //     ),
                                              //     alignment: chatList[index]
                                              //                 ['toUserId'] ==
                                              //             _id
                                              //         ? Alignment.topLeft
                                              //         : Alignment.topRight,
                                              //     margin: const EdgeInsets.only(
                                              //       top: 10,
                                              //     ),
                                              //     backGroundColor: chatList[
                                              //                     index]
                                              //                 ['toUserId'] ==
                                              //             _id
                                              //         ? Color(0xFFF9F9F9)
                                              //         : const Color(0xFFC8FBFF),
                                              //     child: Container(
                                              //         // width:
                                              //         //     MediaQuery.of(context)
                                              //         //             .size
                                              //         //             .width *
                                              //         //         0.3,
                                              //         margin: chatList[index][
                                              //                     'toUserId'] ==
                                              //                 _id
                                              //             ? const EdgeInsets
                                              //                 .only(
                                              //                 top: 5.0,
                                              //                 bottom: 5.0,
                                              //               )
                                              //             : const EdgeInsets
                                              //                 .only(
                                              //                 top: 5,
                                              //                 bottom: 5.0,
                                              //               ),
                                              //         child: chatList[index][
                                              //                     'toUserId'] ==
                                              //                 _id
                                              //             // ignore: prefer_const_constructors
                                              //             ? Align(
                                              //                 alignment: Alignment
                                              //                     .centerLeft,
                                              //                 child: Text(
                                              //                   chatList[index][
                                              //                       'content']!,
                                              //                   style:
                                              //                       const TextStyle(
                                              //                     color: Color(
                                              //                         0XFF101010),
                                              //                     fontSize:
                                              //                         16.0,
                                              //                     fontWeight:
                                              //                         FontWeight
                                              //                             .w600,
                                              //                   ),
                                              //                 ),
                                              //               )
                                              //             : Align(
                                              //                 alignment: Alignment
                                              //                     .centerLeft,
                                              //                 child: Text(
                                              //                   chatList[index][
                                              //                       'content']!,
                                              //                   style:
                                              //                       const TextStyle(
                                              //                     color: Color(
                                              //                         0xFF101010),
                                              //                     fontSize:
                                              //                         16.0,
                                              //                     fontWeight:
                                              //                         FontWeight
                                              //                             .w600,
                                              //                   ),
                                              //                 ),
                                              //               )),
                                              //   )
                                              : const SizedBox();
                                        }));
                                        // return const SizedBox(child: Text('asdf'),);
                                      }),
                                )),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    child: _buildMessageComposer(),
                  )
                ],
              )),
              Topmenu(
                title: widget.name,
              ),
            ],
          )),
    ));
  }

  recieverBubble(Size size, String message) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.only(
              left: 16.0, right: 14.0, top: 20, bottom: 25),
          margin: const EdgeInsets.only(top: 20, left: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFF9F9F9),
          ),
          constraints: BoxConstraints(
            maxWidth: size.width * 0.7,
            minWidth: 120,
          ),
          child:
              // FittedBox(
              // fit: BoxFit.fill,
              // child:
              Text(message,
                  style: const TextStyle(
                    color: Color(0xFF101010),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    // ),
                  )),
        ));
  }

  senderBubble(Size size, String message) {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.only(
              left: 16.0, right: 14.0, top: 20, bottom: 25),
          margin: const EdgeInsets.only(top: 20, right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFC8FBFF),
          ),
          constraints: BoxConstraints(
            maxWidth: size.width * 0.7,
            minWidth: 120,
          ),
          child:
              // FittedBox(
              // fit: BoxFit.fill,
              // child:
              Text(message,
                  style: const TextStyle(
                    color: Color(0xFF101010),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    // ),
                  )),
        ));
  }

  void getSharepref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _id = _sharedPreferences.getString('id')!;
    _name = _sharedPreferences.getString('name')!;
  }

  getMessages() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    Map<String, String> qParams = {
      'user_id': widget.id.toString(),
    };
    _dio.options.headers["Authorization"] = "Bearer $_token";
    try {
      await _dio.get(getMessagesUrl, queryParameters: qParams).then((value) {
        print(value.data.toString());
        late Map<String, dynamic> ss = {
          'content': 'Hllo',
          'toUserId': 'asdf',
          'already': 'true',
        };
        if (value.statusCode == 200) {
          if (value.data['data'].length > 0) {
            masseageId = value.data['data'][0]['id'].toString();
            int gg = value.data['data'].length;
            for (int i = gg - 1; i >= 0; i--) {
              print(value.data['data'].length);
              // if (value.data['data'][i]['to_user'] == widget.id.toString()) {
              ss = {
                'content': value.data['data'][i]['content'],
                'toUserId': value.data['data'][i]['to_user'],
              };
              chatStream1.sink.add(jsonEncode(ss));
            }
            // setState(() {});
            // setState(() {});
          }
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void sendMessage(String value) async {
    if (value != "") {
      //_writemessage.clear();
      _sharedPreferences = await SharedPreferences.getInstance();
      _token = _sharedPreferences.getString('accessToken')!;
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      FormData formData =
          FormData.fromMap({"to_user": widget.id, "message": value});
      Response response = await _dio.post(sendMessageUrl, data: formData);
      if (response.statusCode == 200) {
        _writemessage.clear();
        print("Data Send");
        print(response.data);
      }
    } else {
      print("nul ka bacha");
      // setState(() {});
    }
    isLoading.sink.add(false);
  }

  intiliaziePusher() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _id = _sharedPreferences.getString('id')!;
    pusher = PusherClient(
      "d472b6d313e1bef33bb2",
      PusherOptions(
        host: 'https://theeventspotter.com',
        encrypted: true,
        cluster: 'ap2',
      ),
      enableLogging: true,
    );
    channel = pusher.subscribe('chat');
    channel.bind(
      'send',
      (event) {
        // ignore: avoid_print
        print('hgkjhkjhkljhkljhkjhkjh');
        log("SEND Event" + event!.data.toString());
        var ss = (jsonDecode(event.data!));
        if (ss['data']['to_user_id'] == _id &&
            ss['data']['from_user_id'] == widget.id) {
          Map<String, dynamic> ssq = {
            'content': ss['data']['content'],
            'toUserId': _id,
          };
          FlutterBeep.playSysSound(iOSSoundIDs.MailReceived);
          chatStream1.sink.add(jsonEncode(ssq));
        }
      },
    );
  }
}

// import 'dart:convert';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:image_picker/image_picker.dart';
// //import 'package:mime/mime.dart';
// import 'package:open_file/open_file.dart';
// import 'package:uuid/uuid.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: ChatPage(),
//     );
//   }
// }

// class ChatPage extends StatefulWidget {
//   const ChatPage({Key? key}) : super(key: key);

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   List<types.Message> _messages = [];
//   final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');

//   @override
//   void initState() {
//     super.initState();
//     _loadMessages();
//   }

//   void _addMessage(types.Message message) {
//     setState(() {
//       _messages.insert(0, message);
//     });
//   }

//   void _handleAtachmentPressed() {
//     showModalBottomSheet<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: SizedBox(
//             height: 144,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     _handleImageSelection();
//                   },
//                   child: const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('Photo'),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     _handleFileSelection();
//                   },
//                   child: const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('File'),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('Cancel'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _handleFileSelection() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.any,
//     );

//     if (result != null && result.files.single.path != null) {
//       final message = types.FileMessage(
//         author: _user,
//         createdAt: DateTime.now().millisecondsSinceEpoch,
//         id: const Uuid().v4(),
//         mimeType: lookupMimeType(result.files.single.path!),
//         name: result.files.single.name,
//         size: result.files.single.size,
//         uri: result.files.single.path!,
//       );

//       _addMessage(message);
//     }
//   }

//   void _handleImageSelection() async {
//     final result = await ImagePicker().pickImage(
//       imageQuality: 70,
//       maxWidth: 1440,
//       source: ImageSource.gallery,
//     );

//     if (result != null) {
//       final bytes = await result.readAsBytes();
//       final image = await decodeImageFromList(bytes);

//       final message = types.ImageMessage(
//         author: _user,
//         createdAt: DateTime.now().millisecondsSinceEpoch,
//         height: image.height.toDouble(),
//         id: const Uuid().v4(),
//         name: result.name,
//         size: bytes.length,
//         uri: result.path,
//         width: image.width.toDouble(),
//       );

//       _addMessage(message);
//     }
//   }

//   void _handleMessageTap(types.Message message) async {
//     if (message is types.FileMessage) {
//       await OpenFile.open(message.uri);
//     }
//   }

//   void _handlePreviewDataFetched(
//     types.TextMessage message,
//     types.PreviewData previewData,
//   ) {
//     final index = _messages.indexWhere((element) => element.id == message.id);
//     final updatedMessage = _messages[index].copyWith(previewData: previewData);

//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       setState(() {
//         _messages[index] = updatedMessage;
//       });
//     });
//   }

//   void _handleSendPressed(types.PartialText message) {
//     final textMessage = types.TextMessage(
//       author: _user,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: const Uuid().v4(),
//       text: message.text,
//     );

//     _addMessage(textMessage);
//   }

//   void _loadMessages() async {
//     final response = await rootBundle.loadString('assets/messages.json');
//     final messages = (jsonDecode(response) as List)
//         .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
//         .toList();

//     setState(() {
//       _messages = messages;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         bottom: false,
//         child: Chat(
//           messages: _messages,
//           onAttachmentPressed: _handleAtachmentPressed,
//           onMessageTap: _handleMessageTap,
//           onPreviewDataFetched: _handlePreviewDataFetched,
//           onSendPressed: _handleSendPressed,
//           user: _user,
//         ),
//       ),
//     );
//   }
// }
