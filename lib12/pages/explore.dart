import 'dart:async';
import 'package:dio/dio.dart';
import 'package:event_spotter/constant/colors.dart';
import 'package:event_spotter/models/eventsModel.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/pages/userprofile.dart';
import 'package:event_spotter/widgets/conditions.dart';
import 'package:event_spotter/widgets/explore/events.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum screens { explore, filter }

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  String? latlong;
  String? Lat;
  String? _name;
  String? _email1;
  late int lenght;
  late String id;
  bool _isLoading = true;
  EventsModel? eventsModel;
  late String _token;
  String urlEvent = "https://theeventspotter.com/api/getEvents";
  String searchUrl = "https://theeventspotter.com/api/search";
  String MainUrl = "https://theeventspotter.com/";

  late List eventsLiveFeed = [];
  late List<int> favourite = [];
  late List<int> like = [];
  late List<int> totalCount = [];
  late List search = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late Response response;
  final TextEditingController _search = TextEditingController();
  final TextEditingController _distance = TextEditingController();

  screens swap = screens.explore;
  String? value;
  bool ontao = false;

  final dropdown = ['interest', 'no interest'];

  Dio _dio = Dio();
  String urlLocation = "https://theeventspotter.com/api/saveLatLng";

  late String long;
  late SharedPreferences _sharedPreferences;
  Geolocator geolocator = Geolocator();
  int index = 0;
  double topbarheight = 50;
  late Map<String, double> userLocation;
  Widget searchnames() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            spreadRadius: 0.5,
            blurRadius: 0.5,
            color: Colors.black12,
            offset: Offset(-1, 1),
          ),
          BoxShadow(
            spreadRadius: 0.5,
            blurRadius: 0.5,
            color: Colors.black12,
            offset: Offset(1, -1),
          )
        ],
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
                    builder: (context) => Eventposterprofile(
                          id: search[index]['id'],
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
    );
  }
  // Widget searchnames() {
  //   return Padding(
  //     padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
  //     child: Container(
  //       height: MediaQuery.of(context).size.height * 0.2,
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //         color: Colors.black54,
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: SingleChildScrollView(
  //         scrollDirection: Axis.vertical,
  //         child: Column(
  //             children: List.generate(100, (index) {
  //           return Padding(
  //             padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 10),
  //             child: Container(
  //               child: Row(
  //                 children: [
  //                   SizedBox(
  //                     height: 30,
  //                     width: 30,
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(300),
  //                       child: Image.network(
  //                         'https://images.unsplash.com/photo-1638553507237-10ff908cda42?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60',
  //                         fit: BoxFit.cover,
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     width: 20,
  //                   ),
  //                   const Text("Awais",
  //                       style: TextStyle(
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.w400,
  //                           color: Colors.white))
  //                 ],
  //               ),
  //             ),
  //           );
  //         })),
  //       ),
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _search.addListener(searchnames);

    // getInitializedSharedPref();
    getEvetns().whenComplete(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _search.dispose();
    _distance.dispose();

    super.dispose();
  }

  // intiliaziePusher() {
  //   pusher = PusherClient(
  //     "d472b6d313e1bef33bb2",
  //     PusherOptions(
  //       host: 'https://theeventspotter.com',
  //       encrypted: true,
  //       cluster: 'ap2',
  //     ),
  //     enableLogging: true,
  //   );
  //   channel = pusher.subscribe("chat");

  //   channel!.bind(
  //     'send',
  //     (event) {
  //       // ignore: avoid_print
  //       print('hgkjhkjhkljhkljhkjhkjh');
  //       log("SEND Event" + event!.data.toString());
  //       var ss = (jsonDecode(event.data!));
  //       ChatModel _chatModel = ChatModel.fromJson(ss);

  //       // ignore: avoid_print
  //       //print('hjkhkljhkjhkh');
  //       // ignore: avoid_print
  //       // print(ss['data']['to_user_id']);
  //       //  chatStream.sink.add(event.data);
  //       if (ss['data']['to_user_id'] == id) {
  //         print("Done inside //////////////////");
  //         chatStream.sink.add(event.data);
  //         //  showAlertDialog(context, _chatModel, chatStream);

  //       }
  //     },
  //   );
  // }

  // showAlertDialog(BuildContext context, ChatModel chatModel, chatStream) {
  //   // set up the button
  //   Widget okButton = TextButton(
  //     child: Text("Open Chat"),
  //     onPressed: () {
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) => ChatScreen(
  //                 id: chatModel.data.fromUserId,
  //                 name: chatModel.data.fromUserName,
  //                 channel: channel!,
  //                 chatStream: chatStream,
  //               )));
  //     },
  //   );
  //   Widget Cancel = TextButton(
  //     child: Text("Cancel "),
  //     onPressed: () {
  //       Navigator.of(context).pop();
  //     },
  //   );
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text("You have a message ${chatModel.data.fromUserName}"),
  //     content: Text(chatModel.data.content),
  //     actions: [okButton, Cancel],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () {
        eventsLiveFeed.clear();
        // like.clear();
        // favourite.clear();
        // totalCount.clear();

        return getEvetns();
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: scaffoldcolor,
          //Color(0xFF5E5E5E),

          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentfocus = FocusScope.of(context);

              if (!currentfocus.hasPrimaryFocus) {
                currentfocus.unfocus();
              }
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2,
                        blurRadius: 0,
                        offset: Offset(0, 1),
                      )
                    ]),
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage('Assets/images/logo.png'),
                            height: 40,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: size.width * 0.73,
                            child: Textform(
                              onchange: (listen) {
                                if (_search.text.length >= 3) {
                                  searchApiCall();
                                  if (_search.text.length == 0) {
                                    search.clear();
                                  }
                                  setState(() {});
                                }
                                //setState(() {});
                              },
                              isreadonly: false,
                              isSecure: false,
                              controller: _search,
                              icon: Icons.search,
                              label: "Search",
                              color: const Color(0XFFECF2F3),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: size.width * 0.03,
                        left: size.width * 0.03,
                        bottom: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              getpages(size),
                              _search.text.length >= 3
                                  ? searchnames()
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      //
      //
    );
  }

  Widget getpages(Size size) {
    switch (swap) {
      case screens.explore:
        return exploringfeeds(size);

      case screens.filter:
        return filter(size);
    }
  }

  Widget exploringfeeds(Size size) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Createevent()));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: size.height * 0.08,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('Assets/images/create_event.jpeg'),
                  fit: BoxFit.cover,
                  //  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop)
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    FontAwesomeIcons.plusCircle,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "create a new event",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF3BADB7)))
            : Center(
                child: Eventss(
                  eventsModel: eventsModel!,
                  favourite: favourite,
                  eventsLiveFeed: eventsLiveFeed,
                  like: like,
                  totalCount: totalCount,
                  id: id,
                ),
              ),
      ],
    );
  }

  Widget filter(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: size.width * 0.08, top: size.height * 0.04),
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.1, bottom: size.height * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.01),
                          child: const Text(
                            "Filter Events",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                swap = screens.explore;
                              });
                            },
                            icon: const Icon(Icons.close)),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * 0.16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sort by",
                            style: TextStyle(color: Colors.black38),
                          ),
                          Container(
                            //  margin:  EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                              color: const Color(0XFFECF2F2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0, left: 10),
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: value,
                                    items: dropdown.map(buildMenuItem).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        this.value = value;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * 0.16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Distance",
                            style: TextStyle(color: Colors.black38),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                              color: const Color(0XFFECF2F2),
                              borderRadius: BorderRadius.circular(10),
                              //border: Border.all(color : Colors.black38),
                            ),
                            child: Flexible(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * 0.16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "From",
                            style: TextStyle(color: Colors.black38),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                              color: const Color(0XFFECF2F2),
                              borderRadius: BorderRadius.circular(10),
                              //border: Border.all(color : Colors.black38),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * 0.16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "To",
                            style: TextStyle(color: Colors.black38),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                              color: const Color(0XFFECF2F2),
                              borderRadius: BorderRadius.circular(10),
                              //border: Border.all(color : Colors.black38),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Conditions',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    Wrap(
                        children:
                            List.generate(eventconditions.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 6.0, top: 10),
                        child: Elevatedbuttons(
                          sidecolor: Colors.white,
                          width: size.width * 0.4,
                          coloring: const Color(0XFF368890),
                          text: eventconditions[index]['consitions'],
                          textColor: const Color(0XFFFFFFFF),
                        ),
                      );
                    })),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ));
  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      Lat = position.latitude.toString();
      long = position.longitude.toString();
      latlong = Lat! + "," + long;
    });
    print(latlong);
    locationpost();
  }

  void getInitializedSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _name = _sharedPreferences.getString('name')!;
    _email1 = _sharedPreferences.getString('email')!;

    _token = _sharedPreferences.getString('accessToken')!;

    print(_token);
  } ////////////////////////////////////////////////////////////////////////

  Future getEvetns() async {
    getLocation();
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    id = _sharedPreferences.getString('id')!;
    print("Inside the Get Event function");
    try {
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      Response response = await _dio.get(urlEvent);
      //print(response.data);
      if (response.statusCode == 200) {
        eventsModel = EventsModel.fromJson(response.data);

        lenght = eventsModel!.data.length;
        for (int i = 0; i < eventsModel!.data.length; i++) {
          var km = eventsModel!.data[i].km;
          if (eventsModel!.data[i].events.liveFeed.isNotEmpty) {
            for (int j = 0;
                j < eventsModel!.data[i].events.liveFeed.length;
                j++) {
              var js = {
                'img': eventsModel!.data[i].events.liveFeed[j].path,
                'km': km,
                'eventId': eventsModel!.data[i].events.liveFeed[j].eventId
              };

              eventsLiveFeed.add(js);
            }
            // test = true;
          } else {
            //test = false;
          }
        }
        print(lenght);
        // print(MainUrl + _eventsModel.data[0].events.user.profilePicture.image);
      }
    } catch (e) {
      print(e.toString() + "Catch");
    } finally {
      listFav();

      _isLoading = false;
      setState(() {});
    }
  }

  listFav() {
    if (eventsModel!.data.length > 0) {
      for (int i = 0; i < eventsModel!.data.length; i++) {
        var value = eventsModel!.data[i].isFavroute;
        var value1 = eventsModel!.data[i].isLiked;
        var value2 = eventsModel!.data[i].totalLikes;
        like.add(value1);
        totalCount.add(value2);
        favourite.add(value);
      }
    } else {
      favourite.add(0);
      totalCount.add(0);
      favourite.add(0);
    }
  }

  locationpost() async {
    // ignore: avoid_print
    print("Location section ");
    print(_token);
    FormData formData = FormData.fromMap({
      "lat_lng": latlong,
    });
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _dio.options.headers["Authorization"] = "Bearer ${_token}";

    response = await _dio.post(
      urlLocation,
      data: formData,
    );
    print(response.toString());
  }

  searchApiCall() async {
    search.clear();
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    Map<String, String> qParams = {
      'text': _search.text,
    };

    try {
      // Response response = await _dio.get(searchUrl);
      // print(response.data);
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      await _dio.get(searchUrl, queryParameters: qParams).then((value) {
        print(value.data);
        if (response.statusCode == 200) {
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
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.radiusofbutton,
    this.profileImage = '',
    this.onpressed,
    required this.title,
  }) : super(key: key);

  final BorderRadiusGeometry? radiusofbutton;
  final String? profileImage;
  final String title;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(profileImage!), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 13),
        ),
      ],
    );
  }
}

class Buttonicon extends StatelessWidget {
  const Buttonicon(
      {Key? key, this.radiusofbutton, required this.title, this.icon})
      : super(key: key);

  final BorderRadiusGeometry? radiusofbutton;

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: radiusofbutton!,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 15,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
