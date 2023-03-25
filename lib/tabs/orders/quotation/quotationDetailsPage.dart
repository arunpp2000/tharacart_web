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
  int sum=0;
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

       totalExcel=0;
      items = [];
      for (var a in event.data()!['items']) {
        items.add(a);
        sum = a['price'] + sum;
        q = a['quantity'] + q;
        print("--------");
        print(sum);
      }
      totalExcel=sum*q;
      grandtotal=(totalExcel!+data['deliveryCharge']+data['gst'])-data['discount'];
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
                                    DataColumn(
                                      label: Text("Invoice Number",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "ShipRocketId",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Refferred By",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "PromoCode",
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
                                          DataCell(SelectableText(
                                            'TCE-${invoiceNo ?? ''}',
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            shipprocketId ?? '',
                                            // data['shipRocketOrderId'],
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            data['referralCode']??'',
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            data['promoCode'].toString(),
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
                                      label: Text("Product Code",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Qty",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
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
                                      label: Text("Prize",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
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
                                      productPrice.text =
                                          items[index]['price'].toString();
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
                                            qty,
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
                                            price,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (buildContext) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Edit Product  Details'),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Container(
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  width: 350,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Color(
                                                                          0xFFE6E6E6),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            16,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        TextFormField(
                                                                      autovalidateMode:
                                                                          AutovalidateMode
                                                                              .onUserInteraction,
                                                                      validator:
                                                                          (value) {
                                                                        RegExp
                                                                            regex =
                                                                            RegExp(r'^\d+(\.\d+)?$');
                                                                        if (!regex
                                                                            .hasMatch(value!)) {
                                                                          return "Enter only numbers";
                                                                        }
                                                                      },
                                                                      controller:
                                                                          productPrice,
                                                                      obscureText:
                                                                          false,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'price',
                                                                        labelStyle:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              Color(0xFF8B97A2),
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                        hintText:
                                                                            'Enter Name',
                                                                        hintStyle:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              Color(0xFF8B97A2),
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                        enabledBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                          borderRadius:
                                                                              const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(4.0),
                                                                            topRight:
                                                                                Radius.circular(4.0),
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                          borderRadius:
                                                                              const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(4.0),
                                                                            topRight:
                                                                                Radius.circular(4.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      style:
                                                                          TextStyle(
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
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  width: 350,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Color(
                                                                          0xFFE6E6E6),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            16,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        TextFormField(
                                                                      autovalidateMode:
                                                                          AutovalidateMode
                                                                              .onUserInteraction,
                                                                      validator:
                                                                          (value) {
                                                                        RegExp
                                                                            regex =
                                                                            RegExp(r'^\d+(\.\d+)?$');
                                                                        if (!regex
                                                                            .hasMatch(value!)) {
                                                                          return "Enter only numbers";
                                                                        }
                                                                      },
                                                                      controller:
                                                                          productGty,
                                                                      obscureText:
                                                                          false,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Quanity',
                                                                        labelStyle:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              Color(0xFF8B97A2),
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                        hintText:
                                                                            'Enter Quanity',
                                                                        hintStyle:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              Color(0xFF8B97A2),
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                        enabledBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                          borderRadius:
                                                                              const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(4.0),
                                                                            topRight:
                                                                                Radius.circular(4.0),
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                          borderRadius:
                                                                              const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(4.0),
                                                                            topRight:
                                                                                Radius.circular(4.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      style:
                                                                          TextStyle(
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
                                                                  height: 10,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  'Cancel')),
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                bool pressed =
                                                                    await alert(
                                                                        context,
                                                                        'Do you want update Product Details?');
                                                                if (pressed) {
                                                                  items.removeAt(
                                                                      index);
                                                                  items.insert(
                                                                      index,
                                                                      {
                                                                        'color':
                                                                            null,
                                                                        'cut':
                                                                            null,
                                                                        'expectedPrice':
                                                                            exP,
                                                                        'expectedQty':
                                                                            exQ,
                                                                        'gst':
                                                                            gst,
                                                                        'hsnCode':
                                                                            hcode,
                                                                        'id':
                                                                            id,
                                                                        'image':
                                                                            image,
                                                                        'name':
                                                                            name,
                                                                        'price':
                                                                            int.tryParse(productPrice.text),
                                                                        'productCode':
                                                                            productCode,
                                                                        'quantity':
                                                                            int.tryParse(productGty.text),
                                                                        'shopDiscount':
                                                                            null,
                                                                        'shopId':
                                                                            null,
                                                                        'size':
                                                                            null,
                                                                        'status':
                                                                            0,
                                                                        'unit':
                                                                            null,
                                                                      });
                                                                  setState(
                                                                      () {});
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'quotation')
                                                                      .doc(widget
                                                                          .id)
                                                                      .update({
                                                                    'items': items,
                                                                  }).then((value) {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                        'quotation')
                                                                        .doc(widget
                                                                        .id)
                                                                        .update({
                                                                      'price':sum!+data['deliveryCharge'],
                                                                    });
                                                                  });

                                                                  submit = true;
                                                                  Navigator.pop(
                                                                      context);
                                                                  showUploadMessage(
                                                                      context,
                                                                      '  Updated...');
                                                                  setState(() {

                                                                  });
                                                                }
                                                              },
                                                              child: Text(
                                                                  'Update')),
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
                                padding: const EdgeInsets.only(right: 80),
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
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 80),
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
                                      '\₹${data['gst'].toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
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
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // submit==true?
                              ElevatedButton(
                                  onPressed: () {

                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (buildContext) {
                                          return AlertDialog(
                                            title: Text('Edit Order Details'),
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
                                                          controller: Price,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: 'price',
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
                                                                'Enter Name',
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
                                                      height: 10,
                                                    ),
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
                                                    SizedBox(
                                                      height: 10,
                                                    ),
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
                                                          validator: (value) {
                                                            RegExp regex =
                                                                RegExp(
                                                                    r'^\d+$');
                                                            if (regex.hasMatch(
                                                                value!)) {
                                                              print(
                                                                  "Input contains only numbers");
                                                            } else {
                                                              print(
                                                                  "Input contains non-numeric characters");
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
                                                      height: 10,
                                                    ),
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
                                                          validator: (value) {
                                                            RegExp regex =
                                                                RegExp(
                                                                    r'^\d+$');
                                                            if (regex.hasMatch(
                                                                value!)) {
                                                              print(
                                                                  "Input contains only numbers");
                                                            } else {
                                                              print(
                                                                  "Input contains non-numeric characters");
                                                            }
                                                          },
                                                          controller: totalgst,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Total (excel.gst)',
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
                                                                'Total',
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
                                                      height: 10,
                                                    ),
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
                                                          controller: Gst,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: 'Gst',
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
                                                                'Enter Gst',
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
                                                    if (Price.text != '' &&
                                                        discount.text != '' &&
                                                        Gst.text != '' &&
                                                        totalgst.text != '') {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'quotation')
                                                          .doc(widget.id)
                                                          .update({
                                                        'price':
                                                            double.tryParse(
                                                                Price.text),
                                                        'discount':
                                                            double.tryParse(
                                                                discount.text),
                                                        'deliveryCharge':
                                                            double.tryParse(
                                                                deliverycharge
                                                                    .text),
                                                        'gst': double.tryParse(
                                                            Gst.text),
                                                        'total': double.tryParse(
                                                            totalgst.text),
                                                        'quotationStatus': 1,
                                                      });
                                                      Navigator.pop(context);
                                                      showUploadMessage(context,
                                                          'Product Details Updated...');
                                                    } else {
                                                      Price.text == ''
                                                          ? showUploadMessage(
                                                              context,
                                                              'Enter Order Price')
                                                          : discount.text == ''
                                                              ? showUploadMessage(
                                                                  context,
                                                                  'Enter Order Discount')
                                                              : deliverycharge
                                                                          .text ==
                                                                      ''
                                                                  ? showUploadMessage(
                                                                      context,
                                                                      'Enter Order Delivery charge')
                                                                  : Gst.text ==
                                                                          ''
                                                                      ? showUploadMessage(
                                                                          context,
                                                                          'Enter Order Gst')
                                                                      : totalgst.text ==
                                                                              ''
                                                                          ? showUploadMessage(
                                                                              context,
                                                                              'Enter Order Total Gst')
                                                                          : '';
                                                    }
                                                  },
                                                  child: Text('Update')),
                                            ],
                                          );
                                        });
                                  },
                                  child: Text('update'))
                              // :SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
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
