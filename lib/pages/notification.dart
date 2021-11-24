import 'package:dio/dio.dart';
import 'package:event_spotter/models/notificationModel.dart';
import 'package:event_spotter/pages/timeago.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Noti extends StatefulWidget {
  const Noti({Key? key}) : super(key: key);

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  String imagepath =
      'https://www.lancasterbrewery.co.uk/files/images/christmasparty.jpg';
  int index = 0;
  String NotificationUrl = "https://theeventspotter.com/api/notifications";
  String MainUrl = "https://theeventspotter.com/";
  late SharedPreferences _sharedPreferences;
  late AutoGenerate _notificationModel;
  int lenght = 2;
  late String token;
  bool _isLoading = true;
  Dio _dio = Dio();
  @override
  void initState() {
    super.initState();
    print("object");
    getnotifications().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (lenght != 0) {
      Size size = MediaQuery.of(context).size;
      return _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              backgroundColor: Colors.white,
              body: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        const SliverAppBar(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          automaticallyImplyLeading: false,
                          title: Text(
                            "Notifications",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 23,
                            ),
                          ),
                          centerTitle: true,
                        ),
                      ],
                  body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(lenght, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0XFFFAFAFA),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20,
                                          left: 30,
                                          right: 30.0,
                                          bottom: 20),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // Container(
                                          //   height: 40,
                                          //   width: 40,
                                          //   decoration:

                                          //   BoxDecoration(
                                          //     shape: BoxShape.circle,
                                          //     image: DecorationImage(

                                          //         image: NetworkImage(imagepath),
                                          //         fit: BoxFit.cover),
                                          //   ),

                                          // ),

                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 25.0,
                                            // ignore: unrelated_type_equality_checks
                                            backgroundImage: _notificationModel
                                                        .data[index]
                                                        .user
                                                        .profilePicture !=
                                                    ""
                                                ? NetworkImage(MainUrl +
                                                    _notificationModel
                                                        .data[index]
                                                        .user
                                                        .profilePicture
                                                        .image)
                                                : const AssetImage(
                                                        'Assets/images/user.png')
                                                    as ImageProvider,
                                          ),

                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _notificationModel
                                                      .data[index].title,
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  _notificationModel
                                                      .data[index].message,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    time(index),
                                  ],
                                ),
                              ),
                            );
                          })),
                    ]),
                  )));
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text(
                "Notifications",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 23,
                ),
              ),
              centerTitle: true,
            ),
          ],
          body: const Center(
            child: Text("No Notifications"),
          ),
        ),
      );
    }
  }

  getnotifications() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    token = _sharedPreferences.getString('accessToken')!;
    // ignore: avoid_print
    print("Inside the Get Notification function");
    try {
      _dio.options.headers["Authorization"] = "Bearer ${token}";
      Response response = await _dio.get(NotificationUrl);
      if (response.data["success"] == true) {
        _notificationModel = AutoGenerate.fromJson(response.data);
        lenght = _notificationModel.data.length;
        // print(response);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    } finally {
      _isLoading = false;
    }
  }

  time(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          TimeAgo.displayTimeAgoFromTimestamp(
              _notificationModel.data[index].createdAt),
          style: const TextStyle(fontSize: 15, color: Colors.black45),
        ),
      ),
    );
  }
}
