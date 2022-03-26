import 'package:dio/dio.dart';
import 'package:event_spotter/models/notificationModel.dart';
import 'package:event_spotter/pages/request.dart';
import 'package:event_spotter/pages/timeago.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_spotter/widgets/topmenu.dart';

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
  int length = 2;
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
    if (length != 0) {
      Size size = MediaQuery.of(context).size;
      return SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: Color(0xFF3BADB7)))
                      : NestedScrollView(
                          headerSliverBuilder: (context, innerBoxIsScrolled) =>
                              [
                                // const SliverAppBar(
                                //   backgroundColor: Colors.white,
                                //   elevation: 0,
                                //   automaticallyImplyLeading: false,
                                //   title: Text(
                                //     "Notifications",
                                //     style: TextStyle(
                                //       color: Colors.black,
                                //       fontWeight: FontWeight.w700,
                                //       fontSize: 23,
                                //     ),
                                //   ),
                                //   centerTitle: true,
                                // ),
                              ],
                          body: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, left: 10, top: 80, bottom: 0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(length, (index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 10),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (contexxt) =>
                                                          const Pendingrequests()));
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Color(
                                                              0xFFE5E7EB)))),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20,
                                                            left: 10,
                                                            right: 10.0,
                                                            bottom: 20),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 25.0,
                                                          // ignore: unrelated_type_equality_checks
                                                          backgroundImage: _notificationModel
                                                                      .data[
                                                                          index]
                                                                      .user
                                                                      .profilePicture !=
                                                                  ""
                                                              ? NetworkImage(MainUrl +
                                                                  _notificationModel
                                                                      .data[
                                                                          index]
                                                                      .user
                                                                      .profilePicture!
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
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width: size
                                                                              .width *
                                                                          0.43,
                                                                      child:
                                                                          Text(
                                                                        _notificationModel
                                                                            .data[index]
                                                                            .title,
                                                                        maxLines:
                                                                            2,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Color(0xFF101010)),
                                                                      )),
                                                                  const Spacer(),
                                                                  time(index),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                _notificationModel
                                                                    .data[index]
                                                                    .message,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Color(
                                                                        0xFF606060)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      })),
                                ]),
                              ))),
                  const Topmenu(title: "Notifications"),
                ],
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
        length = _notificationModel.data.length;
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
