

import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Container(
            //   // color: Colors.green,
            //   height: MediaQuery.of(context).size.height * 0.1,
            //   width: 150,
            //   child: Image.asset(
            //     "",
            //     fit: BoxFit.fill,
            //   ),
            // ),
            // Text(
            //   " ",
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 18,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "V 0.0.1",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 9,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Online",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              ' ' ,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'useremail',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
              Text(
                '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    ); ;
  }
}
