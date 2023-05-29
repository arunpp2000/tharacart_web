import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../widgets/button.dart';
import '../../../widgets/uploadmedia.dart';
import '../../dashboard/dashboard.dart';
import 'editingGroup.dart';

class AddGroupWidget extends StatefulWidget {
  const AddGroupWidget({Key? key}) : super(key: key);

  @override
  _AddGroupWidgetState createState() => _AddGroupWidgetState();
}

class _AddGroupWidgetState extends State<AddGroupWidget> {
  late TextEditingController name;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, dynamic> newService = {};
  List<List<dynamic>> data = [];
  List<dynamic> kms = [];
  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      withData: true,
      withReadStream: true,
    );

    if (result == null) return;
    final file = result.files.first;
    print(file.path);
    _openFile(file);
  }

  List<int> pincodes = [];
  void _openFile(PlatformFile file) {
    print("-----------------------");

    List<List<dynamic>> listData =
        CsvToListConverter().convert(String.fromCharCodes(file.bytes!));
    int i = 0;
    print('abc');
    pincodes = [];
    for (dynamic a in listData) {
      if (a != null && a != "") {
        pincodes.add(int.tryParse(a[0].toString())??0);
      }
    }
    data = listData;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    print(pincodes);
    return Scaffold(
      key: scaffoldKey,

      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Add Group',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: name,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Group Name',
                        hintText: 'Please Enter Group Name',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                color: Color(0xFF303030),
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FFButtonWidget(
                        onPressed: () {
                          if (name.text != '') {
                            pickFile();
                          } else {
                            showUploadMessage(
                                context, 'Please Enter Group Name');
                          }
                        },
                        text: pincodes.length == 0
                            ? 'Upload File'
                            : 'Change File',
                        options: FFButtonOptions(
                          width: 130,
                          height: 40,
                          color: primaryColor,
                          textStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          if (name.text != '' && pincodes.length != 0) {
                            bool pressed = await alert(
                                context, 'Do You want add Group');
                            if (pressed) {
                              FirebaseFirestore.instance
                                  .collection('pincodeGroups')
                                  .doc(name.text)
                                  .set({
                                'pincodes': pincodes,
                              });
                              showUploadMessage(context, 'Group Added');
                            }
                          } else {
                            errorMsg(
                                context, 'Please Enter Group Name');
                          }
                        },
                        text: 'Upload',
                        options: FFButtonOptions(
                          width: 130,
                          height: 40,
                          color: primaryColor,
                          textStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
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
              ],
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('pincodeGroups').snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  var data=snapshot.data?.docs;
                  return SizedBox(
                    height: scrheight/2,
                    child: ListView.builder(
                        itemCount: data?.length,
                        itemBuilder: (buildContex,int index){
                          return Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditingPincodeGroup(
                                  name: data![index].id,
                                  pincode: data[index]['pincodes'],
                                )));
                              },
                              child: Card(
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(data![index].id,style: TextStyle(fontWeight: FontWeight.bold),),
                                )),
                              ),
                            ),
                          );
                        }),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
