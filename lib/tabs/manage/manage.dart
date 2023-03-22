import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../dashboard/dashboard.dart';

class Manage extends StatefulWidget {
  const Manage({Key? key}) : super(key: key);

  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  'Admin Dashboard',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                color: Color(0xFF3474E0),
                height: scrheight * 0.08,
                width: scrwidth * 0.15,
                child: const Center(
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
          child: Row(
            children: [
              Text('Manage',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
          child: Row(
            children: [
              InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ProductsWidget(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        // await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         ProductsWidget(),
                        //   ),
                        // );
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.productHunt,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80,
                    ),
                    Text(
                      'Products',
                      style:TextStyle(
                          fontFamily: 'Poppins'),

                    )
                  ],
                ),
              ),
              SizedBox(width: scrwidth*0.030,),
              InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => BrandsWidget(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        // await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => BrandsWidget(),
                        //   ),
                        // );
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.bold,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80,
                    ),
                    Text(
                      'Brands',
                      style: TextStyle(
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),SizedBox(width: scrwidth*0.030,),
              InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CategoryWidget(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        // await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         CategoryWidget(),
                        //   ),
                        // );
                      },
                      icon: Icon(
                        Icons.category,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80,
                    ),
                    Text(
                      'Category',
                      style:TextStyle(
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),SizedBox(width: scrwidth*0.030,),
              InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => OfferWidget(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        // await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => OfferWidget(),
                        //   ),
                        // );
                      },
                      icon: Icon(
                        Icons.local_offer,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80,
                    ),
                    Text(
                      'Offers',
                      style: TextStyle(
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),SizedBox(width: scrwidth*0.030,),
              InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => OfferWidget(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        // await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => BranchWidget(),
                        //   ),
                        // );
                      },
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80,
                    ),
                    Text(
                      'Branches',
                      style:TextStyle(
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),SizedBox(width: scrwidth*0.030,),

            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
          child: Row(
            children: [
              InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => OfferWidget(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        // await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => BranchWidget(),
                        //   ),
                        // );
                      },
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80,
                    ),
                    Text(
                      'Branches',
                      style:TextStyle(
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),SizedBox(width: scrwidth*0.030,),
              InkWell(
                onTap: ()  {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => BannerWidget(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.photo_library,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80, onPressed: () {  },
                    ),
                    Text(
                      'Banners',
                      style:TextStyle(
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),SizedBox(width: scrwidth*0.030,),
              InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AddGroupWidget(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.group_add,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80, onPressed: () {  }
                      ,
                    ),
                    Text(
                      'Groups',
                      style: TextStyle(
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),SizedBox(width: scrwidth*0.030,),
              InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => SMTP(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.sms_outlined,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80, onPressed: () {  }
                      ,
                    ),
                    Text(
                      'SMTP',
                      style: TextStyle(
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),SizedBox(width: scrwidth*0.030,),
              InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => Medal(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.leaderboard,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80, onPressed: () {  }
                      ,
                    ),
                    Text(
                      'Medal',
                      style:TextStyle(
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),SizedBox(width: scrwidth*0.030,),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
          child: Row(
            children: [

              InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AddMessage(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.add_alert,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80, onPressed: () {  }
                      ,
                    ),
                    Text(
                      'Running Message',
                      style:TextStyle(
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),SizedBox(width: scrwidth*0.030,),
              InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AddContact(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.add_call,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80, onPressed: () {  },
                    ),
                    Text(
                      'Add Contact',
                      style:TextStyle(
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),SizedBox(width: scrwidth*0.030,),
              InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AddNotification(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.notification_add,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80, onPressed: () {  },
                    ),
                    Text(
                      'Add Notification',
                      style:TextStyle(
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),SizedBox(width: scrwidth*0.030,),
              InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AddAnnoucement(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.announcement,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80, onPressed: () {  },
                    ),
                    Text(
                      'Add Announcement',
                      style:TextStyle(
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),SizedBox(width: scrwidth*0.030,),SizedBox(width: scrwidth*0.030,),
              InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AddSurvey(),
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.question_answer_rounded,
                        color: Colors.black,
                        size: 80,
                      ),
                      iconSize: 80, onPressed: () {  },
                    ),
                    Text(
                      'Add Survey',
                      style: TextStyle(
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),


      ],),
    );
  }
}
