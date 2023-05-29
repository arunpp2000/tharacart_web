
import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../widgets/button.dart';
import '../../../widgets/storage.dart';
import '../../../widgets/uploadmedia.dart';
import '../../dashboard/dashboard.dart';

class AddCategory extends StatefulWidget {
  AddCategory({Key? key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String categoryImage='';
  TextEditingController? categoryName;
  TextEditingController? categoryBadge;
  TextEditingController? brandName;
  List<DropdownMenuItem> fetchedBrand = [];
  String selectedBrand = '';
  Map<String,dynamic> brand={};
  Map<String,dynamic> brandDetails={};

  TextEditingController? madeIn;
  TextEditingController? description;
  TextEditingController? productBrand;
  String categoryBanner='';
  String radioButtonItem = 'Global';
  String radio = '';
  TextEditingController? textEditingController;
  TextEditingController? search;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var pickedFile;
  final ImagePicker _picker = ImagePicker();
  late File file;
  var bytes;
  Future imgFromGalleryCImage() async {
    print('----------------------HERkkkE?-------------------------');
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    var fileName = DateTime.now();
    var ref = await FirebaseStorage.instance.ref().child('proofs/$fileName');
    Uri blobUri = Uri.parse(pickedFile.path);
    http.Response response = await http.get(blobUri);
    await ref
        .putData(response.bodyBytes, SettableMetadata(contentType: 'image/png'))
        .then((p0) async {
      categoryImage = (await ref.getDownloadURL()).toString();
      print(categoryImage);
      setState(() {});
    });

  }
  Future imgFromGalleryCbanner() async {
    print('----------------------HERkkkE?-------------------------');
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    var fileName = DateTime.now();
    var ref = await FirebaseStorage.instance.ref().child('proofs/$fileName');
    Uri blobUri = Uri.parse(pickedFile.path);
    http.Response response = await http.get(blobUri);
    await ref
        .putData(response.bodyBytes, SettableMetadata(contentType: 'image/png'))
        .then((p0) async {
      categoryBanner = (await ref.getDownloadURL()).toString();
      print(categoryBanner);
      setState(() {});
    });

  }
  @override
  void initState() {
    super.initState();
    if (fetchedBrand.isEmpty) {
      getBrands().then((value) {
        setState(() {});
      });
    }
    categoryName = TextEditingController();
    categoryBadge = TextEditingController();
    brandName = TextEditingController();
    productBrand = TextEditingController();
    madeIn = TextEditingController();
    description = TextEditingController();
    textEditingController = TextEditingController();
    search = TextEditingController();
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

  Future getBrands() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("brands").get();
    for (var doc in data1.docs) {
      brand[doc.get('brand')]=doc.get('brandId');
      brandDetails[doc.get('brandId')]=doc.get('brand');
      fetchedBrand.add(DropdownMenuItem(
        child: Text(doc.get('brand')),
        value: doc.get('brand').toString(),
      ));
    }
    if(mounted){
      setState(() {
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      body: SafeArea(
        child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Add Category',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      imgFromGalleryCImage();
                    },
                    text: categoryImage==''?'Upload Image':'Change Image',
                    options: FFButtonOptions(
                      width: 130,
                      height: 40,
                      color: primaryColor,
                      textStyle: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),

                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      imgFromGalleryCbanner();
                    },
                    text: categoryBanner==''?'Upload Banner':'Change Banner',
                    options: FFButtonOptions(
                      width: 130,
                      height: 40,
                      color: primaryColor,
                      textStyle: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
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
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xFFE6E6E6),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: TextFormField(
                          controller: categoryName,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: 'Category Name',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius:
                              const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius:
                              const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style:
                          TextStyle(
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
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xFFE6E6E6),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: TextFormField(
                          controller: categoryBadge,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'categoryBadge',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: 'categoryBadge',
                            hintStyle:TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius:
                              const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius:
                              const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style:
                          TextStyle(
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
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xFFE6E6E6),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: TextFormField(
                          controller: description,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: 'Description',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius:
                              const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius:
                              const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style:
                          TextStyle(
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
                          controller: productBrand,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Product Brand',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                            ),
                            hintText:
                            'Enter your product Brand',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder:
                            UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius:
                              const BorderRadius.only(
                                topLeft:
                                Radius.circular(4.0),
                                topRight:
                                Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder:
                            UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius:
                              const BorderRadius.only(
                                topLeft:
                                Radius.circular(4.0),
                                topRight:
                                Radius.circular(4.0),
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
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xFFE6E6E6),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: TextFormField(
                          controller: madeIn,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Made In',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: 'Made In',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius:
                              const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius:
                              const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style:
                          TextStyle(
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
              alignment: Alignment(0.95, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    if (categoryName?.text != ''
                        &&categoryImage!=''&&
                        categoryBanner!=''&&
                        categoryBadge?.text!=''&&
                        description!.text!=''&&
                        productBrand?.text!=''&&
                        madeIn?.text!='') {
                      bool proceed = await alert(context,
                          'You want to add this Category?');

                      if (proceed) {
                        FirebaseFirestore.instance
                            .collection('category')
                            .add({
                          'name': categoryName?.text,
                          'imageUrl': categoryImage,
                          'brand':productBrand?.text,
                          'categoryBadge':categoryBadge?.text,
                          'banner':categoryBanner,
                          'description':description?.text,
                          'madeIn':madeIn?.text,
                          'branchId':'currentBranchId',
                          'search': setSearchParam(categoryName!.text),
                        }).then((value) {
                          value.update({
                            'categoryId':value.id,
                          });
                        });
                      }

                      categoryName?.clear();
                      productBrand?.clear();
                      description?.clear();
                      madeIn?.clear();
                      categoryImage='';

                      showUploadMessage(
                          context, "New Category Added...");



                    } else {
                      categoryImage==''?
                      showUploadMessage(
                          context, "Please Upload Image"):
                      categoryBanner==''?
                      showUploadMessage(
                          context, "Please Upload Banner"):
                      categoryBadge?.text==''?
                      showUploadMessage(
                          context, "Please Enter Badge"):
                      categoryName?.text==''?
                      showUploadMessage(
                          context, "Please Enter category Name"):
                      description?.text==''?
                      showUploadMessage(
                          context, "Please Enter Description"):
                      productBrand?.text==''?
                      showUploadMessage(
                          context, "Please Brand Name"):
                      showUploadMessage(
                          context, "Please Enter Made in");
                    }
                  },
                  text: 'Add',
                  options: FFButtonOptions(
                    width: 140,
                    height: 60,
                    color: primaryColor,
                    textStyle:
                    TextStyle(
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
            )
          ],
        ),
          ),
      ),
    );
  }
}
