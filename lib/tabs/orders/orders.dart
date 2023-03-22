import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../dashboard/dashboard.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
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
              Text('Orders',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
          child: Row(
            children: [
              Column(
                children: [
                  // Generated code for this Badge Widget...
                  Badge(
                    child: IconButton(
                      onPressed: () async {
                        // await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         OrdersWidget(),
                        //   ),
                        // );
                      },
                      icon: Icon(
                        Icons.add_box_outlined,
                        color: Colors.black,
                        size: 60,
                      ),
                      iconSize: 60,
                    ),

                    badgeContent: Text('2',
                      // newB2cOrders.toString(),
                      style:TextStyle(fontFamily:'Poppins',color: Colors.white, )


                    ),
                    showBadge: true,
                    // shape: BadgeShape.circle,
                    // badgeColor: Colors.red,
                    // elevation: 4,
                    // padding:
                    // EdgeInsetsDirectional.fromSTEB(
                    //     8, 8, 8, 8),
                    // position: BadgePosition.topEnd(),
                    // // animationType: BadgeAnimationType.scale,
                    // toAnimate: true,
                  ),

                  Align(
                    alignment: Alignment(0, 0),
                    child: Text(
                      'B2C Orders',
                      style: TextStyle(fontFamily:'Poppins',color: Colors.black, ) ,
                    ),
                  ),
                ],
              ),
              SizedBox(width: scrwidth*0.08,),

              Column(
                children: [
                  Badge(
                    child: IconButton(
                      onPressed: () async {
                        // await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         B2b_Order(),
                        //   ),
                        // );
                      },
                      icon: Icon(
                        Icons.add_box_outlined,
                        color: Colors.black,
                        size: 60,
                      ),
                      iconSize: 60,
                    ),

                    badgeContent: Text('1',
                      //newB2bOrders.toString(),
                      style:TextStyle(fontFamily:'Poppins',color: Colors.white, )
                    ),
                    showBadge: true,
                    // shape: BadgeShape.circle,
                    // badgeColor: Colors.red,
                    // elevation: 4,
                    // padding:
                    // EdgeInsetsDirectional.fromSTEB(
                    //     8, 8, 8, 8),
                    // position: BadgePosition.topEnd(),
                    // // animationType: BadgeAnimationType.scale,
                    // toAnimate: true,
                  ),
                  const Align(
                    alignment: Alignment(0, 0),
                    child: Text(
                      'B2B Orders',
                      style: TextStyle(fontFamily:'Poppins',color: Colors.black, )
    ),


                  )],
              ),

            ],
          ),
        ),



      ],),
    );
  }
}
