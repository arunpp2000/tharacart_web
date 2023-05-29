
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/button.dart';
import '../../widgets/uploadmedia.dart';
import '../dashboard/dashboard.dart';

class RequestDetailsWidget extends StatefulWidget {


   var id;
   RequestDetailsWidget({Key? key, this.id}) : super(key: key);

  @override
  _RequestDetailsWidgetState createState() => _RequestDetailsWidgetState();
}

class _RequestDetailsWidgetState extends State<RequestDetailsWidget> {
  late TextEditingController code;
  late TextEditingController customerDiscount;
  late TextEditingController commission;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var data;
  var user;
  String? name;
  String? email;
  String? phoneNo;
  String? image;
  String? userId;
  getImage() async {
    var userImage = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
    image=userImage.get('photoUrl');
    print("pic "+image.toString());
    setState(() {

    });
  }

  getrefferal() {
    FirebaseFirestore.instance
        .collection('referralRequests')
        .doc(widget.id)
        .snapshots()
        .listen((event) async {
    name=event.data()!['userName'];
    email=event.data()!['email'];
    phoneNo=event.data()!['phoneNo'];
    code.text=event.data()!['referralCode'];
    userId=await event.data()!['userId'];
    getImage();
print(userId);
if(mounted){
  setState(() {

  });
}

    });
  }
  @override
  void initState() {
    super.initState();
    code = TextEditingController();
    customerDiscount = TextEditingController();
    commission = TextEditingController();
    getrefferal();
    // getImage();
  }


    // DocumentSnapshot? data;
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
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.white,
      body:  Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                  child: Container(
                                    width: 76,
                                    height: 76,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: "https://lh3.googleusercontent.com/a/AATXAJz8c8iGF2WQcbaV6aZUVYXTpBsQKdVo2CdOvGV6=s96-c"??'',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                  child: Text(
                                    name!,
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF090F13),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                  child: Text(
                                    phoneNo!,
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFFEE8B60),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                  child: Text(
                                    email!,
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFFEE8B60),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: code,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Refer Code',
                                        labelStyle:
                                        TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                        ),
                                        hintText: 'Please Enter Refer Code',
                                        hintStyle:
                                        TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,

                                      controller: customerDiscount,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Customer Discount',
                                        labelStyle:
                                        TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                        ),
                                        hintText: 'Please Enter Customer Discount',
                                        hintStyle:
                                        TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: commission,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'User Commission',
                                        labelStyle:
                                        TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                        ),
                                        hintText: 'Please Enter User Commission',
                                        hintStyle:
                                        TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'Cancel',
                        options: FFButtonOptions(
                          width: 110,
                          height: 40,
                          color: Colors.white,
                          textStyle: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF4B39EF),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 8,
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          if(code.text!=''&&customerDiscount.text!=''&&commission.text!=''){
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Confirm'),
                                  content: Text('Do You Want to Continue?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(alertDialogContext),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: ()  {
                                        FirebaseFirestore.instance.collection('referralRequests').doc(widget.id).update({
                                          'approved':1,
                                          'referralCode':code.text,
                                          'customerDiscount':int.tryParse(customerDiscount.text),
                                          'userCommission':int.tryParse(commission.text),
                                        }).then((value) {

                                          FirebaseFirestore.instance.collection('users').doc(userId).update({
                                            'referralCommission':int.tryParse(commission.text),
                                          });
                                        });

                                        Navigator.pop(alertDialogContext);
                                        Navigator.pop(context);

                                        showUploadMessage(context, 'Details Updated...');

                                      },
                                      child: Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }else{
                            code.text==''?showUploadMessage(context, 'Please Enter Code'):
                            customerDiscount.text==''?showUploadMessage(context, 'Please Enter Customer Discount'):
                            showUploadMessage(context, 'Please Enter User Commission');
                          }
                        },
                        text: 'Update',
                        options: FFButtonOptions(
                          width: 110,
                          height: 40,
                          color: primaryColor,
                          textStyle: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

      )

    );
  }
}
