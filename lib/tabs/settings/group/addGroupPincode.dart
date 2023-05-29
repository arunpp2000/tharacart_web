
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/button.dart';
import '../../../widgets/uploadmedia.dart';
import '../../dashboard/dashboard.dart';

class AddGroupPincode extends StatefulWidget {
  final String? name;
  const AddGroupPincode({Key? key, this.name}) : super(key: key);

  @override
  _AddGroupPincodeState createState() => _AddGroupPincodeState();
}

class _AddGroupPincodeState extends State<AddGroupPincode> {
  late TextEditingController emailAddressController1;
  late TextEditingController pinCode;
  var data;



  @override
  void initState() {
    super.initState();
    emailAddressController1 = TextEditingController();
    pinCode = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          TextFormField(
            controller: pinCode,
            obscureText: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Pincode',
              labelStyle:TextStyle(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF57636C),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              hintText: 'Enter your Pincode...',
              hintStyle:TextStyle(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF57636C),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFDBE2E7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFDBE2E7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
            ),
            style: TextStyle(
              fontFamily: 'Lexend Deca',
              color: Color(0xFF1D2429),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FFButtonWidget(
                  onPressed: () async {

                    if(pinCode.text!=''){
                      FirebaseFirestore.instance.collection('pincodeGroups').doc(widget.name).update({
                        'pincodes':FieldValue.arrayUnion([int.tryParse(pinCode.text)])
                      });
                      showUploadMessage(context, 'New PinCode Added');
                    }else{
                      errorMsg(context, 'Please Enter PinCode');
                    }


                  },
                  text: 'Save',
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: primaryColor,
                    textStyle: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
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
        ],
      ),
    );
  }
}
