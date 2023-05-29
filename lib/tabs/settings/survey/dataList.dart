import 'dart:convert';
import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tharacart_web/tabs/settings/survey/surveyDetals%20page.dart';

import '../../../../widgets/button.dart';
import '../../../widgets/uploadmedia.dart';
import '../../../widgets/util.dart';
import '../../dashboard/dashboard.dart';

import 'package:universal_html/html.dart' as html;





class SurveyDataList extends StatefulWidget {
  var id;

  var name;

  SurveyDataList({Key? key, this.id, this.name}) : super(key: key);

  @override
  _SurveyDataListState createState() => _SurveyDataListState();
}

class _SurveyDataListState extends State<SurveyDataList> {


  @override
  void initState() {
    super.initState();


  }

  TextEditingController searchController = TextEditingController();
  String? Rmessage;
  int? selectIndex;
  List question=[];
  Future<void> SurveyData() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('survey')
        .doc(widget.id)
        .collection('surveyData')
        .get();

    await FirebaseFirestore.instance
        .collection('survey')
        .doc(widget.id)
        .get()
        .then((value) {
      question = [];
      for (var a in value.data()!['survey']) {
        question.add(a['question']);
      }
    });
    var excel = Excel.createExcel();
    // var excel = Excel.createExcel();
    Sheet sheetObject = excel['survey'];
    // CellStyle cellStyle = CellStyle(
    //     backgroundColorHex: "#1AFF1A",
    //     fontFamily: getFontFamily(FontFamily.Calibri)
    // );
    int i = 2;
    var cell = sheetObject.cell(CellIndex.indexByString("A1"));
    cell.value = 'Date'; // dynamic values support provided;
    // cell.cellStyle = cellStyle;

