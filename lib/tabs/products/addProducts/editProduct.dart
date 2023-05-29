


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../widgets/button.dart';
import '../../../widgets/storage.dart';
import '../../../widgets/uploadmedia.dart';
import '../../dashboard/dashboard.dart';
import 'addProducts.dart';
import 'b2bDelhiDialogue.dart';
import 'b2bDialogueBox.dart';
import 'b2cDialogueBox.dart';
import 'edit.dart';

class Editproduct extends StatefulWidget {
  Editproduct({
    Key? key,
    this.productId, this.shopId, this.categoryId, this.subCategoryId, this.brandId,
  }) : super(key: key);

  final String? productId;
  final String? shopId;
  final String? categoryId;
  final String? subCategoryId;
  final String? brandId;

  @override
  _EditproductState createState() => _EditproductState();
}

class _EditproductState extends State<Editproduct> {
  String? uploadedFileUrl1;
  String? uploadedFileUrl2;
  String categoryName='';
  bool b2c=true;
  bool b2b=true;
  bool available=true;
  var imagesItem;
  bool imported=true;
  bool payOnDelivery=true;
  bool organic=true;
 late TextEditingController b2bP;
 late TextEditingController madefrom;
 late TextEditingController b2bd;
 late TextEditingController b2bDelhiP;
 late TextEditingController b2bDelhiD;
 late TextEditingController stock;
 late TextEditingController sold;
 late TextEditingController hsnCode;
 late TextEditingController productName;
 late TextEditingController productCode;
 late TextEditingController productBrand;
 late TextEditingController productDescription;
 late TextEditingController productIncredient;
 late TextEditingController fact;
 late TextEditingController weight;
 late TextEditingController instructions;
 late TextEditingController productPrice;
 late TextEditingController gst;
  List<Item> colors = [];
  Map<String,dynamic> productPricing={};
  late TextEditingController discountPriceController;
  final pageViewController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<DropdownMenuItem> fetchedCategories = [];
  List _selectedCuisine = [];
  // List<MultipleSelectItem> cuisine = [];
  late List B2C_tierPrice;
  late List B2B_tierPrice;
  late List B2B_Delhi_tierPrice;
  bool loaded=false;
  late bool loaded1;

  List<DropdownMenuItem> fetchedSubCategory = [];
  List<DropdownMenuItem> fetchedBrand = [];
  List<DropdownMenuItem> fetchedShops = [];
  late int selectedShopIndex;
  String selectedCategory = "";
  String category = "";
  String radioButtonitem = "";
  String selectedShop = "";

  String selectedSubCategory = "";
  String selectedBrand = "";
  List _selectedColors = [];
  List _selectedSize = [];
  List _selectedCuts = [];
  List images = [];
  List videos = [];
  late QuerySnapshot subCategories;
  List<Map<String,dynamic>> unitList = [];
  List<DropdownMenuItem> units = [];
  List<Map<String,dynamic>> shopList = [];
  String  basicUnit='';
 late TextEditingController startController;
 late TextEditingController stepController;
 late TextEditingController stopController;

  List<Item> products = [];
  List productsList = [];
  Map<String,dynamic> brand={};
  Map<String,dynamic> shops={};
  Map<String,dynamic> shopDetails={};

  Map<String,dynamic> brandDetails={};
  Map<String,dynamic> categoryIdFromName={};
  Map<String,dynamic> categoryDetails={};
  Map<String,dynamic> subCategory={};
  Map<String,dynamic> subCategoryDetails={};
  String? videoUrl;


