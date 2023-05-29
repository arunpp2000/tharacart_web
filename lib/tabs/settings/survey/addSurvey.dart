import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/uploadmedia.dart';
import '../../../main.dart';
import '../../dashboard/dashboard.dart';


class AddSurvey extends StatefulWidget {
  const AddSurvey({Key? key}) : super(key: key);

  @override
  State<AddSurvey> createState() => _AddSurveyState();
}

class _AddSurveyState extends State<AddSurvey> {
  TextEditingController link = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController ques = TextEditingController();
  TextEditingController A = TextEditingController();
  TextEditingController B = TextEditingController();
  TextEditingController C = TextEditingController();
  TextEditingController D = TextEditingController();
  String? Rmessage;
  String? urb;
  var pickedFile;
  final ImagePicker _picker = ImagePicker();
  late File file;
  var bytes;
  getDetails() {
    FirebaseFirestore.instance
        .collection('survey')
        .doc('b')
        .get()
        .then((event) {
      title.text = event.data()!['title'];
      imgUrl = event.data()!['logo'];
      desc.text = event.data()!['description'];
      type = event.data()!['delete'];
      questions.clear();
      for(var a in event.data()!['survey']){
        questions.add(a);

      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // getDetails();
  }

  String imgUrl = '';
late int selectIndex;
  bool edit = false;
  bool type = false;
  bool qType = false;
  List questions = [];


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
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>edit()));
                        },
                        child: Text(
                          'Add Survey',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Logo',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              imgUrl == ''
                  ? IconButton(
                onPressed: () async {
                  imgFromGalleryb();
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 30,
                ),
                iconSize: 30,
              )
                  : Container(
                height: h * 0.26,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12)),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  fit: BoxFit.cover,
                ),
                // color: Colors
                //     .red,
              ),
              imgUrl == ''
                  ? SizedBox()
                  : ElevatedButton(
                  onPressed: () async {
                    imgFromGalleryb();
                  },
                  child: Text('edit')),

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
                        maxLines: 4,
                        controller: desc,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Please Enter Description',
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
                        controller: ques,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Question',
                          hintText: 'Please Enter Question',
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Question Type',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Single'),
                  Switch(
                    value: qType,
                    onChanged: (value) {
                      setState(() {
                        qType = value;
                        print(qType);
                      });
                    },
                  ),
                  Text('Optional'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              qType == false
                  ? Container()
                  : Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20, 10, 20, 16),
                          child: TextFormField(
                            controller: A,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Option A',
                              hintText: 'Please Enter Option A',
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
                            controller: B,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Option B',
                              hintText: 'Please Enter Option B',
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
                            controller: C,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Option C',
                              hintText: 'Please Enter Option C',
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
                            controller: D,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Option D',
                              hintText: 'Please Enter Option D',
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
                ],
              ),

              Align(
                alignment: Alignment(0.75, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (ques.text != '') {
                        bool pressed = await alert(
                            context, 'Do you want add this Question?');
                        if (pressed) {
                          questions.add({
                            'question': ques.text,
                            'type': qType == false ? 0 : 1,
                            'option': qType == false
                                ? []
                                : [
                              A.text,
                              B.text,
                              C.text,
                              D.text,
                            ]
                          });
                          showUploadMessage(context, 'Question Added');
                          qType = false;
                          ques.clear();
                        }
                      } else {
                        ques.text == ''
                            ? showUploadMessage(
                            context, 'Please Enter Question')
                            : ' ';
                      }
                      setState(() {
                      });
                    },
                    text: 'Add Question',
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
              SizedBox(height: 10,),
              SizedBox(
                child: questions.isEmpty?Center(child: Text('empty')):ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      // height: h*0.2,
                      child: InkWell(
                        onLongPress: () async {
                          bool pressed = await alert(context,
                              'Do you want edit This Question?');
                          if (pressed) {
                            edit = true;
                            selectIndex=index;
                            print(selectIndex);
                            qType=questions[index]['type']==0?false:true;
                            ques.text=questions[index]['question'];
                            A.text=questions[index]['option'][0];
                            B.text=questions[index]['option'][1];
                            C.text=questions[index]['option'][2];
                            D.text=questions[index]['option'][3];

                          }
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5),
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
                                      'question:',
                                      style:
                                      GoogleFonts.outfit(
                                          fontWeight:
                                          FontWeight
                                              .w600),
                                    ),
                                    Expanded(child: Text(questions[index]['question']))
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                questions[index]['option'].length==0?SizedBox(): Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'A:',
                                          style:
                                          GoogleFonts.outfit(
                                              fontWeight:
                                              FontWeight
                                                  .w600),
                                        ),
                                        Expanded(
                                          child: Text(questions[index]['option'][0].toString(),
                                            style:
                                            GoogleFonts.outfit(
                                                fontWeight:
                                                FontWeight
                                                    .w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'B:',
                                          style:
                                          GoogleFonts.outfit(
                                              fontWeight:
                                              FontWeight
                                                  .w600),
                                        ),
                                        Expanded(
                                          child: Text(questions[index]['option'][1].toString(),
                                            style:
                                            GoogleFonts.outfit(
                                                fontWeight:
                                                FontWeight
                                                    .w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'C:',
                                          style:
                                          GoogleFonts.outfit(
                                              fontWeight:
                                              FontWeight
                                                  .w600),
                                        ),
                                        Expanded(
                                          child: Text(questions[index]['option'][2].toString(),
                                            style:
                                            GoogleFonts.outfit(
                                                fontWeight:
                                                FontWeight
                                                    .w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'D:',
                                          style:
                                          GoogleFonts.outfit(
                                              fontWeight:
                                              FontWeight
                                                  .w600),
                                        ),
                                        Expanded(
                                          child: Text(questions[index]['option'][3].toString(),
                                            style:
                                            GoogleFonts.outfit(
                                                fontWeight:
                                                FontWeight
                                                    .w600),
                                          ),
                                        ),
                                      ],
                                    )
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
                                      'Do you want delete This question?');
                                  if (pressed) {
                                    questions.removeAt(index);
                                  }
                                  showUploadMessage(context,('question Deleted'));
                                  setState(() {
                                  });
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
              ),
              Align(
                alignment: Alignment(0.75, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (imgUrl!=''&& title.text != '' &&desc.text != '' &&
                          questions != null) {
                        bool pressed = await alert(
                            context, 'Do you want add this Survey?');
                        if (pressed) {
                          FirebaseFirestore.instance
                              .collection('survey')
                              .add({
                            'title': title.text,
                            'logo': imgUrl,
                            'description': desc.text,
                            'delete': type,
                            'date': FieldValue.serverTimestamp(),
                            'survey': questions,
                            'search':setSearchParam(title.text)
                          }).then((value) {
                            value.update({'id':value.id});
                          });
                          imgUrl = '';
                          title.clear();
                          desc.clear();
                          questions = [];
                          showUploadMessage(context, 'New Survey Added');
                        }
                      } else {
                        imgUrl == '' ? showUploadMessage(context, 'Please upload logo')
                            :
                        title.text == '' ? showUploadMessage(context, 'Please Enter Title')
                            : desc.text == ''
                            ? showUploadMessage(
                            context, 'Please Enter description')
                            : questions== null
                            ? showUploadMessage(
                            context, 'Please Enter Questions')
                            : '';
                      }
                    },
                    text: 'Add Survey',
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
            ],
          ),
        ),
      ),
    );
  }
  Future imgFromGalleryb() async {
    print('----------------------HERkkkE?-------------------------');
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    var fileName = DateTime.now();
    var ref = await FirebaseStorage.instance.ref().child('proofs/$fileName');
    Uri blobUri = Uri.parse(pickedFile.path);
    http.Response response = await http.get(blobUri);
    await ref
        .putData(response.bodyBytes, SettableMetadata(contentType: 'image/png'))
        .then((p0) async {
      imgUrl = (await ref.getDownloadURL()).toString();
      print(imgUrl);
      setState(() {});
    });

  }
}
