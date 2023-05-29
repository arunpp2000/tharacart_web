import 'package:animated_custom_dropdown/custom_dropdown.dart';
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
import 'b2cpdf.dart';
import 'editpop.dart';
import 'invoice.dart';

class B2cOrderDetails extends StatefulWidget {
  var id;

  B2cOrderDetails({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  _B2cOrderDetailsState createState() => _B2cOrderDetailsState();
}

class _B2cOrderDetailsState extends State<B2cOrderDetails> {
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
  String partner ='';
  List items = [];
  int? sum;
  TextEditingController awbCode = TextEditingController();
  TextEditingController trackingUrl = TextEditingController();
  TextEditingController pController = TextEditingController();
  String? shipprocketId;
  String? invoiceNo;
  getorders() {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.id)
        .snapshots()
        .listen((event) {
      data = event.data();
      address = event.data()!['shippingAddress'];
      sum = 0;
      items=[];
      for (var a in event.data()!['items']) {
        items.add(a);
        sum = a['price'] + sum;
      }
      try {
        partner=data['partner'];
        pController.text=data['partner'];
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

  // if (widget.order.referralCode != null) {
  // QuerySnapshot rUsers = await FirebaseFirestore
  //     .instance
  //     .collection('users')
  //     .where('referralCode',
  // isEqualTo: widget.order.referralCode)
  //     .get();
  // }

  List<dynamic> p=[];
  List<String> pItems=[''];
  getPartner(){
    FirebaseFirestore.instance.collection('settings').doc('order').get().then((value) {
      p=value.data()!['partners'];
      for(var a in value.data()!['partners'])
{
  pItems.add(a.toString());
}

      // pItems=value.data()!['partners'];
      print('---------');
      print(p);
      setState(() {

      });
    });

  }
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    getorders();
    getPartner();
  }

  @override
  Widget build(BuildContext context) {
    trackingUrl.text = data['trackingUrl'] ?? '';
    awbCode.text = data['awb_code'] ?? '';
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
                                    data['orderStatus'] == 3 ||
                                            data['orderStatus'] == 4
                                        ? IconButton(
                                            onPressed: () async {
                                              Map items = {};
                                              List products = [];
                                              for (var a in data['items']) {
                                                print('=========');
                                                print(a['name']);
                                                items = {
                                                  'productName': a['name'],
                                                  'price': a['price'],
                                                  'quantity':
                                                      a['quantity'].toInt(),
                                                  'total': a['price'] *
                                                      a['quantity'],
                                                  'gst': a['gst'],
                                                };
                                                products.add(items);
                                              }
                                              print(items);
                                              List<InvoiceItem> item = [];
                                              int? amount = int.tryParse(
                                                  data['price'].toString());
                                              print(amount.toString());
                                              String number = NumberToWord()
                                                  .convert('en-in', amount!);
                                              for (var data in products) {
                                                item.add(
                                                  InvoiceItem(
                                                    description: data['productName'],
                                                    gst: data['total'] - data['quantity'] * data['price'] * 100 / (100 + data['gst']),
                                                    // gst: items['quantity']*items['price']*100/(100+items['gst'])* items['gst']/100,
                                                    price: data['price'],
                                                    quantity: data['quantity'],
                                                    tax: data['quantity'] *
                                                        data['price'] *
                                                        100 /
                                                        (100 + data['gst']),
                                                    total: data['total'],
                                                    unitPrice: data['price'] *
                                                        100 /
                                                        (100 + data['gst']),
                                                  ),
                                                );
                                              }

                                              final invoice = Invoice(
                                                invoiceNo: data['invoiceNo'],
                                                discount: data['discount'],
                                                shipRocketId:
                                                    data['shipRocketOrderId'],
                                                invoiceNoDate:
                                                    data['invoiceDate'],
                                                orderId: widget.id,
                                                shipping:
                                                    data['deliveryCharge'],
                                                orderDate: data['placedDate'],
                                                total: data['total'],
                                                price: data['price'],
                                                gst: data['gst'],
                                                amount: number,
                                                method: data['shippingMethod'],
                                                b2b: data['b2b'],
                                                shippingAddress: [
                                                  ShippingAddress(
                                                    gst: data['gst']
                                                            .toString() ??
                                                        '',
                                                    name: address['name'],
                                                    area: address['area'],
                                                    address: address['address'],
                                                    mobileNumber:
                                                        address['mobileNumber'],
                                                    pincode: address['pinCode'],
                                                    city: address['city'],
                                                    state: address['state'],
                                                  ),
                                                ],
                                                salesItems: item,
                                              );

                                              final pdfFile =
                                                  await B2cPdfInvoiceApi
                                                      .generate(invoice);
                                              await PdfApi.openFile(pdfFile);
                                            },
                                            icon: Icon(Icons.picture_as_pdf))
                                        : SizedBox(),
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    data['orderStatus'] == 0
                                        ? Text(
                                            'Status:' + 'Pending',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : data['orderStatus'] == 1
                                            ? Text('Status:' + 'Accepted',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            : data['orderStatus'] == 2
                                                ? Text(
                                                    'Status:' + 'Cancelled',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : data['orderStatus'] == 3
                                                    ? Text(
                                                        'Status:' + 'Shipped',
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    : Text(
                                                        'Status:' + 'Delivered',
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                  ],
                                ),
                              ),

                              data['orderStatus'] >= 1
                                  ?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 12, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 200,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: Color(0xFFE6E6E6),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      16, 0, 0, 0),
                                                  child: TextFormField(
                                                    controller: awbCode,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'AWB Code',
                                                      labelStyle: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF8B97A2),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      hintText:
                                                          'Enter your AWB Code',
                                                      hintStyle: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF8B97A2),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  4.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  4.0),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  4.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  4.0),
                                                        ),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF8B97A2),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  if(awbCode.text!=''){
                                                  bool pressed = await alert(
                                                      context, 'Update AWB');
                                                  if (pressed) {
                                                    FirebaseFirestore.instance
                                                        .collection('orders')
                                                        .doc(widget.id)
                                                        .update({
                                                      'awb_code': awbCode.text,
                                                    });
                                                    showUploadMessage(context,
                                                        'AWB updated...');
                                                  }
                                                  }else{
                                                    errorMsg(context, 'Please Enter AWB Code...');
                                                  }
                                                },
                                                text: 'Update',
                                                options: FFButtonOptions(
                                                  height: 40,
                                                  color: primaryColor,
                                                  textStyle: TextStyle(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
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
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                                          child: Container(
                                            width: 330,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                const BoxShadow(
                                                  blurRadius: 2,
                                                  color: Color(0x4D101213),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: CustomDropdown.search(
                                              hintText: 'Select partner',
                                              hintStyle: TextStyle(color: Colors.black),
                                              items: pItems.isEmpty?['']:pItems,
                                              controller:pController,
                                              excludeSelected: false,
                                              onChanged: (text) {
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(8.0),
                                        //   child: Container(
                                        //     width: 300,
                                        //     decoration: BoxDecoration(
                                        //         color: Colors.grey[200],
                                        //         border: Border.all(
                                        //           color: Colors.white,
                                        //         ),
                                        //         borderRadius: BorderRadius.circular(12)),
                                        //     child: DropdownButtonFormField<String>(
                                        //       value: partner,
                                        //       decoration: InputDecoration(
                                        //         hintText: "Partners",
                                        //         border: OutlineInputBorder(),
                                        //       ),
                                        //       onChanged: (crs) {
                                        //         setState(() {
                                        //           partner = crs.toString();
                                        //         });
                                        //       },
                                        //       validator: (value) =>
                                        //       value == null ? 'field required' : null,
                                        //       items: p.toList()
                                        //           .map<DropdownMenuItem<String>>((value) {
                                        //         return DropdownMenuItem<String>(
                                        //           value: value,
                                        //           child: Text(value),
                                        //         );
                                        //       }).toList(),
                                        //     ),
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 12, 0, 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 300,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: Color(0xFFE6E6E6),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      16, 0, 0, 0),
                                                  child: TextFormField(
                                                    controller: trackingUrl,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Tracking Url',
                                                      labelStyle: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF8B97A2),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      hintText:
                                                          'Enter your Tracking Url',
                                                      hintStyle: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF8B97A2),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  4.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  4.0),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  4.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  4.0),
                                                        ),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF8B97A2),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      if(trackingUrl.text!=''){
                                                      bool pressed = await alert(
                                                          context,
                                                          'Update Tracking Url');
                                                      if (pressed) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'orders')
                                                            .doc(widget.id)
                                                            .update({
                                                          'trackingUrl':
                                                              trackingUrl.text,
                                                          'partner':pController.text,
                                                        });
                                                        showUploadMessage(context,
                                                            'Tracking Url updated...');
                                                      }
                                                      }else{
                                                        errorMsg(context, 'Please Enter Tracking Url...');
                                                      }
                                                    },
                                                    text: 'Update',
                                                    options: FFButtonOptions(
                                                      height: 40,
                                                      color: primaryColor,
                                                      textStyle: TextStyle(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius: 12,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      if (trackingUrl.text !=
                                                          '') {
                                                        bool pressed = await alert(
                                                            context,
                                                            'Launch Tracking Url');
                                                        if (pressed) {
                                                          _launchURL(
                                                              trackingUrl.text);
                                                        }
                                                      } else {
                                                        trackingUrl.text ==''? errorMsg(
                                                            context,
                                                            'Please Enter Tracking Url...'):'';
                                                      }
                                                    },
                                                    text: 'Launch',
                                                    options: FFButtonOptions(
                                                      height: 40,
                                                      color: primaryColor,
                                                      textStyle: TextStyle(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
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
                                                data['placedDate'].toDate()),
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
                                            data['referralCode'],
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
                                      String name =
                                          data['shippingAddress']['name'];
                                      String address =
                                          data['shippingAddress']['address'];
                                      String number = data['shippingAddress']
                                          ['mobileNumber'];
                                      String anumber = data['shippingAddress']
                                          ['alternativePhone'];
                                      String city =
                                          data['shippingAddress']['city'];
                                      String area =
                                          data['shippingAddress']['area'];
                                      String pincode =
                                          data['shippingAddress']['pinCode'];
                                      String state =
                                          data['shippingAddress']['state'];
                                      String landmark =
                                          data['shippingAddress']['landMark'];
                                      // Timestamp placedDate = data[0]['shippingAddress']['placedDate'];
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
                                  ],
                                  rows: List.generate(
                                    items.length,
                                    (index) {
                                      String name = items[index]['name'];
                                      String productCode =
                                          items[index]['productCode'];
                                      String price =
                                          items[index]['price'].toString();
                                      String qty =
                                          items[index]['quantity'].toString();
                                      String gst =
                                          items[index]['gst'].toString();
                                      String hcode =
                                          items[index]['hsnCode'].toString();
                                      String image =
                                          items[index]['image'].toString();
                                      // String hcode = items[index]['quantity'].toString();
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
                              // Padding(
                              //   padding: EdgeInsets.all(8.0),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       Padding(
                              //         padding: const EdgeInsets.only(right: 80),
                              //         child: Row(
                              //           children: [
                              //             Text(
                              //               'Product Total (${items.length}) items',
                              //               style: TextStyle(
                              //                   fontSize: 15,
                              //                   fontWeight: FontWeight.bold),
                              //             ),
                              //             SizedBox(
                              //               width: 50,
                              //             ),
                              //             Text(
                              //               '\₹$sum',
                              //               style: TextStyle(
                              //                   fontSize: 15,
                              //                   fontWeight: FontWeight.bold),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: EdgeInsets.all(8.0),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       Padding(
                              //         padding: const EdgeInsets.only(right: 80),
                              //         child: Row(
                              //           children: [
                              //             Text(
                              //               'Shipping Charge',
                              //               style: TextStyle(
                              //                   fontSize: 15,
                              //                   fontWeight: FontWeight.bold),
                              //             ),
                              //             SizedBox(
                              //               width: 50,
                              //             ),
                              //             Text('3242'),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
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
                                      '\₹${data['total'].toStringAsFixed(2)}',
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
                                            '\₹'+data['price'].toString(),
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
