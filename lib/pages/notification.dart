import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/widgets/smallbutton.dart';
import 'package:flutter/material.dart';

class Noti extends StatefulWidget {
  const Noti({Key? key}) : super(key: key);

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
   int index = 0;
  @override
  Widget build(BuildContext context) {
   
    Size size = MediaQuery.of(context).size;
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
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 30, left: 30),
                 child: Row(
                   children: [
                      Elevatedbuttons(
                                    sidecolor: index == 0 ? Colors.transparent : Colors.black , 
                                    text: "Live",
                                    textColor: index == 0 ? Colors.white : Colors.black ,
                                    coloring: index == 0  ? const Color(0XFF38888F) :  Colors.white,
                                    
                                    primary: index == 0 ? const Color(0XFF38888F) : Colors.white,
                                    onpressed: () {
                                      setState(() {
                                        index = 0;
                                        print('sfaf');
                                      });
                                    },
                                    
                                    ),

                                    const SizedBox(width: 20,),

                                     Elevatedbuttons(
                                    sidecolor:  index == 1 ?  Colors.transparent  : Colors.black,
                                    text: "Account",
                                    textColor: index == 1 ? Colors.white : Colors.black,
                                    coloring:index == 1 ?  const Color(0XFF38888F) : Colors.white,
                                 
                                    primary: index == 1 ?  const Color(0XFF38888F) : Colors.white,
                                    
                                       onpressed: () {
                                      setState(() {
                                        index =1;
                                        print('aaq');
                                      });
                                    },),
                   ],
                 ),
                ),
                IndexedStack(
                  index: index,
                  children: [
                   
                    Padding(
                      padding: const EdgeInsets.only(right : 20.0 , left: 30 , top : 30),
                      child: Column(
                        children: [
                          
                          const SizedBox(
                            height: 40,
                          ),
                          notificationinfo(
                              size,
                              Icons.live_tv,
                              'Jhon Doe started a live stream of their event',
                              '3s ago'),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          notificationinfo(size, Icons.camera_enhance,
                              'Jhon Doe added a snap of their event', '1m ago'),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          notificationinfo(
                              size,
                              Icons.live_tv,
                              'Jhon Doe started a live stream of their event',
                              '2m ago'),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          notificationinfo(size, Icons.camera_enhance,
                              'Jhon Doe added a snap of their event', '2m ago'),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          notificationinfo(
                              size,
                              Icons.live_tv,
                              'Jhon Doe started a live stream of their event',
                              '2m ago'),
                        ],
                      ),
                    ),

                     Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          account(
                              size,
                              // 'https://unsplash.com/photos/lLdGG3ESoiI',
                              'Joana Karg',
                              'started following you',
                              '3s ago'),
                          const SizedBox(
                            height: 10,
                          ),
                          account(
                              size,
                              // 'https://unsplash.com/photos/lLdGG3ESoiI',
                              'Lorem KuliaEvening Party',
                              ' commented on your event',
                              '3s ago'),
                          const SizedBox(
                            height: 10,
                          ),
                          account(
                              size,
                              // 'https://unsplash.com/photos/lLdGG3ESoiI',
                              'School Party',
                              'Your event  was unpublished because it didn’t follow our commuity guidelines. Click notification for more details.',
                              '3s ago'),
                          const SizedBox(
                            height: 10,
                          ),
                          account(
                              size,
                              // 'https://unsplash.com/photos/lLdGG3ESoiI',
                              'Karl Jhon',
                              'started following you',
                              '3s ago'),
                          const SizedBox(
                            height: 10,
                          ),
                          account(
                              size,
                              //'https://images.unsplash.com/photo-1522158637959-30385a09e0da?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGV2ZW50fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
                              'Joana karg',
                              'started following you',
                              '43 minutes ago'),
                          const SizedBox(
                            height: 10,
                          ),
                          account(
                              size,
                              // 'https://unsplash.com/photos/lLdGG3ESoiI',
                              'Lorem KuliaEvening Party',
                              'commented on your event',
                              '45 minutes ago'),
                          const SizedBox(
                            height: 10,
                          ),
                          account(
                              size,
                              // 'https://unsplash.com/photos/lLdGG3ESoiI',
                              'School Party',
                              'Your event  was unpublished because it didn’t follow our commuity guidelines. Click notification for more details.',
                              '50 minutes ago'),
                          const SizedBox(
                            height: 10,
                          ),
                          account(
                              size,

                              // 'https://unsplash.com/photos/lLdGG3ESoiI',
                              'Karl Jhon',
                              'started following you',
                              '1 hour ago'),
                        ]),
                  ],
                ),
              ]),
            )));
  }

  notificationinfo(
      Size size, IconData? icon, String? text, String? postedtime) {
    return Row(
      children: [
        Smallbutton(
          size: size.height * 0.06,
          icon: icon,
          onpressed: () {},
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: Text(
            text!,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          postedtime!,
          style: const TextStyle(color: Colors.black45),
        ),
      ],
    );
  }

  account(Size size, String? name, String? details, String? timepassed) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0XFFFAFAFA),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 20, left: 30, right: 30.0, bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://www.lancasterbrewery.co.uk/files/images/christmasparty.jpg'),
                        fit: BoxFit.cover),
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
                        name!,
                        style: const TextStyle(fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        details!,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                timepassed!,
                style: const TextStyle(fontSize: 15, color: Colors.black45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
