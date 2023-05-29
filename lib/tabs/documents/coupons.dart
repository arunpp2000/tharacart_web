import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
//import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/button.dart';
import '../../widgets/uploadmedia.dart';
import '../dashboard/dashboard.dart';
import '../products/addCategory/editCategory.dart';

class Coupons extends StatefulWidget {
  const Coupons({Key? key}) : super(key: key);

  @override
  _CouponsState createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, dynamic> userOrder = {};
  Map<String, dynamic> newPrice = {};
  Map<String, dynamic> userAddress = {};
  Map<String, dynamic> prdSold = {};
  List coupons = [];

  createCustomerData() async {
    QuerySnapshot b2c = await FirebaseFirestore.instance
        .collection('orders')
        .where('orderStatus', isEqualTo: 4)
        .where('branchId', isEqualTo: currentBranchId)
        .get();

    QuerySnapshot b2b = await FirebaseFirestore.instance
        .collection('b2bOrders')
        .where('orderStatus', isEqualTo: 4)
        .where('branchId', isEqualTo: currentBranchId)
        .get();

    List fullOrders = [];
    List products = [];
    userOrder = {};
    newPrice = {};
    for (DocumentSnapshot doc in b2c.docs) {
      String name = doc['promoCode'];

      // if(!orders.contains(name)){
      //   orders.add(name);
      // }

      if (userOrder[name] == null) {
        userOrder[name] = 1;
        newPrice[name] = doc['discount'];
      } else {
        userOrder[name] += 1;
        newPrice[name] += doc['discount'];
      }

      var items = doc['items'];

      // for(var data in items){
      //   prdSku[data['name']]=data['productCode'];
      //
      //   String name=data['name'];
      //   fullOrders.add(data);
      //   if(userOrder[name]==null){
      //     userOrder[name]=data['quantity'];
      //     newPrice[name]=data['quantity']*data['price'];
      //
      //
      //   } else {
      //     userOrder[name]+=data['quantity'];
      //     newPrice[name]+=data['quantity']*data['price'];
      //
      //   }
      //   if(!products.contains(name)){
      //     products.add(data['name']);
      //     prdSold[data['name']]=1;
      //     orders.add(data);
      //
      //   }else{
      //     prdSold[data['name']]+=1;
      //
      //   }
      // }
    }

    for (DocumentSnapshot doc in b2b.docs) {
      String name = doc['promoCode'];
      // if(!orders.contains(name)){
      //   orders.add(name);
      // }

      if (userOrder[name] == null) {
        userOrder[name] = 1;
        newPrice[name] = doc['discount'];
      } else {
        userOrder[name] += 1;
        newPrice[name] += doc['discount'];
      }

      var items = doc['items'];

      // for(var data in items){
      //   prdSku[data['name']]=data['productCode'];
      //
      //   String name=data['name'];
      //   fullOrders.add(data);
      //   if(userOrder[name]==null){
      //     userOrder[name]=data['quantity'];
      //     newPrice[name]=data['quantity']*data['price'];
      //
      //   }else{
      //     userOrder[name]+=data['quantity'];
      //     newPrice[name]+=data['quantity']*data['price'];
      //
      //   }
      //   if(!products.contains(name)){
      //     products.add(data['name']);
      //     prdSold[data['name']]=1;
      //
      //     orders.add(data);
      //
      //   }else{
      //     prdSold[data['name']]+=1;
      //
      //   }
      // }
    }

    var excel = Excel.createExcel();
    // var excel = Excel.createExcel();
    Sheet sheetObject = excel['coupons'];
    CellStyle cellStyle = CellStyle(
        backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri));

    int i = 2;

    var cell = sheetObject.cell(CellIndex.indexByString("A1"));
    cell.value = 'Coupon Code'; // dynamic values support provided;
    cell.cellStyle = cellStyle;

    var cell1 = sheetObject.cell(CellIndex.indexByString("B1"));
    cell1.value = 'Orders'; // dynamic values support provided;
    cell1.cellStyle = cellStyle;

    var cell2 = sheetObject.cell(CellIndex.indexByString("C1"));
    cell2.value = 'Amount Discount'; // dynamic values support provided;
    cell2.cellStyle = cellStyle;

    var cell3 = sheetObject.cell(CellIndex.indexByString("D1"));
    cell3.value = 'Created'; // dynamic values support provided;
    cell3.cellStyle = cellStyle;

    var cell4 = sheetObject.cell(CellIndex.indexByString("E1"));
    cell4.value = 'Expired'; // dynamic values support provided;
    cell4.cellStyle = cellStyle;

    // final xls.Workbook workbook = xls.Workbook();
    // final xls.Worksheet sheet = workbook.worksheets[0];
    //
    // int i = 1;
    // List prdName=[];

    // xls.Range
    // range = sheet.getRangeByName('A1');
    // range.setText('Coupon Code');
    //
    //
    // range = sheet.getRangeByName('B1');
    // range.setText('Orders');
    //
    // range = sheet.getRangeByName('C1');
    // range.setText('Amount Discount');
    //
    // range = sheet.getRangeByName('D1');
    // range.setText('Created');
    //
    // range = sheet.getRangeByName('E1');
    // range.setText('Expired');

