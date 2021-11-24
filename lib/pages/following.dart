import 'package:event_spotter/widgets/more/followinglist.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:flutter/material.dart';

class Following extends StatelessWidget {
  const Following({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController _search = TextEditingController();

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
                  padding: const EdgeInsets.only(top : 30, right: 30 , left : 30 , bottom: 30),
                  child: Column(
            children: [
              Textform(
                controller: _search,
                icon: Icons.search,
                label: "Search",
                color: const Color(0XFFECF2F3),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: Offset(2, 2))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(top : 20 , right: 20 , left: 20 ),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            "You have",
                            style: TextStyle(fontSize: 15, color: Colors.black54),
                          ),

                         SizedBox(width:10,),
                          Text(
                            "2534 Followers",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Followinglist(size: size)
                    ],
                  ),
                ),
              )
            ],
                  ),
                ),
          )),
    );
  }
}

