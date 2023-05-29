import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../dashboard/dashboard.dart';
import 'addSurvey.dart';

class SurveyDataDetails extends StatefulWidget {
  var id;

  var pid;

  var name;

  SurveyDataDetails({Key? key, this.id, this.pid, this.name}) : super(key: key);

  @override
  _SurveyDataDetailsState createState() => _SurveyDataDetailsState();
}

class _SurveyDataDetailsState extends State<SurveyDataDetails> {
  @override
  void initState() {
    super.initState();
    getDetails();
  }

  TextEditingController link = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController ques = TextEditingController();
  TextEditingController A = TextEditingController();
  TextEditingController B = TextEditingController();
  TextEditingController C = TextEditingController();
  TextEditingController D = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List Options = [];
  late String Rmessage;
  late int selectIndex;
  String? name;
  late Timestamp sDate;
  getDetails() {
    FirebaseFirestore.instance
        .collection('survey')
        .doc(widget.pid)
        .collection('surveyData')
        .doc(widget.id)
        .get()
        .then((event) {
      name = event['userName'];
      sDate = event['date'];
      surList.clear();
      for (var a in event['surveyList']) {
        surList.add(a);
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  List surList = [];
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
              fontWeight: FontWeight.w600),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Flexible(
                child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: surList.length,
                itemBuilder: (context, index) {
                  if (surList.isEmpty) {
                    return CircularProgressIndicator();
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Name:${name!}'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Submitted Date:${sDate.toDate().toString().substring(0, 16)}',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(0.15),
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
                            leading: Text(
                              '${index + 1}',
                              style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w600),
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Question: ' +
                                            surList[index]['question'],
                                        style: GoogleFonts.outfit(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Answer: ' + surList[index]['answer'],
                                        style: GoogleFonts.outfit(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}
