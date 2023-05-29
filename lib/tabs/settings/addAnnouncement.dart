import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/button.dart';
import '../../widgets/uploadmedia.dart';
import '../dashboard/dashboard.dart';


class AddAnnoucement extends StatefulWidget {
  const AddAnnoucement({Key? key}) : super(key: key);

  @override
  State<AddAnnoucement> createState() => _AddAnnoucementState();
}

class _AddAnnoucementState extends State<AddAnnoucement> {
  TextEditingController link = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  String? Rmessage;
  getDetails() {
    FirebaseFirestore.instance
        .collection('announcement')
        .doc('a')
        .get()
        .then((event) {
      title.text = event.data()!['title'];
      content.text = event.data()!['content'];
      color.text = event.data()!['color'];
      type = event.data()!['b2b'];
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  String imgUrl = '';
  bool edit = false;
  bool type = false;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
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
                  children: const [
                    Expanded(
                      child: Text(
                         'Add Announcement',
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('B2C'),
                  Switch(
                    value: type,
                    onChanged: (value) {
                      setState(() {
                        type = value;
                        print(type);
                      });
                    },
                  ),
                  Text('B2B'),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20, 10, 20, 16),
                      child: TextFormField(
                        controller: title,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          hintText: 'Please Enter Title',
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
                        controller: color,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Color Code',
                          hintText: 'Please Enter Color Code',
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
                        controller: content,
                        obscureText: false,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Content',
                          hintText: 'Please Enter Content',
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
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment(0.75, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (content.text != '' &&
                          title.text != '' &&
                          color.text != '') {
                        bool pressed = await alert(
                            context, 'Do you want add this announcement?');
                        if (pressed) {
                          FirebaseFirestore.instance
                              .collection('announcement')
                              .doc('a')
                              .update({
                            'b2b': type,
                            "color": color.text,
                            'title': title.text,
                            'content': content.text,
                            'view': [],
                          });
                          showUploadMessage(context,'Added');
                        }
                      } else {
                        title.text == ''
                            ? showUploadMessage(context, 'Please Enter Title')
                            : content.text == ''
                            ? showUploadMessage(
                            context, 'Please Enter title')
                            : color.text == ''
                            ? showUploadMessage(
                            context, 'Please Enter Color Code')
                            : '';
                      }
                    },
                    text: 'Update',
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
            ],
          ),
        ),
      ),
    );
  }
}
