import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/eventsModel.dart';
import 'package:event_spotter/pages/event_details_page.dart';
import 'package:event_spotter/pages/explore.dart';
import 'package:event_spotter/widgets/explore/livefeed.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Eventss extends StatefulWidget {
  const Eventss({Key? key}) : super(key: key);

  @override
  State<Eventss> createState() => _EventssState();
}

class _EventssState extends State<Eventss> {
  Dio _dio = Dio();
  late SharedPreferences _sharedPreferences;
  late String _token;
  late int lenght;
  bool _isLoading = true;
  late EventsModel _eventsModel;
  late List eventsLiveFeed = [];
  bool test = false;

  String urlEvent = "https://theeventspotter.com/api/getEvents";
  String MainUrl = "https://theeventspotter.com/";
  @override
  void initState() {
    super.initState();
    getEvetns().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String isFollow = "follow";

    String description = "new year party at local park";

    bool active = false;

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Livefeeds(eventsLiveFeeds: eventsLiveFeed, test: test),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Events near you",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  children:
                      List.generate(lenght = _eventsModel.data.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Eventdetailing(
                                    model: _eventsModel,
                                    indexs: index,
                                  )));
                        },
                        child: Container(
                          height: size.height * 0.38,
                          width: size.width * double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  color: Colors.black12)
                            ],
                          ),
                          child: Column(children: [
                            Container(
                              height: size.height * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: size.width * double.infinity,
                              child: Stack(children: [
                                Container(
                                  height: size.height * 0.25,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: MainUrl +
                                          _eventsModel.data[index].events
                                              .eventPictures[0].imagePath,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  top: size.height * 0.02,
                                  child: SizedBox(
                                    height: size.height * 0.04,
                                    width: size.width * 0.25,
                                    // decoration: const BoxDecoration(color: Color(0XFF38888E)),
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color(0XFF38888E),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.userPlus,
                                              size: 10,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(isFollow),
                                          ],
                                        )),
                                  ),
                                ),
                                Positioned(
                                  top: size.height * 0.07,
                                  right: 20,
                                  child: Column(children: [
                                    LikeButton(
                                        size: 20,
                                        isLiked: active,
                                        likeBuilder: (isliked) {
                                          final color = isliked
                                              ? Colors.red
                                              : Colors.grey;
                                          return Icon(Icons.favorite,
                                              color: color, size: 20);
                                        },
                                        countBuilder: (count, isliked, text) {
                                          final color = isliked
                                              ? Colors.red
                                              : Colors.grey;
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    LikeButton(
                                        size: 20,
                                        isLiked: active,
                                        likeBuilder: (isliked) {
                                          final color = isliked
                                              ? Colors.green
                                              : Colors.grey;
                                          return Icon(Icons.flag,
                                              color: color, size: 20);
                                        },
                                        countBuilder: (count, isliked, text) {
                                          final color = isliked
                                              ? Colors.green
                                              : Colors.grey;
                                        }),
                                  ]),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: size.width * 0.02,
                                  left: size.width * 0.02,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Button(
                                          title: _eventsModel.data[index].events
                                              .user.name, //new
                                          radiusofbutton:
                                              BorderRadius.circular(20),
                                          profileImage: MainUrl +
                                                  _eventsModel
                                                      .data[index]
                                                      .events
                                                      .user
                                                      .profilePicture!.image!
                                                    
                                              ), //new
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Buttonicon(
                                        radiusofbutton:
                                            BorderRadius.circular(20),
                                        icon: FontAwesomeIcons.userPlus,
                                        title: _eventsModel
                                                .data[index].Following
                                                .toString() +
                                            " " "Followers",
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              height: size.height * 0.12,
                              width: double.infinity,
                              decoration: const BoxDecoration(),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: size.height * 0.008,
                                    right: size.width * 0.020,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.calendar,
                                          size: 15,
                                          color: Colors.black54,
                                        ),
                                        Text(
                                          _eventsModel
                                              .data[index].events.eventDate
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black87),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        const Icon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          size: 15,
                                          color: Colors.black54,
                                        ),
                                        Text(
                                            _eventsModel.data[index].km
                                                    .toString() +
                                                " " +
                                                "away",
                                            style: const TextStyle(
                                                color: Colors.black87)),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      top: size.height * 0.04,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          _eventsModel.data[index].events
                                              .eventDescription,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: size.width * 0.01,
                                    left: size.width * 0.01,
                                    child: Row(
                                      children: [
                                        IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              extras(
                                                  FontAwesomeIcons.thumbsUp,
                                                  _eventsModel
                                                      .data[index].isLiked
                                                      .toString(),
                                                  size),
                                              divider(),
                                              extras(
                                                  Icons.comment,
                                                  _eventsModel.data[index]
                                                      .events.comment.length
                                                      .toString(),
                                                  size),
                                              divider(),
                                              // extras(MdiIcons.share,
                                              //     posts[1]['share'], size),
                                              // divider(),                           //no inculded
                                              extras(
                                                  Icons.live_tv,
                                                  _eventsModel.data[index]
                                                      .events.liveFeed.length
                                                      .toString(),
                                                  size),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
  }

  // flaggedOrLiked(Size size, IconData icon) {
  //   return Container(
  //     height: size.height * 0.03,
  //     width: size.width * 0.07,
  //     decoration: const BoxDecoration(color: Colors.white),
  //     child: Icon(
  //       icon,
  //       size: 15,
  //     ),
  //   );
  // }

  VerticalDivider divider() {
    return const VerticalDivider(
      thickness: 1,
      color: Colors.black26,
      indent: 13,
      endIndent: 13,
    );
  }

  extras(IconData icon, String totalcount, Size size) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            icon,
            size: 16,
          ),
          onPressed: () {},
        ),
        Text(totalcount),
      ],
    );
  }

  Future getEvetns() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    print("Inside the Get Event function");
    try {
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      Response response = await _dio.get(urlEvent);
      //print(response.data);
      if (response.statusCode == 200) {
        _eventsModel = EventsModel.fromJson(response.data);
        lenght = _eventsModel.data.length;
        for (int i = 0; i < _eventsModel.data.length; i++) {
          var km = _eventsModel.data[i].km;
          if (_eventsModel.data[i].events.liveFeed.isNotEmpty) {
            for (int j = 0;
                j < _eventsModel.data[i].events.liveFeed.length;
                j++) {
              var js = {
                'img': _eventsModel.data[i].events.liveFeed[j].path,
                'km': km,
              };
              test = true;
              eventsLiveFeed.add(js);
            }
          } else {
            test = false;
          }
        }
        print(lenght);
        // print(MainUrl + _eventsModel.data[0].events.user.profilePicture.image);
      }
    } catch (e) {
      print(e.toString() + "Catch");
    } finally {
      _isLoading = false;
    }
    setState(() {});
  }
}
