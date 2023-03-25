import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../widgets/button.dart';
import '../../../widgets/storage.dart';
import '../../../widgets/uploadmedia.dart';
import '../../dashboard/dashboard.dart';


class EditBrand extends StatefulWidget {
  final String? brandId;
  final String? name;
  final String? head;
  final String? image;
  final String? banner;
  final String? content;
  final List? galleryImage;
  final List? imageList;
  final List? youTubeLinkList;
  final String? color;
  const EditBrand({Key? key, this.brandId, this.name, this.image, this.banner, this.color, this.galleryImage, this.imageList, this.youTubeLinkList, this.content, this.head}) : super(key: key);

  @override
  _EditBrandState createState() => _EditBrandState();
}

class _EditBrandState extends State<EditBrand> {

  String imageUrl = '';
  String banner = '';
 late TextEditingController content;
 late TextEditingController name;
 late String uploadedFileUrl2;
 late TextEditingController textController2;
 late TextEditingController color;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final head =TextEditingController();

 late TextEditingController youTubeLink;
 late TextEditingController imageName;
  List imageList=[];
  List galleryImage=[];
  List youTubeLinkList=[];

  @override
  void initState() {
    super.initState();
    name = TextEditingController(
        text: widget.name
    );
    textController2 = TextEditingController();
    color = TextEditingController(text: widget.color);
    imageName = TextEditingController();
    content = TextEditingController(text: widget.content);
    head.text=widget.head!;
    youTubeLink = TextEditingController();
    youTubeLinkList=widget.youTubeLinkList!;
    imageList=widget.imageList!;
    galleryImage=widget.galleryImage!;
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
      appBar: AppBar(
        backgroundColor:primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Edit Brand',
          style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('brands')
                  .doc(widget.brandId)
                  .snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                var data=snapshot.data;
                return Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: CachedNetworkImage(
                                height: 100,
                                width: 130,
                                imageUrl: imageUrl==''?widget.image??'':imageUrl,
                              ),
                            ),
                            Container(
                              child: CachedNetworkImage(
                                height: 100,
                                width: 130,
                                imageUrl: banner==''?widget.banner??'':banner,
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
                                final selectedMedia = await selectMedia(
                                  maxWidth: 1080.00,
                                  maxHeight: 1320.00,
                                );
                                if (selectedMedia != null &&
                                    validateFileFormat(
                                        selectedMedia.storagePath,
                                        context)) {
                                  showUploadMessage(
                                      context, 'Uploading file...',
                                      showLoading: true);
                                  final downloadUrl = await uploadData(
                                      selectedMedia.storagePath,
                                      selectedMedia.bytes);
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  if (downloadUrl != null) {
                                    setState(() =>
                                    imageUrl = downloadUrl);
                                    showUploadMessage(
                                        context, 'Success!');
                                  } else {
                                    showUploadMessage(context,
                                        'Failed to upload media');
                                  }
                                }
                              },
                              text: 'Change Image',
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
                                final selectedMedia = await selectMedia(
                                  maxWidth: 1080.00,
                                  maxHeight: 1320.00,
                                );
                                if (selectedMedia != null &&
                                    validateFileFormat(
                                        selectedMedia.storagePath,
                                        context)) {
                                  showUploadMessage(
                                      context, 'Uploading file...',
                                      showLoading: true);
                                  final downloadUrl = await uploadData(
                                      selectedMedia.storagePath,
                                      selectedMedia.bytes);
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  if (downloadUrl != null) {
                                    setState(() =>
                                    banner = downloadUrl);
                                    showUploadMessage(context,
                                        'Media upload Success!');
                                  } else {
                                    showUploadMessage(context,
                                        'Failed to upload media');
                                  }
                                }
                              },
                              text: 'Change Banner',
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
                                    controller: name,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Brand ',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintText: 'Enter your Brand name',
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
                                    controller: head,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Head',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintText: 'Enter Head',
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
                                    controller: color,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Color ',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintText: 'Enter Color Code',
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
                                    controller: content,
                                    maxLines: 7,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'content',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintText: 'Please Enter content',
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
                                        fontSize: 12
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Image List',style: TextStyle(fontWeight: FontWeight.bold),),
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
                                    controller: imageName,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'name',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintText: 'Please Enter image name',
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
                            ),
                            SizedBox(width: 10,),
                            FFButtonWidget(
                              onPressed: () async {
                                if(imageName.text!=''){
                                  final selectedMedia = await selectMedia(
                                    maxWidth: 1080.00,
                                    maxHeight: 1320.00,
                                  );
                                  if (selectedMedia != null &&
                                      validateFileFormat(
                                          selectedMedia.storagePath,
                                          context)) {
                                    showUploadMessage(
                                        context, 'Uploading file...',
                                        showLoading: true);
                                    final downloadUrl = await uploadData(
                                        selectedMedia.storagePath,
                                        selectedMedia.bytes);
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    if (downloadUrl != null) {
                                      setState(() {
                                        imageList.add({
                                          'name':imageName.text,
                                          'link':downloadUrl,
                                        });
                                        imageName.clear();
                                      });
                                      showUploadMessage(context, 'Success!');
                                    } else {
                                      showUploadMessage(
                                          context, 'Failed to upload media');
                                    }
                                  }
                                }else{
                                  showUploadMessage(context, 'Please Enter Image Name');
                                }

                              },
                              text:'Upload',

                              options: FFButtonOptions(
                                height: 40,
                                color: primaryColor,
                                textStyle:
                                TextStyle(
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

                          ],
                        ),
                      ),
                      Wrap(
                        children: List.generate(imageList.length, (index){
                          final list=imageList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              InkWell(
                                onLongPress: () async {
                                  bool pressed=await alert(context, 'Delete List');
                                  if(pressed){
                                    imageList.removeAt(index);
                                    setState(() {

                                    });
                                    showUploadMessage(context, 'List Removed...');
                                  }
                                },
                                child: Container(


                                  child: CachedNetworkImage(
                                    imageUrl: list['link'],
                                    width: 80,
                                    height: 80,



                                  ),),
                              ),
                              Text(list['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                            ],),
                          );
                        }),
                      ),
                      SizedBox(height: 10,),
                      Text('Gallery Image',style: TextStyle(fontWeight: FontWeight.bold),),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [

                            FFButtonWidget(
                              onPressed: () async {
                                final selectedMedia = await selectMedia(
                                  maxWidth: 1080.00,
                                  maxHeight: 1320.00,
                                );
                                if (selectedMedia != null &&
                                    validateFileFormat(
                                        selectedMedia.storagePath,
                                        context)) {
                                  showUploadMessage(
                                      context, 'Uploading file...',
                                      showLoading: true);
                                  final downloadUrl = await uploadData(
                                      selectedMedia.storagePath,
                                      selectedMedia.bytes);
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  if (downloadUrl != null) {
                                    setState(() {
                                      galleryImage.add(
                                        downloadUrl,
                                      );
                                    });
                                    showUploadMessage(context, 'Success!');
                                  } else {
                                    showUploadMessage(
                                        context, 'Failed to upload media');
                                  }
                                }
                              },
                              text:'Upload',

                              options: FFButtonOptions(
                                height: 40,
                                color: primaryColor,
                                textStyle:
                                TextStyle(
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

                          ],
                        ),
                      ),
                      Wrap(
                        children: List.generate(galleryImage.length, (index){
                          final list=galleryImage[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              InkWell(
                                onLongPress: () async {
                                  bool pressed=await alert(context, 'Delete List');
                                  if(pressed){
                                    galleryImage.removeAt(index);
                                    setState(() {

                                    });
                                    showUploadMessage(context, 'List Removed...');
                                  }
                                },
                                child: Container(


                                  child: CachedNetworkImage(
                                    imageUrl: list,
                                    width: 80,
                                    height: 80,


                                  ),),
                              ),
                            ],),
                          );
                        }),
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
                                    controller: youTubeLink,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'youTubeLink',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintText: 'Please Enter youTubeLink',
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
                            ),
                            SizedBox(width: 10,),
                            FFButtonWidget(
                              onPressed: ()  async {

                                if(youTubeLink.text!=''){
                                  final selectedMedia = await selectMedia(
                                    maxWidth: 1080.00,
                                    maxHeight: 1320.00,
                                  );
                                  if (selectedMedia != null &&
                                      validateFileFormat(
                                          selectedMedia.storagePath,
                                          context)) {
                                    showUploadMessage(
                                        context, 'Uploading file...',
                                        showLoading: true);
                                    final downloadUrl = await uploadData(
                                        selectedMedia.storagePath,
                                        selectedMedia.bytes);
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    if (downloadUrl != null) {
                                      setState(() {
                                        youTubeLinkList.add({
                                          'thumbnail':downloadUrl,
                                          'link':youTubeLink.text,
                                        });
                                        youTubeLink.clear();
                                      });
                                      showUploadMessage(context, 'Success!');
                                    } else {
                                      showUploadMessage(
                                          context, 'Failed to upload media');
                                    }
                                  }
                                }else{
                                  showUploadMessage(context, 'Please Enter youtube link');
                                }

                              },
                              text:'Upload',

                              options: FFButtonOptions(
                                height: 40,
                                color: primaryColor,
                                textStyle:
                                TextStyle(
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

                          ],
                        ),
                      ),
                      Wrap(

                        children: List.generate(youTubeLinkList.length, (index) {
                          final list=youTubeLinkList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onLongPress: () async {
                                bool pressed=await alert(context, 'Delete List');
                                if(pressed){
                                  youTubeLinkList.removeAt(index);
                                  setState(() {

                                  });
                                  showUploadMessage(context, 'List Removed...');
                                }
                              },
                              child: Container(


                                child: CachedNetworkImage(
                                  imageUrl: list['thumbnail'],
                                  width: 80,
                                  height: 80,


                                ),),
                            ),
                          );
                        }),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment(0.95, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 30),
                              child: FFButtonWidget(
                                onPressed: () async {


                                  if(name.text!=''&&color.text!=''&&head.text!=''){
                                    bool proceed = await alert(
                                        context, 'You want to Update this brand?');
                                    if (proceed) {
                                      data?.reference.update(    {
                                        'brand':name.text,
                                        'color':color.text,
                                        'head':head.text,
                                        'imageUrl':imageUrl==''?widget.image:imageUrl,
                                        'banner':banner==''?widget.banner:banner,
                                        'content':content.text??'',
                                        'imageList':imageList,
                                        'galleryImage':galleryImage,
                                        'youTube':youTubeLinkList,
                                      });

                                      Navigator.pop(context);

                                      showUploadMessage(context, 'Success!');
                                    }
                                  }else{
                                    name.text==''?
                                    showUploadMessage(context, 'Please Enter Name'):
                                    head.text==''?
                                    showUploadMessage(context, 'Please Enter Head'):
                                    showUploadMessage(context, 'Please Enter Color Code');
                                  }
                                },
                                text: 'Update',
                                options: FFButtonOptions(
                                  width: 140,
                                  height: 50,
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
                          ),
                          // Align(
                          //   alignment: Alignment(0.95, 0),
                          //   child: Padding(
                          //     padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          //     child: FFButtonWidget(
                          //       onPressed: () async {
                          //
                          //
                          //           bool proceed = await alert(
                          //               context, 'You want to Delete this brand?');
                          //           if (proceed) {
                          //
                          //             data.reference.update({
                          //               'delete':true,
                          //             });
                          //
                          //
                          //             Navigator.pop(context);
                          //
                          //             showUploadMessage(context, 'Delete Success!');
                          //           }
                          //
                          //       },
                          //       text: 'Delete',
                          //       options: FFButtonOptions(
                          //         width: 140,
                          //         height: 50,
                          //         color: FlutterFlowTheme.primaryColor,
                          //         textStyle:
                          //         FlutterFlowTheme.subtitle2.override(
                          //           fontFamily: 'Montserrat',
                          //           color: Colors.white,
                          //           fontSize: 18,
                          //           fontWeight: FontWeight.w500,
                          //         ),
                          //         elevation: 2,
                          //         borderSide: BorderSide(
                          //           color: Colors.transparent,
                          //           width: 2,
                          //         ),
                          //         borderRadius: 8,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),
                );
              }
          ),


        ),
      ),
    );
  }
}
