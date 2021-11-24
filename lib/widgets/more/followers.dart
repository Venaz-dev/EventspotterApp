import 'package:event_spotter/constant/json/follow_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Followerlist extends StatelessWidget {
  const Followerlist({
    Key? key,
    required this.size,
  }) : super(key: key);

  
  final Size size;

  @override
  Widget build(BuildContext context) {
    
    return  Column(
      children: List.generate(following.length , (index){
       
            {
return  Container(
              
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
                        IconButton(onPressed: (){}, icon: const Icon(FontAwesomeIcons.userPlus , size: 15,),
                        ),
                        const SizedBox(width: 5,),
                        const Text(
                          "Unfollow",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    following[index]['image']),
                                fit: BoxFit.cover,
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(
                                following[index]['name'],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 17 , fontWeight: FontWeight.w500),
                              ),
                              Text(
                                 following[index]['description'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              )
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

         
      
      }    
        ),
  
      
    );
  }
}
