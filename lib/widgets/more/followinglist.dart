import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/followinglistmodel.dart';
import 'package:event_spotter/pages/timeago.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Followinglist extends StatefulWidget {
  FollowingListModel followingListModel;
  Followinglist({
    Key? key,
    required this.followingListModel,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<Followinglist> createState() => _FollowinglistState();
}

final Dio _dio = Dio();
late SharedPreferences _sharedPreferences;
bool _isLoading = true;
bool test = false;
late FollowingListModel _followingListModel;
late String _token;

class _FollowinglistState extends State<Followinglist> {
  String MainUrl = "https://theeventspotter.com/";
  String unFollow = "https://theeventspotter.com/api/unfollow";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.followingListModel.data.length, (index) {
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
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.block,
                          )),
                      const Text(
                        "UnFollow",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
                                  widget.followingListModel.data[index]
                                      .followingUser.profilePicture.image),
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
                              widget.followingListModel.data[index]
                                  .followingUser.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
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
              widget.followingListModel.data[index].followingUser.createdAt),
          style: const TextStyle(fontSize: 15, color: Colors.black45),
        ),
      ),
    );
  }

  unfollow(int index) async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _token = _sharedPreferences.getString('accessToken')!;
    FormData formData = new FormData.fromMap({
      "id": widget.followingListModel.data[index].id,
    });
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    await _dio.post(unFollow, data: formData).then((value) {
      if (value.data["success"] == true) {
        showToaster(value.data["message"]);
      } else {
        print("error");
      }
    });
  }
}
