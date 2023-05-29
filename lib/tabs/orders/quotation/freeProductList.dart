
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



import 'package:flutter/material.dart';

import '../../../widgets/uploadmedia.dart';
import '../../dashboard/dashboard.dart';

class FreeProductList extends StatefulWidget {
  var id;

  FreeProductList({Key? key, this.id}) : super(key: key);

  @override
  _FreeProductListState createState() => _FreeProductListState();
}

class _FreeProductListState extends State<FreeProductList> {
  TextEditingController search = TextEditingController();
  TextEditingController invoiceNo = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String number='';
  int limit=5;
  Timestamp?  thisMonth;
  Timestamp?  today;
  @override
  void initState() {

    super.initState();

  }


  TextEditingController count =TextEditingController(text: '1');
  int countt=1;
  void _increment() {
    setState(() {
      countt++;
    });
  }

  void _decrement() {
    setState(() {
      if (countt != 1) {
        countt--;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Add Free Product',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: Color(0xFFC4C4C4),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                          child: TextFormField(
                            controller: search,
                            obscureText: false,
                            onFieldSubmitted: (text){
                              setState(() {
                              });
                            },
                            decoration: InputDecoration(
                              // labelText: 'Search here...',
                              // labelStyle: FlutterFlowTheme
                              //     .bodyText1
                              //     .override(
                              //   fontFamily: 'Lexend Deca',
                              //   color: Color(0xFF57636C),
                              //   fontSize: 14,
                              //   fontWeight: FontWeight.normal,
                              // ),
                              hintText: 'Search product',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            style:
                            TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF262D34),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                      //   child: FFButtonWidget(
                      //     onPressed: () {
                      //       print('Button pressed ...');
                      //     },
                      //     text: 'Search',
                      //     options: FFButtonOptions(
                      //       width: 100,
                      //       height: 40,
                      //       color: Color(0xFF4B39EF),
                      //       textStyle:
                      //       FlutterFlowTheme.subtitle2.override(
                      //         fontFamily: 'Lexend Deca',
                      //         color: Colors.white,
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.normal,
                      //       ),
                      //       elevation: 2,
                      //       borderSide: BorderSide(
                      //         color: Colors.transparent,
                      //         width: 1,
                      //       ),
                      //       borderRadius: 50,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              search.text==''?SizedBox():
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('products')
                        .orderBy('date',descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator());
                      }
                      var data=snapshot.data!.docs;
                      print(data.length);
                      return   ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (buildContext,int index){
                            String images = data[index]['imageId'].isEmpty?'':data[index]['imageId'][0];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(0),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 0,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsetsDirectional
                                                            .fromSTEB(12, 0, 0, 0),
                                                        child: InkWell(
                                                          onTap: (){
                                                            showDialog(
                                                                context: context,
                                                                barrierDismissible: false,
                                                                builder: (buildContext) {
                                                                  return AlertDialog(
                                                                    title: Text('Add Quantity'),
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
                                                                                  keyboardType: TextInputType.number,
                                                                                  autovalidateMode:
                                                                                  AutovalidateMode
                                                                                      .onUserInteraction,
                                                                                  validator: (value) {
                                                                                    RegExp regex = RegExp(
                                                                                        r'^\d+(\d+)?$');
                                                                                    if (!regex.hasMatch(
                                                                                        value!)) {
                                                                                      return "Enter only numbers";
                                                                                    }
                                                                                  },
                                                                                  controller: count,
                                                                                  obscureText: false,
                                                                                  decoration:
                                                                                  InputDecoration(
                                                                                    labelText: 'Quantity',
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

                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                          onPressed: () async {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Text('ok')),
                                                                    ],
                                                                  );
                                                                });
                                                          },
                                                          child: Card(
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            color: Color(0xFFF1F5F8),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  8),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  2, 2, 2, 2),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    8),
                                                                child: CachedNetworkImage(
                                                                  imageUrl: images,
                                                                  width: 90,
                                                                  height: 90,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(12, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            data[index]['name'],
                                                            style: TextStyle(
                                                              fontFamily:
                                                              'Lexend Deca',
                                                              color:
                                                              Color(0xFF111417),
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                          SizedBox(height: 5,),
                                                          // Padding(
                                                          //   padding:
                                                          //   EdgeInsetsDirectional
                                                          //       .fromSTEB(
                                                          //       0, 4, 0, 4),
                                                          //   child: Text('Qty :',
                                                          //     style:
                                                          //     FlutterFlowTheme
                                                          //         .bodyText1
                                                          //         .override(
                                                          //       fontFamily:
                                                          //       'Lexend Deca',
                                                          //       color: Color(
                                                          //           0xFF090F13),
                                                          //       fontSize: 14,
                                                          //       fontWeight:
                                                          //       FontWeight
                                                          //           .normal,
                                                          //     ),
                                                          //   ),
                                                          // ),

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [

                                                              ElevatedButton(onPressed: () async {
                                                                bool proceed = await alert(
                                                                    context, 'Do you Want Add this Free Product?');
                                                                if(proceed) {
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                      'quotation')
                                                                      .doc(widget.id)
                                                                      .update({
                                                                    'items': FieldValue
                                                                        .arrayUnion([{
                                                                      'color': null,
                                                                      'cut': null,
                                                                      'expectedPrice': 0,
                                                                      'expectedQty': 0,
                                                                      'newPrice':0,
                                                                      'newQty':0,
                                                                      'gst': 0,
                                                                      'hsnCode': data[index]['hsnCode'],
                                                                      'id':data[index]['productId'] ,
                                                                      'image': images,
                                                                      'name':data[index]['name'],
                                                                      'price': 0,
                                                                      'productCode':data[index]['productCode'] ,
                                                                      'quantity': int.tryParse(count.text),
                                                                      'shopDiscount': null,
                                                                      'size': null,
                                                                      'shopId': null,
                                                                      'status': 0,
                                                                      'unit': null,
                                                                    }
                                                                    ])

                                                                  });
                                                                  showUploadMessage(context,'Added');
                                                                  count.text='1';
                                                                }

                                                              }, child: Text('add Product'))





                                                              // TextButton(
                                                              //     onPressed: _decrement,
                                                              //     child: const Text('-', style: TextStyle(color: Colors.grey),
                                                              //     )),
                                                              // Text(
                                                              //   '$count',
                                                              //   style: const TextStyle(color: Colors.grey),
                                                              // ),
                                                              // TextButton(
                                                              //     onPressed: _increment,
                                                              //     child: const Text(
                                                              //       '+',
                                                              //       style: TextStyle(color: Colors.grey),
                                                              //     )),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Padding(
                                              //   padding: EdgeInsetsDirectional.fromSTEB(
                                              //       16, 4, 16, 4),
                                              //   child: Row(
                                              //     mainAxisSize: MainAxisSize.max,
                                              //     mainAxisAlignment:
                                              //     MainAxisAlignment.spaceBetween,
                                              //     children: [
                                              //       Text(
                                              //         '[Price]',
                                              //         style: FlutterFlowTheme
                                              //             .subtitle1
                                              //             .override(
                                              //           fontFamily: 'Lexend Deca',
                                              //           color: Color(0xFF151B1E),
                                              //           fontSize: 18,
                                              //           fontWeight: FontWeight.w500,
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget ProductCard(int hscode,String productId,String img,String name,String pC,int cnt){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding:
              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
              child: Material(
                color: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(
                      color: Colors.white,
                      width: 0,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional
                                    .fromSTEB(12, 0, 0, 0),
                                child: InkWell(
                                  onTap: ()
                                  async {
                                    bool proceed = await alert(
                                        context, 'Do you Want Add this Free Product?');
                                    if(proceed) {
                                      FirebaseFirestore
                                          .instance
                                          .collection(
                                          'quotation')
                                          .doc(widget.id)
                                          .update({
                                        'items': FieldValue
                                            .arrayUnion([{
                                          'color': null,
                                          'cut': null,
                                          'expectedPrice': 0,
                                          'expectedQty': 0,
                                          'gst': 0,
                                          'hsnCode': hscode,
                                          'id': productId,
                                          'image': img,
                                          'name': name,
                                          'price': 0,
                                          'productCode': pC,
                                          'quantity': cnt,
                                          'shopDiscount': null,
                                          'size': null,
                                          'shopId': null,
                                          'status': 0,
                                          'unit': null,
                                        }
                                        ])
                                      });
                                    }
                                  },
                                  child: Card(
                                    clipBehavior: Clip
                                        .antiAliasWithSaveLayer,
                                    color: Color(0xFFF1F5F8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8),
                                    ),
                                    child: Padding(
                                      padding:
                                      EdgeInsetsDirectional
                                          .fromSTEB(
                                          2, 2, 2, 2),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(
                                            8),
                                        child: CachedNetworkImage(
                                          imageUrl: img,
                                          width: 90,
                                          height: 90,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional
                                  .fromSTEB(12, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontFamily:
                                      'Lexend Deca',
                                      color:
                                      Color(0xFF111417),
                                      fontSize: 12,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional
                                        .fromSTEB(
                                        0, 4, 0, 4),
                                    child: Text('Qty :',
                                      style:
                                      TextStyle(
                                        fontFamily:
                                        'Lexend Deca',
                                        color: Color(
                                            0xFF090F13),
                                        fontSize: 14,
                                        fontWeight:
                                        FontWeight
                                            .normal,
                                      ),
                                    ),
                                  ),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          onPressed: _decrement,
                                          child: const Text('-', style: TextStyle(color: Colors.grey),
                                          )),
                                      Text(
                                        '$count',
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                      TextButton(
                                          onPressed: _increment,
                                          child: const Text(
                                            '+',
                                            style: TextStyle(color: Colors.grey),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(
                      //       16, 4, 16, 4),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.max,
                      //     mainAxisAlignment:
                      //     MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         '[Price]',
                      //         style: FlutterFlowTheme
                      //             .subtitle1
                      //             .override(
                      //           fontFamily: 'Lexend Deca',
                      //           color: Color(0xFF151B1E),
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
