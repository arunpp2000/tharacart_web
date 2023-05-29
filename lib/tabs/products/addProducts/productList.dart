import 'dart:convert';
import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../widgets/button.dart';
import '../../../widgets/uploadmedia.dart';
import '../../../widgets/util.dart';
import '../../dashboard/dashboard.dart';
import '../addCategory/editCategory.dart';
import 'editProduct.dart';
import 'package:universal_html/html.dart' as html;

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List products = [];
  late TextEditingController search = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Stream<QuerySnapshot>? userStream;
  bool nxtVal = false;
  int ind = 0;

  Map<String,dynamic> newQty={};
  Map<String,dynamic> newPrice={};
  Map<String,dynamic> prdSku={};
  Map<String,dynamic> prdSold={};


  createProductsReport() async {

    QuerySnapshot b2c=await FirebaseFirestore.instance.collection('orders')
        .where('orderStatus',isEqualTo: 4)
        .where('branchId',isEqualTo: currentBranchId)
        .get();

    QuerySnapshot b2b=await FirebaseFirestore.instance.collection('b2bOrders')
        .where('orderStatus',isEqualTo: 4)
        .where('branchId',isEqualTo: currentBranchId)
        .get();




    List orders=[];
    List fullOrders=[];
    List products=[];


    for(DocumentSnapshot doc in b2c.docs){
      var items=doc['items'];

      for(var data in items){
        prdSku[data['name']]=data['productCode'];

        String name=data['name'];
        fullOrders.add(data);
        if(newQty[name]==null){
          newQty[name]=data['quantity'];
          newPrice[name]=data['quantity']*data['price'];


        } else {
          newQty[name]+=data['quantity'];
          newPrice[name]+=data['quantity']*data['price'];

        }
        if(!products.contains(name)){
          products.add(data['name']);
          prdSold[data['name']]=1;
          orders.add(data);

        }else{
          prdSold[data['name']]+=1;

        }
      }
    }

    for(DocumentSnapshot doc in b2b.docs){
      var items=doc['items'];

      for(var data in items){
        prdSku[data['name']]=data['productCode'];

        String name=data['name'];
        fullOrders.add(data);
        if(newQty[name]==null){
          newQty[name]=data['quantity'];
          newPrice[name]=data['quantity']*data['price'];

        }else{
          newQty[name]+=data['quantity'];
          newPrice[name]+=data['quantity']*data['price'];

        }
        if(!products.contains(name)){
          products.add(data['name']);
          prdSold[data['name']]=1;

          orders.add(data);

        }else{
          prdSold[data['name']]+=1;

        }
      }    }




    var excel = Excel.createExcel();
    // var excel = Excel.createExcel();
    Sheet sheetObject = excel['ProductsReport'];
    CellStyle cellStyle = CellStyle(
        backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri));

    int i = 2;

    var cell = sheetObject
        .cell(CellIndex.indexByString("A1"));
    cell.value =
    'Product Title'; // dynamic values support provided;
    cell.cellStyle = cellStyle;

    var cell1 = sheetObject
        .cell(CellIndex.indexByString("B1"));
    cell1.value =
    'SKU'; // dynamic values support provided;
    cell1.cellStyle = cellStyle;

    var cell2 = sheetObject
        .cell(CellIndex.indexByString("C1"));
    cell2.value =
    'Item Sold'; // dynamic values support provided;
    cell2.cellStyle = cellStyle;

    var cell3 = sheetObject
        .cell(CellIndex.indexByString("D1"));
    cell3.value =
    'Net Sales'; // dynamic values support provided;
    cell3.cellStyle = cellStyle;

    var cell4 = sheetObject
        .cell(CellIndex.indexByString("E1"));
    cell4.value =
    'Orders'; // dynamic values support provided;
    cell4.cellStyle = cellStyle;

    // final xls.Workbook workbook = xls.Workbook();
    // final xls.Worksheet sheet = workbook.worksheets[0];
    //
    // int i = 1;
    // List prdName=[];

    //
    // xls.Range
    // range = sheet.getRangeByName('A1');
    // range.setText('Product Title');
    //
    // range = sheet.getRangeByName('B1');
    // range.setText('SKU');
    //
    // range = sheet.getRangeByName('C1');
    // range.setText('Item Sold');
    //
    // range = sheet.getRangeByName('D1');
    // range.setText('Net Sales');
    //
    // range = sheet.getRangeByName('E1');
    // range.setText('Orders');




    for(var data in orders){

      var cell = sheetObject
          .cell(CellIndex.indexByString("A$i"));
      try{
        cell.value =
        data['name']; // dynamic values support provided;
      }catch(e){
        print(e.toString());
      }

      cell.cellStyle = cellStyle;

      var cell1 = sheetObject
          .cell(CellIndex.indexByString("B$i"));
      cell1.value =
          prdSku[data['name']].toString(); // dynamic values support provided;
      cell1.cellStyle = cellStyle;

      var cell2 = sheetObject
          .cell(CellIndex.indexByString("C$i"));
      cell2.value =
          newQty[data['name']].toString(); // dynamic values support provided;
      cell2.cellStyle = cellStyle;

      var cell3 = sheetObject
          .cell(CellIndex.indexByString("D$i"));
      cell3.value =
          newPrice[data['name']].toString(); // dynamic values support provided;
      cell3.cellStyle = cellStyle;

      var cell4 = sheetObject
          .cell(CellIndex.indexByString("E$i"));
      cell4.value =
          prdSold[data['name']].toString(); // dynamic values support provided;
      cell4.cellStyle = cellStyle;


      // xls.Range range = sheet.getRangeByName('A${(i+1)}');
      // range.setText(data['name']);
      //
      // range = sheet.getRangeByName('B${(i+1)}');
      // range.setText(prdSku[data['name']].toString());
      //
      // range = sheet.getRangeByName('C${(i+1)}');
      //
      // range.setText(newQty[data['name']].toString());
      //
      // range = sheet.getRangeByName('D${(i+1)}');
      // range.setText(newPrice[data['name']].toString());
      //
      // range = sheet.getRangeByName('E${(i+1)}');
      // range.setText(prdSold[data['name']].toString());


// Insert a row

// Insert a column.
      i++;
    }
    excel.setDefaultSheet('ProductsReport');
    var fileBytes = excel.encode();
    File file;
    final content = base64Encode(fileBytes!);
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute(
          "download", "Products Reports${DateTime.now().toString().substring(0, 10)}.xlsx")
      ..click();
    //
    // final List<int> bytes = workbook.saveAsStream();
    // workbook.dispose();
    //
    // if (kIsWeb) {
    //   AnchorElement(
    //       href:
    //       'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
    //     ..setAttribute('download', 'PRODUCTS-REPORTS-${DateTime.now().toString().substring(0,16)}.xlsx')
    //     ..click();
    // } else {
    //   final String path = (await getApplicationSupportDirectory()).path;
    //   final String fileName =
    //   Platform.isWindows ? '$path\\PRODUCTS-REPORTS-${DateTime.now().toString().substring(0,16)}.xlsx' : '$path/PRODUCTS-REPORTS-${DateTime.now().toString().substring(0,16)}.xlsx';
    //   final File file = File(fileName);
    //   await file.writeAsBytes(bytes, flush: true);
    //   OpenFile.open(fileName);
    // }


  }
  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {
      ind = 0;
      userStream = FirebaseFirestore.instance
          .collection('products')
          .orderBy('date', descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(limit)
          .snapshots();
    } else {
      ind += limit;
      userStream = FirebaseFirestore.instance
          .collection('products')
          .orderBy('date', descending: true)
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
          .collection('products')
          .orderBy('date', descending: true)
          .limit(limit)
          .snapshots();
    } else {
      ind -= limit;
      userStream = FirebaseFirestore.instance
          .collection('products')
          .orderBy('date', descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(limit)
          .snapshots();
    }
    setState(() {});
  }

  List datas = [
    'B2C',
    'B2B',
  ];
bool loading =false;
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
    userStream = FirebaseFirestore.instance
        .collection('products')
        .orderBy('date', descending: true)
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
                        'Product List ',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
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
                                          .collection('products')
                                          .orderBy('date', descending: true)
                                          .limit(limit)
                                          .snapshots();
                                    } else {
                                      userStream = FirebaseFirestore.instance
                                          .collection("products")
                                          .orderBy('date', descending: true)
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
                                      .collection('products')
                                      .orderBy('date', descending: true)
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
                  InkWell(
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                   createProductsReport();



                      setState(() {
                        loading = false;
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
                  ),

                ],
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: userStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    data = [];
                    products = [];
                    products=snapshot.data!.docs;
                    data = snapshot.data!.docs;
                    if (data.length != 0) {
                      print(data.length);
                      lastDoc = snapshot.data?.docs[data.length - 1];
                      lastDocuments[pageIndex] = lastDoc;
                      firstDoc = snapshot.data?.docs[0];
                    }
                    return data.length == 0
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
                                      label: Text("Image",
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
                                      label: Text("Action",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                  ],
                                  rows: List.generate(
                                    data.length,
                                    (index) {
                                      String name = data[index]['name'];
                                      String image = data[index]['imageId'].isEmpty?'':data[index]['imageId'][0];

                                      // String shippingMethod = data[index]['shippingMethod'];
                                      // String price = data[index]['price'].toString();
                                      // Timestamp placedDate = data[index]['placedDate'];
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
                                          DataCell(InkWell(
                                            onTap: () async {
                                              await showDialog(
                                                  barrierDismissible: true,
                                                  context: context,
                                                  builder: (buildContext) {
                                                    return AlertDialog(
                                                      insetPadding:
                                                      EdgeInsets.all(12),
                                                      content: Center(
                                                          child: Container(
                                                            height: 500,
                                                            width: 500,
                                                            child:
                                                            CachedNetworkImage(
                                                              imageUrl: image==null?'assets/images/tara1.png':image,
                                                            ),
                                                          )),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'back')),
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Container(
                                                height: 150,
                                                width: 100,
                                                child: CachedNetworkImage(
                                                  imageUrl: image==null?'':image,
                                                )),
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
                                                            builder:
                                                                (context) =>
                                                                    Editproduct(
                                                                      productId:
                                                                          data[index]
                                                                              [
                                                                              'productId'],
                                                                    )));
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
                                            data.length < limit
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
                  })
            ],
          ),
        ),
      ),
    );
  }
}
