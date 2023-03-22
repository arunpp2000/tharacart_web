
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/button.dart';
import '../../widgets/storage.dart';
import '../../widgets/uploadmedia.dart';
import '../dashboard/dashboard.dart';


class AddBrand extends StatefulWidget {
  AddBrand({Key? key}) : super(key: key);

  @override
  _AddBrandState createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  String imageUrl = '';
  String imageListLink = '';
  String banner = '';
  TextEditingController? name;
  TextEditingController? content;
  String? uploadedFileUrl2;
  TextEditingController? youTubeLink;
  TextEditingController? imageName;
  TextEditingController? color;
  final head =TextEditingController();

  List imageList=[];
  List galleryImage=[];
  List youTubeLinkList=[];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    imageName = TextEditingController();
    content = TextEditingController();
    youTubeLink = TextEditingController();
    color = TextEditingController();
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList =[];
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                              setState(() => imageUrl = downloadUrl);
                              showUploadMessage(context, 'Success!');
                            } else {
                              showUploadMessage(
                                  context, 'Failed to upload media');
                            }
                          }
                        },
                        text: imageUrl == ''
                            ? 'Upload Image'
                            : 'Change Image',
                        options: FFButtonOptions(
                          height: 40,
                          color:primaryColor,
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
                              setState(() => banner = downloadUrl);
                              showUploadMessage(
                                  context, 'Media upload Success!');
                            } else {
                              showUploadMessage(
                                  context, 'Failed to upload media');
                            }
                          }
                        },
                        text: banner == ''
                            ? 'Upload Banner'
                            : 'Change Banner',
                        options: FFButtonOptions(
                          height: 40,
                          color: primaryColor,
                          textStyle:
                         TextStyle(
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
                                labelStyle:TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'Enter your Head',
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
                              controller: color,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Color ',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'Enter your Color code',
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
                                labelStyle:TextStyle(
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
                          if(imageName?.text!=''){
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
                                    'name':imageName?.text,
                                    'link':downloadUrl,
                                  });
                                  imageName?.clear();
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
                          color:primaryColor,
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

                          if(youTubeLink?.text!=''){
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
                                    'link':youTubeLink?.text,
                                  });
                                  youTubeLink?.clear();
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


                Align(
                  alignment: Alignment(0.95, 0),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {


                        if(name?.text!=''&&color?.text!=''&&imageUrl!=''&&banner!=''&&head.text!=''){
                          bool proceed = await alert(
                              context, 'You want to add this brand?');
                          if (proceed) {
                            FirebaseFirestore.instance.collection('brands')
                                .add({
                              'brand':name?.text,
                              'delete':false,
                              'head':head.text,
                               'branchId':'currentBranchId',
                              'imageUrl':imageUrl,
                              'banner':banner,
                              'color':color?.text,
                              'content':content?.text??'',
                              'imageList':imageList,
                              'galleryImage':galleryImage,
                              'youTube':youTubeLinkList,
                            }).then((value) {
                              value.update({
                                'brandId':value.id,
                              });
                            });

                            Navigator.pop(context);

                            showUploadMessage(context, 'Success!');
                          }
                        }else{
                          color?.text==''?showUploadMessage(context, 'Please Enter color code'):
                          imageUrl==''?showUploadMessage(context, 'Please Upload Image'):
                          banner==''?showUploadMessage(context, 'Please Upload Banner'):
                          head.text==''?showUploadMessage(context, 'Please Enter Head'):
                          showUploadMessage(context, 'Please Enter Name');
                        }
                      },
                      text: 'Upload',
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
      ),
    );
  }
}
