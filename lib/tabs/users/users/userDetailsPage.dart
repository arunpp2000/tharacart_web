import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../widgets/button.dart';
import '../../../widgets/uploadmedia.dart';

class UsersViewWidget extends StatefulWidget {
  final String? id;
  const UsersViewWidget({Key? key, this.id}) : super(key: key);

  @override
  _UsersViewWidgetState createState() => _UsersViewWidgetState();
}

class _UsersViewWidgetState extends State<UsersViewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<void> _launched;

  late DocumentSnapshot data;
  Future<void> _makeCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call$url';
    }
  }

  int totalOrders = 0;
  double wallet = 0;

  getOrders() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('orders')
        .where('orderStatus', isEqualTo: 4)
        .where('userId', isEqualTo: widget.id)
        .get();

    QuerySnapshot snap1 = await FirebaseFirestore.instance
        .collection('b2bOrders')
        .where('orderStatus', isEqualTo: 4)
        .where('userId', isEqualTo: widget.id)
        .get();

    totalOrders = snap.docs.length + snap1.docs.length;
    print(snap.docs.length);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
  }

  String refferalCode = '';
  String gst = '';
  String group = '';
  String states = '';
  String pinCode = '';
  String fullName = '';
  String photoUrl = '';
  // String mobile='';
  // String email='';
  final TextEditingController email = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController phone = TextEditingController();
  String groupName = '';
  getGroups(int pinCode) async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('pincodeGroups')
        .where('pincodes', arrayContains: pinCode)
        .get();

    if (snap.docs.isNotEmpty) {
      groupName = snap.docs[0].id;
    }
    FirebaseFirestore.instance.collection('users').doc(widget.id).update({
      'email': email.text,
      'pinCode': pincode.text,
      'mobileNumber': phone.text,
      'state': state.text,
      'group': groupName,
    });

    print(groupName);

    showUploadMessage(context, 'User Details Updated...');
    Navigator.pop(context);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Details',
          style: TextStyle(
            fontFamily: 'Lexend Deca',
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Row(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () async {
                      bool pressed =await  alert(context, 'Delete User ?');
                      if(pressed){
                        // FirebaseFirestore.instance.collection('deletedUsers')
                        //     .doc(data.id)
                        //     .set(data.data());
                        data.reference.delete();
                        showUploadMessage(context, 'User Deleted...');
                        Navigator.pop(context);

                      }
                    },
                    child: Icon(Icons.delete)),
              ),
            ],
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                data = snapshot.data!;
                fullName = data['fullName'];
                email.text = data['email'];
                phone.text = data['mobileNumber'];
                photoUrl = data['photoUrl'];

                try {
                  pinCode = data['pinCode'];
                  refferalCode = data['referralCode'];
                  states = data['state'];
                  gst = data['gst'];
                  group = data['group'];
                } catch (e) {
                  print('------------');
                  print(e);
                  print('------------');
                }

                try {
                  wallet = double.tryParse(data['wallet'].toString())!;
                } catch (e) {
                  print(e.toString());
                }

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 76,
                                    height: 76,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: photoUrl == ''
                                          ? 'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png'
                                          : photoUrl,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 0),
                                    child: Text(
                                      fullName ?? '',
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 10, 20, 16),
                              child: TextFormField(
                                controller: phone,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Phone No',
                                  hintText: 'Please Enter Phone No',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF95A1AC),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF95A1AC),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF1F4F8),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF1F4F8),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          20, 24, 0, 24),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF090F13),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                              child: TextFormField(
                                controller: email,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  hintText: 'Please Enter Email Address',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF95A1AC),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF95A1AC),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF1F4F8),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF1F4F8),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsetsDirectional.fromSTEB(
                                      20, 24, 0, 24),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF090F13),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                              child: TextFormField(
                                controller: state,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'State',
                                  hintText: 'Please Enter State',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF95A1AC),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF95A1AC),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF1F4F8),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF1F4F8),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          20, 24, 0, 24),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF090F13),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                              child: TextFormField(
                                controller: pincode,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Pincode',
                                  hintText: 'Please Enter Pincode',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF95A1AC),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF95A1AC),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF1F4F8),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF1F4F8),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          20, 24, 0, 24),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF090F13),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0.05),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              if (pincode.text != '' &&
                                  email.text != '' &&
                                  phone.text != '' &&
                                  state.text != '') {
                                getGroups(int.tryParse(pincode.text) ?? 0);
                              } else {
                                phone.text == ''
                                    ? showUploadMessage(
                                        context, 'Please Enter Phone No')
                                    : email.text == ''
                                        ? showUploadMessage(context,
                                            'Please Enter Email Address')
                                        : state.text == ''
                                            ? showUploadMessage(
                                                context, 'Please Enter State')
                                            : showUploadMessage(context,
                                                'Please Enter Pincode');
                              }
                            },
                            text: 'Save Changes',
                            options: FFButtonOptions(
                              width: 340,
                              height: 60,
                              color: Color(0xFF4B39EF),
                              textStyle: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              elevation: 2,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 8,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 12, 0, 12),
                                child: Text(
                                  'User Details',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 12, 0, 4),
                                child: Text(
                                  'Wallet : ${wallet.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 12, 0, 4),
                                child: Text(
                                  'Total Orders : ${totalOrders.toString()}',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(24, 0, 0, 4),
                                child: Text(
                                  'Referral Code  : $refferalCode',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(24, 0, 0, 4),
                                child: Text(
                                  'GST : $gst',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(24, 0, 0, 4),
                                child: Text(
                                  'Group : $group',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   children: [
                          //     Padding(
                          //       padding:
                          //           EdgeInsetsDirectional.fromSTEB(24, 0, 0, 4),
                          //       child: Text(
                          //         'State : $state',
                          //         style: TextStyle(
                          //           fontFamily: 'Lexend Deca',
                          //           color: Colors.black,
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.normal,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   children: [
                          //     Padding(
                          //       padding:
                          //           EdgeInsetsDirectional.fromSTEB(24, 0, 0, 4),
                          //       child: Text(
                          //         'PinCode : $pinCode',
                          //         style: TextStyle(
                          //           fontFamily: 'Lexend Deca',
                          //           color: Colors.black,
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.normal,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
