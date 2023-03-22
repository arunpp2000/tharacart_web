import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:tharacart_web/widgets/button.dart';
import '../../../widgets/uploadmedia.dart';
import '../../widgets/storage.dart';
import '../dashboard/dashboard.dart';
Map<String,dynamic> newList={};
List groupNames=[];
class AddProduct extends StatefulWidget {
  AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? uploadedFileUrl1;
  String? videoUrl;
  bool b2c=false;
  bool imported=false;
  bool payOnDelivery=false;
  bool b2b=false;
  bool organic=false;
  Map<String,dynamic> productPricing={};
  int? radioButtonValue;
  List<String> _selectedCuisine = [];
  List<Item> products = [];
  List<String> productsList = [];

  List<Map<String,dynamic>> newGroupPriceB2c=[];
  List<Map<String,dynamic>> newGroupPriceB2b=[];

  String radioButtonitem='Non Veg';
  List<Map<String,dynamic>> b2cTierPrice=[];
  List<Map<String,dynamic>> b2bTierPrice=[];
  List<Map<String,dynamic>> b2bDelhiTierPrice=[];

  late TextEditingController textController1;
  late TextEditingController soldQty;
  late  TextEditingController b2bP;
  late TextEditingController b2bDelhiP;
  late TextEditingController b2bDelhiD;
  late  TextEditingController productCode;
  late  TextEditingController productBrand;
  late  TextEditingController productDescription;
  late TextEditingController b2bd;
  late TextEditingController stock;
  late TextEditingController sold;
  late TextEditingController hsnCode;
  late  TextEditingController fact;
  late  TextEditingController weight;
  late TextEditingController instructions;
  late TextEditingController madefrom;
  late TextEditingController productIngredients;
  late TextEditingController b2cP;
  late TextEditingController gst;
  late  TextEditingController b2cD;
  late TextEditingController searchController;
  final pageViewController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<DropdownMenuItem> fetchedCategories = [];
  List<DropdownMenuItem> fetchedShops = [];
  List<DropdownMenuItem> fetchedSubCategory = [];
  List<DropdownMenuItem> fetchedBrand = [];
  String selectedCategory = "";
  int selectedShopIndex = 0;

  String categoryName='';
  String selectedSubCategory = "";
  String selectedBrand = "";
  String selectedShop = "";
  List<String> _selectedColors = [];
  List<String> _selectedSize = [];
 // List<CutRecord> _selectedCuts = [];

  QuerySnapshot? subCategories;
  List<Map<String,dynamic>> unitList = [];
  List<Map<String,dynamic>> shopList = [];
  List<DropdownMenuItem> units = [];
  String  basicUnit='';
  late TextEditingController startController;
  late TextEditingController stepController;
  late TextEditingController stopController;
  Map<String,dynamic> brand={};
  Map<String,dynamic> shops={};
  Map<String,dynamic> shopDetails={};

  Map<String,dynamic> brandDetails={};
  Map<String,dynamic> category={};
  Map<String,dynamic> categoryDetails={};
  Map<String,dynamic> subCategory={};
  Map<String,dynamic> subCategoryDetails={};

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    b2bP = TextEditingController();
    productCode = TextEditingController();
    productBrand = TextEditingController();
    productDescription = TextEditingController();
    b2bd = TextEditingController();
    b2bDelhiP = TextEditingController();
    b2bDelhiD = TextEditingController();
    stock = TextEditingController();
    sold = TextEditingController();
    hsnCode = TextEditingController();
    fact = TextEditingController();
    weight = TextEditingController();
    instructions = TextEditingController();
    madefrom = TextEditingController();
    productIngredients = TextEditingController();
    gst = TextEditingController();


