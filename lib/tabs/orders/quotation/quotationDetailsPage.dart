import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:tharacart_web/tabs/orders/b2c/pdf.Api.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../widgets/button.dart';
import '../../../widgets/uploadmedia.dart';
import '../../dashboard/dashboard.dart';
import '../b2c/b2cpdf.dart';
import '../b2c/editpop.dart';
import '../b2c/invoice.dart';
import 'freeProductList.dart';

class QuotationDetails extends StatefulWidget {
  var id;

  QuotationDetails({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  _QuotationDetailsState createState() => _QuotationDetailsState();
}

class _QuotationDetailsState extends State<QuotationDetails> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  _launchURL(String urls) async {
    var url = urls;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Map address = {};
  var data;
  List items = [];
  double sum=0;
  double tax=0;
  double gst=0;
  double itemTotal=0;
  int q=0;

  int totalExcel=0;
  var grandtotal;
  TextEditingController awbCode = TextEditingController();
  TextEditingController trackingUrl = TextEditingController();
  String? shipprocketId;
  String? invoiceNo;
  getorders() {
    FirebaseFirestore.instance
        .collection('quotation')
        .doc(widget.id)
        .snapshots()
        .listen((event) {
      data = event.data();
      double tot = data['total'] ?? 0;
      double qnty = data['quantity'] ?? 0;
      double pre = data['price'] ?? 0;
      double gt = data['gst'] ?? 0;
      double summ = (tot-qnty) * (pre*100) / (100+gt);
    //  gst=gst+(item.quantity *(mrp*tax/(100+tax)));
      // var summ = (double.tryParse(data['total']) - (double.tryParse(data['quantity'])))
      //         * double.tryParse(data['price']) * 100 / (100 + double.tryParse(data['gst']));
      print(summ);
       sum=0;
       q=0;
       gst=0;
       tax=0;
       itemTotal=0;

       totalExcel=0;
      items = [];
      for (var a in event.data()!['items']) {
        items.add(a);
        tax = a['gst'].toDouble();
        sum = ((a['newPrice']) * (a['newQty'])) + sum;

        gst = gst +
            (a['newQty'] * ((a['newPrice']) * tax / (100 + tax)));
        itemTotal = itemTotal +
            (a['newQty'] * (a['newPrice'] * 100 / (100 + tax)));
        print("--------");
        print(sum);
      }
      // totalExcel=sum*q;
      grandtotal = (sum + data['deliveryCharge']) -data['discount'];

      address = event.data()!['shippingAddress'];
      deliverycharge.text=data['deliveryCharge'].toString();
      // Gst.text=summ.toString();
      discount.text=data['discount'].toString();
      Price.text=data['price'].toString();
      totalgst.text=grandtotal.toString();
      print('=====================');
print(items);
      print('=====================');
      try {
        shipprocketId = data['shippRocketId'];
        invoiceNo = data['invoiceNo'].toString();
      } catch (e) {
        print(e.toString());
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  int? selectedIndex;

  // if (widget.order.referralCode != null) {
  // QuerySnapshot rUsers = await FirebaseFirestore
  //     .instance
  //     .collection('users')
  //     .where('referralCode',
  // isEqualTo: widget.order.referralCode)
  //     .get();
  // }

  //productupdate
  final productPrice = TextEditingController();
  final productGst = TextEditingController();
  final productGty = TextEditingController();
  final productQty = TextEditingController();
  final productunitPrice = TextEditingController();
  final productDiscount = TextEditingController();

  //total update
  final Price = TextEditingController();
  final discount = TextEditingController();
  final deliverycharge = TextEditingController();
  final Gst = TextEditingController();
  final totalgst = TextEditingController();
  // final productDiscount =TextEditingController();
  // final productDiscount =TextEditingController();

  late bool submit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getorders();

  }

  @override
  Widget build(BuildContext context) {
    // trackingUrl.text = data['trackingUrl'] ?? '';
    // awbCode.text = data['awb_code'] ?? '';
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Color(0xFF383838)),
          automaticallyImplyLeading: true,
          title: Text(
            'Details',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFF090F13),
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 5,
        ),
        backgroundColor: Color(0xFFF1F4F8),
        body: SingleChildScrollView(
          controller: scroll,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color: Colors.transparent,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.shopping_bag),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Order Details',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'OrderId:  ' + widget.id,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),

                              SizedBox(
                                width:
                                    // double.infinity,
                                    MediaQuery.of(context).size.width * 0.95,
                                child: DataTable(
                                  horizontalMargin: 10,
                                  columnSpacing: 20,
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        "Order Date",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Order Time",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Shipping Method",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                      ),
                                    ),
                                  ],
                                  rows: List.generate(
                                    1,
                                    (index) {
                                      // String name = data[index]['shippingAddress']['name'];
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
                                          DataCell(SelectableText(
                                            DateFormat("dd-MM-yyyy").format(
                                                data['placedDate'].toDate())
                                            ,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            DateFormat.jm().format(
                                                data['placedDate'].toDate()),
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            data['shippingMethod'],
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),

                                        ],
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Material(
                      color: Colors.transparent,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.person),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Customer Details',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (buildContext) {
                                              return AddressPopUp(
                                                name: address['name'],
                                                address: address['address'],
                                                landMark: address['landMark'],
                                                area: address['area'],
                                                pincode: address['pinCode'],
                                                state: address['state'],
                                                orderId: widget.id,
                                                customerId: data['userId'],
                                                city: address['city'],
                                              );
                                            });
                                      },
                                      icon: Icon(Icons.edit))
                                ],
                              ),
                              Divider(),
                              SizedBox(
                                width:
                                    // double.infinity,
                                    MediaQuery.of(context).size.width * 0.95,
                                child: DataTable(
                                  horizontalMargin: 10,
                                  columnSpacing: 20,
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        "Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text("Mobile Number",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Alternative Number",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text("Address",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                    DataColumn(
                                      label: Text("Area",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                    DataColumn(
                                      label: Text("LandMark",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                    DataColumn(
                                      label: Text("City",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                    DataColumn(
                                      label: Text("State",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                    DataColumn(
                                      label: Text("Pincode",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                  ],
                                  rows: List.generate(
                                    1,
                                    (index) {
                                      String name = data['shippingAddress']['name'];
                                      String address = data['shippingAddress']['address'];
                                      String number = data['shippingAddress']['mobileNumber'];
                                      String anumber = data['shippingAddress']['alternativePhone'];
                                      String city = data['shippingAddress']['city'];
                                      String area = data['shippingAddress']['area'];
                                      String pincode = data['shippingAddress']['pinCode'];
                                      String state = data['shippingAddress']['state'];
                                      String landmark = data['shippingAddress']['landMark'];
                                      return DataRow(
                                        color: index.isOdd
                                            ? MaterialStateProperty.all(Colors
                                                .blueGrey.shade50
                                                .withOpacity(0.7))
                                            : MaterialStateProperty.all(
                                                Colors.blueGrey.shade50),
                                        cells: [
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
                                            number,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            anumber,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            address,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            area,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            landmark,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            city,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            state,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            pincode,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Material(
                      color: Colors.transparent,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.shopping_bag),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Product Details',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              SizedBox(
                                width:
                                    // double.infinity,
                                    MediaQuery.of(context).size.width * 0.95,
                                child: DataTable(
                                  horizontalMargin: 10,
                                  columnSpacing: 20,
                                  columns: [
                                    DataColumn(
                                      label: Text("No",
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
                                      label: Text(
                                        "Image",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    DataColumn(
                                      label:Expanded(child: Text("Product Code",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                    ),
                                    DataColumn(
                                      label: Text("hsnCode",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                    DataColumn(
                                      label: Text("GST",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                    DataColumn(
                                      label: Expanded(child:Text(
                                        "Actucal Qty",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 11),
                                      ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(child:Text("Actucal Prize",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                    ),
                                    DataColumn(
                                      label:Expanded(child: Text(
                                        "Expected Qty",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple,
                                            fontSize: 11),
                                      ),
                                    ),
                                    ),
                                    DataColumn(
                                      label: Expanded(child: Text("Expected Prize",
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    )
                                    ),
                                    DataColumn(
                                      label: Expanded(child:Text(
                                        "New Qty",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 11),
                                      ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text("New Prize",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11)),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(" ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                  ],
                                  rows: List.generate(
                                    items.length,
                                    (index) {
                                      String name = items[index]['name'];
                                      String productCode =
                                          items[index]['productCode']??'';
                                      String price =
                                          items[index]['price'].toString();
                                      String p = items[index]['price'].toString();
                                      int status = items[index]['status'];
                                      productGty.text =
                                          items[index]['quantity'].toString();
                                      // productGst.text= items[index]['gst'].toString();
                                      productunitPrice.text =
                                          items[index]['unit'].toString();
                                      productDiscount.text =
                                          items[index]['discount'].toString();
                                      productPrice.text =
                                          items[index]['price'].toString();
                                      String qty =
                                          items[index]['quantity'].toString();
                                      String gst =
                                          items[index]['gst'].toString();
                                      String hcode =
                                          items[index]['hsnCode'].toString();
                                      String image =
                                          items[index]['image'].toString();
                                      String id = items[index]['id'].toString();
                                      var exP = items[index]['expectedPrice'];
                                      var exQ = items[index]['expectedQty'];
                                      return DataRow(
                                        color: index.isOdd
                                            ? MaterialStateProperty.all(Colors
                                                .blueGrey.shade50
                                                .withOpacity(0.7))
                                            : MaterialStateProperty.all(
                                                Colors.blueGrey.shade50),
                                        cells: [
                                          DataCell(SelectableText(
                                            ' ${index + 1}',
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
                                                          imageUrl: image,
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
                                                  imageUrl: image,
                                                )),
                                          )),
                                          DataCell(SelectableText(
                                            productCode,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),

                                          DataCell(SelectableText(
                                            hcode,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            gst,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            qty,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.green,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            price,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.green,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            items[index]['expectdQty'].toString(),
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            items[index]['expectdPrice'].toString(),
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            items[index]['newQty'].toString(),
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.red,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            items[index]['newPrice'].toString(),
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.red,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                    context:
                                                    context,
                                                    barrierDismissible:
                                                    false,
                                                    builder:
                                                        (buildContext) {
                                                      print('gst:  ' +
                                                          items[index]['gst']
                                                              .toString());
                                                      productGst
                                                          .text = items[index]
                                                      [
                                                      'gst']
                                                          .toString();
                                                      productPrice
                                                          .text = items[index]
                                                      [
                                                      'newPrice']
                                                          .toString();
                                                      productQty
                                                          .text = items[index]
                                                      [
                                                      'newQty']
                                                          .toString();
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Edit New Product details'),
                                                        content:
                                                        SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  width: 350,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.white,
                                                                    borderRadius: BorderRadius.circular(8),
                                                                    border: Border.all(
                                                                      color: Color(0xFFE6E6E6),
                                                                    ),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                                                    child: TextFormField(
                                                                      keyboardType: TextInputType.number,
                                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                      validator: (value) {
                                                                        RegExp regex = RegExp(r'^\d+(\.\d+)?$');
                                                                        if (!regex.hasMatch(value!)) {
                                                                          return "Enter only numbers";
                                                                        }
                                                                      },
                                                                      controller: productPrice,
                                                                      obscureText: false,
                                                                      decoration: InputDecoration(
                                                                        labelText: 'New Price',
                                                                        labelStyle: TextStyle(
                                                                          fontFamily: 'Montserrat',
                                                                          color: Color(0xFF8B97A2),
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        hintText: 'Enter Price',
                                                                        hintStyle: TextStyle(
                                                                          fontFamily: 'Montserrat',
                                                                          color: Color(0xFF8B97A2),
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        enabledBorder: UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.transparent,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: const BorderRadius.only(
                                                                            topLeft: Radius.circular(4.0),
                                                                            topRight: Radius.circular(4.0),
                                                                          ),
                                                                        ),
                                                                        focusedBorder: UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.transparent,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: const BorderRadius.only(
                                                                            topLeft: Radius.circular(4.0),
                                                                            topRight: Radius.circular(4.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      style: TextStyle(
                                                                        fontFamily: 'Montserrat',
                                                                        color: Color(0xFF8B97A2),
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Container(
                                                                  width: 350,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.white,
                                                                    borderRadius: BorderRadius.circular(8),
                                                                    border: Border.all(
                                                                      color: Color(0xFFE6E6E6),
                                                                    ),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                                                    child: TextFormField(
                                                                      keyboardType: TextInputType.number,
                                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                      validator: (value) {
                                                                        RegExp regex = RegExp(r'^\d+(\d+)?$');
                                                                        if (!regex.hasMatch(value!)) {
                                                                          return "Enter only numbers";
                                                                        }
                                                                      },
                                                                      controller: productQty,
                                                                      obscureText: false,
                                                                      decoration: InputDecoration(
                                                                        labelText: 'New Quantity',
                                                                        labelStyle: TextStyle(
                                                                          fontFamily: 'Montserrat',
                                                                          color: Color(0xFF8B97A2),
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        hintText: 'Enter Quantity',
                                                                        hintStyle: TextStyle(
                                                                          fontFamily: 'Montserrat',
                                                                          color: Color(0xFF8B97A2),
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        enabledBorder: UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.transparent,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: const BorderRadius.only(
                                                                            topLeft: Radius.circular(4.0),
                                                                            topRight: Radius.circular(4.0),
                                                                          ),
                                                                        ),
                                                                        focusedBorder: UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.transparent,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: const BorderRadius.only(
                                                                            topLeft: Radius.circular(4.0),
                                                                            topRight: Radius.circular(4.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      style: TextStyle(
                                                                        fontFamily: 'Montserrat',
                                                                        color: Color(0xFF8B97A2),
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Container(
                                                                  width: 350,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.white,
                                                                    borderRadius: BorderRadius.circular(8),
                                                                    border: Border.all(
                                                                      color: Color(0xFFE6E6E6),
                                                                    ),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                                                    child: TextFormField(
                                                                      keyboardType: TextInputType.number,
                                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                      validator: (value) {
                                                                        RegExp regex = RegExp(r'^\d+(\.\d+)?$');
                                                                        if (!regex.hasMatch(value!)) {
                                                                          return "Enter only numbers";
                                                                        }
                                                                      },
                                                                      controller: productGst,
                                                                      obscureText: false,
                                                                      decoration: InputDecoration(
                                                                        labelText: 'GST',
                                                                        labelStyle: TextStyle(
                                                                          fontFamily: 'Montserrat',
                                                                          color: Color(0xFF8B97A2),
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        hintText: 'Enter GST',
                                                                        hintStyle: TextStyle(
                                                                          fontFamily: 'Montserrat',
                                                                          color: Color(0xFF8B97A2),
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        enabledBorder: UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.transparent,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: const BorderRadius.only(
                                                                            topLeft: Radius.circular(4.0),
                                                                            topRight: Radius.circular(4.0),
                                                                          ),
                                                                        ),
                                                                        focusedBorder: UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.transparent,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: const BorderRadius.only(
                                                                            topLeft: Radius.circular(4.0),
                                                                            topRight: Radius.circular(4.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      style: TextStyle(
                                                                        fontFamily: 'Montserrat',
                                                                        color: Color(0xFF8B97A2),
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                              child: Text('Cancel')),
                                                          TextButton(
                                                              onPressed: () async {
                                                                bool pressed = await alert(context, 'Do you want update Product Details?');
                                                                if (pressed) {
                                                                  items.removeAt(index);
                                                                  items.insert(index, {
                                                                    'color': null,
                                                                    'cut': null,
                                                                    'expectedPrice': exP,
                                                                    'expectedQty': exQ,
                                                                    'newPrice': double.tryParse(productPrice.text),
                                                                    'newQty': int.tryParse(productQty.text),
                                                                    'gst': double.tryParse(productGst.text),
                                                                    'hsnCode': hcode,
                                                                    'id': id,
                                                                    'image': image,
                                                                    'name': name,
                                                                    'price': p,
                                                                    'productCode': productCode,
                                                                    'quantity': qty,
                                                                    'shopDiscount': null,
                                                                    'shopId': null,
                                                                    'size': null,
                                                                    'status': status,
                                                                    'unit': null,
                                                                  });
                                                                  FirebaseFirestore.instance.collection('quotation').doc(widget.id).update({
                                                                    'items': items,
                                                                  });
                                                                  Navigator.pop(context);
                                                                  showUploadMessage(context, '  Updated...');
                                                                  setState(() {});
                                                                }
                                                              },
                                                              child: Text('Update')),
                                                        ],
                                                      );
                                                    });
                                                  },

                                              child: Icon(Icons.edit))),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.5,
                    ),
                    Material(
                      color: Colors.transparent,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => FreeProductList(
                                                    id: widget.id,
                                                  )));
                                        },
                                        child: Text('Add Free Product'))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 80),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Price',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      '\₹${sum.toString()}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Discount',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      '\₹${data['discount']}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (buildContext) {
                                                return AlertDialog(
                                                  title: Text('Edit Discount'),
                                                  content: SingleChildScrollView(
                                                    child: Container(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width: 350,
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                              border: Border.all(
                                                                color:
                                                                Color(0xFFE6E6E6),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                              EdgeInsets.fromLTRB(
                                                                  16, 0, 0, 0),
                                                              child: TextFormField(
                                                                autovalidateMode:
                                                                AutovalidateMode
                                                                    .onUserInteraction,
                                                                validator: (value) {
                                                                  RegExp regex = RegExp(
                                                                      r'^\d+(\.\d+)?$');
                                                                  if (!regex.hasMatch(
                                                                      value!)) {
                                                                    return "Enter only numbers";
                                                                  }
                                                                },
                                                                controller: discount,
                                                                obscureText: false,
                                                                decoration:
                                                                InputDecoration(
                                                                  labelText:
                                                                  'Discount',
                                                                  labelStyle:
                                                                  TextStyle(
                                                                    fontFamily:
                                                                    'Montserrat',
                                                                    color: Color(
                                                                        0xFF8B97A2),
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                  hintText:
                                                                  'Enter Discount',
                                                                  hintStyle:
                                                                  TextStyle(
                                                                    fontFamily:
                                                                    'Montserrat',
                                                                    color: Color(
                                                                        0xFF8B97A2),
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                  enabledBorder:
                                                                  UnderlineInputBorder(
                                                                    borderSide:
                                                                    BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                          4.0),
                                                                      topRight: Radius
                                                                          .circular(
                                                                          4.0),
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                  UnderlineInputBorder(
                                                                    borderSide:
                                                                    BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                          4.0),
                                                                      topRight: Radius
                                                                          .circular(
                                                                          4.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                  'Montserrat',
                                                                  color: Color(
                                                                      0xFF8B97A2),
                                                                  fontWeight:
                                                                  FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text('Cancel')),
                                                    TextButton(
                                                        onPressed: () async {
                                                          if (
                                                              discount.text != ''
                                                             ) {
                                                            FirebaseFirestore.instance
                                                                .collection(
                                                                'quotation')
                                                                .doc(widget.id)
                                                                .update({
                                                              'discount':
                                                              double.tryParse(
                                                                  discount.text),
                                                            });
                                                            Navigator.pop(context);
                                                            showUploadMessage(context,
                                                                'discount Updated...');
                                                          } else {
                                                            discount.text == ''
                                                                ? showUploadMessage(
                                                                context,
                                                                'Enter discount')
                                                                : '';
                                                          }
                                                        },
                                                        child: Text('Update')),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Icon(Icons.edit))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Delivery charge',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      '\₹${data['deliveryCharge']}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (buildContext) {
                                                return AlertDialog(
                                                  title: Text('Edit  Delivery Charge'),
                                                  content: SingleChildScrollView(
                                                    child: Container(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width: 350,
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                              border: Border.all(
                                                                color:
                                                                Color(0xFFE6E6E6),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                              EdgeInsets.fromLTRB(
                                                                  16, 0, 0, 0),
                                                              child: TextFormField(
                                                                autovalidateMode:
                                                                AutovalidateMode
                                                                    .onUserInteraction,
                                                                validator: (value) {
                                                                  RegExp regex = RegExp(
                                                                      r'^\d+(\.\d+)?$');
                                                                  if (!regex.hasMatch(
                                                                      value!)) {
                                                                    return "Enter only numbers";
                                                                  }
                                                                },
                                                                controller: deliverycharge,
                                                                obscureText: false,
                                                                decoration:
                                                                InputDecoration(
                                                                  labelText:
                                                                  'Delivery charge',
                                                                  labelStyle:
                                                                  TextStyle(
                                                                    fontFamily:
                                                                    'Montserrat',
                                                                    color: Color(
                                                                        0xFF8B97A2),
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                  hintText:
                                                                  'Enter Delivery Charge',
                                                                  hintStyle:
                                                                  TextStyle(
                                                                    fontFamily:
                                                                    'Montserrat',
                                                                    color: Color(
                                                                        0xFF8B97A2),
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                  enabledBorder:
                                                                  UnderlineInputBorder(
                                                                    borderSide:
                                                                    BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                          4.0),
                                                                      topRight: Radius
                                                                          .circular(
                                                                          4.0),
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                  UnderlineInputBorder(
                                                                    borderSide:
                                                                    BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                          4.0),
                                                                      topRight: Radius
                                                                          .circular(
                                                                          4.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                  'Montserrat',
                                                                  color: Color(
                                                                      0xFF8B97A2),
                                                                  fontWeight:
                                                                  FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 30,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text('Cancel')),
                                                    TextButton(
                                                        onPressed: () async {
                                                          if (
                                                              deliverycharge.text != '') {
                                                            FirebaseFirestore.instance
                                                                .collection(
                                                                'quotation')
                                                                .doc(widget.id)
                                                                .update({
                                                              'deliveryCharge':
                                                              double.tryParse(deliverycharge.text),
                                                            });
                                                            Navigator.pop(context);
                                                            showUploadMessage(context,
                                                                'deliveryCharge Updated...');
                                                          } else {
                                                            deliverycharge.text == '' ? errorMsg(context, 'Enter deliveryCharge') : '';
                                                          }
                                                        },
                                                        child: Text('Update')),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Icon(Icons.edit))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 80),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Total (excel.GST)',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      '\₹'+totalExcel.toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),

                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 80),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'GST:',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      '\₹${gst.toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                  ],
                                ),
                              ),
                              data['shippingMethod'] == 'Cash On Delivery'
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 80),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'COD Charge:',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Text(
                                            '\₹ 33.00',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 80),
                                      child: Row(
                                        children: [
                                          Text(
                                            '----------------------------------------------------------',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 80),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Order Total',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            '\₹'+grandtotal.toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // submit==true?

                              // :SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    data['quotationStatus']==0?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: FFButtonWidget(
                            onPressed: () async {
                              bool proceed = await alert(
                                  context, 'Do you Want Reject this Quotation?');
                              if(proceed){
                                FirebaseFirestore.instance.collection('quotation').doc(widget.id).update({
                                  'quotationStatus':2
                                });
                                Navigator.pop(context);
                                showUploadMessage(context, 'Rejected');
                              }

                            },
                            text: 'Reject',
                            options: FFButtonOptions(
                              width: 110,
                              height: 40,
                              color: Colors.red,
                              textStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13
                              ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: FFButtonWidget(
                            onPressed: () async {
                              bool proceed = await alert(
                                  context, 'Do you Want Accept this Quotation?');
                              if(proceed){
                                FirebaseFirestore.instance.collection('quotation').doc(widget.id).update({
                                  'quotationStatus':1
                                });
                                Navigator.pop(context);
                                showUploadMessage(context, 'Accepted');
                              }
                            },
                            text: 'Accept',
                            options: FFButtonOptions(
                              width: 110,
                              height: 40,
                              color: Colors.teal,
                              textStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13
                              ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                          ),
                        ),
                      ],
                    ):data['quotationStatus']==1? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: FFButtonWidget(
                            onPressed: () async {
                              bool proceed = await alert(
                                  context, 'Do you Want Reject this Quotation?');
                              if(proceed){
                                FirebaseFirestore.instance.collection('quotation').doc(widget.id).update({
                                  'quotationStatus':2
                                });
                                Navigator.pop(context);
                                showUploadMessage(context, 'Rejected');
                              }

                            },
                            text: 'Reject',
                            options: FFButtonOptions(
                              width: 110,
                              height: 40,
                              color: Colors.red,
                              textStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13
                              ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                          ),
                        ),
                      ],
                    ):Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: FFButtonWidget(
                            onPressed: () async {
                              bool proceed = await alert(
                                  context, 'Do you Want Accept this Quotation?');
                              if(proceed){
                                FirebaseFirestore.instance.collection('quotation').doc(widget.id).update({
                                  'quotationStatus':1
                                });
                                Navigator.pop(context);
                                showUploadMessage(context, 'Accepted');
                              }
                            },
                            text: 'Accept',
                            options: FFButtonOptions(
                              width: 110,
                              height: 40,
                              color: Colors.teal,
                              textStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13
                              ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          // );
          // }),
        ));
  }
}
