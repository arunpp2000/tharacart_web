import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tharacart_web/tabs/orders/quotation/quotationDetailsPage.dart';
import 'package:tharacart_web/tabs/orders/returnOrders/returnOrdersDetails.dart';

import '../../../../widgets/button.dart';
import '../../dashboard/dashboard.dart';
import '../b2c/detailsPage.dart';

class QuotationList extends StatefulWidget {
  const QuotationList({Key? key}) : super(key: key);

  @override
  _QuotationListState createState() => _QuotationListState();
}

class _QuotationListState extends State<QuotationList> {
  List students = [];
  late TextEditingController search = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Stream<QuerySnapshot>? userStream;
  bool nxtVal = false;
  int ind = 0;
  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {
      ind = 0;
      userStream = FirebaseFirestore.instance
          .collection("orders")
          .where('orderStatus', isEqualTo: selectedIndex)
          .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
          .where('placedDate', isLessThanOrEqualTo: datePicked2)
          .orderBy('placedDate', descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(limit)
          .snapshots();
    } else {
      ind += limit;
      userStream = FirebaseFirestore.instance
          .collection("orders")
          .where('orderStatus', isEqualTo: selectedIndex)
          .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
          .where('placedDate', isLessThanOrEqualTo: datePicked2)
          .orderBy('placedDate', descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .startAfterDocument(lastDoc)
          .snapshots();
    }
    setState(() {});
  }

  prev() {
    pageIndex--;
    if (firstDoc == null || pageIndex == 0) {
      ind = 0;
      userStream = FirebaseFirestore.instance
          .collection("orders")
          .where('orderStatus', isEqualTo: selectedIndex)
          .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
          .where('placedDate', isLessThanOrEqualTo: datePicked2)
          .orderBy('placedDate', descending: true)
          .limit(limit)
          .snapshots();
    } else {
      ind -= limit;
      userStream = FirebaseFirestore.instance
          .collection("orders")
          .where('orderStatus', isEqualTo: selectedIndex)
          .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
          .where('placedDate', isLessThanOrEqualTo: datePicked2)
          .orderBy('placedDate', descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(limit)
          .snapshots();
    }
    setState(() {});
  }

  List datas = [
    'Requests',
    'Accepted',
  ];

  Map<int, DocumentSnapshot> lastDocuments = {};
  QuerySnapshot? data;
  int pageIndex = 0;
  var lastDoc;
  var firstDoc;
  int limit = 20;
  int selectedIndex = 0;
  Timestamp? datePicked1;
  Timestamp? datePicked2;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedIndex=0;
    userStream = FirebaseFirestore.instance
        .collection("quotation")
        .where('quotationStatus', isEqualTo: 0)
        .orderBy('placedDate', descending: true)
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
                        'Return Orders',
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
                                            userStream = FirebaseFirestore.instance
                                                .collection("quotation")
                                                .where('quotationStatus', isEqualTo: index)
                                                .orderBy('placedDate', descending: true)
                                                .limit(limit)
                                                .snapshots();
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
                                      // .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
                                      // .where('placedDate', isLessThanOrEqualTo: datePicked2)
                                          .orderBy('placedDate', descending: true)
                                          .limit(limit)
                                          .snapshots();
                                    } else {
                                      userStream = FirebaseFirestore.instance
                                          .collection("orders")
                                          .where('orderStatus', isEqualTo: selectedIndex)
                                      // .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
                                      // .where('placedDate', isLessThanOrEqualTo: datePicked2)
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
                                      .collection("quotation")
                                      .where('quotationStatus', isEqualTo: 0)
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
              StreamBuilder<QuerySnapshot>(
                  stream: userStream,
                  builder: (context, snapshot) {
                    print(snapshot.error);
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }


                    data = snapshot.data;


                    // if (data!.docs.isEmpty) {
                    //   // lastDoc = snapshot.data?.docs[data!.docs.length - 1];
                    //   // lastDocuments[pageIndex] = lastDoc;
                    //   // firstDoc = snapshot.data?.docs[0];
                    // }

                    return data!.docs.isEmpty
                        ? LottieBuilder.network(
                      'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                      height: 500,
                    )
                        : SizedBox(
                      width:
                      // double.infinity,
                      MediaQuery.of(context).size.width * 0.85,
                      child: DataTable(
                        horizontalMargin: 10,
                        columnSpacing: 20,
                        columns: [
                          DataColumn(
                            label: Text(
                              "S.No",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
                          ),
                          DataColumn(
                            label: Text("Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11)),
                          ),
                          DataColumn(
                            label: Text(
                              "Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
                          ),
                          DataColumn(
                            label: Text("Shipping Method",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11)),
                          ),
                          DataColumn(
                            label: Text("Amount",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11)),
                          ),
                          DataColumn(
                            label: Text("Action",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11)),
                          ),
                        ],
                        rows: List.generate(
                          data!.docs.length,
                              (index) {
                            String name = data!.docs[index]['shippingAddress']['name'];
                            String shippingMethod = data!.docs[index]['shippingMethod'];
                            String price = data!.docs[index]['price'].toString();
                            Timestamp placedDate = data!.docs[index]['placedDate'];
                            return DataRow(
                              color: index.isOdd
                                  ? MaterialStateProperty.all(Colors
                                  .blueGrey.shade50
                                  .withOpacity(0.7))
                                  : MaterialStateProperty.all(
                                  Colors.blueGrey.shade50),
                              cells: [
                                DataCell(Container(
                                  width:
                                  MediaQuery.of(context).size.width *
                                      0.02,
                                  child: SelectableText(
                                    (ind == 0
                                        ? index + 1
                                        : ind + index + 1)
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                                DataCell(SelectableText(
                                  DateFormat("dd-MM-yyyy")
                                      .format(placedDate.toDate()),
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                DataCell(SelectableText(
                                  name,
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                DataCell(SelectableText(
                                  shippingMethod,
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                DataCell(SelectableText(
                                  price,
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                DataCell(
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotationDetails(
                                            id:data!.docs[index].id,
                                          )));
                                          print(data!.docs[index].id);

                                        },
                                        child: Container(
                                            height: 30,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(12),
                                                border: Border.all(
                                                    color: Colors.black
                                                        .withOpacity(
                                                        0.3))),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Action',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }),
              selectedIndex==0?SizedBox():  Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    pageIndex == 0
                        ? SizedBox()
                        : InkWell(
                      onTap: () {
                        prev();
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text('Previous')),
                      ),
                    ),
                    (lastDoc == null && pageIndex != 0) || data!.docs.length < limit
                        ? SizedBox()
                        : InkWell(
                      onTap: () {
                        next();
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text('Next')),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
