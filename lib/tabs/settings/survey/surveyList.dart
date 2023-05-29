import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/button.dart';
import '../../dashboard/dashboard.dart';
import '../../orders/b2c/detailsPage.dart';
import 'dataList.dart';
import 'editSurvey.dart';

class SurveyList extends StatefulWidget {
  SurveyList({Key? key}) : super(key: key);

  @override
  _SurveyListState createState() => _SurveyListState();
}

class _SurveyListState extends State<SurveyList> {
  List students = [];
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
          .where('orderStatus', isGreaterThan: 2)
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(limit)
          .snapshots();
    } else {
      ind += limit;
      userStream = FirebaseFirestore.instance
          .collection("orders")
          .where('orderStatus', isGreaterThan: 2)
          .limit(limit)
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
          .where('orderStatus', isGreaterThan: 2)
          .limit(limit)
          .snapshots();
    } else {
      ind -= limit;
      userStream = FirebaseFirestore.instance
          .collection("orders")
          .where('orderStatus', isGreaterThan: 2)
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(limit)
          .snapshots();
    }
    setState(() {});
  }


  Map<int, DocumentSnapshot> lastDocuments = {};
  List<QueryDocumentSnapshot>? data;
  int pageIndex = 0;
  var lastDoc;
  var firstDoc;
  int limit = 20;
  int? selectedIndex = 0;
  Timestamp? datePicked1;
  Timestamp? datePicked2;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  final scroll = ScrollController();
  @override
  void initState() {
    super.initState();
    DateTime time = DateTime.now();
    datePicked1 =
        Timestamp.fromDate(DateTime(time.year, time.month, time.day, 0, 0, 0));
    datePicked2 = Timestamp.fromDate(
        DateTime(time.year, time.month, time.day, 23, 59, 59));
    selectedIndex = 0;
    userStream = FirebaseFirestore.instance
        .collection('survey').where('delete',isEqualTo: false).orderBy('date',descending: true)
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
                        'Survey List',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
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
                    data = snapshot.data!.docs;
                    if (data!.isNotEmpty) {
                      lastDoc = snapshot.data?.docs[data!.length - 1];
                      lastDocuments[pageIndex] = lastDoc;
                      firstDoc = snapshot.data?.docs[0];
                    }
                    // data?.sort((a,b){
                    //   return b['placedDate'].compareTo(a['placedDate']);
                    // }
                    return data!.isEmpty
                        ? LottieBuilder.network(
                      'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                      height: 500,
                    )
                        : Column(
                      children: [
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
                                label: Text(
                                  "Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "View",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ),
                              DataColumn(
                                label: Text("Edit",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11)),
                              ),
                            ],
                            rows: List.generate(
                              data!.length,
                                  (index) {
                                String name = data![index]
                              ['title'];
                                Timestamp placedDate =
                                data![index]['date'];
                                return DataRow(
                                  color: index.isOdd
                                      ? MaterialStateProperty.all(Colors
                                      .blueGrey.shade50
                                      .withOpacity(0.7))
                                      : MaterialStateProperty.all(
                                      Colors.blueGrey.shade50),
                                  cells: [
                                    DataCell(Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
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
                                    DataCell(SelectableText(
                                      name,
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                    DataCell(
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SurveyDataList(
                                                id:data![index]['id'],
                                                name:data![index]['title'],
                                              )));
                                              print(data![index].id);
                                            },
                                            child: Container(
                                                height: 30,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(12),
                                                    border: Border.all(
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                            0.3))),
                                                alignment:
                                                Alignment.center,
                                                child: Text(
                                                  'View',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.white),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditSurvey(
                                                            id: data![
                                                            index]
                                                                ['id'],
                                                          )));
                                              print(data![index].id);
                                            },
                                            child: Container(
                                                height: 30,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(12),
                                                    border: Border.all(
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                            0.3))),
                                                alignment:
                                                Alignment.center,
                                                child: Text(
                                                  'Action',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.white),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
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
                                      borderRadius:
                                      BorderRadius.circular(
                                          10)),
                                  child: Center(
                                      child: Text('Previous')),
                                ),
                              ),
                              (lastDoc == null && pageIndex != 0) ||
                                  data!.length < limit
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
                                      borderRadius:
                                      BorderRadius.circular(
                                          10)),
                                  child:
                                  Center(child: Text('Next')),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
