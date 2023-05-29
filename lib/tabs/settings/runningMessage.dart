import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/button.dart';
import '../../widgets/uploadmedia.dart';
import '../dashboard/dashboard.dart';


class AddMessage extends StatefulWidget {
  const AddMessage({Key? key}) : super(key: key);

  @override
  State<AddMessage> createState() => _AddMessageState();
}

class _AddMessageState extends State<AddMessage> {
  TextEditingController message = TextEditingController();
  String? Rmessage;
  getMessage() {
    FirebaseFirestore.instance
        .collection('settings')
        .doc('message')
        .snapshots()
        .listen((event) {
      Rmessage = event.data()!['message'];
      message.text = event.data()!['message'];
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getMessage();
  }

  bool edit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Running Message',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20, 10, 20, 16),
                      child: TextFormField(
                        controller: message,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Running Message',
                          hintText: 'Please Enter Running message',
                          labelStyle: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF95A1AC),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          hintStyle: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF95A1AC),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Align(
                alignment: Alignment(0.75, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (message.text != '') {
                        bool pressed = await alert(
                            context, 'Do you want Add This Message?');
                        if (pressed) {
                          FirebaseFirestore.instance
                              .collection('settings')
                              .doc('message')
                              .update({
                            'message': message.text,
                          }).then((value) {
                            // Navigator.pop(context);
                            // message.clear();
                            showUploadMessage(context, 'Added');
                            setState(() {

                            });
                          });
                        }
                      } else {
                        message.text == ''
                            ? errorMsg(
                            context, 'Please Enter Message')
                            : '';
                      }
                    },
                    text: message.text==''?'Add':'update',
                    options: FFButtonOptions(
                      width: 150,
                      height: 50,
                      color: primaryColor,
                      textStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      elevation: 2,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: 8,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              // InkWell(
              //   onTap: () async {
              //     bool pressed =
              //         await alert(context, 'Do you want edit This Message?');
              //     if (pressed) {
              //       edit = true;
              //       message.text = Rmessage;
              //       setState(() {});
              //     }
              //   },
              //   child: Rmessage == '' || Rmessage == null
              //       ? SizedBox()
              //       : Container(
              //           height: MediaQuery.of(context).size.height / 4,
              //           width: double.infinity,
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(18),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Color(0xff000000).withOpacity(0.15),
              //                 blurRadius: 4,
              //                 spreadRadius: 0,
              //                 offset: Offset(
              //                   0,
              //                   4,
              //                 ),
              //               )
              //             ],
              //           ),
              //           margin: const EdgeInsets.all(10),
              //           child: ListTile(
              //             title: Center(
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Expanded(
              //                     child: Text(Rmessage.toString().toUpperCase(),
              //                         style: GoogleFonts.outfit(
              //                             fontSize: 20,
              //                             fontWeight: FontWeight.w600)),
              //                   ),
              //                   IconButton(
              //                       onPressed: () async {
              //                         bool pressed = await alert(context,
              //                             'Do you want Delete This Message?');
              //                         if (pressed) {
              //                           FirebaseFirestore.instance
              //                               .collection('settings')
              //                               .doc('message')
              //                               .update({
              //                             'message': '',
              //                           });
              //                           showUploadMessage(
              //                               context, 'Message Deleted');
              //                           setState(() {
              //                             message.text = '';
              //                           });
              //                         }
              //                       },
              //                       icon: Icon(Icons.delete))
              //                 ],
              //               ),
              //             ),
              //             // leading: Text('${index+1}'),
              //           ),
              //         ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
