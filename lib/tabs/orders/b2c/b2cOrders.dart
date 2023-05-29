import 'dart:convert';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:universal_html/html.dart' as html;
import '../../../widgets/button.dart';
import '../../../widgets/util.dart';
import '../../dashboard/dashboard.dart';
import 'detailsPage.dart';

class B2COrders extends StatefulWidget {
  B2COrders({Key? key}) : super(key: key);

  @override
  _B2COrdersState createState() => _B2COrdersState();
}

class _B2COrdersState extends State<B2COrders> {
  // Future<void> Delivered() async {
  //   QuerySnapshot b2c = await FirebaseFirestore.instance.collection('orders')
  //       .where('orderStatus', isEqualTo: 4)
  //       .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
  //       .where('placedDate', isLessThanOrEqualTo: datePicked2)
  //       .get();
  //   //QuerySnapshot b2c=await FirebaseFirestore.instance.collection('orders').where('orderStatus',isEqualTo: 4).get();
  //   print(b2c.docs.length);
  //   print('============');
  //   if (b2c.docs.isEmpty) {
  //     errorMsg(context, 'NO Data Fount');
  //   } else {
  //     var excel = Excel.createExcel();
  //     Sheet sheetObject = excel['b2cReports'];
  //     CellStyle cellStyle = CellStyle(
  //       // backgroundColorHex: "#1AFF1A",
  //         fontFamily: getFontFamily(FontFamily.Calibri));
  //     int i = 0;
  //     var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
  //     cell1.value = 'SL NO';
  //     cell1.cellStyle = cellStyle;
  //     var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
  //     cell2.value = 'Date'; // dynamic values support provided;
  //     cell2.cellStyle = cellStyle;
  //     var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
  //     cell3.value = 'Name'; // dynamic values support provided;
  //     cell3.cellStyle = cellStyle;
  //     var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
  //     cell4.value = 'Invoice Number'; // dynamic values support provided;
  //     cell4.cellStyle = cellStyle;
  //     var cell5 = sheetObject.cell(CellIndex.indexByString("E1"));
  //     cell5.value = 'Shipping Method'; // dynamic values support provided;
  //     cell5.cellStyle = cellStyle;
  //     var cell6 = sheetObject.cell(CellIndex.indexByString("F1"));
  //     cell6.value = 'Amount'; // dynamic values support provided;
  //     cell6.cellStyle = cellStyle;
  //     for (DocumentSnapshot doc in b2c.docs) {
  //       var cell1 = sheetObject.cell(CellIndex.indexByString("A${i + 2}"));
  //       cell1.value = i + 1; // dynamic values support provided;
  //       cell1.cellStyle = cellStyle;
  //       var cell2 = sheetObject.cell(CellIndex.indexByString("B${i + 2}"));
  //       cell2.value = dateTimeFormat('d-MMM-y',
  //           doc['placedDate'].toDate());
  //       // dynamic values support provided;
  //       cell2.cellStyle = cellStyle;
  //       var cell3 = sheetObject.cell(CellIndex.indexByString("C${i + 2}"));
  //       cell3.value =
  //       doc['shippingAddress']['name']; // dynamic values support provided;
  //       cell3.cellStyle = cellStyle;
  //       var cell4 = sheetObject.cell(CellIndex.indexByString("D${i + 2}"));
  //       cell4.value = 'TCE-' +
  //           doc['invoiceNo'].toString(); // dynamic values support provided;
  //       cell4.cellStyle = cellStyle;
  //       var cell5 = sheetObject.cell(CellIndex.indexByString("E${i + 2}"));
  //       cell5.value = doc['shippingMethod']; // dynamic values support provided;
  //       cell5.cellStyle = cellStyle;
  //       var cell6 = sheetObject.cell(CellIndex.indexByString("F${i + 2}"));
  //       cell6.value = doc['total']; // dynamic values support provided;
  //       cell6.cellStyle = cellStyle;
  //       i++;
  //     }
  //
  //     excel.setDefaultSheet('b2cReports');
  //     var fileBytes = excel.encode();
  //     File file;
  //
  //     final content = base64Encode(fileBytes!);
  //     final anchor = html.AnchorElement(
  //         href: "data:application/octet-stream;charset=utf-16le;base64,$content")
  //       ..setAttribute(
  //           "download",
  //           "Delivered B2c Reports${DateTime.now().toString().substring(
  //               0, 10)}.xlsx")
  //       ..click();
  //   }
  // }

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
          .orderBy('placedDate', descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(limit)
          .snapshots();
    } else {
      ind += limit;
      userStream = FirebaseFirestore.instance
          .collection("orders")
          .where('orderStatus', isEqualTo: selectedIndex)
          .orderBy('placedDate', descending: true)
          .limit(limit)
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
          .orderBy('placedDate', descending: true)
          .limit(limit)
          .snapshots();
    } else {
      ind -= limit;
      userStream = FirebaseFirestore.instance
          .collection("orders")
          .where('orderStatus', isEqualTo: selectedIndex)
          .orderBy('placedDate', descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(limit)
          .snapshots();
    }
    setState(() {});
  }




