import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';

import '../../../widgets/uploadmedia.dart';
import 'addGroupPincode.dart';


class EditingPincodeGroup extends StatefulWidget {
  final String? name;
  final List? pincode;
  EditingPincodeGroup({Key? key, this.name, this.pincode}) : super(key: key);

  @override
  _EditingPincodeGroupState createState() => _EditingPincodeGroupState();
}

class _EditingPincodeGroupState extends State<EditingPincodeGroup> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController hour;
  late TextEditingController time;
  var fullPlaces ;
  var place;
  var data;
  late FocusNode myFocusNode;
  List<dynamic> updateList = [];
  List placeList = [];

  bool add=false;
  DocumentSnapshot? doc;
  getPinCode1()async {

    FirebaseFirestore.instance.collection('pincodeGroups').doc(widget.name).snapshots().listen((event) {
      doc=event;
      placeList=[];
      placeList=event['pincodes'];

      if(mounted){
        setState(() {

        });
      }
    });




  }



  late TextEditingController search;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    search=TextEditingController();
    hour=TextEditingController();
    time=TextEditingController();
    getPinCode1();
  }
  getPincode() async {
    placeList=[];
    if(search.text!=null&&search.text!='') {
      for(int pin in widget.pincode??[]) {
        if (pin.toString().indexOf(search.text,0)==0) {
          placeList.add(pin);
        }
      }
    }
    else{
      placeList=widget.pincode!;
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF075454),
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        title: Text(
          widget.name??'',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: 300,
                  child: AddGroupPincode(
                    name: widget.name,
                  ),
                ),
              );
            },
          );
          Navigator.pop(context);
        },
        backgroundColor: Color(0xFF075454),
        elevation: 8,
        child: FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
          size: 24,
        ),
      ),

      body: Column(children: [
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
                    controller: search,
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      getPincode();

                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'search Pincode',
                      labelStyle:
                      TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      hintText: 'search pincode',
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
              )
            ],
          ),
        ),
        Flexible(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: placeList.length,
              itemBuilder: (context, int index) {

                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: Alignment(0, -0.11),
                            child: InkWell(
                              onLongPress: () async {
                                print(placeList.length);

                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Delete PinCode ?'),
                                      content: Text('Do you want to Delete PinCode'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            print(placeList.length);



                                            doc?.reference.update({
                                              'pincodes':FieldValue.arrayRemove([placeList[index]]),
                                            });

                                            placeList.removeAt(index);

                                            setState(() {

                                            });

                                            Navigator.pop(alertDialogContext);
                                            Navigator.pop(context);
                                            showUploadMessage(context, 'PinCode Deleted..');

                                          },
                                          child: Text('Confirm'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                placeList[index].toString(),
                                style:TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                );
              },
            )
        ),
      ]),
    );
  }
}
