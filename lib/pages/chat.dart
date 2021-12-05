import 'package:dio/dio.dart';
import 'package:event_spotter/constant/json/post.dart';
import 'package:event_spotter/models/chathistory.dart';
import 'package:event_spotter/widgets/chat/chatsection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  String getuserUrl = "https://theeventspotter.com/api/getMessageHistory";
  String MainUrl = "https://theeventspotter.com/";
  late SharedPreferences _sharedPreferences;
  late Chathistory _chathistory;
  late String token;
  late int _lenght;
  bool _isLoading=true;
  Dio _dio = Dio();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessageHistory();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "All chats",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 23),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Chatsection(
              size: size,
              image: posts[1]['uploaderImage'],
              messenger: 'Joanna Karag',
              message: 'Hey, are you coming to the event?',
              time: '9:42 am',
              count: '8',
              messengercolor: const Color(0XFF3A4759),
              messagecolor: const Color(0XFF333333),
              fontWeightofmessage: FontWeight.w400,
              fontWeightofmessenger: FontWeight.w700,
              timecolor: const Color(0XFF26C696),
            ),
            const Divider(
              thickness: 1,
            ),
            Read(
                size: size,
                image: posts[2]['uploaderImage'],
                messenger: 'Lorem Kulia',
                message: 'Where are you? We are waiting.',
                time: '9:42 am',
                count: '8',
                messengercolor: const Color(0XFFA4A4A4),
                messagecolor: const Color(0XFFB4B4B4),
                fontWeightofmessage: FontWeight.w400,
                fontWeightofmessenger: FontWeight.w400,
                timecolor: const Color(0XFFB4B4B4)),
            const Divider(
              thickness: 1,
            ),
            Read(
                size: size,
                image: posts[3]['uploaderImage'],
                messenger: 'Karl John',
                message: 'Hurry Up! The party is started.',
                time: '9:25 am',
                count: '8',
                messengercolor: const Color(0XFFA4A4A4),
                messagecolor: const Color(0XFFB4B4B4),
                fontWeightofmessage: FontWeight.w400,
                fontWeightofmessenger: FontWeight.w400,
                timecolor: const Color(0XFFB4B4B4)),
            const Divider(
              thickness: 1,
            ),
            Chatsection(
                size: size,
                image: posts[4]['uploaderImage'],
                messenger: 'Joanna Karag',
                message: 'Hey, are you coming to the event?',
                time: '10:20 am',
                count: '6',
                messengercolor: const Color(0XFF3A4759),
                messagecolor: const Color(0XFF333333),
                fontWeightofmessage: FontWeight.w400,
                fontWeightofmessenger: FontWeight.w700,
                timecolor: const Color(0XFF26C696)),
            const Divider(
              thickness: 1,
            ),
            Read(
                size: size,
                image: posts[2]['uploaderImage'],
                messenger: 'Lorem Kulia',
                message: 'Where are you? We are waiting.',
                time: '9:25 am',
                count: '8',
                messengercolor: const Color(0XFFA4A4A4),
                messagecolor: const Color(0XFFB4B4B4),
                fontWeightofmessage: FontWeight.w400,
                fontWeightofmessenger: FontWeight.w400,
                timecolor: const Color(0XFFB4B4B4)),
            const Divider(
              thickness: 1,
            ),
            Read(
                size: size,
                image: posts[0]['uploaderImage'],
                messenger: 'Karl John',
                message: 'Where are you? We are waiting.',
                time: '9:25 am',
                count: '8',
                messengercolor: const Color(0XFFA4A4A4),
                messagecolor: const Color(0XFFB4B4B4),
                fontWeightofmessage: FontWeight.w400,
                fontWeightofmessenger: FontWeight.w400,
                timecolor: const Color(0XFFB4B4B4)),
          ],
        ),
      ),
    );
  }

  void getMessageHistory() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    token = _sharedPreferences.getString('accessToken')!;
    // ignore: avoid_print
    print("Inside the Get Notification function");
    try {
      _dio.options.headers["Authorization"] = "Bearer ${token}";
      Response response = await _dio.get(getuserUrl);
      if (response.statusCode == 200) {
        _chathistory = Chathistory.fromJson(response.data);
        _lenght = _chathistory.data.length;
        // print(response);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    } finally {
      _isLoading = false;
    }
  }
}