  getUsers(String id){

    FirebaseFirestore.instance.collection('users')
        .get().then((users){


      for(DocumentSnapshot doc in users.docs){

        try{

          List bagIds=doc['bagIds'];
          List b2cBagIds=doc['b2cBagIds'];


          if(bagIds.contains(id)){

            List list=doc['bag'];

            int i=0;
            for(int k=0;k<list.length;k++){
              if(id==list[k]['id']){
                i=k;
                break;
              }
            }
            list.removeAt(i);
            doc.reference.update({
              'bagIds':FieldValue.arrayRemove([widget.productId]),
              'bag':list,
            });

          }
          if(b2cBagIds.contains(id)){

            List list=doc['b2cBag'];

            int i=0;
            for(int k=0;k<list.length;k++){
              if(id==list[k]['id']){
                i=k;
                break;
              }
            }
            list.removeAt(i);


            doc.reference.update({
              'b2cBagIds':FieldValue.arrayRemove([widget.productId]),
              'b2cBag':list,
            });

          }



        }catch(e){
          print(doc['fullName']);
        }

      }


    });

    print('done');

    if(mounted){
      setState(() {

      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedIndex=0;
    // print('product id '+widget.productId);
    productName = TextEditingController();
    productCode = TextEditingController();
    productBrand = TextEditingController();
    madefrom = TextEditingController();
    b2bP = TextEditingController();
    b2bd = TextEditingController();
    b2bDelhiP = TextEditingController();
    b2bDelhiD = TextEditingController();
    stock = TextEditingController();
    sold = TextEditingController();
    hsnCode = TextEditingController();
    productDescription = TextEditingController();
    productIncredient = TextEditingController();
    fact = TextEditingController();
    weight = TextEditingController();
    instructions = TextEditingController();
    gst = TextEditingController();
    productPrice = TextEditingController();
    discountPriceController = TextEditingController();
    startController = TextEditingController();
    stepController = TextEditingController();
    stopController = TextEditingController();
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
    // if (_selectedColors.isEmpty) {
    //   getColors().then((value) {
    //     setState(() {});
    //   });
    // }
    if (_selectedSize.isEmpty) {
      // getSizes().then((value) {
      //   setState(() {});
      // });
    }
    if (_selectedCuisine.isEmpty) {
      // getCuisine().then((value) {
      //   setState(() {});
      // });
    }


    getUnits();
    if (_selectedCuts.isEmpty) {
      // getCuts().then((value) {
      //   setState(() {});
      // });
    }
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
  // Future getCuts() async {
  //
  //   QuerySnapshot data1 =  await FirebaseFirestore.instance.collection("cuts").get();
  //   List<Map<String,dynamic>> temp = [];
  //
  //
  //   for (var cutRecord in data1.docs) {
  //     cuts.add(MultipleSelectItem.build(
  //       value: cutRecord,
  //       display: cutRecord.get('name'),
  //       content: cutRecord.get('name'),
  //     ));
  //   }
  //
  //
  //
  // }
  Future getShops() async {
    QuerySnapshot data1 = await FirebaseFirestore.instance.collection("shops").get();

    for (var doc in data1.docs) {
      shops[doc.get('name')]=doc.get('shopId');
      shopDetails[doc.get('shopId')]=doc.get('name');
      fetchedShops.add(DropdownMenuItem(
        child: Text(doc.get('name')),
        value: doc.get('name').toString(),
      ));
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
      temp.add(unit);
      tempUnit.add(DropdownMenuItem(
        child: Text(unit['name']),
        value: unit['name'],
      ));
    }
    if (mounted) {
      setState(() {
        unitList = temp;
        units=tempUnit;
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
  //
  // List<MultipleSelectItem> colorss = [];
  // List<MultipleSelectItem> sizes = [];
  // List<MultipleSelectItem> cuts = [];

  Future getColors() async {
    QuerySnapshot data1 = await FirebaseFirestore.instance
        .collection("products").get();

    for (var doc in data1.docs) {
      products.add(
          Item.build(value: doc.id, display: doc.get('name'), content: doc.get('name'))
      );

    }
    setState(() {

    });


  }

  // Future getSizes() async {
  //   DocumentSnapshot data1 =
  //   await FirebaseFirestore.instance.collection("sizes").doc("sizes").get();
  //   // int rowIndex=1;
  //   for (var size in data1.get('sizeList')) {
  //     sizes.add(MultipleSelectItem.build(
  //       value: size,
  //       display: size,
  //       content: size,
  //     ));
  //     // rowIndex++;
  //   }
  // }

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
    if(mounted){
      setState(() {
      });
    }
  }

  getSubCategoriesByCategory(String categoryId) {

    for (var doc in subCategories.docs) {
      // Map<String , dynamic> data = doc.data();

      if (doc.get('categoryId') == categoryId ||
          categoryId == "" ||
          categoryId == null) {
        subCategory[doc.get('name')]=doc.get('subCategoryId');
        subCategoryDetails[doc.get('subCategoryId')]=doc.get('name');
        fetchedSubCategory.add(DropdownMenuItem(
          child: Text(doc.get('name')),
          value: doc.get('subCategoryId'),
        ));
      }
    }

    setState(() {
      selectedSubCategory = "";
      selectedCategory = categoryId;

    });
  }
  Future getCategories() async {

    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("category").get();
    for (var doc in data1.docs) {
      categoryIdFromName[doc.get('name')]=doc.get('categoryId');
      categoryDetails[doc.get('categoryId')]=doc.get('name');
      fetchedCategories.add(DropdownMenuItem(
        child: Text(doc.get('name')),
        value: doc.get('name').toString(),
      ));
    }
    if(mounted){
      setState(() {
      });
    }
  }

  setSearchParam(String caseNumber) {
    List <String> caseSearchList = [];
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
  int? selectedIndex;
  List datas = [
    'Update',
    'Image',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor:primaryColor,
          automaticallyImplyLeading: true,
          title: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit()));
            },
            child: Text(
              'Edit Product',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white
              ),
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
        body: SafeArea(
            child: Column(children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Material(
                      color: Colors.transparent,
                      elevation: 5,
                      child: Container(
                        width: 550,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              color: Color(0xFFF1F4F8),
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SingleChildScrollView(
                                controller: scroll,
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children:
                                    List.generate(datas.length, (index) {
                                      return Padding(
                                        padding:
                                        const EdgeInsets.only(right: 10),
                                        child: InkWell(
                                          onTap: () {
                                            selectedIndex = index;

                                            setState(() {});
                                          },
                                          child: Container(
                                            width: 90,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              color: selectedIndex == index
                                                  ? Colors.teal
                                                  : Color(0xFFF1F4F8),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  color: Color(0x3B000000),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 4, 4, 4),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      datas[index],
                                                      style: TextStyle(
                                                        fontFamily:
                                                        'Lexend Deca',
                                                        color: selectedIndex ==
                                                            index
                                                            ? Colors.white
                                                            : Color(0xFF090F13),
                                                        fontSize: 9,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

             selectedIndex==0? Expanded(
                  child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance.collection('products').doc(widget.productId).snapshots(),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        // List<NewProductsRecord>
                        //     editproductNewProductsRecordList =
                        //     snapshot.data;
                        // Customize what your widget looks like with no query results.
                        if (!snapshot.data!.exists) {
                          return Text('No Data');
                          // For now, we'll just include some dummy data.

                        }
                        var productMap= snapshot.data!;
                        productName.text =
                            snapshot.data!.get('name');
                        madefrom.text=snapshot.data!.get('madeFrom');

                        productCode.text=snapshot.data!.get('productCode');
                        weight.text=snapshot.data!.get('weight').toString();
                        gst.text=snapshot.data!.get('gst').toString();
                        productIncredient.text =
                            snapshot.data!.get('ingredients');
                        productDescription!.text =
                            snapshot.data!.get('description');
                        productPrice.text =
                            snapshot.data!.get('b2cP').toString();
                        discountPriceController.text =
                            snapshot.data!.get('b2cD').toString();
                        b2bP.text=snapshot.data!.get('b2bP').toString();
                        b2bd.text=snapshot.data!.get('b2bD').toString();

                        stock.text=snapshot.data!.get('stock').toString();
                        sold.text=snapshot.data!.get('sold').toString();
                        hsnCode.text=snapshot.data!.get('hsnCode').toString();
                        fact.text=
                            snapshot.data!.get('fact');
                        instructions.text=snapshot.data!.get('intructions');
                        images = snapshot.data!.get('imageId').toList();
                        videos = snapshot.data!.get('videoUrl').toList();


                          B2C_tierPrice=snapshot.data!.get('b2cTier');

                          B2B_tierPrice=snapshot.data!.get('b2bTier');

                        if(loaded==false){
                          loaded=true;
                          b2b=snapshot.data!.get('b2b');
                          b2c=snapshot.data!.get('b2c');
                          available=snapshot.data!.get('available');

                          imported=snapshot.data!.get('imported');
                          payOnDelivery=snapshot.data!.get('payOnDelivery');
                          // organic=snapshot.data.get('organic');

                        }



                        if(radioButtonitem==''){
                          radioButtonitem=snapshot.data!.get('veg')==true?'Veg':'Non Veg';
                        }





                        if(selectedCategory==null||selectedCategory==''){
                          selectedCategory =
                          categoryDetails[snapshot.data!.get('category')];
                        }
                        if(selectedBrand==null||selectedBrand==""){
                          selectedBrand=brandDetails[snapshot.data!.get('brand')];


                        }







                        //

                        uploadedFileUrl1 =
                        snapshot.data!.get('imageId').length == 0
                            ? ""
                            : snapshot.data!.get('imageId')[0];
                        videoUrl=snapshot.data!.get('videoUrl').length==0
                            ? ""
                            :snapshot.data!.get('videoUrl')[0];



                        if(productsList.length==0){
                          productsList=snapshot.data!.get('relatedProducts').toList();

                        }


                        // _selectedCuisine= snapshot.data.get('cuisine').toList();

                        startController.text=snapshot.data!.get('start').toString();
                        stepController.text=snapshot.data!.get('step').toString();
                        stopController.text=snapshot.data!.get('stop').toString();

                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [
                              Builder(
                                builder: (context) {
                                  return Container(
                                    width:
                                    MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.3,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: PageView.builder(
                                            controller:
                                            pageViewController,
                                            scrollDirection:
                                            Axis.horizontal,
                                            itemCount: images.length,
                                            itemBuilder:
                                                (context, imagesIndex) {
                                              final imagesItem =
                                              images[imagesIndex];

                                              // return Image.network(
                                              //   imagesItem,
                                              //   width: 100,
                                              //   height: 100,
                                              //   fit: BoxFit.cover,
                                              // );
                                              return CachedNetworkImage(
                                                imageUrl: imagesItem,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  // Text('Organic'),
                                  //
                                  // Switch(
                                  //   value: organic,
                                  //   onChanged: (value) {
                                  //     setState(() {
                                  //       organic = value;
                                  //     });
                                  //   },
                                  // ),
                                  Text('Avaialble'),

                                  Switch(
                                    value: available,
                                    onChanged: (value) {
                                      setState(() {
                                        available = value;
                                      });
                                    },
                                  ),

                                ],
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
                                            controller: productName,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Product Name',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              hintText:
                                              'enter your product name',
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
                                              labelStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              hintText:
                                              'enter your product Code',
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

                              // SearchableDropdown.single(
                              //   items: fetchedCategories,
                              //   value: selectedCategory,
                              //   hint: "Select Category",
                              //   searchHint: "Select Category",
                              //   onChanged: (value) {
                              //     selectedCategory = value;
                              //     setState(() {
                              //       selectedCategory = value;
                              //     });
                              //     getSubCategoriesByCategory(value);
                              //   },
                              //   isExpanded: true,
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
                                            controller: productIncredient,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Ingredients',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                              hintText:
                                              'product Ingredients',
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
                                            controller: fact,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Nutrition Fact',
                                              labelStyle:TextStyle(
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
                                              labelStyle: TextStyle(
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
                                              labelText: 'Made From',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              hintText: 'madefrom',
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
                                        onChanged: (String? val){
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
                                            controller: productPrice,
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
                                            controller: discountPriceController,
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
                                  ],
                                ),
                              ),
                              !b2c?Container():  Column(
                                  children: List.generate(groupNames.length, (index) {
                                    productPricing['b2c'+groupNames[index]+'P']=productMap['b2c'+groupNames[index]+'P'];
                                    productPricing['b2c'+groupNames[index]+'D']=productMap['b2c'+groupNames[index]+'D'];
                                    TextEditingController groupPrice$index=TextEditingController(text: productMap['b2c'+groupNames[index]+'P'].toString());
                                    TextEditingController groupDiscountPrice$index=TextEditingController(text:productMap['b2c'+groupNames[index]+'D'].toString());


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
                                                      onChanged : (text){
                                                        productPricing['b2c'+groupNames[index]+'D']=double.tryParse(text);

                                                      },
                                                      controller: groupDiscountPrice$index,
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

                                      ],
                                    );
                                  })
                              ),
                              !b2b?Container():  Column(
                                  children: List.generate(groupNames.length, (index) {
                                    productPricing['b2b'+groupNames[index]+'P']=productMap['b2b'+groupNames[index]+'P'];
                                    productPricing['b2b'+groupNames[index]+'D']=productMap['b2b'+groupNames[index]+'D'];
                                    TextEditingController groupPrice$index=TextEditingController(text: productMap['b2b'+groupNames[index]+'P'].toString());
                                    TextEditingController groupDiscountPrice$index=TextEditingController(text:productMap['b2b'+groupNames[index]+'D'].toString());

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
                                                      controller: groupPrice$index,
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
                                                      style:TextStyle(
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
                                                      controller: groupDiscountPrice$index,
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
                                              labelStyle: TextStyle(
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
                                            keyboardType: TextInputType.text,

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
                                              labelStyle:TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              hintText: 'Product Weight',
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
                                              labelStyle:TextStyle(
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
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: B2C_tierPrice.length+1,
                                      itemBuilder: (context,index){
                                        TextEditingController admin$index=TextEditingController();
                                        // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                        String name=index==(B2C_tierPrice.length)?"":B2C_tierPrice[index]['name'];
                                        String price=index==(B2C_tierPrice.length)?"":B2C_tierPrice[index]['price'];
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

                                                        if(index==(B2C_tierPrice.length)){
                                                          Map<String,dynamic> selected=  await    showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return B2cDialogue();
                                                              });
                                                          if(selected!=null) {
                                                            B2C_tierPrice.add(selected);
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

                                                          B2C_tierPrice.removeAt(index);
                                                          setState(() {

                                                          });

                                                        }

                                                      }, icon: index==(B2C_tierPrice.length)?Icon(Icons.add):
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
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: B2B_tierPrice.length+1,
                                      itemBuilder: (context,index){
                                        TextEditingController admin$index1=TextEditingController();
                                        // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                        String name=index==(B2B_tierPrice.length)?"":B2B_tierPrice[index]['name'];
                                        String price=index==(B2B_tierPrice.length)?"":B2B_tierPrice[index]['price'];
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

                                                        if(index==(B2B_tierPrice.length)){
                                                          Map<String,dynamic> selected1=  await    showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return B2bDialogue();
                                                              });
                                                          if(selected1!=null) {
                                                            B2B_tierPrice.add(selected1);
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

                                                          B2B_tierPrice.removeAt(index);
                                                          setState(() {

                                                          });

                                                        }

                                                      }, icon: index==(B2B_tierPrice.length)?Icon(Icons.add):
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
                                    if(productPricing['b2b'+group+'Tier']==null){
                                      productPricing['b2b'+group+'Tier']=productMap['b2b'+group+'Tier'];
                                    }
                                    List tierPricing$index=productPricing['b2b'+group+'Tier']??[];
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
                                                                            return B2bDelhiDialogue(groupName: group,b2b: true,);
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
                                    if(productPricing['b2c'+group+'Tier']==null){
                                      productPricing['b2c'+group+'Tier']=productMap['b2c'+group+'Tier'];
                                    }
                                    List tierPricing$index=productPricing['b2c'+group+'Tier']??[];

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
                                                                            return B2bDelhiDialogue(groupName: group,b2b: false,);
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
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Text('B2B Delhi Tier Price',
                              //     style: TextStyle(fontWeight: FontWeight.w600),),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.fromLTRB(10,10,10,0),
                              //   child: Container(
                              //
                              //     child: ListView.builder(
                              //         physics: NeverScrollableScrollPhysics(),
                              //         shrinkWrap: true,
                              //         padding: EdgeInsets.zero,
                              //         scrollDirection: Axis.vertical,
                              //         itemCount: B2B_Delhi_tierPrice.length+1,
                              //         itemBuilder: (context,index){
                              //           TextEditingController admin$index1=TextEditingController();
                              //           // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                              //           String name=index==(B2B_Delhi_tierPrice.length)?"":B2B_Delhi_tierPrice[index]['name'];
                              //           String price=index==(B2B_Delhi_tierPrice.length)?"":B2B_Delhi_tierPrice[index]['price'];
                              //           return    Padding(
                              //             padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              //             child: Container(
                              //               width: 350,
                              //               height: 50,
                              //               decoration: BoxDecoration(
                              //                 color: Colors.white,
                              //                 borderRadius: BorderRadius.circular(10),
                              //                 border: Border.all(
                              //                   color: Color(0x8A242222),
                              //                 ),
                              //               ),
                              //               child: Padding(
                              //                 padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              //                 child: Row(
                              //                   mainAxisSize: MainAxisSize.max,
                              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     Text(name),
                              //                     Text(price),
                              //
                              //                     IconButton(
                              //                         onPressed: () async {
                              //
                              //                           if(index==(B2B_Delhi_tierPrice.length)){
                              //                             Map<String,dynamic> selected1=  await    showDialog(
                              //                                 context: context,
                              //                                 builder: (context) {
                              //                                   return B2bDelhiDialogue();
                              //                                 });
                              //                             if(selected1!=null) {
                              //                               B2B_Delhi_tierPrice.add(selected1);
                              //                             }
                              //                             setState(() {
                              //                               // addon.add({
                              //                               // 'addOn':admins1[index]['addOn'],
                              //                               //   'addOnArabic':admins1[index]['addOnArabic'],
                              //                               //   'imageUrl':admins1[index]['imageUrl']
                              //                               // });
                              //                               // print(addon.length);
                              //
                              //                             });
                              //                           }else
                              //                           {
                              //
                              //                             B2B_Delhi_tierPrice.removeAt(index);
                              //                             setState(() {
                              //
                              //                             });
                              //
                              //                           }
                              //
                              //                         }, icon: index==(B2B_Delhi_tierPrice.length)?Icon(Icons.add):
                              //                     Icon(Icons.delete))
                              //                   ],
                              //                 ),
                              //               ),
                              //             ),
                              //           );
                              //         }),
                              //   ),
                              // ),comment
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 0.0),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.fromLTRB(10,10,10,0),
                              //   child: Container(
                              //     height: MediaQuery.of(context).size.height*0.2,
                              //     child: ListView.builder(
                              //         physics: BouncingScrollPhysics(),
                              //         padding: EdgeInsets.zero,
                              //         scrollDirection: Axis.vertical,
                              //         itemCount: variants.length+1,
                              //         itemBuilder: (context,index){
                              //           TextEditingController admin$index1=TextEditingController();
                              //           // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                              //           String name=index==(variants.length)?"":variants[index]['name'];
                              //           String price=index==(variants.length)?"":variants[index]['price'];
                              //           return    Padding(
                              //             padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              //             child: Container(
                              //               width: 350,
                              //               height: 50,
                              //               decoration: BoxDecoration(
                              //                 color: Colors.white,
                              //                 borderRadius: BorderRadius.circular(10),
                              //                 border: Border.all(
                              //                   color: Color(0x8A242222),
                              //                 ),
                              //               ),
                              //               child: Padding(
                              //                 padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              //                 child: Row(
                              //                   mainAxisSize: MainAxisSize.max,
                              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     Text(name),
                              //                     Text(price),
                              //
                              //                     IconButton(
                              //                         onPressed: () async {
                              //
                              //                           if(index==(variants.length)){
                              //                             Map<String,dynamic> selected1=  await    showDialog(
                              //                                 context: context,
                              //                                 builder: (context) {
                              //                                   return DialogBox1();
                              //                                 });
                              //                             if(selected1!=null) {
                              //                               variants.add(selected1);
                              //                             }
                              //                             setState(() {
                              //                               // addon.add({
                              //                               // 'addOn':admins1[index]['addOn'],
                              //                               //   'addOnArabic':admins1[index]['addOnArabic'],
                              //                               //   'imageUrl':admins1[index]['imageUrl']
                              //                               // });
                              //                               // print(addon.length);
                              //
                              //                             });
                              //                           }else
                              //                           {
                              //
                              //                             variants.removeAt(index);
                              //                             setState(() {
                              //
                              //                             });
                              //
                              //                           }
                              //
                              //                         }, icon: index==(variants.length)?Icon(Icons.add):
                              //                     Icon(Icons.delete))
                              //                   ],
                              //                 ),
                              //               ),
                              //             ),
                              //           );
                              //         }),
                              //   ),
                              // ),
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
                              //         allItems: products,
                              //         initValue: productsList,
                              //         hintText: 'Select Related Products',
                              //         selectCallback: (List selectedValue) =>
                              //         productsList = selectedValue,
                              //       )
                              //   ),
                              // ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 0.0),
                              ),
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 16, 0, 0),
                                      child: FFButtonWidget(
                                        icon :Icon(Icons.save),
                                        onPressed: () async {
                                          final name =
                                              productName.text;

                                          if (name == "" ||
                                              name == null) {
                                            showUploadMessage(context,
                                                "please enter product name");
                                          } else if (uploadedFileUrl1 ==
                                              "" ||
                                              uploadedFileUrl1 ==
                                                  null) {
                                            showUploadMessage(context,
                                                "please choose a product image");
                                          }

                                          else {
                                            bool proceed = await alert(
                                                context,
                                                'You want to upload this product?');

                                            if (proceed) {
                                              Map<String,dynamic> pMap= {
                                                'name': name,
                                                'madeFrom':madefrom.text,
                                                'b2c':b2c,
                                                'b2b':b2b,
                                                'imported':imported,
                                                'productCode':productCode.text,
                                                'description':productDescription.text,
                                                'available':available,
                                                'payOnDelivery':payOnDelivery,

                                                // 'organic':organic,
                                                'veg': radioButtonitem=='Veg'?true:false,
                                                'ingredients': productIncredient.text,
                                                'relatedProducts':productsList,
                                                'b2cP': double.tryParse(productPrice.text)??0,
                                                'b2cD': double.tryParse(discountPriceController.text)??0,
                                                'b2bP': double.tryParse(b2bP.text)??0,
                                                'b2bD': double.tryParse(b2bd.text)??0,
                                                'stock': int.tryParse(stock.text)??0,
                                                'sold': int.tryParse(sold.text)??0,
                                                'hsnCode': int.tryParse(hsnCode.text)??0,
                                                'gst':double.tryParse(gst.text)??0,
                                                'fact':fact.text,
                                                'weight':double.tryParse(weight.text)??0,
                                                'category': categoryIdFromName[selectedCategory],
                                                'categoryName': selectedCategory,
                                                'intructions':instructions.text,
                                                'brand':brand[selectedBrand],
                                                'search': setSearchParam(name),
                                                'b2cTier':B2C_tierPrice,
                                                'b2bTier':B2B_tierPrice,
                                                'start': double.tryParse(startController.text)??0,
                                                'step': double.tryParse(stepController.text)??0,
                                                'stop': double.tryParse(stopController.text)??0,
                                                'imageId': FieldValue.arrayUnion(
                                                    [uploadedFileUrl1]),
                                                'videoUrl': FieldValue.arrayUnion([videoUrl]),
                                              };
                                              for(String key in productPricing.keys){
                                                pMap[key]=productPricing[key];
                                              }
                                              snapshot.data?.reference.update(pMap).then((value) {

                                                getUsers(widget.productId??'');

                                              });
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              showUploadMessage(context, 'Product Updated..');


                                            }
                                          }
                                        },
                                        text: 'Update',
                                        options: FFButtonOptions(
                                          width: 150,
                                          height: 60,
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
                                    // Align(
                                    //   alignment: Alignment(0.95, 0),
                                    //   child: Padding(
                                    //     padding: EdgeInsets.fromLTRB(
                                    //         0, 16, 0, 0),
                                    //     child: FFButtonWidget(
                                    //       icon :Icon(Icons.delete),
                                    //       onPressed: () async {
                                    //         // final name = textController1.text;
                                    //         // final description = textController2.text;
                                    //         // final price =
                                    //         // double.parse(textController3.text);
                                    //         // final userId = currentUserUid;
                                    //
                                    //         bool proceed = await alert(
                                    //             context,
                                    //             'You want to delete this product?');
                                    //
                                    //         if (proceed) {
                                    //
                                    //           await NewProductsRecord
                                    //               .collection
                                    //               .doc(widget.productId)
                                    //               .delete();
                                    //           showUploadMessage(context, 'Delete Success!');
                                    //
                                    //         }
                                    //       },
                                    //       text: 'Delete',
                                    //       options: FFButtonOptions(
                                    //         width: 150,
                                    //         height: 60,
                                    //         color: FlutterFlowTheme
                                    //             .primaryColor,
                                    //         textStyle: FlutterFlowTheme
                                    //             .subtitle2
                                    //             .override(
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
                                    // )
                                  ]),
                              SizedBox(height: 20.0,)
                            ],
                          ),
                        );
                      })):  Expanded(
                 child: StreamBuilder<DocumentSnapshot>(
                     stream: FirebaseFirestore.instance.collection('products').doc(widget.productId).snapshots(),
                     builder: (context, snapshot) {
                       // Customize what your widget looks like when it's loading.
                       if (!snapshot.hasData) {
                         return Center(child: CircularProgressIndicator());
                       }
                       // List<NewProductsRecord>
                       //     editproductNewProductsRecordList =
                       //     snapshot.data;
                       // Customize what your widget looks like with no query results.
                       if (!snapshot.data!.exists) {
                         return Text('No Data');
                         // For now, we'll just include some dummy data.

                       }


                       images = snapshot.data?.get('imageId').toList();
                       videos = snapshot.data?.get('videoUrl').toList();

















                       //

                       uploadedFileUrl1 =
                       snapshot.data?.get('imageId').length == 0
                           ? ""
                           : snapshot.data?.get('imageId')[0];
                       videoUrl=snapshot.data?.get('videoUrl').length==0
                           ? ""
                           :snapshot.data?.get('videoUrl')[0];

                       return ListView(
                           shrinkWrap: true,
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                           context, 'Uploading file...',
                                           showLoading: true);
                                       final downloadUrl = await uploadData(
                                           selectedMedia.storagePath,
                                           selectedMedia.bytes);
                                       await FirebaseFirestore.instance
                                           .collection('products')
                                           .doc(widget
                                           .productId)
                                           .update({
                                         'imageId': FieldValue.arrayUnion(
                                             [downloadUrl]),
                                       }).then((value) {
                                         setState(() {
                                           images.add(downloadUrl);
                                         });
                                       });
                                       ScaffoldMessenger.of(context)
                                           .hideCurrentSnackBar();
                                       if (downloadUrl != null) {
                                         setState(() =>
                                         uploadedFileUrl1 = downloadUrl);
                                         showUploadMessage(context, 'Success!');
                                       } else {
                                         showUploadMessage(
                                             context, 'Failed to upload media');
                                       }
                                     }
                                   },
                                   icon: Icon(
                                     Icons.image,
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
                                       await FirebaseFirestore.instance
                                           .collection('products')
                                           .doc(widget
                                           .productId)
                                           .update({
                                         'videoUrl': FieldValue.arrayUnion(
                                             [downloadUrl]),
                                       }).then((value) {
                                         setState(() {
                                           videos.add(downloadUrl);
                                         });
                                       });
                                       ScaffoldMessenger.of(context)
                                           .hideCurrentSnackBar();
                                       if (downloadUrl != null) {
                                         setState(() =>
                                         videoUrl = downloadUrl);
                                         print(videoUrl);
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
                             Text('Images',style:TextStyle(
                                 fontSize: 20,fontWeight: FontWeight.bold
                             ),textAlign: TextAlign.center,),
                             Container(

                               child: GridView.builder(
                                 padding: EdgeInsets.zero,
                                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                   crossAxisCount: 4,
                                   crossAxisSpacing: 15,
                                   mainAxisSpacing: 15,
                                   childAspectRatio: 1
                                 ),
                                 physics: NeverScrollableScrollPhysics(),

                                 shrinkWrap: true,
                                 itemCount: images.length,
                                 itemBuilder: (context, listViewIndex) {
                                   imagesItem = images[listViewIndex];

                                   return Card(
                                     elevation: 5,
                                     child: Container(
                                       decoration: BoxDecoration(
                                         image: DecorationImage(
                                           image: NetworkImage(imagesItem),
                                           fit: BoxFit.cover
                                         )
                                       ),
                                       child: Align(
                                         alignment: Alignment.topRight,
                                         child: Padding(
                                           padding: const EdgeInsets.all(15.0),
                                           child: Container(
                                             decoration: BoxDecoration(
                                               color: Colors.red.withOpacity(0.5),
                                               shape: BoxShape.circle
                                             ),
                                             child: Padding(
                                               padding: const EdgeInsets.all(7.5),
                                               child: IconButton(
                                                 onPressed: () async {
                                                   await FirebaseFirestore.instance
                                                       .collection('products')
                                                       .doc(
                                                       widget.productId)
                                                       .update({
                                                     'imageId': FieldValue.arrayRemove(
                                                         [imagesItem]),
                                                   }).then((value) {
                                                     FirebaseStorage.instance
                                                         .refFromURL(imagesItem)
                                                         .delete();
                                                     setState(() {
                                                       images.remove(imagesItem);
                                                     });
                                                   });
                                                 },
                                                 icon: Icon(
                                                   Icons.delete,
                                                   color: Colors.black,
                                                   size: 30,
                                                 ),
                                                 iconSize: 30,
                                               ),
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                   );
                                   //   Container(
                                   //   color: Colors.red,
                                   //   child: ListTile(
                                   //     title: Image.network(
                                   //       imagesItem,
                                   //
                                   //       fit: BoxFit.cover,
                                   //     ),
                                   //     trailing: IconButton(
                                   //       onPressed: () async {
                                   //         await FirebaseFirestore.instance
                                   //             .collection('products')
                                   //             .doc(
                                   //             widget.productId)
                                   //             .update({
                                   //           'imageId': FieldValue.arrayRemove(
                                   //               [imagesItem]),
                                   //         }).then((value) {
                                   //           FirebaseStorage.instance
                                   //               .refFromURL(imagesItem)
                                   //               .delete();
                                   //           setState(() {
                                   //             images.remove(imagesItem);
                                   //           });
                                   //         });
                                   //       },
                                   //       icon: Icon(
                                   //         Icons.delete,
                                   //         color: Colors.black,
                                   //         size: 30,
                                   //       ),
                                   //       iconSize: 30,
                                   //     ),
                                   //   ),
                                   // );
                                   // return CachedNetworkImage(
                                   //   imageUrl:imagesItem,
                                   //   width: 100,
                                   //   height: 100,
                                   //   fit: BoxFit.cover,
                                   // );
                                 },
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(top: 10),
                               child: Text('Videos',style:TextStyle(
                                   fontSize: 20,fontWeight: FontWeight.bold
                               ),textAlign: TextAlign.center,),
                             ),
                             Container(

                               child: GridView.builder(
                                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                     crossAxisCount: 4,
                                     crossAxisSpacing: 15,
                                     mainAxisSpacing: 15,
                                     childAspectRatio: 1
                                 ),
                                 padding: EdgeInsets.zero,
                                 physics: NeverScrollableScrollPhysics(),
                                 scrollDirection: Axis.vertical,
                                 shrinkWrap: true,
                                 itemCount: videos.length,
                                 itemBuilder: (context, listViewIndex) {
                                   final video = videos[listViewIndex];
                                   return ListTile(
                                     title:  InkWell(
                                       onTap: ()
                                       {
                                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoViewer(
                                         //   video: video,
                                         // )));
                                       },
                                       child: Container(
                                         height: 150,
                                         decoration: BoxDecoration(
                                             image: DecorationImage(
                                               fit: BoxFit.fill,
                                               image: Image.network(
                                                   imagesItem,height: 100).image,
                                             )

                                         ),
                                         child: Center(child: Icon(Icons.play_circle_outline,size: 50,color: Colors.white,)),
                                       ),
                                     ),
                                     trailing: IconButton(
                                       onPressed: () async {
                                         await FirebaseFirestore.instance
                                             .collection('products')
                                             .doc(
                                             widget.productId)
                                             .update({
                                           'videoUrl': FieldValue.arrayRemove(
                                               [video]),
                                         }).then((value) {
                                           FirebaseStorage.instance
                                               .refFromURL(video)
                                               .delete();
                                           setState(() {
                                             videos.remove(video);
                                           });
                                         });
                                       },
                                       icon: Icon(
                                         Icons.delete,
                                         color: Colors.black,
                                         size: 30,
                                       ),
                                       iconSize: 30,
                                     ),
                                   );
                                   // return CachedNetworkImage(
                                   //   imageUrl:imagesItem,
                                   //   width: 100,
                                   //   height: 100,
                                   //   fit: BoxFit.cover,
                                   // );
                                 },
                               ),
                             )
                           ]);
                     }))
            ])));
  }
}