    for (var data in coupons) {
      var cell = sheetObject.cell(CellIndex.indexByString("A$i"));

      cell.value = data; // dynamic values support provided;

      cell.cellStyle = cellStyle;

      var cell1 = sheetObject.cell(CellIndex.indexByString("B$i"));

      try {
        cell1.value =
            userOrder[data] == null ? '0' : userOrder[data].toString();
      } catch (e) {}
      ;
      // dynamic values support provided;
      cell1.cellStyle = cellStyle;

      var cell2 = sheetObject.cell(CellIndex.indexByString("C$i"));
      try {
        cell2.value = newPrice[data] == null ? '0.00' : newPrice[data].toString();
      } catch (e) {}
      // dynamic values support provided;
      cell2.cellStyle = cellStyle;

      var cell3 = sheetObject.cell(CellIndex.indexByString("D$i"));
      try {
        cell3.value = couponMapByName[data]['createdTime']
            .toDate()
            .toString()
            .substring(0, 16);
      } catch (e) {}
      // dynamic values support provided;
      cell3.cellStyle = cellStyle;

      var cell4 = sheetObject.cell(CellIndex.indexByString("E$i"));
      try {
        cell4.value = couponMapByName[data]['expiryDate']
            .toDate()
            .toString()
            .substring(0, 16);
      } catch (e) {}
      // dynamic values support provided;
      cell4.cellStyle = cellStyle;

      // xls.Range range = sheet.getRangeByName('A${(i+1)}');
      //
      //
      //   range.setText(data);
      //
      //
      //
      // range = sheet.getRangeByName('B${(i+1)}');
      // range.setText(userOrder[data]==null?'0':userOrder[data].toString());
      //
      // range = sheet.getRangeByName('C${(i+1)}');
      // range.setText(newPrice[data]==null?'0.00':newPrice[data].toString());
      //
      // range = sheet.getRangeByName('D${(i+1)}');
      // range.setText(couponMapByName[data]['createdTime'].toDate().toString().substring(0,16));
      //
      // range = sheet.getRangeByName('E${(i+1)}');
      // range.setText(couponMapByName[data]['expiryDate'].toDate().toString().substring(0,16));

// Insert a row

// Insert a column.
      i++;
    }
    excel.setDefaultSheet('coupons');
    var fileBytes = excel.encode();
    var directory = await getExternalStorageDirectory();
    String outputFile = directory!.path +
        "/COUPONS-REPORT-${DateTime.now().toString().substring(0, 16)}.xlsx";

    File(outputFile)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'file saved in application directory($outputFile)',
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
            color: Colors.white),
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
    OpenFile.open(outputFile);

    // final List<int> bytes = workbook.saveAsStream();
    // workbook.dispose();
    //
    // if (kIsWeb) {
    //   AnchorElement(
    //       href:
    //       'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
    //     ..setAttribute('download', 'COUPONS-REPORT-${DateTime.now().toString().substring(0,16)}.xlsx')
    //     ..click();
    // } else {
    //   final String path = (await getApplicationSupportDirectory()).path;
    //   final String fileName =
    //   Platform.isWindows ? '$path\\COUPONS-REPORT-${DateTime.now().toString().substring(0,16)}.xlsx' : '$path/COUPONS-REPORT-${DateTime.now().toString().substring(0,16)}.xlsx';
    //   final File file = File(fileName);
    //   await file.writeAsBytes(bytes, flush: true);
    //   OpenFile.open(fileName);
    // }
  }

  int totalCoupons = 0;
  int totalQty = 0;
  int totalReturnedOrders = 0;
  int totalReturnedOrdersb2b = 0;
  double totalCODOrders = 0;
  double totalCODOrdersReturned = 0;
  double totalAmount = 0;
  double totalOnlineOrders = 0;
  double totalOnlineOrdersReturned = 0;
  double deliveryCharge = 0;
  double tips = 0;

  Map<String, dynamic> couponMapByName = {};

  getCustomers() {
    FirebaseFirestore.instance.collection('offers').snapshots().listen((event) {
      totalCoupons = event.docs.length;
      coupons = [];
      for (DocumentSnapshot doc in event.docs) {
        coupons.add(doc['code']);

        couponMapByName[doc['code']] = doc.data();
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   automaticallyImplyLeading: true,
      //   title: Text(
      //     'Coupons',
      //     style: TextStyle(
      //       fontFamily: 'Poppins',
      //       color: Colors.white,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w500,
      //     ),
      //   ),
      //   actions: [],
      //   centerTitle: true,
      //   elevation: 2,
      // ),
      backgroundColor: Colors.white,
      body: SafeArea(
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
                      'Coupons',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Material(
                color: Colors.transparent,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 16, 24, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Coupons ',
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              totalCoupons.toString(),
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FFButtonWidget(
              onPressed: () async {
                bool pressed = await alert(context, 'Create File...');
                if (pressed) {
                  createCustomerData();
                }
              },
              text: 'Create Coupons Report',
              icon: FaIcon(
                FontAwesomeIcons.fileExcel,
              ),
              options: FFButtonOptions(
                width: 300,
                height: 40,
                color: primaryColor,
                textStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                elevation: 12,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
