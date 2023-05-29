import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/button.dart';
import '../../widgets/uploadmedia.dart';
import '../dashboard/dashboard.dart';



class AddContact extends StatefulWidget {
  AddContact({Key? key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
 bool edit=false;
 bool type=false;


  late String currentId;
  TextEditingController Name = TextEditingController();
  TextEditingController Number = TextEditingController();
  TextEditingController types = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

 setSearchParam(String caseNumber) {
   List<String> caseSearchList = [];
   String temp = "";

   List<String> nameSplits = caseNumber.split(" ");
   for (int i = 0; i < nameSplits.length; i++) {
     String name = "";

     for (int k = i; k < nameSplits.length; k++) {
       name = name + nameSplits[k] + " ";
     }
     temp = "";

     for (int j = 0; j < name.length; j++) {
       temp = temp + name[j];
       caseSearchList.add(temp.toUpperCase());
     }
   }
   return caseSearchList;
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

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
                      'Add Contacts',
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          edit == true
                              ? Column(
                            children: [

                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: 330,
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
                                            controller: Name,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Name',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              hintText: 'enter your name',
                                              hintStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              enabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  Colors.transparent,
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
                                                  color:
                                                  Colors.transparent,
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
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: 330,
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
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  10)
                                            ],
                                            autovalidateMode:
                                            AutovalidateMode
                                                .onUserInteraction,
                                            keyboardType:
                                            TextInputType.phone,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter phone number";
                                              } else if (!RegExp(
                                                  r'(^(?!.*(\d)\1{9})?[0-9]{10,12}$)')
                                                  .hasMatch(value!)) {
                                                return "phone number is not valid";
                                              } else {
                                                return null;
                                              }
                                            },
                                            controller: Number,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Number',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              hintText:
                                              'enter your Number',
                                              hintStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              enabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  Colors.transparent,
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
                                                  color:
                                                  Colors.transparent,
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
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: 330,
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
                                            controller: types,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Business Type',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              hintText: 'enter Business type',
                                              hintStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              enabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  Colors.transparent,
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
                                                  color:
                                                  Colors.transparent,
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
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsets.fromLTRB(0, 16, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        edit = false;
                                        type = false;
                                        Name.clear();
                                        Number.clear();
                                        setState(() {});
                                      },
                                      text: 'cancel',
                                      options: FFButtonOptions(
                                        width: 150,
                                        height: 50,
                                        color: Colors.red,
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
                                  Padding(
                                    padding:
                                    EdgeInsets.fromLTRB(0, 16, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        if (Name.text != '' &&
                                            Number.text != ''&&types.text != '') {
                                          bool pressed = await alert(
                                              context,
                                              'Do you want Update This contact?');
                                          if (pressed) {
                                            FirebaseFirestore.instance
                                                .collection('contact')
                                                .doc(currentId)
                                                .update({
                                              'name': Name.text,
                                              'number': Number.text,
                                              'businessType': types.text,
                                              'search': setSearchParam(
                                                  Name.text +
                                                      ' ' +
                                                      Number.text),
                                            });
                                            showUploadMessage(
                                                context, 'Updated');
                                            edit = false;
                                            Name.clear();
                                            Number.clear();
                                            setState(() {});
                                          }
                                        } else {
                                          Name.text == ''
                                              ? showUploadMessage(context,
                                              'Please Enter Name')
                                              : Number.text == '' ? showUploadMessage(context, 'Please Enter Number')
                                              : types.text == '' ? showUploadMessage(context, 'Please Enter Business Type')
                                              : '';
                                        }
                                      },
                                      text: 'Update',
                                      options: FFButtonOptions(
                                        width: 150,
                                        height: 50,
                                        color: Colors.green,
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
                                  )
                                ],
                              )
                            ],
                          )
                              : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: 330,
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
                                            controller: Name,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Name',
                                              labelStyle: TextStyle
                                                  (
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              hintText: 'enter your name',
                                              hintStyle:TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              enabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  Colors.transparent,
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
                                                  color:
                                                  Colors.transparent,
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
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: 330,
                                        height: 75,
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
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  10)
                                            ],
                                            autovalidateMode:
                                            AutovalidateMode
                                                .onUserInteraction,
                                            keyboardType:
                                            TextInputType.phone,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter phone number";
                                              } else if (!RegExp(
                                                  r'(^(?!.*(\d)\1{9})?[0-9]{10,12}$)')
                                                  .hasMatch(value)) {
                                                return "phone number is not valid";
                                              } else {
                                                return null;
                                              }
                                            },
                                            controller: Number,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Number',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              hintText:
                                              'enter your Number',
                                              hintStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              enabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  Colors.transparent,
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
                                                  color:
                                                  Colors.transparent,
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
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: 330,
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
                                            controller: types,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Type',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              hintText: 'enter type',
                                              hintStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              enabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  Colors.transparent,
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
                                                  color:
                                                  Colors.transparent,
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
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment(0.75, 0),
                                child: Padding(
                                  padding:
                                  EdgeInsets.fromLTRB(0, 16, 0, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      if (Name.text != '' &&
                                          Number.text != ''&&types.text != '') {
                                        QuerySnapshot regusr =
                                        await FirebaseFirestore
                                            .instance
                                            .collection('contact')
                                            .where('number',
                                            isEqualTo:
                                            Number.text)
                                            .get();
                                        if (regusr.docs.isNotEmpty) {
                                          showUploadMessage(context,
                                              'This number is already registered');
                                        } else {
                                          bool pressed = await alert(
                                              context,
                                              'Do you want Add This Contact ?');
                                          if (pressed) {
                                            FirebaseFirestore.instance
                                                .collection('contact')
                                                .doc()
                                                .set({
                                              'status': false,
                                              'date': DateTime.now(),
                                              'name': Name.text,
                                              'number': Number.text,
                                              'businessType': types.text,
                                              'search': setSearchParam(
                                                  Name.text +
                                                      ' ' +
                                                      Number.text),
                                            }).then((value) {
                                              Number.clear();
                                              Name.clear();
                                              showUploadMessage(context,
                                                  'Contact Added');
                                              setState(() {});
                                            });
                                          }
                                        }
                                      } else {
                                        Name.text == ''
                                            ? showUploadMessage(context,
                                            'Please Enter Name')
                                            : Number.text == '' ? showUploadMessage(context, 'Please Enter Number')
                                            : types.text == '' ? showUploadMessage(context, 'Please Enter Business Type')
                                            : '';
                                      }
                                    },
                                    text: 'Add Contact',
                                    options: FFButtonOptions(
                                      width: 150,
                                      height: 50,
                                      color:
                                      primaryColor,
                                      textStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontSize: 18,
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
                            ],
                          ),
                          SizedBox(height: 10,),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('contact').where('status',isEqualTo: false)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                var data = snapshot.data?.docs;
                                return SingleChildScrollView(

                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: data?.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height: 110,
                                        child: InkWell(
                                          onLongPress: () async {
                                            bool pressed = await alert(context,
                                                'Do you want edit This contact?');
                                            if (pressed) {
                                              edit = true;
                                              currentId = data![index].id;
                                              Name.text = data![index]['name'];
                                              Number.text = data[index]['number'];
                                              types.text = data[index]['businessType'];
                                              setState(() {});
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.15),
                                                  blurRadius: 4,
                                                  spreadRadius: 0,
                                                  offset: Offset(
                                                    0,
                                                    4,
                                                  ),
                                                )
                                              ],
                                            ),
                                            child: ListTile(
                                              title: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Name : ' +
                                                            data![index]['name'],
                                                        style:
                                                        GoogleFonts.outfit(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),

                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Number : ' +
                                                            data[index]
                                                            ['number'],
                                                        style:
                                                        GoogleFonts.outfit(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Business Type : ' +
                                                            data[index]
                                                            ['businessType'],
                                                        style:
                                                        GoogleFonts.outfit(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              leading: Text(
                                                '${index + 1}',
                                                style: GoogleFonts.outfit(
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              trailing: IconButton(
                                                  onPressed: () async {
                                                    bool pressed = await alert(
                                                        context,
                                                        'Do you want delete This contact?');
                                                    if (pressed) {
                                                      FirebaseFirestore.instance
                                                          .collection('contact')
                                                          .doc(data[index].id)
                                                          .update({
                                                        'status': true,
                                                      });
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.black,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