  Future<void> Shipped() async {

    QuerySnapshot b2c=await FirebaseFirestore.instance.collection('orders').where('orderStatus',isEqualTo: 3).get();
    print(b2c.docs.length);
    print('============');
    var excel = Excel.createExcel();

    Sheet sheetObject = excel['b2cReports'];
    CellStyle cellStyle = CellStyle(
      // backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri));
    int i = 0;

    var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
    cell1.value = 'SL NO';
    cell1.cellStyle = cellStyle;
    var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
    cell2.value = 'Date'; // dynamic values support provided;
    cell2.cellStyle = cellStyle;
    var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
    cell3.value = 'Name'; // dynamic values support provided;
    cell3.cellStyle = cellStyle;
    var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
    cell4.value = 'Invoice Number'; // dynamic values support provided;
    cell4.cellStyle = cellStyle;
    var cell5 = sheetObject.cell(CellIndex.indexByString("E1"));
    cell5.value = 'Shipping Method'; // dynamic values support provided;
    cell5.cellStyle = cellStyle;
    var cell6 = sheetObject.cell(CellIndex.indexByString("F1"));
    cell6.value = 'Amount'; // dynamic values support provided;
    cell6.cellStyle = cellStyle;
    for (DocumentSnapshot doc in b2c.docs) {
      var cell1 = sheetObject.cell(CellIndex.indexByString("A${i + 2}"));
      cell1.value = i + 1; // dynamic values support provided;
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("B${i + 2}"));
      cell2.value =dateTimeFormat('d-MMM-y',
          doc['placedDate'].toDate());
      // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("C${i + 2}"));
      cell3.value = doc['shippingAddress']['name']; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(CellIndex.indexByString("D${i + 2}"));
      cell4.value = 'TCE-'+doc['invoiceNo'].toString(); // dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(CellIndex.indexByString("E${i + 2}"));
      cell5.value = doc['shippingMethod']; // dynamic values support provided;
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(CellIndex.indexByString("F${i + 2}"));
      cell6.value = doc['total']; // dynamic values support provided;
      cell6.cellStyle = cellStyle;
      i++;
      print(cell1.value);
    }
    excel.setDefaultSheet('b2cReports');
    var fileBytes = excel.encode();
    File file;
    final content = base64Encode(fileBytes!);
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute(
          "download", "Shipped B2c Reports${DateTime.now().toString().substring(0, 10)}.xlsx")
      ..click();
  }
  Future<void> Delivered() async {

    QuerySnapshot b2c=await FirebaseFirestore.instance.collection('orders').where('orderStatus',isEqualTo: 4).get();
    print(b2c.docs.length);
    print('============');
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['b2cReports'];
    CellStyle cellStyle = CellStyle(
      // backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri));
    int i = 0;
    var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
    cell1.value = 'SL NO';
    cell1.cellStyle = cellStyle;
    var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
    cell2.value = 'Date'; // dynamic values support provided;
    cell2.cellStyle = cellStyle;
    var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
    cell3.value = 'Name'; // dynamic values support provided;
    cell3.cellStyle = cellStyle;
    var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
    cell4.value = 'Invoice Number'; // dynamic values support provided;
    cell4.cellStyle = cellStyle;
    var cell5 = sheetObject.cell(CellIndex.indexByString("E1"));
    cell5.value = 'Shipping Method'; // dynamic values support provided;
    cell5.cellStyle = cellStyle;
    var cell6 = sheetObject.cell(CellIndex.indexByString("F1"));
    cell6.value = 'Amount'; // dynamic values support provided;
    cell6.cellStyle = cellStyle;
    for (DocumentSnapshot doc in b2c.docs) {
      var cell1 = sheetObject.cell(CellIndex.indexByString("A${i + 2}"));
      cell1.value = i + 1; // dynamic values support provided;
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("B${i + 2}"));
      cell2.value =dateTimeFormat('d-MMM-y',
          doc['placedDate'].toDate());
      // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("C${i + 2}"));
      cell3.value =
      doc['shippingAddress']['name']; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(CellIndex.indexByString("D${i + 2}"));
      cell4.value = 'TCE-'+doc['invoiceNo'].toString(); // dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(CellIndex.indexByString("E${i + 2}"));
      cell5.value = doc['shippingMethod']; // dynamic values support provided;
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(CellIndex.indexByString("F${i + 2}"));
      cell6.value = doc['total']; // dynamic values support provided;
      cell6.cellStyle = cellStyle;
      i++;
    }

    excel.setDefaultSheet('b2cReports');
    var fileBytes = excel.encode();
    File file;

    final content = base64Encode(fileBytes!);
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute(
          "download", "Delivered B2c Reports${DateTime.now().toString().substring(0, 10)}.xlsx")
      ..click();
  }
  List datas = [
    'Pending',
    'Accepted',
    'Cancelled',
    'Shipped',
    'Delivered',
  ];

