import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/pages/timeago.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'chatscreen.dart';

class Notifications extends StatefulWidget {
  Notifications({
    Key? key,
  }) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  String getuserUrl = "https://theeventspotter.com/api/getMessageHistory";
  String MainUrl = "https://theeventspotter.com/";
  String searchUrl = "https://theeventspotter.com/api/search";

  late SharedPreferences _sharedPreferences;
  late String token;
  late int _lenght;
  bool _isLoading = true;
  late List search = [];

  Dio _dio = Dio();
  List data = [];
  final TextEditingController _search = TextEditingController();
  @override
  void initState() {
    _search.addListener(searchnames);
    getMessageHistory();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _search.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentfocus = FocusScope.of(context);

        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   title: const Text(
          //     "All chats",
          //     style: TextStyle(
          //         color: Colors.black, fontWeight: FontWeight.w600, fontSize: 23),
          //   ),
          //   centerTitle: true,
          //   automaticallyImplyLeading: false,
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          // ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 80.0, bottom: 20, left: 20, right: 20),
                      child: RefreshIndicator(
                        onRefresh: () {
                          data.clear();
                          return getMessageHistory();
                        },
                        child: ListView(
                          children: [
                            Text(
                              "All chats",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF101010)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: size.width * 0.9,
                              child: Textform(
                                onchange: (listen) {
                                  if (_search.text.length >= 3) {
                                    search.clear();
                                    searchApiCall();
                                    setState(() {});
                                    if (_search.text.length == 0) {
                                      search.clear();
                                    }
                                    setState(() {});
                                  }
                                },
                                isreadonly: false,
                                isSecure: false,
                                controller: _search,
                                icon: FontAwesomeIcons.search,
                                iconColor: Color(0xFF707070),
                                iconSize: 18.0,
                                label: "Search chat",
                                color: const Color(0XFFf5f5f5),
                              ),
                            ),
                            Stack(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      //   height: size.height * 0.1,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            top:
                                                BorderSide(color: Colors.white),
                                            left:
                                                BorderSide(color: Colors.white),
                                            right:
                                                BorderSide(color: Colors.white),
                                            bottom: BorderSide(
                                                color: Colors.white)),
                                      ),

                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30.0, bottom: 20),
                                        child: Column(
                                          children: List.generate(data.length,
                                              (index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                decoration: const BoxDecoration(
                                                  //color: Colors.red,
                                                  border: Border(
                                                    top: BorderSide(
                                                        color: Colors.white),
                                                    left: BorderSide(
                                                        color: Colors.white),
                                                    right: BorderSide(
                                                        color: Colors.white),
                                                    bottom: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    ChatScreen(
                                                                      id: data[index]
                                                                              [
                                                                              "toId"]
                                                                          .toString(),
                                                                      name: data[
                                                                              index]
                                                                          [
                                                                          "name"],
                                                                    )));
                                                    // data.clear();
                                                  },
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          //color: Colors.blue,
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              image: CachedNetworkImageProvider(
                                                                  MainUrl +
                                                                      data[index]
                                                                          [
                                                                          "img"]),
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              data[index]
                                                                  ['name'],
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 16),
                                                            ),
                                                            Text(
                                                              data[index]
                                                                  ["message"],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xFF6B7280),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      // Text(
                                                      //   "12:00pm",
                                                      //   style: TextStyle(
                                                      //       color: Colors.green.shade400,
                                                      //       fontWeight: FontWeight.w600),
                                                      // ),
                                                      time(index),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              _search.text.length >= 3
                                  ? searchnames()
                                  : const SizedBox(),
                            ]),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                          height: 58,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color(0xFFE5E7EB), width: 1))),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Row(
                              children: const [
                                SizedBox(
                                    width: 35.0,
                                    child: Image(
                                        image: AssetImage(
                                            "Assets/images/logo-no-text.png"))),
                                Spacer(),
                                SizedBox(
                                    width: 35.0,
                                    child: Image(
                                        image: AssetImage(
                                            "Assets/icons/notification.png")))
                              ],
                            ),
                          )),
                    ),
                  ],
                )),
    );
  }

  time(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          TimeAgo.displayTimeAgoFromTimestamp(data[index]["createdAt"]),
          style: const TextStyle(
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w400,
              fontSize: 12),
        ),
      ),
    );
  }

  getMessageHistory() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    token = _sharedPreferences.getString('accessToken')!;
    // ignore: avoid_print
    print("Inside the Get Notification function");
    try {
      _dio.options.headers["Authorization"] = "Bearer ${token}";
      Response response = await _dio.get(getuserUrl);

      if (response.statusCode == 200) {
        print(response.data);
        if (response.data['data'].length > 0) {
          for (int i = 0; i < response.data['data'].length; i++) {
            if (response.data['data'][i]['to_user']['profile_picture'] !=
                null) {
              var js = {
                'img': response.data['data'][i]['to_user']['profile_picture']
                    ['image'],
                'userId': response.data['data'][i]['to_user']['name'],
                'message': response.data['data'][i]['content'],
                'toId': response.data['data'][i]['to_user']['id'].toString(),
                'createdAt': response.data['data'][i]['created_at'],
                'name': response.data['data'][i]['to_user']['name']
              };
              data.add(js);
            } else {
              var js = {
                'img': "images/user.jpeg",
                'userId': response.data['data'][i]['to_user']['name'],
                'message': response.data['data'][i]['content'],
                'toId': response.data['data'][i]['to_user']['id'],
                'createdAt': response.data['data'][i]['updated_at'],
                'name': response.data['data'][i]['to_user']['name']
              };
              data.add(js);
            }
          }
        } else {
          print("no data");
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }

  searchApiCall() async {
    search.clear();
    _sharedPreferences = await SharedPreferences.getInstance();
    token = _sharedPreferences.getString('accessToken')!;
    Map<String, String> qParams = {
      'text': _search.text,
    };

    try {
      // Response response = await _dio.get(searchUrl);
      // print(response.data);
      _dio.options.headers["Authorization"] = "Bearer ${token}";
      await _dio.get(searchUrl, queryParameters: qParams).then((value) {
        print(value.data);
        if (value.statusCode == 200) {
          search.clear();
          if (value.data.isNotEmpty) {
            for (int i = 0; i < value.data.length; i++) {
              if (value.data[i]['profile_picture'] != null) {
                var js = {
                  'id': value.data[i]['id'],
                  'image': value.data[i]['profile_picture']['image'],
                  'name': value.data[i]['name'],
                };
                search.add(js);
              } else {
                var js = {
                  'id': value.data[i]['id'],
                  'image': "images/user.jpeg",
                  'name': value.data[i]['name'],
                };
                search.add(js);
              }
            }
          }
        }
      });
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {});
    }
  }

  Widget searchnames() {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              children: List.generate(search.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            id: search[index]['id'].toString(),
                            name: search[index]['name'],
                          )));
                },
                child: Ink(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(300),
                          child: Image.network(
                            MainUrl + search[index]["image"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(search[index]["name"],
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black))
                    ],
                  ),
                ),
              ),
            );
          })),
        ),
      ),
    );
  }
}
