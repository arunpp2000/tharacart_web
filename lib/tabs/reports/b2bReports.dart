import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';


import 'package:flutter/material.dart';


class B2bReports extends StatefulWidget {
  const B2bReports({Key? key}) : super(key: key);

  @override
  _B2bReportsState createState() => _B2bReportsState();
}

class _B2bReportsState extends State<B2bReports> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  late Timestamp thisYear;
  bool _loadingButton1 = false;
  late Timestamp thisMonth;
  late Timestamp todayDate;


  int totalOrders=0;
  int thisMonthOrders=0;
  int totalOrdersB2B=0;
  int thisMonthOrdersB2B=0;
  double thisMonthSales=0;
  double totalSales=0;
  double thisMonthSalesB2B=0;
  double totalSalesB2B=0;

  String month='';
  getTotalOrdersB2C() async {


    FirebaseFirestore.instance.collection('orders')

    // .orderBy('invoiceDate',descending: true)
    //   .where('orderStatus',isGreaterThan: 2)
        .where('invoiceDate',isGreaterThanOrEqualTo: thisYear)

        .snapshots().listen((event) {

      totalOrders=event.docs.length;
      print('--------------------------------');
      print(totalOrders);

      totalSales=0;
      for(DocumentSnapshot data in event.docs){
        if(data['orderStatus']>2){
          totalSales+=data.get('price');

        }

      }

      if(mounted){
        setState(() {

        });
      }


    });



  }
  getThisMonthB2C() async {


    FirebaseFirestore.instance.collection('orders')
    // .orderBy('invoiceDate',descending: true)
        .where('invoiceDate',isGreaterThanOrEqualTo: thisMonth)
        .snapshots().listen((event) {

      thisMonthOrders=event.docs.length;

      thisMonthSales=0;
      for(DocumentSnapshot data in event.docs){
        if(data['orderStatus']>2){

          thisMonthSales+=data.get('price');

        }
      }

      if(mounted){
        setState(() {

        });
      }


    });



  }

  getTotalOrdersB2B() async {

    print(thisYear.toDate().toString().substring(0,10));

    FirebaseFirestore.instance.collection('b2bOrders')
    // .orderBy('invoiceDate',descending: true)
        .where('invoiceDate',isGreaterThanOrEqualTo: thisYear)

        .snapshots().listen((event) {

      totalOrdersB2B=event.docs.length;

      totalSalesB2B=0;
      for(DocumentSnapshot data in event.docs){
        if(data['orderStatus']>2){

          totalSalesB2B+=data.get('price');

        }
      }

      if(mounted){
        setState(() {

        });
      }


    });



  }
  getThisMonthB2B() async {


    FirebaseFirestore.instance.collection('b2bOrders')
    // .orderBy('invoiceDate',descending: true)
        .where('invoiceDate',isGreaterThanOrEqualTo: thisMonth)
        .snapshots().listen((event) {

      thisMonthOrdersB2B=event.docs.length;

      thisMonthSalesB2B=0;
      for(DocumentSnapshot data in event.docs){
        if(data['orderStatus']>2){

          thisMonthSalesB2B+=data.get('price');

        }
      }

      if(mounted){
        setState(() {

        });
      }


    });



  }
  @override
  void initState() {
    super.initState();
    DateTime today=DateTime.now();

    thisYear =Timestamp.fromDate(DateTime(today.year,1,1,0,0,0));
    todayDate =Timestamp.fromDate(DateTime(today.year,today.month,today.day,0,0,0));

    thisMonth =Timestamp.fromDate(DateTime(today.year,today.month,0,0));
    month=
    todayDate.toDate().month==1? 'January':
    todayDate.toDate().month==2? 'February':
    todayDate.toDate().month==3? 'March':
    todayDate.toDate().month==4? 'April':
    todayDate.toDate().month==5? 'May':
    todayDate.toDate().month==6? 'June':
    todayDate.toDate().month==7? 'July':
    todayDate.toDate().month==8? 'August':
    todayDate.toDate().month==9? 'September':
    todayDate.toDate().month==10? 'October':
    todayDate.toDate().month==11? 'November':'December';

    getTotalOrdersB2C();
    getThisMonthB2C();

    getTotalOrdersB2B();
    getThisMonthB2B();

    print(thisYear.toDate().toString().substring(0,10));

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(

          children: [
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //
            //     TextButton(
            //
            //         onPressed: () {
            //           showDatePicker(
            //               context: context,
            //               initialDate: selectedDate1,
            //               firstDate: DateTime(1901, 1),
            //               lastDate: DateTime(2100,1)).then((value){
            //
            //             setState(() {
            //               DateFormat("yyyy-MM-dd").format(value);
            //               datePicked1 = Timestamp.fromDate(value);
            //               selectedDate1=value;
            //             });
            //           });
            //
            //         },
            //         child: Text(
            //           datePicked1==null?'Choose Starting Date': datePicked1.toDate().toString().substring(0,10),
            //           style: FlutterFlowTheme.bodyText1.override(
            //             fontFamily: 'Poppins',
            //             color: Colors.blue,
            //             fontSize: 11,
            //             fontWeight: FontWeight.w600,),
            //         )),
            //     Text(
            //       'To',
            //       style: FlutterFlowTheme.bodyText1.override(
            //         fontFamily: 'Poppins',
            //       ),
            //     ),
            //     TextButton(
            //
            //         onPressed: () {
            //           showDatePicker(
            //               context: context,
            //               initialDate: selectedDate2,
            //               firstDate: DateTime(1901, 1),
            //               lastDate: DateTime(2100,1)).then((value){
            //
            //             setState(() {
            //               DateFormat("yyyy-MM-dd").format(value);
            //               datePicked2 = Timestamp.fromDate(value);
            //               selectedDate2=value;
            //             });
            //           });
            //
            //         },
            //         child: Text(
            //           datePicked2==null?'Choose Ending Date': datePicked2.toDate().toString().substring(0,10),
            //           style: FlutterFlowTheme.bodyText1.override(
            //             fontFamily: 'Poppins',
            //             color: Colors.blue,
            //             fontSize: 11,
            //             fontWeight: FontWeight.w600,),
            //         )),
            //     FlutterFlowIconButton(
            //       borderColor: Colors.transparent,
            //       borderRadius: 30,
            //       borderWidth: 1,
            //       buttonSize: 50,
            //       icon: FaIcon(
            //         FontAwesomeIcons.search,
            //         color: Colors.black,
            //         size: 25,
            //       ),
            //       onPressed: () async {
            //         if(datePicked1!=null&&datePicked2!=null){
            //           print('pressed');
            //           print(datePicked1);
            //           print(datePicked2);
            //
            //           await getName();
            //           print('pressed1');
            //         }else{
            //           datePicked1==null? showUploadMessage(context, 'Please Choose Starting Date'):
            //           showUploadMessage(context, 'Please Choose Ending Date');
            //         }
            //
            //
            //
            //       },
            //     )
            //   ],
            // ),
// Generated code for this Card_11 Widget...
            InkWell(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BReportsWidget()));
              },
              child: Container(
                width:500,
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                child: Text(
                                  'This Month ($month) ',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
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
                                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Total Sales',
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF39D2C0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                        '₹ ${thisMonthSalesB2B.toStringAsFixed(2)}',
                                        style:GoogleFonts.poppins(
                                            fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black
                                        )
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Total Orders',
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF39D2C0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                        thisMonthOrdersB2B.toString(),
                                        style:GoogleFonts.poppins(
                                            fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black
                                        )
                                    ),
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
            ),
            SizedBox(height: 50,),

            InkWell(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BReportsWidget()));

              },
              child: Container(
                width:500,
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                child: Text(
                                  'This Year ( ${thisYear.toDate().year}.${thisYear.toDate().month}.${thisYear.toDate().day} )',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
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
                                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Total Sales',
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF39D2C0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                        '₹ ${totalSalesB2B.toStringAsFixed(2)}',
                                        style:GoogleFonts.poppins(
                                            fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black
                                        )
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Total Orders',
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF39D2C0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                        totalOrdersB2B.toString(),
                                        style:GoogleFonts.poppins(
                                            fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black
                                        )
                                    ),
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
            )
          ],
        ),
      ),
    );
  }
}