    var cell1 = sheetObject.cell(CellIndex.indexByString("B1"));
    cell1.value = 'Name'; // dynamic values support provided;
    // cell1.cellStyle = cellStyle;
    var cell2 = sheetObject.cell(CellIndex.indexByString("C1"));
    cell2.value = 'MOBILE'; // dynamic values support provided;
    // cell2.cellStyle = cellStyle;
    var cell3 = sheetObject.cell(CellIndex.indexByString("D1"));
    cell3.value = 'E-MAIL'; // dynamic values support provided;
    // cell3.cellStyle = cellStyle;
    int pp = 4;
    for (int n = 0; n < question.length; n++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: pp, rowIndex: 0))
          .value = question[n];
      pp++; // add column headers
    }
    for (DocumentSnapshot doc in snap.docs) {
      var cell = sheetObject.cell(CellIndex.indexByString("A$i"));
      cell.value = doc
          .get('date')
          .toDate()
          .toString()
          .substring(0, 16); // dynamic values support provided;
      // cell.cellStyle = cellStyle;
      var cell1 = sheetObject.cell(CellIndex.indexByString("B$i"));
      cell1.value = doc.get('userName').toString();
      // cell.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("C$i"));
      cell2.value = doc.get('mobileNumber').toString();
      // cell.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("D$i"));
      cell3.value = doc.get('email').toString();
      // cell.cellStyle = cellStyle;
      int cc = 2;
      String alphabet = 'D';
      for (int c = 0; c < question.length; c++) {
        print('123');
        List surveyList = doc.get('surveyList');
        for (var item in surveyList) {
          if (item['question'] == question[c]) {
            int charCode =
            alphabet.codeUnitAt(0); // get the ASCII code of the alphabet
            charCode++; // increment the ASCII code
            alphabet = String.fromCharCode(charCode);

            sheetObject.cell(CellIndex.indexByString("${alphabet}${i}")).value =
            '${item['answer']}';
          }
        }
        cc++; // add column headers
      }
      i++;
    }
    excel.setDefaultSheet('survey');
    var fileBytes = excel.encode();
    File file;
    final content = base64Encode(fileBytes!);
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute(
          "download", widget.name+"Reports${DateTime.now().toString().substring(0, 10)}.xlsx")
      ..click();
  }

  String imgUrl = '';
  int? selectedIndex;
  bool loading = false;
  bool type = false;
  bool qType = false;
  List questions = [];

  late QuerySnapshot data;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          widget.name,
          style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
          ),
        ),
        actions: [
          // IconButton(onPressed: (){
          //   // ReportPDF.generate(widget.name, data);
          // }, icon: Icon(Icons.picture_as_pdf)),
          IconButton(onPressed: () async {
            setState(() {
              loading = false;
            });

        SurveyData();

            setState(() {
              loading = false;
            });
          }, icon: Icon(Icons.download)),
          // IconButton(onPressed: (){
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>EditSurvey(
          //       id:widget.id
          //   )));
          // }, icon: Icon(Icons.edit))

        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .95,
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
                            // controller: searchController,
                            initialValue: searchController.text,
                            onChanged:(value){
                              setState(() {
                                if(value!=null) {
                                  searchController.text = value.toUpperCase();
                                }
                                else{
                                  searchController.text="";
                                }
                              });

                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Search',
                              labelStyle:
                              TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: '',
                              hintStyle:
                             TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
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
                      ElevatedButton(onPressed: (){
                        searchController.clear();
                        setState(() {

                        });
                      }, child: Text('clear'))
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                searchController.text==''? Flexible(
                  child:StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('survey').doc(widget.id).collection('surveyData').orderBy('date',descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        print(snapshot.error);
                        if (!snapshot.hasData) {
                          return Center(
                              child: CircularProgressIndicator());
                        }
                        data = snapshot.data!;
                        print('--');
                        print(data);
                        return SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: data.docs.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 110,
                                child: InkWell(
                                  onTap: () async {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SurveyDataDetails(
                                      id:data.docs[index]['userId'],
                                      pid:widget.id,
                                      name:widget.name,
                                    )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff000000)
                                              .withOpacity(0.15),
                                          blurRadius: 4,
                                          spreadRadius: 0,
                                          offset: Offset(
                                            0,
                                            4,
                                          ),
                                        )
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text('Name : ' + data.docs[index]['userName'],
                                                style:
                                                GoogleFonts.outfit(
                                                    fontWeight:
                                                    FontWeight
                                                        .w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text('Mobile Number : ' + data.docs[index]['mobileNumber'],
                                                style:
                                                GoogleFonts.outfit(
                                                    fontWeight:
                                                    FontWeight
                                                        .w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Submitted Date : ' +
                                                    data.docs[index]['date'].toDate().toString().substring(0,16),
                                                style:
                                                GoogleFonts.outfit(
                                                    fontWeight:
                                                    FontWeight
                                                        .w600),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      leading: Text(
                                        '${index + 1}',
                                        style: GoogleFonts.outfit(
                                            fontWeight:
                                            FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                ):
                Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('survey').doc(widget.id).collection('surveyData').where('search',
                          arrayContains: searchController.text.toUpperCase())
                          .snapshots(),
                      builder: (context, snapshot) {
                        print(snapshot.error);
                        if (!snapshot.hasData) {
                          return Center(
                              child: CircularProgressIndicator());
                        }
                        data = snapshot.data!;
                        return SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: data.docs.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 110,
                                child: InkWell(
                                  onTap: () async {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SurveyDataDetails(
                                      id:data.docs[index]['userId'],
                                      pid:widget.id,
                                      name:widget.name,
                                    )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff000000)
                                              .withOpacity(0.15),
                                          blurRadius: 4,
                                          spreadRadius: 0,
                                          offset: Offset(
                                            0,
                                            4,
                                          ),
                                        )
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text('Name : ' + data.docs[index]['userName'],
                                                style:
                                                GoogleFonts.outfit(
                                                    fontWeight:
                                                    FontWeight
                                                        .w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text('Mobile Number : ' + data.docs[index]['mobileNumber'],
                                                style:
                                                GoogleFonts.outfit(
                                                    fontWeight:
                                                    FontWeight
                                                        .w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Submitted Date : ' +
                                                    data.docs[index]['date'].toDate().toString().substring(0,16),
                                                style:
                                                GoogleFonts.outfit(
                                                    fontWeight:
                                                    FontWeight
                                                        .w600),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      leading: Text(
                                        '${index + 1}',
                                        style: GoogleFonts.outfit(
                                            fontWeight:
                                            FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
