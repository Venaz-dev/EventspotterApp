import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:event_spotter/models/ChatModel.dart';
import 'package:flutter/material.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  String name;
  int id;
  Channel channel;
  // StreamController<dynamic> chatStream;
  ChatScreen({
    Key? key,
    required this.name,
    required this.id,
    required this.channel,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isMe = true;
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

  late PusherClient pusher;
  Dio _dio = Dio();
  _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
            
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 25.0,
            color: const Color(0XFF368890),
            onPressed: () {
              Map<String, dynamic> ssq = {
                'content': _writemessage.text,
                'toUserId': widget.id.toString(),
                'already': 'true',
              };
              chatStream1.sink.add(jsonEncode(ssq));
              // chatList.add(ssq);
              sendMessage(_writemessage.text);
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    intiliaziePusher();
    getSharepref();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.minScrollExtent) {
    //     getMoreMessages();
    //   }
    // });
    chatList = [];
    getMessages();
    
    // TODO: implement initState
    // widget.channel.bind('chat', (event) {
    // ChatModel _chat = ChatModel.fromJson(jsonDecode(event!.data!));
    // chatList.add(_chat);
    // widget.chatStream.sink.add(event!.data!);
    // });

    super.initState();
  }

  @override
  void dispose() {
    _writemessage.dispose();
    chatStream1.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF368890),
      appBar: AppBar(
        backgroundColor: const Color(0XFF368890),
        title: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: StreamBuilder<dynamic>(
                      stream: chatStream1.stream,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError)
                          return Text('error');
                        else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }

                        if (!(jsonDecode((snapshot.data)))
                            .containsKey('already')) {
                          ChatModel ssa =
                              ChatModel.fromJson(jsonDecode(snapshot.data));
                          Map<String, dynamic> js = {
                            'content': ssa.data.content,
                            'toUserId': ssa.data.toUserId,
                          };
                          chatList.add(js);
                        } else {
                          chatList.add(jsonDecode(snapshot.data));
                        }
                        return ListView.builder(
                            reverse: false,
                            
                            itemCount: chatList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: chatList[index]['toUserId'] == _id
                                    ? const EdgeInsets.only(
                                        top: 8.0,
                                        left: 80,
                                        bottom: 8.0,
                                      )
                                    : const EdgeInsets.only(
                                        top: 8.0,
                                        right: 80.0,
                                      ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 15.0),
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration: BoxDecoration(
                                  color: chatList[index]['toUserId'] == _id
                                      ? Colors.grey[350]
                                      : Colors.grey[200],
                                  borderRadius: isMe
                                      ? const BorderRadius.only(
                                          topRight: Radius.circular(15.0),
                                          bottomLeft: Radius.circular(15.0),
                                        )
                                      : const BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          bottomRight: Radius.circular(15.0),
                                        ),
                                ),
                                child: Column(
                                  children: [
                                    chatList[index]['toUserId'] == _id
                                        // ignore: prefer_const_constructors
                                        ? SizedBox(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                chatList[index]['content']!,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                chatList[index]['content']!,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              );
                            });

                        //  return _buildMessage("adsad", true);
                      }),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }

  void getSharepref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _id = _sharedPreferences.getString('id')!;
    _name = _sharedPreferences.getString('name')!;
  }

  getMessages() async {
    print(widget.id);

    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    Map<String, String> qParams = {
      'user_id': widget.id.toString(),
    };
    _dio.options.headers["Authorization"] = "Bearer $_token";
    try {
      await _dio.get(getMessagesUrl, queryParameters: qParams).then((value) {
        print(value.data.toString());
        late Map<String, dynamic> ss;
        if (value.statusCode == 200) {
          if (value.data['data'].length > 0) {
            masseageId = value.data['data'][0]['id'].toString();
            for (int i = 0; i < value.data['data'].length; i++) {
              print(value.data['data'].length);
              if (value.data['data'][i]['to_user'] == widget.id.toString()) {
                Map<String, dynamic> ssq = {
                  'content': value.data['data'][i]['content'],
                  'toUserId': value.data['data'][i]['to_user'],
                  'already': 'true',
                };
                chatList.add(ssq);
                ss = ssq;
                //  chatStream1.sink.add(jsonEncode(ssq));
              } else {
                Map<String, dynamic> ssq = {
                  'content': value.data['data'][i]['content'],
                  'toUserId': value.data['data'][i]['to_user'],
                };
                chatList.add(ssq);
                ss = ssq;
              }
            }
            chatStream1.sink.add(jsonEncode(ss));
            setState(() {});
          }
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void sendMessage(String value) async {
    _writemessage.clear();
    if (value != "") {
      _sharedPreferences = await SharedPreferences.getInstance();
      _token = _sharedPreferences.getString('accessToken')!;
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      FormData formData =
          FormData.fromMap({"to_user": widget.id, "message": value});
      Response response = await _dio.post(sendMessageUrl, data: formData);
      if (response.statusCode == 200) {
        print("Data Send");
      }
    } else {
      print("nul ka bacha");
    }
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

    widget.channel.bind(
      'send',
      (event) {
        // ignore: avoid_print
        print('hgkjhkjhkljhkljhkjhkjh');
        log("SEND Event" + event!.data.toString());
        var ss = (jsonDecode(event.data!));
        ChatModel _chatModel = ChatModel.fromJson(ss);
        if (ss['data']['to_user_id'] == _id) {
          chatStream1.sink.add(event.data);

          //showToaster1("${_chatModel.data.fromUserName} Send Message");
        }
      },
    );
  }

  void getMoreMessages() async {
    print(widget.id);

    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    Map<String, String> qParams = {
      'old_message_id': masseageId,
      'to_user': widget.id.toString(),
    };
    _dio.options.headers["Authorization"] = "Bearer $_token";
    try {
      await _dio.get(getMessageUrl, queryParameters: qParams).then((value) {
        print(value.data.toString());
        late Map<String, dynamic> ss;
        if (value.statusCode == 200) {
          masseageId = value.data['data'][0]['id'].toString();
          if (value.data['data'].length > 0) {
            for (int i = 0; i < value.data['data'].length; i++) {
              print(value.data['data'].length);
              if (value.data['data'][i]['to_user'] == widget.id.toString()) {
                Map<String, dynamic> ssq = {
                  'content': value.data['data'][i]['content'],
                  'toUserId': value.data['data'][i]['to_user'],
                  'already': 'true',
                };
                chatList.add(ssq);
                ss = ssq;
                //  chatStream1.sink.add(jsonEncode(ssq));
              } else {
                Map<String, dynamic> ssq = {
                  'content': value.data['data'][i]['content'],
                  'toUserId': value.data['data'][i]['to_user'],
                };
                chatList.add(ssq);
                ss = ssq;
              }
            }
            setState(() {
              chatStream1.sink.add(jsonEncode(ss));
            });
          }
        }
      });
    } catch (e) {
      print(e.toString());
    }
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