  Map<int, DocumentSnapshot> lastDocuments = {};
  List<QueryDocumentSnapshot>? data;
  int pageIndex = 0;
  var lastDoc;
  var firstDoc;
  int limit = 20;
  int? selectedIndex = 0;
  Timestamp? datePicked1;
  Timestamp? datePicked2;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  final scroll = ScrollController();
  late int ordeS;
  int orderCount=0;
  int totalIndex=0;

  getCount() async {
    var b2corders=FirebaseFirestore.instance
        .collection("orders")
        .where('orderStatus', isEqualTo:selectedIndex);

    AggregateQuerySnapshot query=await b2corders.count().get();
    orderCount=query.count;
    totalIndex=(orderCount/limit).ceil()-1;
    print(orderCount);
    print('=====');
    setState(() {

    });
  }
  @override
  void initState()  {
    super.initState();
    DateTime time = DateTime.now();
    datePicked1 =
        Timestamp.fromDate(DateTime(time.year, time.month, time.day, 0, 0, 0));
    datePicked2 = Timestamp.fromDate(
        DateTime(time.year, time.month, time.day, 23, 59, 59));
    selectedIndex = 0;
    getCount();
    userStream = FirebaseFirestore.instance
        .collection("orders")
        .where('orderStatus', isEqualTo: 0)
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
                        'B2C Orders',
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
                                            getCount();
                                            userStream = FirebaseFirestore
                                                .instance
                                                .collection("orders")
                                                .where('orderStatus',
                                                isEqualTo: selectedIndex)
                                                .orderBy('placedDate',
                                                descending: true)
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
              selectedIndex == 0
                  ? SizedBox()
                  : Container(
                      width: 550,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: selectedDate1,
                                        firstDate: DateTime(1901, 1),
                                        lastDate: DateTime(2100, 1))
                                    .then((value) {
                                  DateFormat("yyyy-MM-dd").format(value!);
                                  datePicked1 = Timestamp.fromDate(value);
                                  selectedDate1 = value;
                                  // getOrders();
                                  userStream = FirebaseFirestore.instance
                                      .collection('orders')
                                  .where('orderStatus',isEqualTo: selectedIndex)
                                      .where('placedDate',
                                          isGreaterThanOrEqualTo: datePicked1)
                                      .where('placedDate',
                                          isLessThanOrEqualTo: datePicked2)
                                      .orderBy('placedDate', descending: true)
                                      .snapshots();
                                  setState(() {});
                                });
                              },
                              child: Text(
                                datePicked1 == null
                                    ? 'Choose Starting Date'
                                    : datePicked1!
                                        .toDate()
                                        .toString()
                                        .substring(0, 10),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                          Text(
                            'To',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: selectedDate2,
                                        firstDate: DateTime(1901, 1),
                                        lastDate: DateTime(2100, 1))
                                    .then((value) {
                                  DateFormat("yyyy-MM-dd").format(value!);
                                  datePicked2 = Timestamp.fromDate(value.add(
                                      Duration(
                                          hours: 23,
                                          minutes: 59,
                                          seconds: 59)));
                                  selectedDate2 = value;
                                  setState(() {});
                                });
                              },
                              child: Text(
                                datePicked2 == null
                                    ? 'Choose Ending Date'
                                    : datePicked2!
                                        .toDate()
                                        .toString()
                                        .substring(0, 10),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
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
                                          .where('orderStatus',
                                              isEqualTo: selectedIndex)
                                          .orderBy('placedDate',
                                              descending: true)
                                          .limit(limit)
                                          .snapshots();
                                    } else {
                                      userStream = FirebaseFirestore.instance
                                          .collection("orders")
                                          .where('orderStatus',
                                              isEqualTo: selectedIndex)
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
                                      .where('orderStatus',
                                          isEqualTo: selectedIndex)
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
                  selectedIndex!>2?InkWell(
                    onTap: () async {

                      if(selectedIndex==3){
Shipped();
                      }else if(selectedIndex==4){
Delivered();
                      }
                      setState(() {

                      });
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.teal),
                      child: Center(
                        child: Text(
                          'Generate Excel',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ):SizedBox(),
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
                    data = snapshot.data!.docs;

                    if (data!.isNotEmpty) {
                      lastDoc = snapshot.data?.docs[data!.length - 1];
                      lastDocuments[pageIndex] = lastDoc;
                      firstDoc = snapshot.data?.docs[0];
                    }
                    return data!.isEmpty
                        ? LottieBuilder.network(
                            'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                            height: 500,
                          )
                        : Column(
                            children: [
                              SizedBox(
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
                                    selectedIndex!>2?DataColumn(
                                      label: Text(
                                        "Invoice Number",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                      ),
                                    ):DataColumn(label: SizedBox()),
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
                                    data!.length,
                                    (index) {
                                      String name = data![index]
                                          ['shippingAddress']['name'];
                                      String shippingMethod =
                                          data![index]['shippingMethod'];
                                      String price = data![index]['price'].toString();
                                      Timestamp placedDate =
                                          data![index]['placedDate'];
                                      return DataRow(
                                        color: index.isOdd
                                            ? MaterialStateProperty.all(Colors
                                                .blueGrey.shade50
                                                .withOpacity(0.7))
                                            : MaterialStateProperty.all(
                                                Colors.blueGrey.shade50),
                                        cells: [
                                          DataCell(Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                          selectedIndex!>2?DataCell(SelectableText(
                                           'TCE-'+ data![index]['invoiceNo'].toString(),
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )):DataCell(SizedBox()),
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
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                B2cOrderDetails(
                                                                  id: data![
                                                                          index]
                                                                      .id,
                                                                )));
                                                    print(data![index].id);
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
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.3))),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        'Action',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                  child: Text('Previous')),
                                            ),
                                          ),
                                    (lastDoc == null && pageIndex != 0) ||
                                        data!.length! < limit
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
                                            borderRadius:
                                            BorderRadius.circular(
                                                10)),
                                        child:
                                        Center(child: Text('Next')),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
