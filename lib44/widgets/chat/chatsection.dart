import 'package:flutter/material.dart';

class Chatsection extends StatelessWidget {
  const Chatsection({
    Key? key,
    required this.size,
    this.image,
    this.messenger,
    this.message,
    this.time,
    this.count,
    this.messengercolor,
    this.messagecolor,
    this.fontWeightofmessenger,
    this.fontWeightofmessage,
    this.timecolor,
  }) : super(key: key);

  final Size size;
  final String? image;
  final String? messenger;
  final String? message;
  final String? time;
  final String? count;
  final Color? messengercolor;
  final Color? messagecolor;
  final FontWeight? fontWeightofmessenger;
  final FontWeight? fontWeightofmessage;
  final Color? timecolor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){},
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(color: Colors.white),
                  left: BorderSide(color: Colors.white),
                  right: BorderSide(color: Colors.white),
                  bottom: BorderSide(color: Colors.white)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          //color: Colors.blue,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(image!), fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              messenger!,
                              style: TextStyle(
                                  color: messengercolor,
                                  fontWeight: fontWeightofmessenger,
                                  fontSize: 22.5),
                            ),
                             
                                  Text(
                                    message!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: fontWeightofmessage,
                                        color: messagecolor),
                                  ),
                                 
                                 
                                
                          
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            time!,
                            style: TextStyle(
                                color: timecolor, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.right,
                          ),
                         const  SizedBox(height: 5,),
                           Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0XFF26C696),
                                    ),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          count!,
                                          style: const TextStyle(
                                              color: Color(0XFFFFFFFF), fontSize: 14),
                                        )),
                                  )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Read extends StatelessWidget {
  const Read({
    Key? key,
    required this.size,
    this.image,
    this.messenger,
    this.message,
    this.time,
    this.count,
    this.messengercolor,
    this.messagecolor,
    this.fontWeightofmessenger,
    this.fontWeightofmessage,
    this.timecolor,
  }) : super(key: key);

  final Size size;
  final String? image;
  final String? messenger;
  final String? message;
  final String? time;
  final String? count;
  final Color? messengercolor;
  final Color? messagecolor;
  final FontWeight? fontWeightofmessenger;
  final FontWeight? fontWeightofmessage;
  final Color? timecolor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (){},
          child: Container(
            //   height: size.height * 0.1,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(color: Colors.white),
                  left: BorderSide(color: Colors.white),
                  right: BorderSide(color: Colors.white),
                  bottom: BorderSide(color: Colors.white)),
            ),
        
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          //color: Colors.blue,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(image!), fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              messenger!,
                              style: TextStyle(
                                  color: messengercolor,
                                  fontWeight: fontWeightofmessenger,
                                  fontSize: 22.5),
                            ),
                           Text(
                                  message!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: fontWeightofmessage,
                                      color: messagecolor),
                                ),
                               
                             
                          ],
                        ),
                      ),
                      Text(
                        time!,
                        style: TextStyle(
                            color: timecolor, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
