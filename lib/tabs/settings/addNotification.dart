import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../widgets/button.dart';
import '../../widgets/storage.dart';
import '../../widgets/uploadmedia.dart';
import '../dashboard/dashboard.dart';


class AddNotification extends StatefulWidget {
  const AddNotification({Key? key}) : super(key: key);

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  TextEditingController link = TextEditingController();
  TextEditingController msg = TextEditingController();
  TextEditingController title = TextEditingController();
  String? Rmessage;

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
  @override
  void initState() {
    super.initState();

  }
  var pickedFile;
  final ImagePicker _picker = ImagePicker();
  late File file;
  var bytes;
  String imgUrl='';
  bool edit = false;
  @override
  Widget build(BuildContext context) {
    var h =MediaQuery.of(context).size.height;
    var w =MediaQuery.of(context).size.width;
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
                      'Add Notification',
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
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        20, 10, 20, 16),
                    child: TextFormField(
                      controller: msg,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Message',
                        hintText: 'Please Enter Message',
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
           
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Notification Image',style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            imgUrl==''?
            IconButton(
              onPressed: () async {
                imgFromGalleryb();
              },
              icon: Icon(
                Icons.add,
                color: Colors.black,
                size: 30,
              ),
              iconSize: 30,
            ):
            Container(
              height:
              h * 0.25,
              width:
              double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12)
              ),
              child: CachedNetworkImage(imageUrl: imgUrl, fit: BoxFit.cover,),
              // color: Colors
              //     .red,
            ),
            imgUrl==''?SizedBox(): ElevatedButton(onPressed: () async {
              imgFromGalleryb();
            }, child: Text('edit')),
            SizedBox(),
            Align(
              alignment: Alignment(0.75, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    if (title.text != ''&&msg.text != '') {
                      bool pressed = await alert(
                          context, 'Do you want add this Notification?');
                      if (pressed) {
                        FirebaseFirestore.instance
                            .collection('notification')
                            .add({
                          'date':DateTime.now(),
                          'imageurl':imgUrl,
                          'title':title.text,
                          'msg':msg.text,
                        }).then((value) {
                          value.update({
                            'id':value.id,
                          });
                          // Navigator.pop(context);
                          // message.clear();
                          title.clear();
                          msg.clear();
                          imgUrl='';

                          showUploadMessage(context, 'Notification Added');
                          Navigator.pop(context);
                          setState(() {

                          });
                        });
                      }
                    } else {
                      msg.text == ''
                          ? showUploadMessage(
                          context, 'Please Enter Message')
                          : '';
                    }
                  },
                  text: 'Add',
                  options: FFButtonOptions(
                    width: 150,
                    height: 50,
                    color: primaryColor,
                    textStyle:TextStyle(
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
    );
  }
}