    b2cP = TextEditingController(text: '');
    b2cD=TextEditingController(text: '');
    searchController = TextEditingController(text: '');
    startController = TextEditingController(text: '1.0');
    stepController = TextEditingController(text: '1.0');
    stopController = TextEditingController(text: '20.0');
    if (fetchedShops.isEmpty) {
      getShops().then((value) {
        setState(() {});
      });
    }
    if (fetchedCategories.isEmpty) {
      getCategories().then((value) {
        setState(() {});
      });
    }
    if (fetchedSubCategory.isEmpty) {
      getSubCategories().then((value) {
        setState(() {});
      });
    }
    if (fetchedBrand.isEmpty) {
      getBrands().then((value) {
        setState(() {});
      });
    }
    if (productsList.isEmpty) {
      getColors().then((value) {
        setState(() {});
      });
    }
    if (_selectedSize.isEmpty) {
      getSizes().then((value) {
        setState(() {});
      });
    }
    getUnits();
    // if (_selectedCuts.isEmpty) {
    //   getCuts().then((value) {
    //     setState(() {});
    //   });
    // }


  }
  // Future<void>  getCuisine() async {
  //   Stream cus=queryCuisineRecord();
  //   // int rowIndex=1;
  //   cus.listen((value) {
  //     for (var cusRecord in value) {
  //       cuisine.add(MultipleSelectItem.build(
  //         value: cusRecord.name,
  //         display: cusRecord.name,
  //         content: cusRecord.name,
  //       ));
  //     }
  //   }
  //   );
  // }

  Future getColors() async {
    QuerySnapshot data1 = await FirebaseFirestore.instance
        .collection("products").get();

    for (var doc in data1.docs) {
      products.add(
          Item.build(value: doc.id, display: doc.get('name'), content: doc.get('name'))
      );

    }
    print(products.length);
    print('products*************');
    if(mounted){
      setState(() {

      });
    }


  }

  Future getShops() async {
    QuerySnapshot data1 = await FirebaseFirestore.instance.collection("shops").get();
    for (var doc in data1.docs) {
      shops[doc.get('name')]=doc.get('shopId');
      shopDetails[doc.get('shopId')]=doc.get('name');
      fetchedShops.add(DropdownMenuItem(
        child: Text(doc.get('name')),
        value: doc.get('name').toString(),
      ));
      // i++;
    }
    if (mounted) {
      setState(() {
      });
    }
  }

  Future getUnits() async {
    DocumentSnapshot data1 =
    await FirebaseFirestore.instance.collection("units").doc("units").get();
    List<Map<String,dynamic>> temp = [];
    List<DropdownMenuItem> tempUnit =[];
    for (var unit in data1.get('unitlist')) {
      unitList.add(unit);
      units.add(DropdownMenuItem(
        child: Text(unit['name']),
        value: unit['name'],
      ));
    }
    if (mounted) {
      setState(() {
        // unitList = temp;
        // units=tempUnit;
      });
    }
  }

  // ListBuilder<String> convertListToListBuilder(List<String> list) {
  //   ListBuilder<String> listBuilder = ListBuilder<String>();
  //   for (var items in list) {
  //     listBuilder.add(items);
  //   }
  //   return listBuilder;
  // }
  // ListBuilder<CutRecord> convertMapListToMapListBuilder(List<CutRecord> list) {
  //   ListBuilder<CutRecord> listBuilder = ListBuilder<CutRecord>();
  //   for (var items in list) {
  //     listBuilder.add(items);
  //   }
  //   return listBuilder;
  // }

  List<Item> colors = [];
  List<MultipleSelectItem> sizes = [];
  List<MultipleSelectItem> cuts = [];

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

  // Future getColors() async {
  //   DocumentSnapshot data1 = await FirebaseFirestore.instance
  //       .collection("colors")
  //       .doc("colors")
  //       .get();
  //
  //   for (var color in data1.get('colorList')) {
  //     colors.add(Item.build(
  //       value: '0xFF${color['code']}',
  //       display: color['name'],
  //
  //       content: color['name'],
  //     ));
  //   }
  // }

  Future getSizes() async {
    DocumentSnapshot data1 =
    await FirebaseFirestore.instance.collection("sizes").doc("sizes").get();
    // int rowIndex=1;
    for (var size in data1.get('sizeList')) {
      sizes.add(MultipleSelectItem.build(
        value: size,
        display: size,
        content: size,
      ));
      // rowIndex++;
    }
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

  Future getSubCategories() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("subCategory").get();
    setState(() {
      subCategories = data1;
    });
    for (var doc in data1.docs) {
      subCategory[doc.get('name')]=doc.get('subCategoryId');
      subCategoryDetails[doc.get('subCategoryId')]=doc.get('name');
      fetchedSubCategory.add(DropdownMenuItem(
        child: Text(doc.get('name')),
        value: doc.get('name').toString(),
      ));
    }
  }

  getSubCategoriesByCategory(String categoryId) {
    List<DropdownMenuItem> subcategories = <DropdownMenuItem>[];

    for (var doc in subCategories!.docs) {

      if (doc.get('categoryId') == categoryId ||
          categoryId == "" ||
          categoryId == null) {
        subCategory[doc.get('name')]=doc.get('subCategoryId');
        subCategoryDetails[doc.get('subCategoryId')]=doc.get('name');
        subcategories.add(DropdownMenuItem(
          child: Text(doc.get('name')),
          value: doc.get('name').toString(),
        ));
      }
    }

    setState(() {
      selectedSubCategory = "";
      selectedCategory = categoryId;
      fetchedSubCategory = subcategories;
    });
  }

  Future getCategories() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("category").get();
    for (var doc in data1.docs) {
      category[doc.get('name')]=doc.get('categoryId');
      categoryDetails[doc.get('categoryId')]=doc.get('name');
      fetchedCategories.add(DropdownMenuItem(
        child: Text(doc.get('name')),
        value: doc.get('name').toString(),

      ));
    }
  }



  // Future getCuts() async {
  //
  //   // Stream cut=queryCutRecord();
  //
  //   cut.listen((value) {
  //     for (var cutRecord in value) {
  //       cuts.add(MultipleSelectItem.build(
  //         value: cutRecord,
  //         display: cutRecord.name,
  //         content: cutRecord.name,
  //       ));
  //     }
  //   });
  //
  //
  // }
  @override
  Widget build(BuildContext context) {

    print(selectedShopIndex);

    return Scaffold(
      key: scaffoldKey,
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   automaticallyImplyLeading: true,
      //   title: Text(
      //     'Products',
      //     style: TextStyle(
      //         fontFamily: 'Poppins',
      //         color: Colors.white,
      //         fontSize: 20,
      //         fontWeight: FontWeight.w600
      //     ),
      //   ),
      //   actions: [],
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Add Product',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
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
                              context, 'Uploading Image...',
                              showLoading: true);
                          final downloadUrl = await uploadData(
                              selectedMedia.storagePath,
                              selectedMedia.bytes);
                          ScaffoldMessenger.of(context)
                              .hideCurrentSnackBar();
                          if (downloadUrl != null) {
                            setState(() =>
                            uploadedFileUrl1 = downloadUrl);
                            showUploadMessage(
                                context, 'Success!');
                          } else {
                            showUploadMessage(context,
                                'Failed to upload media');
                          }
                        }
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 30,
                      ),
                      iconSize: 30,
                    ),
                    IconButton(
                      onPressed: () async {
                        final selectedMedia = await selectMedia(
                            isVideo: true
                        );
                        if (selectedMedia != null &&
                            validateFileFormat(

                                selectedMedia.storagePath,
                                context)) {
                          showUploadMessage(
                              context, 'Uploading Video...',
                              showLoading: true);
                          final downloadUrl = await uploadData(
                              selectedMedia.storagePath,
                              selectedMedia.bytes);
                          ScaffoldMessenger.of(context)
                              .hideCurrentSnackBar();
                          if (downloadUrl != null) {
                            setState(() =>
                            videoUrl = downloadUrl);
                            showUploadMessage(context,
                                'Media upload Success!');
                          } else {
                            showUploadMessage(context,
                                'Failed to upload media');
                          }
                        }
                      },
                      icon: Icon(
                        Icons.slow_motion_video_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      iconSize: 30,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Text('B2C'),

                    Switch(
                      value: b2c,
                      onChanged: (value) {
                        setState(() {
                          b2c = value;
                          print(b2c);
                        });
                      },
                    ),
                    SizedBox(width: 20,),
                    Text('B2B'),

                    Switch(
                      value: b2b,
                      onChanged: (value) {
                        setState(() {
                          b2b = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Text('Imported'),

                    Switch(
                      value: imported,
                      onChanged: (value) {
                        setState(() {
                          imported = value;
                          print(imported);
                        });
                      },
                    ),
                    SizedBox(width: 20,),
                    Text('Pay On Delivery'),

                    Switch(
                      value: payOnDelivery,
                      onChanged: (value) {
                        setState(() {
                          payOnDelivery = value;
                        });
                      },
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //
                //   children: [
                //     Text('Organic'),
                //
                //     Switch(
                //       value: organic,
                //       onChanged: (value) {
                //         setState(() {
                //           organic = value;
                //           print(organic);
                //         });
                //       },
                //     ),
                //
                //   ],
                // ),

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
                              controller: textController1,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Product Name',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText:
                                'enter your product name',
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
                              controller: productCode,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Product Code',
                                labelStyle:TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText:
                                'enter your product Code',
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
                              controller: productDescription,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Product Description',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight:
                                  FontWeight.w500,
                                ),
                                hintText:
                                'enter your product Description',
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
                  padding: EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     width: 330,
                //     // height: 70,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(
                //         color: Color(0xFFE6E6E6),
                //       ),
                //     ),
                //     child: SearchableDropdown.single(
                //       items: fetchedBrand,
                //       value: selectedBrand,
                //       hint: "Select Brand",
                //       searchHint: "Select Brand",
                //       onChanged: (value) {
                //         setState(() {
                //           selectedBrand = value;
                //           // categoryController.text=value;
                //         });
                //       },
                //       isExpanded: true,
                //     ),
                //   ),
                // ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 0.0),
                ),
                // Container(
                //   width: 330,
                //   // height: 70,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(8),
                //     border: Border.all(
                //       color: Color(0xFFE6E6E6),
                //     ),
                //   ),
                //   child: SearchableDropdown.single(
                //     items: fetchedCategories,
                //     value: selectedCategory,
                //     hint: "Select Category",
                //     searchHint: "Select Category",
                //     onChanged: (value) {
                //       // setState(() {
                //       //   fetchedSubCategory=<DropdownMenuItem>[];
                //       //   selectedSubCategory="";
                //       //   selectedCategory = value;
                //       //   // categoryController.text=value;
                //       // });
                //       getSubCategoriesByCategory(value);
                //     },
                //     isExpanded: true,
                //   ),
                // ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 0.0),
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
                              controller: productIngredients,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Ingredients',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'Product Ingredients',
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
                              controller: fact,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Nutrition Fact',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'Nutrition Fact',
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
                              controller: instructions,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Instructions',
                                labelStyle:TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'Instructions',
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
                              controller: madefrom,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Made  From',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'Contry',
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
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Radio(
                          value:"Non Veg",
                          groupValue: radioButtonitem,
                          onChanged: (val){
                            setState(() {
                              radioButtonitem =val!;
                            });
                          },
                        ),
                        Text('Non Veg', style: new TextStyle(
                            color: Colors.black, fontSize: 15),),
                        Radio(
                          value: 'Veg',
                          groupValue: radioButtonitem,
                          onChanged: (val){
                            setState(() {
                              radioButtonitem =val!;
                            });
                          },
                        ),Text("Veg", style: new TextStyle(
                            color: Colors.black, fontSize: 15),),

                      ]
                  ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('B2C Price'),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 10),
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
                              controller: b2cP,
                              keyboardType: TextInputType.number,

                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'price',
                                labelStyle:TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'product price',
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
                      ),
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
                              controller: b2cD,
                              keyboardType: TextInputType.number,

                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'discount price',
                                labelStyle:TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'discount price',
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
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('B2B Price'),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 10),
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
                              controller: b2bP,
                              keyboardType: TextInputType.number,

                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'price',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'product price',
                                hintStyle:TextStyle(
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
                      ),
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
                              controller: b2bd,
                              keyboardType: TextInputType.number,

                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'discount price',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'discount price',
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
                              style:TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                !b2c?Container():  Column(
                    children: List.generate(groupNames.length, (index) {
                      TextEditingController groupPrice$index=TextEditingController();
                      TextEditingController groupDiscountPrice$index=TextEditingController();


                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('B2C ${groupNames[index]} Price'),
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
                                        controller: groupPrice$index,
                                        keyboardType: TextInputType.number,
                                        onChanged: (text){

                                          productPricing['b2c'+groupNames[index]+'P']=double.tryParse(text);
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'price',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF8B97A2),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          hintText: 'product price',
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
                                ),
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
                                        onChanged : (text){
                                          productPricing['b2c'+groupNames[index]+'D']=double.tryParse(text);

                                        },
                                        controller: groupDiscountPrice$index,
                                        keyboardType: TextInputType.number,

                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'discount price',
                                          labelStyle:TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF8B97A2),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          hintText: 'discount price',
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
                                ),
                              ],
                            ),
                          ),

                        ],
                      );
                    })
                ),
                !b2b?Container():  Column(
                    children: List.generate(groupNames.length, (index) {
                      TextEditingController group$Price=TextEditingController();
                      TextEditingController group$DiscountPrice=TextEditingController();

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('B2B ${groupNames[index]} Price'),
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
                                        controller: group$Price,
                                        keyboardType: TextInputType.number,
                                        onChanged: (text){

                                          productPricing['b2b'+groupNames[index]+'P']=double.tryParse(text);
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'price',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF8B97A2),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          hintText: 'product price',
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
                                ),
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
                                      padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                      child: TextFormField(
                                        controller: group$DiscountPrice,
                                        keyboardType: TextInputType.number,
                                        onChanged: (text){

                                          productPricing['b2b'+groupNames[index]+'D']=double.tryParse(text);
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'discount price',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF8B97A2),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          hintText: 'discount price',
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
                                ),
                              ],
                            ),
                          ),

                        ],
                      );
                    })
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
                              controller: stock,
                              keyboardType: TextInputType.number,

                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Stock',
                                labelStyle:TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'Stock',
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
                      ),
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
                              controller: sold,
                              keyboardType: TextInputType.number,

                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Sold',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'Sold',
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
                      ),
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
                              controller: hsnCode,
                              keyboardType: TextInputType.number,

                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'HSN Code',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'HSN Code',
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
                      ),
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
                              controller: weight,
                              keyboardType: TextInputType.number,

                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Weight',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'Weight',
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
                      ),
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
                              controller: gst,
                              keyboardType: TextInputType.number,

                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'GST',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'GST',
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
                      ),
                    ],
                  ),
                ),




                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('B2C Tier Price',
                    style: TextStyle(fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                  child: Container(

                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: b2cTierPrice.length+1,
                        itemBuilder: (context,index){
                          TextEditingController admin$index=TextEditingController();
                          // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                          String name=index==(b2cTierPrice.length)?"":b2cTierPrice[index]['name'];
                          String price=index==(b2cTierPrice.length)?"":b2cTierPrice[index]['price'];
                          return    Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Container(
                              width: 350,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0x8A242222),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(name),
                                    Text(price),

                                    IconButton(
                                        onPressed: () async {

                                          if(index==(b2cTierPrice.length)){
                                            Map<String,dynamic> selected=  await    showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return SizedBox();
                                                 //   B2cDialogue();
                                                });
                                            if(selected!=null) {
                                              b2cTierPrice.add(selected);
                                            }
                                            setState(() {
                                              // addon.add({
                                              // 'addOn':admins1[index]['addOn'],
                                              //   'addOnArabic':admins1[index]['addOnArabic'],
                                              //   'imageUrl':admins1[index]['imageUrl']
                                              // });
                                              // print(addon.length);

                                            });
                                          }else
                                          {

                                            b2cTierPrice.removeAt(index);
                                            setState(() {

                                            });

                                          }

                                        }, icon: index==(b2cTierPrice.length)?Icon(Icons.add):
                                    Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('B2B Tier Price',
                    style: TextStyle(fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                  child: Container(

                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: b2bTierPrice.length+1,
                        itemBuilder: (context,index){
                          TextEditingController admin$index1=TextEditingController();
                          // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                          String name=index==(b2bTierPrice.length)?"":b2bTierPrice[index]['name'];
                          String price=index==(b2bTierPrice.length)?"":b2bTierPrice[index]['price'];
                          return    Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Container(
                              width: 350,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0x8A242222),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(name),
                                    Text(price),

                                    IconButton(
                                        onPressed: () async {

                                          if(index==(b2bTierPrice.length)){
                                            // Map<String,dynamic> selected1=  await    showDialog(
                                            //     context: context,
                                            //     builder: (context) {
                                            //       return B2bDialogue();
                                            //     });
                                            // if(selected1!=null) {
                                            //   b2bTierPrice.add(selected1);
                                            // }
                                            setState(() {
                                              // addon.add({
                                              // 'addOn':admins1[index]['addOn'],
                                              //   'addOnArabic':admins1[index]['addOnArabic'],
                                              //   'imageUrl':admins1[index]['imageUrl']
                                              // });
                                              // print(addon.length);

                                            });
                                          }else
                                          {

                                            b2bTierPrice.removeAt(index);
                                            setState(() {

                                            });

                                          }

                                        }, icon: index==(b2bTierPrice.length)?Icon(Icons.add):
                                    Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                !b2b?Container():    Column(
                    children: List.generate(groupNames.length, (index) {

                      String group=groupNames[index];


                      List<Map<String,dynamic>> tierPricing$index=productPricing['b2b'+group+'Tier']??[];
                      return   Column(

                          children:[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('B2B $group Tier Price',
                                style: TextStyle(fontWeight: FontWeight.w600),),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10,10,10,0),
                              child: Container(

                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: tierPricing$index.length+1,
                                    itemBuilder: (context,index){
                                      TextEditingController admin$index1=TextEditingController();
                                      // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                      String name=index==(tierPricing$index.length)?"":tierPricing$index[index]['name'];
                                      String price=index==(tierPricing$index.length)?"":tierPricing$index[index]['price'];
                                      return    Padding(
                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Container(
                                          width: 350,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Color(0x8A242222),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(name),
                                                Text(price),

                                                IconButton(
                                                    onPressed: () async {

                                                      if(index==(tierPricing$index.length)){
                                                        Map<String,dynamic> selected1=  await    showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return SizedBox();
                                                                // B2bDelhiDialogue(groupName: group,b2b: true,);
                                                            });
                                                        if(selected1!=null) {
                                                          tierPricing$index.add(selected1);
                                                          productPricing['b2b'+group+'Tier']=tierPricing$index;
                                                        }
                                                        setState(() {
                                                          // addon.add({
                                                          // 'addOn':admins1[index]['addOn'],
                                                          //   'addOnArabic':admins1[index]['addOnArabic'],
                                                          //   'imageUrl':admins1[index]['imageUrl']
                                                          // });
                                                          // print(addon.length);

                                                        });
                                                      }else
                                                      {

                                                        tierPricing$index.removeAt(index);
                                                        setState(() {

                                                        });

                                                      }

                                                    }, icon: index==(tierPricing$index.length)?Icon(Icons.add):
                                                Icon(Icons.delete))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ]);
                    })
                ),
                !b2c?Container(): Column(
                    children: List.generate(groupNames.length, (index) {
                      String group=groupNames[index];
                      List<Map<String,dynamic>> tierPricing$index=productPricing['b2c'+group+'Tier']??[];

                      return   Column(

                          children:[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('B2C $group Tier Price',
                                style: TextStyle(fontWeight: FontWeight.w600),),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10,10,10,0),
                              child: Container(

                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: tierPricing$index.length+1,
                                    itemBuilder: (context,index){
                                      TextEditingController admin$index1=TextEditingController();
                                      // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                      String name=index==(tierPricing$index.length)?"":tierPricing$index[index]['name'];
                                      String price=index==(tierPricing$index.length)?"":tierPricing$index[index]['price'];
                                      return    Padding(
                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Container(
                                          width: 350,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Color(0x8A242222),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(name),
                                                Text(price),

                                                IconButton(
                                                    onPressed: () async {

                                                      if(index==(tierPricing$index.length)){
                                                        Map<String,dynamic> selected1=  await    showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return SizedBox();
                                                                //B2bDelhiDialogue(groupName: group,b2b: false,);
                                                            });
                                                        if(selected1!=null) {
                                                          tierPricing$index.add(selected1);
                                                          productPricing['b2c'+group+'Tier']=tierPricing$index;

                                                        }
                                                        setState(() {
                                                          // addon.add({
                                                          // 'addOn':admins1[index]['addOn'],
                                                          //   'addOnArabic':admins1[index]['addOnArabic'],
                                                          //   'imageUrl':admins1[index]['imageUrl']
                                                          // });
                                                          // print(addon.length);

                                                        });
                                                      }else
                                                      {

                                                        tierPricing$index.removeAt(index);
                                                        setState(() {

                                                        });

                                                      }

                                                    }, icon: index==(tierPricing$index.length)?Icon(Icons.add):
                                                Icon(Icons.delete))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ]);
                    })
                ),

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(10,10,10,0),
                //   child: Container(
                //       width: 330,
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(8),
                //         border: Border.all(
                //           color: Color(0xFFE6E6E6),
                //         ),
                //       ),
                //       child: MultiFilterSelect(
                //         // allItems: products,
                //         // initValue: productsList,
                //         // hintText: 'Select Related Products',
                //         // selectCallback: (List selectedValue) =>
                //         // productsList = selectedValue,
                //
                //       )
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 0.0),
                ),
                Align(
                  alignment: Alignment(0.95, 0),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {

                        final name = textController1.text;



                        final userId = 'currentUserUid';
                        if (name == "" || name == null) {
                          showUploadMessage(context,
                              "Please enter product name");
                        } else if (uploadedFileUrl1 == "" ||
                            uploadedFileUrl1 == null) {
                          showUploadMessage(context,
                              "Please choose a product image");
                        }
                        // else if (videoUrl == "" ||
                        //     videoUrl == null) {
                        //   showUploadMessage(context,
                        //       "Please choose a product Video");
                        // }
                        else {
                          bool proceed = await alert(context,
                              'You want to upload this product?');

                          if (proceed) {
                            Map<String,dynamic> productMap={
                              'date':FieldValue.serverTimestamp(),
                              'madeFrom':madefrom.text,
                              'gst':int.tryParse(gst.text),
                              'name': name,
                              'productCode':productCode.text,
                              'description':productDescription.text,
                              'b2c':b2c,
                              'b2b':b2b,
                              'imported':imported,
                              // 'organic':organic,
                              'payOnDelivery':payOnDelivery,
                              'intructions':instructions.text,
                              'relatedProducts':productsList,
                              'veg': radioButtonitem=='Veg'?true:false,
                              'ingredients': productIngredients.text,
                              'fact':fact.text,
                              'weight':double.tryParse(weight.text)??0 ,
                              'b2cP': double.tryParse(b2cP.text)??0,
                              'b2cD': double.tryParse(b2cD.text)??0,
                              'b2bP':double.tryParse(b2bP.text)??0,
                              'b2bD':double.tryParse(b2bd.text)??0,
                              'userId': userId,
                              'category':category[selectedCategory],
                              'categoryName': selectedCategory,
                              'brand':brand[selectedBrand],
                              'search': setSearchParam(name),
                              'b2cTier':b2cTierPrice,
                              'b2bTier':b2bTierPrice,
                              'open':false,
                              'available':false,
                              'branchId': 'currentBranchId',
                              'start': double.tryParse(startController.text)??0,
                              'step': double.tryParse(stepController.text)??0,
                              'stop': double.tryParse(stopController.text)??0,
                              'stock':int.tryParse(stock.text)??0,
                              'sold':int.tryParse(sold.text)??0,
                              'hsnCode':int.tryParse(hsnCode.text),
                              'ones':0,
                              'twos':0,
                              'threes':0,
                              'fours':0,
                              'fives':0,
                              'totalReviews':0,
                              'imageId': FieldValue.arrayUnion(
                                  [uploadedFileUrl1]??[]),
                              'videoUrl': FieldValue.arrayUnion(
                                  [videoUrl]??[]),
                            };
                            for(String key in productPricing.keys){
                              productMap[key]=productPricing[key];
                            }
                            FirebaseFirestore.instance.collection('products').add(productMap).then((value) {
                              value.update({
                                'productId':value.id,
                              });
                            });
                            Navigator.pop(context);
                            showUploadMessage(context, 'New Product Added...');
                          }
                        }
                      },
                      text: 'Add Product',
                      options: FFButtonOptions(
                        width: 180,
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
class MultipleSelectItem<V, D, C> {
  V value;
  D display;

  /// drop down content.
  C content;

  MultipleSelectItem.build({
    required this.value,
    required this.display,
    required this.content,
  });

  MultipleSelectItem.fromJson(
      Map<String, dynamic> json, {
        displayKey = 'display',
        valueKey = 'value',
        contentKey = 'content',
      })  : value = json[valueKey] ?? '',
        display = json[displayKey] ?? '',
        content = json[contentKey] ?? '';

  static List<MultipleSelectItem> allFromJson(
      List jsonList, {
        displayKey = 'display',
        valueKey = 'value',
        contentKey = 'content',
      }) {
    return jsonList
        .map((json) => MultipleSelectItem.fromJson(
      json,
      displayKey: displayKey,
      valueKey: valueKey,
      contentKey: contentKey,
    ))
        .toList();
  }
}

class Item<V, D, C> {
  V value;

  /// display in the TextField
  D display;

  /// display in the list content.
  C content;

  Item.build({
    required this.value,
    required this.display,
    required this.content,
  });

  Item.fromJson(
      Map<String, dynamic> json, {
        displayKey = 'display',
        valueKey = 'value',
        contentKey = 'content',
      })  : value = json[valueKey] ?? '',
        display = json[displayKey] ?? '',
        content = json[contentKey] ?? '';

  static List<Item> allFromJson(
      List jsonList, {
        displayKey = 'display',
        valueKey = 'value',
        contentKey = 'content',
      }) {
    return jsonList
        .map((json) => Item.fromJson(
      json,
      displayKey: displayKey,
      valueKey: valueKey,
      contentKey: contentKey,
    ))
        .toList();
  }
}