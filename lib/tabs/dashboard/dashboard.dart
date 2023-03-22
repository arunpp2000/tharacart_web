import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var scrwidth;
var scrheight;
var primaryColor;

ScrollController scroll = ScrollController();
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
   scroll = ScrollController();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    scrwidth = MediaQuery.of(context).size.width;
    scrheight = MediaQuery.of(context).size.height;
     primaryColor=Color(0xff5B19A8);

    return Scaffold(
      body: SingleChildScrollView(
        controller: scroll,
        child: Column(
          children: [
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
                    color: primaryColor,
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
                  Text('Sales Report',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                        child: Text('B2C Sales'),
                      ),
                      Container(
                        width: scrwidth * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7,
                              color: Color(0x2F1D2429),
                              offset: Offset(0, 3),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.local_police_rounded,
                                      color: Color(0xFF4B39EF),
                                      size: 44,
                                    ),
                                    Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Color(0x4C4B39EF),
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 0),
                                        child: Text('This Month (' ')'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('Total Sales',
                                                style: TextStyle(
                                                  color: Color(0xFF39D2C0),
                                                  fontFamily: 'Lexend Deca',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                )

                                              // FlutterFlowTheme.bodyText1.override(
                                              //   fontFamily: 'Lexend Deca',
                                              //   color: Color(0xFF39D2C0),
                                              //   fontSize: 14,
                                              //   fontWeight: FontWeight.bold,
                                              // ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 4, 0, 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(' ',
                                                // '₹ ${'thisMonthSales'.toStringAsFixed(2)}',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('Total Orders',
                                                style: TextStyle(
                                                  color: Color(0xFF39D2C0),
                                                  fontFamily: 'Lexend Deca',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 4, 0, 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('',
                                                // thisMonthOrders.toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: scrwidth * 0.030,
                      ),
                      Container(
                        width: scrwidth * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7,
                              color: Color(0x2F1D2429),
                              offset: Offset(0, 3),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.local_police_rounded,
                                      color: Color(0xFF4B39EF),
                                      size: 44,
                                    ),
                                    Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Color(0x4C4B39EF),
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 0),
                                        child: Text('This Year (' ')'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('Total Sales',
                                                style: TextStyle(
                                                  color: Color(0xFF39D2C0),
                                                  fontFamily: 'Lexend Deca',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                )

                                                // FlutterFlowTheme.bodyText1.override(
                                                //   fontFamily: 'Lexend Deca',
                                                //   color: Color(0xFF39D2C0),
                                                //   fontSize: 14,
                                                //   fontWeight: FontWeight.bold,
                                                // ),
                                                ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 4, 0, 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(' ',
                                                // '₹ ${'thisMonthSales'.toStringAsFixed(2)}',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('Total Orders',
                                                style: TextStyle(
                                                  color: Color(0xFF39D2C0),
                                                  fontFamily: 'Lexend Deca',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 4, 0, 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('',
                                                // thisMonthOrders.toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: scrwidth * 0.060,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                        child: Text('B2B Sales'),
                      ),
                      Container(
                        width: scrwidth * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7,
                              color: Color(0x2F1D2429),
                              offset: Offset(0, 3),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.local_police_rounded,
                                      color: Color(0xFF4B39EF),
                                      size: 44,
                                    ),
                                    Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Color(0x4C4B39EF),
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 0),
                                        child: Text('This Month (' ')'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('Total Sales',
                                                style: TextStyle(
                                                  color: Color(0xFF39D2C0),
                                                  fontFamily: 'Lexend Deca',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                )

                                              // FlutterFlowTheme.bodyText1.override(
                                              //   fontFamily: 'Lexend Deca',
                                              //   color: Color(0xFF39D2C0),
                                              //   fontSize: 14,
                                              //   fontWeight: FontWeight.bold,
                                              // ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 4, 0, 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(' ',
                                                // '₹ ${'thisMonthSales'.toStringAsFixed(2)}',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('Total Orders',
                                                style: TextStyle(
                                                  color: Color(0xFF39D2C0),
                                                  fontFamily: 'Lexend Deca',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 4, 0, 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('',
                                                // thisMonthOrders.toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: scrwidth * 0.030,
                      ),
                      Container(
                        width: scrwidth * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7,
                              color: Color(0x2F1D2429),
                              offset: Offset(0, 3),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.local_police_rounded,
                                      color: Color(0xFF4B39EF),
                                      size: 44,
                                    ),
                                    Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Color(0x4C4B39EF),
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 0),
                                        child: Text('This Year (' ')'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('Total Sales',
                                                style: TextStyle(
                                                  color: Color(0xFF39D2C0),
                                                  fontFamily: 'Lexend Deca',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                )

                                              // FlutterFlowTheme.bodyText1.override(
                                              //   fontFamily: 'Lexend Deca',
                                              //   color: Color(0xFF39D2C0),
                                              //   fontSize: 14,
                                              //   fontWeight: FontWeight.bold,
                                              // ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 4, 0, 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(' ',
                                                // '₹ ${'thisMonthSales'.toStringAsFixed(2)}',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('Total Orders',
                                                style: TextStyle(
                                                  color: Color(0xFF39D2C0),
                                                  fontFamily: 'Lexend Deca',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 4, 0, 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('',
                                                // thisMonthOrders.toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20),
              child: Divider(
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(
              height: scrwidth * 0.004,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
              child: Row(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: IconButton(
                            onPressed: () async {
                              // await Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         ShipmentPage(),
                              //   ),
                              // );
                            },
                            icon: Icon(
                              Icons.local_shipping,
                              size: 70,
                            ),
                            iconSize: 60,
                          ),
                        ),
                        Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            'Shipment',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: scrwidth * 0.040,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Badge(
                          child: IconButton(
                            onPressed: () async {
                              // await Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         ReturnOrders(),
                              //   ),
                              // );
                            },
                            icon: Icon(
                              Icons.keyboard_return,
                              size: 70,
                            ),
                            iconSize: 60,
                          ),

                          badgeContent: Text('2'
                              // newReturn.toString(),

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
                            'Return Requests',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: scrwidth * 0.040,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Badge(
                          child: IconButton(
                            onPressed: () async {
                              // await Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         B2BRequestWidget(),
                              //   ),
                              // );
                            },
                            icon: Icon(
                              Icons.person_add_sharp,
                              color: Colors.black,
                              size: 60,
                            ),
                            iconSize: 60,
                          ),

                          badgeContent: Text(''
                              //newB2bRequest.toString(),
                              // style: FlutterFlowTheme.bodyText1
                              //     .override(
                              //   fontFamily: 'Poppins',
                              //   color: Colors.white,
                              // ),
                              ),
                          // showBadge: true,
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
                            'B2B Requests',
                            // style: FlutterFlowTheme.title1
                            //     .override(
                            //     fontFamily: 'Poppins',
                            //     fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: scrwidth * 0.040,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Badge(
                          child: IconButton(
                            onPressed: () async {
                              // await Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         PayoutsWidget(),
                              //   ),
                              // );
                            },
                            icon: Icon(
                              Icons.payments,
                              color: Colors.black,
                              size: 60,
                            ),
                            iconSize: 60,
                          ),

                          badgeContent: Text(''
                              // newPayout.toString(),
                              // style: FlutterFlowTheme.bodyText1
                              //     .override(
                              //   fontFamily: 'Poppins',
                              //   color: Colors.white,
                              // ),
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
                            'Payouts',
                            //   style: FlutterFlowTheme.title1
                            //       .override(
                            //       fontFamily: 'Poppins',
                            //       fontSize: 20),
                            // ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
