
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/button.dart';
import '../../../widgets/uploadmedia.dart';
import '../../dashboard/dashboard.dart';

class B2cDialogue extends StatefulWidget {


  const B2cDialogue({Key? key})
      : super(key: key);

  @override
  _B2cDialogueState createState() => _B2cDialogueState();
}

class _B2cDialogueState extends State<B2cDialogue> {
  late TextEditingController price;
  late TextEditingController name;

  bool add = false;
  String? times;
  var data;
  var addOn;

  late List<dynamic> admins1;
  List<dynamic> updateList = [];
  late FocusNode myFocusNode;
  List<Map<String, dynamic>> addon = [];

  List<DropdownMenuItem> AddOnList = [];



  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    price = TextEditingController();
    name = TextEditingController();

    myFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 300,
                  height: 300,
                  color: Colors.white,
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Please Enter B2C Tier Price',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                      child: TextFormField(
                        controller: name,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Volume',
                          hintStyle: TextStyle(
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                      child: TextFormField(
                        controller: price,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Enter Amount',
                          hintStyle:TextStyle(
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
                    Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(0, 0.35),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    if (add == false) {
                                      add = true;
                                      if (price.text != '' && name.text!='') {
                                        Map<String,dynamic> selected={
                                          'name':name.text,
                                          'price':price.text,
                                        };
                                        Navigator.pop(context,selected);

                                      } else {
                                        showUploadMessage(
                                            context, 'Please Enter price Name');
                                      }
                                      add = false;
                                    }
                                  },
                                  text: 'Add',
                                  options: FFButtonOptions(
                                    width: 130,
                                    height: 45,
                                    color: primaryColor,
                                    textStyle: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 12,
                                  ),
                                  // loading: _loadingButton,
                                )
                              ],
                            ),
                          ),
                        ))
                  ]))));
    });
  }
}
