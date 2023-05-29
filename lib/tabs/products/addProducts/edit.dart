import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../widgets/button.dart';
import '../../dashboard/dashboard.dart';
import 'ProductImages.dart';
import 'editProduct.dart';



class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  List students = [];
  late TextEditingController search = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Stream<QuerySnapshot>? userStream;
  bool nxtVal = false;

  List datas = [
    'Update',
    'Image',
  ];

  Map<int, DocumentSnapshot> lastDocuments = {};
  List data = [];
  int pageIndex = 0;
  var lastDoc;
  var firstDoc;
  int limit = 20;
  int selectedIndex = 0;
  Timestamp? datePicked1;
  Timestamp? datePicked2;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  final scroll = ScrollController();
  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    userStream =
        FirebaseFirestore.instance.collection('pendingPayments')
            .orderBy('placedDate',descending: true)
            .where('paymentReceived',isEqualTo: false)
            .limit(limit)
            .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: scroll,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Failed Orders',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Material(
                      color: Colors.transparent,
                      elevation: 5,
                      child: Container(
                        width: 550,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              color: Color(0xFFF1F4F8),
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SingleChildScrollView(
                                controller: scroll,
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children:
                                    List.generate(datas.length, (index) {
                                      return Padding(
                                        padding:
                                        const EdgeInsets.only(right: 10),
                                        child: InkWell(
                                          onTap: () {
                                            selectedIndex = index;
                                            if(index==0){
                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Editproduct()));
                                            }else{
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductImages()));
                                            }
                                            setState(() {});
                                          },
                                          child: Container(
                                            width: 90,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              color: selectedIndex == index
                                                  ? Colors.teal
                                                  : Color(0xFFF1F4F8),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  color: Color(0x3B000000),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 4, 4, 4),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      datas[index],
                                                      style: TextStyle(
                                                        fontFamily:
                                                        'Lexend Deca',
                                                        color: selectedIndex ==
                                                            index
                                                            ? Colors.white
                                                            : Color(0xFF090F13),
                                                        fontSize: 9,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Container(
                      width: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color(0x39000000),
                            offset: Offset(0, 1),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                                child: TextFormField(
                                  controller: search,
                                  obscureText: false,
                                  onChanged: (text) {
                                    if (text == "") {
                                      userStream = FirebaseFirestore.instance
                                          .collection("orders")
                                          .where('orderStatus', isEqualTo: selectedIndex)
                                          .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
                                          .where('placedDate', isLessThanOrEqualTo: datePicked2)
                                          .orderBy('placedDate', descending: true)
                                          .limit(limit)
                                          .snapshots();
                                    } else {
                                      userStream = FirebaseFirestore.instance
                                          .collection("orders")
                                          .where('orderStatus', isEqualTo: selectedIndex)
                                          .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
                                          .where('placedDate', isLessThanOrEqualTo: datePicked2)
                                          .orderBy('placedDate', descending: true)
                                          .limit(limit)
                                          .where('search',
                                          arrayContains: text.toUpperCase())
                                          .snapshots();
                                    }
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Search ',
                                    hintText: 'Please Enter Name',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF7C8791),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF090F13),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  search.clear();
                                  userStream = FirebaseFirestore.instance
                                      .collection("orders")
                                      .where('orderStatus', isEqualTo: selectedIndex)
                                      .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
                                      .where('placedDate', isLessThanOrEqualTo: datePicked2)
                                      .orderBy('placedDate', descending: true)
                                      .limit(limit)
                                      .snapshots();
                                  setState(() {});
                                },
                                text: 'Clear',
                                options: FFButtonOptions(
                                  width: 100,
                                  height: 40,
                                  color: Color(0xFF4B39EF),
                                  textStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  elevation: 2,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
