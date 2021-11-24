import 'package:event_spotter/constant/json/follow_list.dart';
import 'package:flutter/material.dart';

class Followinglist extends StatelessWidget {
  const Followinglist({
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
                padding: const EdgeInsets.only(bottom: 20 , top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        Container(
                          height: 18,
                          width: 18,
                          decoration: const BoxDecoration(
                            color: Color(0XFF6D6D6C),
                            shape: BoxShape.circle,
                          ),
                          child:  FittedBox(child: IconButton(
                            padding: EdgeInsets.zero,
                            icon : const Icon(Icons.minimize , color: Colors.white,), onPressed: (){},)),
                        ),

                        const SizedBox(width: 5,),
                        const Text(
                          "Block",
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
