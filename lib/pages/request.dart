import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Pendingrequests extends StatefulWidget {
  const Pendingrequests({Key? key}) : super(key: key);

  @override
  _PendingrequestsState createState() => _PendingrequestsState();
}

class _PendingrequestsState extends State<Pendingrequests> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Pending requests",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(20, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                color: Colors.black12),
                          ],
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(300),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://www.lancasterbrewery.co.uk/files/images/christmasparty.jpg',
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("Awais",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  ElevatedButton(
                                    child: const Text("Accept"),
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(0XFF368890),
                                    ),
                                  ),
                                  ElevatedButton(
                                    child: const Text("Decline"),
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.redAccent),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
