import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/button.dart';
import '../../widgets/uploadmedia.dart';
import '../dashboard/dashboard.dart';


class SMTP extends StatefulWidget {
  const SMTP({Key? key}) : super(key: key);

  @override
  State<SMTP> createState() => _SMTPState();
}

class _SMTPState extends State<SMTP> {

 late TextEditingController serverName;
 late TextEditingController portNo;
 late TextEditingController userName;
 late TextEditingController password;
  DocumentSnapshot? smtp;

  getSMTP(){
    FirebaseFirestore.instance.collection('settings')
        .doc('smtp')
        .snapshots()
        .listen((event) {
      smtp=event;

      serverName.text=event['server'];
      portNo.text=event['portNo'].toString();
      userName.text=event['userName'];
      password.text=event['password'];
      if(mounted){
        setState(() {

        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    serverName=TextEditingController();
    portNo=TextEditingController();
    userName=TextEditingController();
    password=TextEditingController();
    getSMTP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'SMTP Server Details',
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
                      controller: serverName,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Server Name',
                        hintText: 'Please Enter Server Name',
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        20, 10, 20, 16),
                    child: TextFormField(
                      controller: portNo,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Port No',
                        hintText: 'Please Enter Port No',
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
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        20, 10, 20, 16),
                    child: TextFormField(
                      controller: userName,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'user Name',
                        hintText: 'Please Enter User Name',
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        20, 10, 20, 16),
                    child: TextFormField(
                      controller: password,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Please Enter Password',
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
                  onPressed: ()  async {

                    if(serverName.text!=''&&portNo.text!=''&&userName.text!=''&&password.text!=''){
                      bool pressed= await alert(context, 'Update Details');
                      if(pressed){
                        smtp?.reference.update({
                          'server':serverName.text,
                          'portNo':int.tryParse(portNo.text),
                          'userName':userName.text,
                          'password':password.text,
                        });

                        showUploadMessage(context, 'SMTP Server Details Updated...');
                      }
                    }else{
                      serverName.text==''?errorMsg(context, 'Please Enter Server Name'):
                      portNo.text==''?errorMsg(context, 'Please Enter Port No'):
                      userName.text==''?errorMsg(context, 'Please Enter UserName'):
                      errorMsg(context, 'Please Enter Password');
                    }



                  },
                  text: 'Update',
                  options: FFButtonOptions(
                    width: 150,
                    height: 50,
                    color: primaryColor,
                    textStyle:
                    TextStyle(
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
            )

          ],
        ),
      ),
    );
  }
}
