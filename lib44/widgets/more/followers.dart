import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/followinglistmodel.dart';
import 'package:event_spotter/models/getfollowerlistmodel.dart';
import 'package:event_spotter/pages/timeago.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Followerlist extends StatefulWidget {
  FollowerListModel followerListModel;

  Followerlist({Key? key, required this.size, required this.followerListModel})
      : super(key: key);

  final Size size;

  @override
  State<Followerlist> createState() => _FollowerlistState();
}

class _FollowerlistState extends State<Followerlist> {
  String MainUrl = "https://theeventspotter.com/";
  String unFollow = "https://theeventspotter.com/api/unfollow";

  late SharedPreferences _sharedPreferences;
  bool _isLoading = true;
  bool test = false;
  Dio _dio = Dio();
  late FollowingListModel _followingListModel;
  late String _token;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.followerListModel.data.length, (index) {
        {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.white),
                  left: BorderSide(color: Colors.white),
                  right: BorderSide(color: Colors.white),
                  bottom: BorderSide(color: Colors.black26)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          await remove(index);
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          FontAwesomeIcons.userMinus,
                          size: 15,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await remove(index);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Remove",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(MainUrl +
                                  widget.followerListModel.data[index].user
                                      .profilePicture!.image!),
                              fit: BoxFit.cover,
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.followerListModel.data[index].user.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                            // Text(
                            //    following[index]['description'],
                            //   style: const TextStyle(
                            //       color: Colors.black,
                            //       fontSize: 15,
                            //       fontWeight: FontWeight.w300),
                            // )
                            time(index),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  time(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          TimeAgo.displayTimeAgoFromTimestamp(
              widget.followerListModel.data[index].user.createdAt),
          style: const TextStyle(fontSize: 15, color: Colors.black45),
        ),
      ),
    );
  }

  remove(int index) async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _token = _sharedPreferences.getString('accessToken')!;

    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    FormData formData = FormData.fromMap({
      "id": widget.followerListModel.data[index].followingId,
    });
    try {
      await _dio.post(unFollow, data: formData).then((value) {
        if (value.data["success"] == true) {
          showToaster(value.data["message"]);
        } else {
          print("error");
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
