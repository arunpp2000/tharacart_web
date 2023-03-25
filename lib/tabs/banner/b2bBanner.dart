import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/button.dart';
import '../../widgets/storage.dart';
import '../../widgets/uploadmedia.dart';
import '../dashboard/dashboard.dart';
import '../products/addCategory/editCategory.dart';

class AddB2bBanner extends StatefulWidget {
  AddB2bBanner({Key? key}) : super(key: key);

  @override
  _AddB2bBannerState createState() => _AddB2bBannerState();
}

class _AddB2bBannerState extends State<AddB2bBanner> {
  String uploadedFileUrl = '';
  String selectedBrand = '';
  String selectedShop = '';
  String selectedProducts = '';
  String selectedCategory = '';
  List<String> fetchedBrand = [];
  List<DropdownMenuItem> fetchedShops = [];
  List<String> fetchedProducts = [];
  List<String> fetchedCategory = [];
  List b2cList = [];
  List b2bList = [];
  getShops() {
    FirebaseFirestore.instance.collection("banner").snapshots().listen((event) {
      b2cList = [];
      b2bList = [];
      for (DocumentSnapshot doc in event.docs) {
        for (var data in doc['homePageBannerB2c']) {
          b2cList.add(data);
        }
        for (var data in doc['homePageBannerB2b']) {
          b2bList.add(data);
        }
      }

      print(b2cList.length);
      print(b2bList.length);

      if (mounted) {
        setState(() {});
      }
    });
  }

