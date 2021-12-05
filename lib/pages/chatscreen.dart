import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:event_spotter/models/ChatModel.dart';
import 'package:flutter/material.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  String name;
  int id;
  Channel channel;
  StreamController<dynamic> chatStream;
  ChatScreen(
      {Key? key,
      required this.name,
      required this.id,
      required this.channel,
      required this.chatStream})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isMe = true;
  final TextEditingController _writemessage = TextEditingController();
  late List<Map<String, dynamic>> chatList = [];
  late SharedPreferences _sharedPreferences;
  late String _token;
  String sendMessageUrl = "https://theeventspotter.com/api/send";
  late String _id;
  late String _id1;
  late String _name;
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
              controller: _writemessage,
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
              widget.chatStream.sink.add(jsonEncode(ssq));
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
    getSharepref();

    getMessages();
    chatList = [];
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
    // TODO: implement dispose
    _writemessage.dispose();
    widget.chatStream.isClosed;
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
                      stream: widget.chatStream.stream,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError)
                          return Text('error');
                        else if (snapshot.connectionState ==
                            ConnectionState.waiting) return Text('waiting');

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
                                      ? Colors.red
                                      : Colors.lightBlue,
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
                                    chatList[index]['toUserId'] == '1'
                                        // ignore: prefer_const_constructors
                                        ? SizedBox(
                                            child: const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Awais , my name is Awais, what is your name",
                                                style: TextStyle(
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

  void getMessages() async {}

  void sendMessage(String value) async {
    _writemessage.clear();
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    FormData formData =
        FormData.fromMap({"to_user": widget.id, "message": value});
    Response response = await _dio.post(sendMessageUrl, data: formData);
    if (response.statusCode == 200) {
      print("Data Send");
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
