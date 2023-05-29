import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/button.dart';
import '../../widgets/uploadmedia.dart';
import '../dashboard/dashboard.dart';


class Medal extends StatefulWidget {
  const Medal({Key? key}) : super(key: key);

  @override
  State<Medal> createState() => _MedalState();
}

class _MedalState extends State<Medal> {

 late TextEditingController b2bBronze;
 late TextEditingController b2bGold;
 late TextEditingController b2bSilver;
 late TextEditingController b2cBronze;
 late TextEditingController b2cGold;
 late TextEditingController b2cSilver;
  DocumentSnapshot? medal;

  getMedal(){
    FirebaseFirestore.instance.collection('settings')
        .doc('ranking')
        .snapshots()
        .listen((event) {
      medal=event;

      b2bBronze.text=event['b2bBronze'].toString();
      b2bGold.text=event['b2bGold'].toString();
      b2bSilver.text=event['b2bSilver'].toString();
      b2cBronze.text=event['b2cBronze'].toString();
      b2cGold.text=event['b2cGold'].toString();
      b2cSilver.text=event['b2cSilver'].toString();
      if(mounted){
        setState(() {

        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    b2bBronze=TextEditingController();
    b2bGold=TextEditingController();
    b2bSilver=TextEditingController();
    b2cBronze=TextEditingController();
    b2cGold=TextEditingController();
    b2cSilver=TextEditingController();
    getMedal();
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
                      'Medal',
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
                      controller: b2bBronze,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'B2B Bronze',
                        hintText: 'Please Enter B2B Bronze',
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
                      controller: b2bGold,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'B2B Gold',
                        hintText: 'Please Enter B2B Gold',
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
                      controller: b2bSilver,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'B2B Silver',
                        hintText: 'Please Enter B2B Silver',
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
                      controller: b2cBronze,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'B2C Bronze',
                        hintText: 'Please Enter B2C Bronze',
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
                      controller: b2cGold,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'B2C Gold',
                        hintText: 'Please Enter B2C Gold',
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
                      controller: b2cSilver,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'B2C Silver',
                        hintText: 'Please Enter B2C Silver',
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

                    if(b2bBronze.text!=''&&b2bGold.text!=''&&b2bSilver.text!=''
                        &&b2cBronze.text!=''&&b2cSilver.text!=''&&b2cGold.text!=''){
                      bool pressed= await alert(context, 'Update Details');
                      if(pressed){
                        medal?.reference.update({
                          'b2bBronze':double.tryParse(b2bBronze.text),
                          'b2bGold':double.tryParse(b2bGold.text),
                          'b2bSilver':double.tryParse(b2bSilver.text),
                          'b2cBronze':double.tryParse(b2cBronze.text),
                          'b2cGold':double.tryParse(b2cGold.text),
                          'b2cSilver':double.tryParse(b2cSilver.text),


                        });
                        showUploadMessage(context, 'Medal Details Updated...');
                      }
                    }else{
                      b2bBronze.text==''?errorMsg(context, 'Please Enter B2B Bronze Price'):
                      b2bGold.text==''?errorMsg(context, 'Please Enter B2B Gold Price'):
                      b2bSilver.text==''?errorMsg(context, 'Please Enter B2B Silver Price'):
                      b2cBronze.text==''?errorMsg(context, 'Please Enter B2C Bronze Price'):
                      b2cSilver.text==''?errorMsg(context, 'Please Enter B2C Silver Price'):
                      errorMsg(context, 'Please Enter B2C Gold Price');
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