  bool edit = false;
  Future getShopss() async {
    QuerySnapshot data1 =
        await FirebaseFirestore.instance.collection("shops").get();

    for (var doc in data1.docs) {
      // shopDetails.add(doc.data());
      shops[doc.get('name')] = doc.get('shopId');
      shopDetails[doc.get('shopId')] = doc.get('name');
      fetchedShops.add(DropdownMenuItem(
        child: Text(doc.get('name')),
        value: doc.get('name').toString(),
      ));
      // i++;
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future getBrands() async {
    QuerySnapshot data1 =
        await FirebaseFirestore.instance.collection("brands").get();
    for (var doc in data1.docs) {
      brand[doc.get('brand')] = doc.get('brandId');
      brandDetails[doc.get('brandId')] = doc.get('brand');
      fetchedBrand.add((doc.get('brand')));
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future getProducts() async {
    QuerySnapshot data1 =
        await FirebaseFirestore.instance.collection("products").get();
    for (var doc in data1.docs) {
      product[doc.get('name')] = doc.get('productId');
      productDetails[doc.get('productId')] = doc.get('name');
      fetchedProducts.add((doc.get('name')));
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future getCategory() async {
    QuerySnapshot data1 =
        await FirebaseFirestore.instance.collection("category").get();
    for (var doc in data1.docs) {
      category[doc.get('name')] = doc.get('categoryId');
      categoryDetails[doc.get('categoryId')] = doc.get('name');
      fetchedCategory.add((doc.get('name')));
    }

    if (mounted) {
      setState(() {});
    }
  }

  int? SelectedIndex;
  late TextEditingController brandController = TextEditingController();
  late TextEditingController productController = TextEditingController();
  late TextEditingController categoryController = TextEditingController();
  Map<String, dynamic> shops = {};
  Map<String, dynamic> category = {};
  Map<String, dynamic> brand = {};
  Map<String, dynamic> product = {};

  Map<String, dynamic> categoryDetails = {};
  Map<String, dynamic> shopDetails = {};
  Map<String, dynamic> productDetails = {};
  Map<String, dynamic> brandDetails = {};
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getShops();
    if (fetchedBrand.isEmpty) {
      getBrands().then((value) {
        setState(() {});
      });
    }
    if (fetchedShops.isEmpty) {
      getShopss().then((value) {
        setState(() {});
      });
    }
    if (fetchedProducts.isEmpty) {
      getProducts().then((value) {
        setState(() {});
      });
    }
    if (fetchedCategory.isEmpty) {
      print('aaa');
      getCategory().then((value) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   automaticallyImplyLeading: true,
      //   title: Text(
      //     'HomePage Banner',
      //     style: bodyText1.override(
      //       fontFamily: 'Lexend Deca',
      //       color: Colors.white,
      //       fontSize: 20,
      //     ),
      //   ),
      //   actions: [],
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'B2B Banner',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            edit == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                        child: Container(
                          width: 330,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 2,
                                color: Color(0x4D101213),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomDropdown.search(
                            hintText: 'Select brand',
                            hintStyle: TextStyle(color: Colors.black),
                            items: fetchedBrand,
                            controller: brandController,
                            excludeSelected: false,
                            onChanged: (text) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                        child: Container(
                          width: 330,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 2,
                                color: Color(0x4D101213),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomDropdown.search(
                            hintText: 'Select Product',
                            hintStyle: TextStyle(color: Colors.black),
                            items: fetchedProducts,
                            controller: productController,
                            excludeSelected: false,
                            onChanged: (text) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                        child: Container(
                          width: 330,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 2,
                                color: Color(0x4D101213),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomDropdown.search(
                            hintText: 'Select category',
                            hintStyle: TextStyle(color: Colors.black),
                            items: fetchedCategory,
                            controller: categoryController,
                            excludeSelected: false,
                            onChanged: (text) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                        child: Container(
                          width: 330,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 2,
                                color: Color(0x4D101213),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomDropdown.search(
                            hintText: 'Select brand',
                            hintStyle: TextStyle(color: Colors.black),
                            items: fetchedBrand,
                            controller: brandController,
                            excludeSelected: false,
                            onChanged: (text) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                        child: Container(
                          width: 330,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 2,
                                color: Color(0x4D101213),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomDropdown.search(
                            hintText: 'Select Product',
                            hintStyle: TextStyle(color: Colors.black),
                            items: fetchedProducts,
                            controller: productController,
                            excludeSelected: false,
                            onChanged: (text) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                        child: Container(
                          width: 330,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 2,
                                color: Color(0x4D101213),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomDropdown.search(
                            hintText: 'Select category',
                            hintStyle: TextStyle(color: Colors.black),
                            items: fetchedCategory,
                            controller: categoryController,
                            excludeSelected: false,
                            onChanged: (text) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
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
                              selectedMedia.storagePath, context)) {
                        showUploadMessage(context, 'Uploading file...',
                            showLoading: true);
                        final downloadUrl = await uploadData(
                            selectedMedia.storagePath, selectedMedia.bytes);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        if (downloadUrl != null) {
                          setState(() => uploadedFileUrl = downloadUrl);
                          showUploadMessage(context, 'Success!');
                        } else {
                          showUploadMessage(context, 'Failed to upload media');
                        }
                      }
                    },
                    text: uploadedFileUrl == '' ? 'Upload Image' : 'Change',
                    icon: FaIcon(
                      FontAwesomeIcons.camera,
                      size: 20,
                    ),
                    options: FFButtonOptions(
                      width: 200,
                      height: 40,
                      color: primaryColor,
                      textStyle: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 12,
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
            uploadedFileUrl == ''
                ? SizedBox()
                : Container(
                    height: 100,

                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    child: CachedNetworkImage(
                      imageUrl: uploadedFileUrl,
                      fit: BoxFit.cover,
                    ),
                    // color: Colors
                    //     .red,
                  ),
            edit == false
                ? Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            if (uploadedFileUrl != '') {
                              print(b2bList.length);
                              b2bList.insert(0, {
                                'imageUrl': uploadedFileUrl,
                                'brand': brand[brandController.text],
                                'product': product[productController.text],
                                'category': category[categoryController.text]
                              });

                              print(b2bList.length);
                              setState(() {});
                              FirebaseFirestore.instance
                                  .collection('banner')
                                  .doc(currentBranchId)
                                  .update({'homePageBannerB2b': b2bList});
                              Navigator.pop(context);
                              showUploadMessage(
                                  context, 'New Banner Uploaded..');
                            } else {
                              showUploadMessage(
                                  context, 'Please Upload Banner');
                            }
                          },
                          text: 'Upload Banner',
                          options: FFButtonOptions(
                            width: 170,
                            height: 40,
                            color: primaryColor,
                            textStyle: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Colors.white,
                              fontSize: 12,
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
                  )
                : Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                  child: Row(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          brandController.clear();
                          productController.clear();
                          categoryController.clear();
                          uploadedFileUrl = '';
                          edit = false;
                          setState(() {});
                        },
                        text: 'cancel',
                        options: FFButtonOptions(
                          width: 170,
                          height: 40,
                          color: Colors.red,
                          textStyle: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                      SizedBox(width: 10,),
                      FFButtonWidget(
                        onPressed: () async {
                          if (uploadedFileUrl != '') {
                            print(b2bList.length);
                            b2bList.removeAt(SelectedIndex!);
                            b2bList.insert(SelectedIndex!, {
                              'imageUrl': uploadedFileUrl,
                              'brand': brand[brandController.text],
                              'product': product[productController.text],
                              'category':
                                  category[categoryController.text]
                            });
                            print(b2bList.length);
                            setState(() {});
                            FirebaseFirestore.instance
                                .collection('banner')
                                .doc(currentBranchId)
                                .update({'homePageBannerB2b': b2bList});
                            Navigator.pop(context);
                            showUploadMessage(
                                context, 'New Banner Uploaded..');
                          } else {
                            showUploadMessage(
                                context, 'Please Upload Banner');
                          }
                        },
                        text: 'update',
                        options: FFButtonOptions(
                          width: 170,
                          height: 40,
                          color: primaryColor,
                          textStyle: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 12,
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
            SizedBox(height: 20,),
            SizedBox(
              width:
                  // double.infinity,
                  MediaQuery.of(context).size.width * 0.85,
              child: DataTable(
                horizontalMargin: 10,
                columnSpacing: 20,
                columns: [
                  DataColumn(
                    label: Text(
                      "S.No",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Image",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ),
                  DataColumn(
                    label: Text("Brand",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                  DataColumn(
                    label: Text("Product",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                  DataColumn(
                    label: Text("Category",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                  DataColumn(
                    label: Text("Action",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                ],
                rows: List.generate(
                  b2bList.length,
                  (index) {
                    String image = b2bList[index]['imageUrl'];
                    String brand = brandDetails[b2bList[index]['brand']] ?? '';
                    String product =
                        productDetails[b2bList[index]['product']] ?? '';
                    String category =
                        categoryDetails[b2bList[index]['category']] ?? '';
                    return DataRow(
                      color: index.isOdd
                          ? MaterialStateProperty.all(
                              Colors.blueGrey.shade50.withOpacity(0.7))
                          : MaterialStateProperty.all(Colors.blueGrey.shade50),
                      cells: [
                        DataCell(Container(
                          width: MediaQuery.of(context).size.width * 0.02,
                          child: SelectableText(
                            '1',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                        DataCell(InkWell(
                          onTap: () async {
                            await showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (buildContext) {
                                  return AlertDialog(
                                    insetPadding: EdgeInsets.all(12),
                                    content: Center(
                                        child: Container(
                                      height: 500,
                                      width: 500,
                                      child: CachedNetworkImage(
                                        imageUrl: image,
                                      ),
                                    )),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('back')),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                              height: 150,
                              width: 100,
                              child: CachedNetworkImage(
                                imageUrl: image,
                              )),
                        )),
                        DataCell(SelectableText(
                          brand,
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        DataCell(SelectableText(
                          product,
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        DataCell(SelectableText(
                          category,
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        DataCell(ElevatedButton(
                            onPressed: () async {
                              bool pressed =
                                  await alert(context, 'Do you want edit?');
                              if (pressed) {
                                SelectedIndex = index;
                                edit = true;
                                categoryController.text = category;
                                brandController.text = brand;
                                productController.text = product;
                                uploadedFileUrl = image;
                              }
                              setState(() {});
                            },
                            child: Icon(Icons.edit))),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
