import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tharacart_web/tabs/orders/returnOrders/returnOrdersDetails.dart';
import '../../../../widgets/button.dart';
import '../../widgets/uploadmedia.dart';
import '../dashboard/dashboard.dart';
import '../products/addCategory/editCategory.dart';


class AdminUsers extends StatefulWidget {
  const AdminUsers({Key? key}) : super(key: key);

  @override
  _AdminUsersState createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  late TextEditingController search = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Stream<QuerySnapshot>? userStream;
  bool nxtVal = false;
  int ind = 0;
  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {
      ind = 0;
      userStream = FirebaseFirestore.instance
          .collection("orders")
          .where('orderStatus', isEqualTo: selectedIndex)
          .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
          .where('placedDate', isLessThanOrEqualTo: datePicked2)
          .orderBy('placedDate', descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(limit)
          .snapshots();
    } else {
      ind += limit;
      userStream = FirebaseFirestore.instance
          .collection("orders")
          .where('orderStatus', isEqualTo: selectedIndex)
          .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
          .where('placedDate', isLessThanOrEqualTo: datePicked2)
          .orderBy('placedDate', descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .startAfterDocument(lastDoc)
          .snapshots();
    }
    setState(() {});
  }

  prev() {
    pageIndex--;
    if (firstDoc == null || pageIndex == 0) {
      ind = 0;
      userStream = FirebaseFirestore.instance
          .collection("orders")
          .where('orderStatus', isEqualTo: selectedIndex)
          .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
          .where('placedDate', isLessThanOrEqualTo: datePicked2)
          .orderBy('placedDate', descending: true)
          .limit(limit)
          .snapshots();
    } else {
      ind -= limit;
      userStream = FirebaseFirestore.instance
          .collection("orders")
          .where('orderStatus', isEqualTo: selectedIndex)
          .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
          .where('placedDate', isLessThanOrEqualTo: datePicked2)
          .orderBy('placedDate', descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(limit)
          .snapshots();
    }
    setState(() {});
  }

  List datas = [
    'Pending',
    'Approved',
    'Deleted',
  ];

  Map<int, DocumentSnapshot> lastDocuments = {};
  List data = [];
  int pageIndex = 0;
  var lastDoc;
  var firstDoc;
  int limit = 20;
  int selectedIndex = 0;
  Timestamp? datePicked1;
  Timestamp? datePicked2;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    userStream = FirebaseFirestore.instance
        .collection('admin_users')
        .where('verified', isNotEqualTo: true)
        .where('delete', isEqualTo: false)
        .orderBy('verified', descending: true)
        .orderBy('created_time', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: scroll,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Admin Users',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
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
                                            if (selectedIndex == 0) {
                                              userStream = FirebaseFirestore
                                                  .instance
                                                  .collection('admin_users')
                                                  .where('verified',
                                                      isNotEqualTo: true)
                                                  .where('delete',
                                                      isEqualTo: false)
                                                  .orderBy('verified',
                                                      descending: true)
                                                  .orderBy('created_time',
                                                      descending: true)
                                                  .snapshots();
                                            } else if (selectedIndex == 1) {
                                              userStream = FirebaseFirestore
                                                  .instance
                                                  .collection('admin_users')
                                                  .where('verified',
                                                      isEqualTo: true)
                                                  .orderBy('created_time',
                                                      descending: true)
                                                  .snapshots();
                                            } else if (selectedIndex == 2) {
                                              userStream = FirebaseFirestore
                                                  .instance
                                                  .collection('admin_users')
                                                  .where('delete',
                                                      isEqualTo: true)
                                                  .orderBy('created_time',
                                                      descending: true)
                                                  .snapshots();
                                            }
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
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Container(
                      width: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color(0x39000000),
                            offset: Offset(0, 1),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                                child: TextFormField(
                                  controller: search,
                                  obscureText: false,
                                  onChanged: (text) {},
                                  decoration: InputDecoration(
                                    labelText: 'Search ',
                                    hintText: 'Please Enter Name',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF7C8791),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF090F13),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  search.clear();
                                  userStream = FirebaseFirestore.instance
                                      .collection("orders")
                                      .where('orderStatus',
                                          isEqualTo: selectedIndex)
                                      .where('placedDate',
                                          isGreaterThanOrEqualTo: datePicked1)
                                      .where('placedDate',
                                          isLessThanOrEqualTo: datePicked2)
                                      .orderBy('placedDate', descending: true)
                                      .limit(limit)
                                      .snapshots();
                                  setState(() {});
                                },
                                text: 'Clear',
                                options: FFButtonOptions(
                                  width: 100,
                                  height: 40,
                                  color: Color(0xFF4B39EF),
                                  textStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  elevation: 2,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: userStream,
                  builder: (context, snapshot) {
                    print(snapshot.error);
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    data = [];
                    data = snapshot.data!.docs;
                    if (data.length != 0) {
                      print(data.length);
                      lastDoc = snapshot.data?.docs[data.length - 1];
                      lastDocuments[pageIndex] = lastDoc;
                      firstDoc = snapshot.data?.docs[0];
                    }
                    return data.length == 0
                        ? LottieBuilder.network(
                            'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                            height: 500,
                          )
                        : SizedBox(
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
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                ),
                                DataColumn(
                                  label: Text("Date",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11)),
                                ),
                                DataColumn(
                                  label: Text("Profile",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11)),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                ),
                                DataColumn(
                                  label: Text("Email",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11)),
                                ),
                                DataColumn(
                                  label: Text("View",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11)),
                                ),
                              ],
                              rows: List.generate(
                                data.length,
                                (index) {
                                  String name = data[index]['display_name'];
                                  String email = data[index]['email'];
                                  String image =
                                      data[index]['photo_url'].toString();
                                  Timestamp placedDate =
                                      data[index]['created_time'];
                                  return DataRow(
                                    color: index.isOdd
                                        ? MaterialStateProperty.all(Colors
                                            .blueGrey.shade50
                                            .withOpacity(0.7))
                                        : MaterialStateProperty.all(
                                            Colors.blueGrey.shade50),
                                    cells: [
                                      DataCell(Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                        child: SelectableText(
                                          (ind == 0
                                                  ? index + 1
                                                  : ind + index + 1)
                                              .toString(),
                                          style: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                      DataCell(SelectableText(
                                        DateFormat("dd-MM-yyyy")
                                            .format(placedDate.toDate()),
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(InkWell(
                                        onTap: () async {
                                          await showDialog(
                                              barrierDismissible: true,
                                              context: context,
                                              builder: (buildContext) {
                                                return AlertDialog(
                                                  insetPadding:
                                                      EdgeInsets.all(12),
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
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text('back')),
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
                                        name,
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(SelectableText(
                                        email,
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(
                                        selectedIndex == 0
                                            ? ElevatedButton(
                                                onPressed: () async {
                                                  bool proceed = await alert(
                                                      context,
                                                      'Do You want to Approve this user  ?');
                                                  if (proceed) {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('branches')
                                                        .doc(currentBranchId)
                                                        .update({
                                                      'admins': FieldValue
                                                          .arrayUnion([
                                                        data[index]['email']
                                                      ]),
                                                    });
                                                  }
                                                },
                                                child: Icon(Icons.add))
                                            : selectedIndex == 1
                                                ? ElevatedButton(
                                                    onPressed: () async {
                                                      bool proceed = await alert(
                                                          context,
                                                          'Do You want to Remove this user  ?');
                                                      if (proceed) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'branches')
                                                            .doc(
                                                                currentBranchId)
                                                            .update({
                                                          'admins': FieldValue
                                                              .arrayRemove([
                                                            data[index]['email']
                                                          ]),
                                                        });
                                                      }
                                                    },
                                                    child: Icon(Icons.delete))
                                                : ElevatedButton(
                                                    onPressed: () async {
                                                      bool proceed = await alert(
                                                          context,
                                                          'Do You want to add pending List ?');
                                                      if (proceed) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'admin_users')
                                                            .doc(data[index]
                                                                ['uid'])
                                                            .update({
                                                          'delete': false
                                                        });
                                                        Navigator.pop(context);
                                                        showUploadMessage(
                                                            context,
                                                            'Successfully Added');
                                                      }
                                                    },
                                                    child: Icon(Icons.add)),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    pageIndex == 0
                        ? SizedBox()
                        : InkWell(
                            onTap: () {
                              prev();
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(child: Text('Previous')),
                            ),
                          ),
                    (lastDoc == null && pageIndex != 0) || data.length < limit
                        ? SizedBox()
                        : InkWell(
                            onTap: () {
                              next();
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(child: Text('Next')),
                            ),
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
