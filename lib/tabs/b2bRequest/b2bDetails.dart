
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/button.dart';
import '../../widgets/flutterDropDown.dart';
import '../../widgets/uploadmedia.dart';

class DetailsPageWidget extends StatefulWidget {
  final String? id;
  const DetailsPageWidget({Key? key, this.id}) : super(key: key);

  @override
  _DetailsPageWidgetState createState() => _DetailsPageWidgetState();
}

class _DetailsPageWidgetState extends State<DetailsPageWidget> {

   bool? safeExtension;
   bool? ebextension;

   bool? safeMcc;
   bool? ebmcc;
  bool load=false;
   String safeZone='';
   String ebZone='';
  String ctb='';
  String ctj='';
  String cxdt='';
  String ctjCd='';
  String dty='';
  String ignm='';
  String lstupdt='';
  Map<String,dynamic> adadr={};
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<void> _launche;

  List<String> zones=['Select Zone'];
  List<String> zones1=['Select Zone'];
  List pinCode=[];

  var zone;

  Future getZone()async{
    DocumentSnapshot snapshot=await FirebaseFirestore.instance
        .collection('safeExpress')
        .doc('safeExpress')
        .get();

    safeZone="A";
    for(var abc in snapshot.get('zonePrice')){
      zones.add(abc['name']);

    }
    if(mounted){
      setState(() {
        safeZone='Select Zone';

      });
    }



  }
  Future getZone1()async{
    DocumentSnapshot snapshot=await FirebaseFirestore.instance
        .collection('expressB')
        .doc('expressB')
        .get();

    ebZone="A";
    for(var abc in snapshot.get('zonePrice')){
      zones1.add(abc['name']);

    }
    if(mounted){
      setState(() {
        ebZone='Select Zone';

      });
    }



  }

