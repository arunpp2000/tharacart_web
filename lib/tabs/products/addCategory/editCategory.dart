import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../widgets/button.dart';
import '../../../widgets/storage.dart';
import '../../../widgets/uploadmedia.dart';
import '../../dashboard/dashboard.dart';
String currentBranchId='XaGJz72DaZdJ4S9g7PkO';
class EditCategory extends StatefulWidget {
  final String? categoryId;
  final String? name;
  final String? description;
  final String? brand;
  final String? madeIn;
  final String? image;
  final String? banner;
  final String? badge;
  const EditCategory({Key? key, this.categoryId, this.name, this.description, this.brand, this.madeIn, this.image, this.banner, this.badge}) : super(key: key);

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  String categoryImage='';
late TextEditingController categoryName;
late TextEditingController categoryBadge;
late TextEditingController brandName;
late TextEditingController madeIn;
late TextEditingController productBrand;
late TextEditingController description;
  String categoryBanner='';
  String radioButtonItem = 'Global';
  String radio = '';
  late TextEditingController textEditingController;
  late TextEditingController search;
  List<DropdownMenuItem> fetchedBrand = [];
  String selectedBrand = '';
  Map<String,dynamic> brand={};
  Map<String,dynamic> brandDetails={};
  final scaffoldKey = GlobalKey<ScaffoldState>();


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
    selectedBrand=brandDetails[widget.brand];
    if(mounted){
      setState(() {
      });
    }

  }

  @override
  void initState() {
    super.initState();
    if (fetchedBrand.isEmpty) {
      getBrands().then((value) {
        setState(() {});
      });
    }
    categoryName = TextEditingController(text: widget.name);
    brandName = TextEditingController(text: widget.brand);
    categoryBadge = TextEditingController(text: widget.badge);
    productBrand = TextEditingController(text: widget.brand);
    madeIn = TextEditingController(text: widget.madeIn);
    description = TextEditingController(text: widget.description);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Edit Category',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),

      body: SafeArea(
        child:  SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('category')
                  .where('categoryId',isEqualTo: widget.categoryId)
                  .snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                var data=snapshot.data?.docs;

                return Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: CachedNetworkImage(
                                height: 100,
                                imageUrl: categoryImage==''?widget.image??'':categoryImage,
                              ),
                            ),
                            Container(
                              child: CachedNetworkImage(
                                height: 100,
                                imageUrl: categoryBanner==''?widget.banner??'':categoryBanner,
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
                                    categoryImage = downloadUrl);
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
                                    categoryBanner = downloadUrl);
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
                                      labelStyle:TextStyle(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment(0.95, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if (categoryName.text != ''
                                      &&
                                      description.text!=''&&
                                      categoryBadge.text!=''&&
                                      brandName.text!=''&&
                                      madeIn.text!='') {
                                    bool proceed = await alert(context,
                                        'You want to add this Category?');

                                    if (proceed) {
                                      DocumentSnapshot snap=data![0];
                                      await snap.reference
                                          .update({
                                        'name': categoryName.text,
                                        'imageUrl': categoryImage==''?widget.image:categoryImage,
                                        'brand':productBrand.text,
                                        'categoryBadge':categoryBadge.text,
                                        'banner':categoryBanner==''?widget.banner:categoryBanner,
                                        'description':description.text,
                                        'madeIn':madeIn.text,
                                        'branchId':currentBranchId,
                                        'search': setSearchParam(categoryName.text),
                                      });
                                    }

                                    categoryName.clear();
                                    brandName.clear();
                                    description.clear();
                                    madeIn.clear();
                                    categoryImage='';

                                    showUploadMessage(
                                        context, "Category Updated...");

                                    Navigator.pop(context);


                                  } else {


                                    categoryName.text==''?
                                    showUploadMessage(
                                        context, "Please Enter category Name"):
                                    description.text==''?
                                    showUploadMessage(
                                        context, "Please Enter Description"):
                                    categoryBadge.text==''?
                                    showUploadMessage(
                                        context, "Please Enter Badge"):
                                    brandName.text==''?
                                    showUploadMessage(
                                        context, "Please Brand Name"):
                                    showUploadMessage(
                                        context, "Please Enter Made in");
                                  }
                                },
                                text: 'Update',
                                options: FFButtonOptions(
                                  width: 140,
                                  height: 60,
                                  color:primaryColor,
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
                          Align(
                            alignment: Alignment(0.95, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {

                                  bool proceed = await alert(context,
                                      'You want Delete Category?');

                                  if (proceed) {
                                    DocumentSnapshot snap=data![0];
                                    await snap.reference
                                        .delete();
                                  }



                                  showUploadMessage(
                                      context, "Category Deleted...");

                                  // Navigator.pop(context);




                                },
                                text: 'Delete',
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
                          ),
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
