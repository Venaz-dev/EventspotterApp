import 'package:event_spotter/constant/json/live_feed.dart';
import 'package:event_spotter/models/eventsModel.dart';
import 'package:flutter/material.dart';

class Livefeeds extends StatefulWidget {
  Livefeeds({Key? key, required this.eventsLiveFeeds}) : super(key: key);

  late List eventsLiveFeeds;

  @override
  State<Livefeeds> createState() => _LivefeedsState();
}

class _LivefeedsState extends State<Livefeeds> {
  @override
  late int lenght;

  String MainUrl = "https://theeventspotter.com/";
  void initState() {
    super.initState();
    lenght = widget.eventsLiveFeeds.length;
    print('hello g $lenght');
    //lenght = lenght - 1;
    print(lenght);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Event live feed",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: List.generate(widget.eventsLiveFeeds.length, (index) {
            // if (widget.liveModel.data[index].events.liveFeed.isNotEmpty) {
            //   lenght1 = widget.liveModel.data[index].events.liveFeed.length;

            return Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
              ),
              child: Container(
                height: size.height * 0.23,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  // color: Colors.red,
                ),
                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.2,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(MainUrl +
                                  widget.eventsLiveFeeds[index]['img']),
                              fit: BoxFit.cover)),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          widget.eventsLiveFeeds[index]['km'] + "miles",
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 17),
                        )),
                  ],
                ),
              ),
            );

            // } else {
            //   //index = index + 1;
            //   return const SizedBox();
            // }
          })),
        ),
      ],
    );
  }
}