  Future<void>_makeCall(String url) async {
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw 'Could not call$url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getZone();
    getZone1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Details',
          style: TextStyle(
            fontFamily: 'Lexend Deca',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
          stream: FirebaseFirestore.instance.collection('b2bRequests').doc( widget.id).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            var data=snapshot.data?.data();
            String name=data!['userName'];
            String number=data['officialNo'];
            var  taxPayerInfo=data['taxpayerInfo'];
            var pAddress=taxPayerInfo['pradr'];
            var address=pAddress['addr'];

            String frontView="";
            String backView="";
            String passOrAadhar="";
            try {
              frontView = data['idFront'];
              backView = data['idBack'];
              passOrAadhar = data['p/aNumber'];
            }
            catch(err){
              passOrAadhar='';
              print(err);
            }
            print(address);
            // if(data!=null){
            String tradeName=taxPayerInfo['tradeNam'];
            String status=taxPayerInfo['sts'];
            String rgdt=taxPayerInfo['rgdt'];
            String stj=taxPayerInfo['stj'];
            String stjCd=taxPayerInfo['stjCd'];
            String panNo=taxPayerInfo['panNo'];

            ctb=taxPayerInfo['ctb'];
            ctj=taxPayerInfo['ctj'];
            ctjCd=taxPayerInfo['ctjCd'];
            cxdt=taxPayerInfo['cxdt'];
            dty=taxPayerInfo['dty'];
            ignm=taxPayerInfo['lgnm'];
            lstupdt=taxPayerInfo['lstupdt'];





            // }
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            name,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 120,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: data!['imageUrl']==''?'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png':data['imageUrl'],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            'Phone : $number',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () {
                            _launche=_makeCall('tel:${data['officialNo']}');
                          },
                          text: 'Call',
                          icon: Icon(
                            Icons.call,
                            size: 15,
                          ),
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: Color(0xFF00B423),
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
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            data!['email'],
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            'Passport/Aadhar Number : $passOrAadhar',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            'Trade Name :'+tradeName,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            'Pan No :'+panNo,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            stj,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            stjCd,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            'RDate :'+rgdt,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            'Status :'+status,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SelectableText(
                            'Passport / Aadhar',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  frontView==""&&backView==""?Container(): Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (_) {
                            //   return Zoom(image: frontView,);
                            // }));
                          },
                          child: Container(
                            width: 180,
                            child: CachedNetworkImage(imageUrl: frontView),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (_) {
                            //   return Zoom(image: backView,);
                            // }));
                          },
                          child: Container(
                            width: 180,
                            child: CachedNetworkImage(imageUrl: backView,),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SelectableText(
                            'Tax Payer Info',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            'GSTIN : ${data['GSTIN']}',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 3, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            ctb,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 3, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            ctj,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 3, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            ctjCd,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 3, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            dty,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 3, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            ignm,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 3, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            lstupdt,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SelectableText(
                            'Permanent Address',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            address['bnm'],
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 3, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            address['bno'],
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  address['city']!=''? Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 3, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            address['city'],
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ):Container(),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 3, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            address['dst'],
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  address['flno']!='' ? Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 3, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            address['flno'],
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ):Container(),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 3, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            'Pincode : ${address['pncd']}',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 3, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            address['st'],
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 3, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SelectableText(
                            address['stcd'],
                            style:TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: SelectableText(
                                'Zone',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(12)),
                                child: DropdownButtonFormField<String>(
                                  value: safeZone,
                                  decoration: InputDecoration(
                                    hintText: "Partners",
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (crs) {
                                    safeZone = crs!;
                                    print(safeZone);
                                    setState(() {});
                                  },
                                  validator: (value) =>
                                  value == null ? 'field required' : null,
                                  items: zones.toList()
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            // Expanded(
                            //   child: FlutterFlowDropDown(
                            //
                            //     options: zones1,
                            //     onChanged: (val) => setState(() => ebZone = val!),
                            //     width: 180,
                            //     height: 50,
                            //     textStyle: TextStyle(
                            //       fontFamily: 'Poppins',
                            //       color: Colors.black,
                            //     ),
                            //     fillColor: Colors.white,
                            //     elevation: 2,
                            //     borderColor: Colors.transparent,
                            //     borderWidth: 0,
                            //     borderRadius: 0,
                            //     margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                            //     hidesUnderline: true,
                            //   ),
                            // ),
                          ],
                        ),
                        //
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: FlutterFlowDropDown(
                        //         options: zones,
                        //         onChanged: (val) => setState(() => safeZone = val),
                        //         width: 180,
                        //         height: 50,
                        //         textStyle: TextStyle(
                        //           fontFamily: 'Poppins',
                        //           color: Colors.black,
                        //         ),
                        //         fillColor: Colors.white,
                        //         elevation: 2,
                        //         borderColor: Colors.transparent,
                        //         borderWidth: 0,
                        //         borderRadius: 0,
                        //         margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                        //         hidesUnderline: true,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                'EB Zone',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(12)),
                                child: DropdownButtonFormField<String>(
                                  value: ebZone,
                                  decoration: InputDecoration(
                                    hintText: "Partners",
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (crs) {
                                    ebZone = crs!;
                                    print(ebZone);
                                    setState(() {});
                                  },
                                  validator: (value) =>
                                  value == null ? 'field required' : null,
                                  items: zones1.toList()
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            // Expanded(
                            //   child: FlutterFlowDropDown(
                            //
                            //     options: zones1,
                            //     onChanged: (val) => setState(() => ebZone = val!),
                            //     width: 180,
                            //     height: 50,
                            //     textStyle: TextStyle(
                            //       fontFamily: 'Poppins',
                            //       color: Colors.black,
                            //     ),
                            //     fillColor: Colors.white,
                            //     elevation: 2,
                            //     borderColor: Colors.transparent,
                            //     borderWidth: 0,
                            //     borderRadius: 0,
                            //     margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                            //     hidesUnderline: true,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      SwitchListTile.adaptive(
                        value:   safeExtension ??false ,
                        onChanged: (newValue) =>
                            setState(() => safeExtension = newValue),
                        title: Text(
                          'Extension',
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        activeColor: Color(0xFF4B39EF),
                        activeTrackColor: Color(0xFF3B2DB6),
                        dense: true,
                        controlAffinity: ListTileControlAffinity.trailing,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                      ),
                      SwitchListTile.adaptive(
                        value:   ebextension ??false ,
                        onChanged: (newValue) =>
                            setState(() => ebextension = newValue),
                        title: Text(
                          'EB Extension',
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        activeColor: Color(0xFF4B39EF),
                        activeTrackColor: Color(0xFF3B2DB6),
                        dense: true,
                        controlAffinity: ListTileControlAffinity.trailing,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                      ),
                      SwitchListTile.adaptive(
                        value: safeMcc ??= true,
                        onChanged: (newValue) =>
                            setState(() => safeMcc = newValue),
                        title: Text(
                          'MCC',
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        activeColor: Color(0xFF4B39EF),
                        activeTrackColor: Color(0xFF3B2DB6),
                        dense: true,
                        controlAffinity: ListTileControlAffinity.trailing,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                      ),
                      SwitchListTile.adaptive(
                        value: ebmcc ??= true,
                        onChanged: (newValue) =>
                            setState(() => ebmcc = newValue),
                        title: Text(
                          'EB MCC',
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        activeColor: Color(0xFF4B39EF),
                        activeTrackColor: Color(0xFF3B2DB6),
                        dense: true,
                        controlAffinity: ListTileControlAffinity.trailing,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () async {

                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Reject'),
                                    content: Text('Do you want to Reject'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(alertDialogContext),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {


                                          snapshot.data?.reference.update({
                                            'status':2,
                                          });


                                          Navigator.pop(alertDialogContext);
                                          // Navigator.pop(context);


                                        },
                                        child: Text('Confirm'),
                                      ),
                                    ],
                                  );
                                },
                              );

                            },
                            text: 'Reject',
                            options: FFButtonOptions(
                              width: 170,
                              height: 50,
                              color: Color(0xFFC20000),
                              textStyle: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              elevation: 3,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if(safeZone!='Select Zone'&&ebZone!='Select Zone'){
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Confirm'),
                                      content: Text('Do you want to Approve'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(alertDialogContext),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {

                                            snapshot.data?.reference.update({
                                              'status':1,
                                              'mcc':safeMcc,
                                              'ebMcc':ebmcc,
                                              'extension':safeExtension,
                                              'ebExtension':ebextension,
                                              'zone':safeZone,
                                              'ebZone':ebZone,
                                            });

                                            FirebaseFirestore.instance.collection('users')
                                                .doc(widget.id).update({
                                              'b2b':true,
                                              'zone':safeZone,
                                              'ebZone':ebZone,
                                              'officialNo':number,
                                              'ext':safeExtension,
                                              'ebExtension':ebextension,
                                              'gst':data['GSTIN'],
                                              'mcc':safeMcc,
                                              'ebMcc':ebmcc,
                                            });

                                            Navigator.pop(alertDialogContext);
                                            // Navigator.pop(context);


                                          },
                                          child: Text('Confirm'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                              else{
                                showUploadMessage(context, 'Please Choose Zone');
                              }
                            },
                            text: 'Approve',
                            options: FFButtonOptions(
                              width: 170,
                              height: 50,
                              color: Color(0xFF4B39EF),
                              textStyle: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              elevation: 3,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
