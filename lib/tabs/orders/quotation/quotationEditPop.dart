import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/uploadmedia.dart';
class QuotationPop extends StatefulWidget {
  final String? name;
  final String? address;
  final String? landMark;
  final String? area;
  final String? city;
  final String? state;
  final String? pincode;
  final String? orderId;
  final String? customerId;
  const QuotationPop({Key? key, this.name, this.address, this.landMark, this.area, this.state, this.pincode, this.orderId, this.customerId, this.city}) : super(key: key);

  @override
  State<QuotationPop> createState() => _QuotationPopState();
}

class _QuotationPopState extends State<QuotationPop> {

  final name =TextEditingController();
  final address =TextEditingController();
  final landMark =TextEditingController();
  final area =TextEditingController();
  final state =TextEditingController();
  final pincode =TextEditingController();
  final city =TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.orderId);
    print(widget.customerId);
    name.text=widget.name!;
    address.text=widget.address!;
    landMark.text=widget.landMark!;
    area.text=widget.area!;
    state.text=widget.state!;
    pincode.text=widget.pincode!;
    city.text=widget.city!;
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Address'),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: 350,
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
                    controller: name,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      hintText: 'Enter Name',
                      hintStyle:TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style:
                    TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: 350,
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
                    maxLines: 3,
                    controller: address,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      hintText: 'Enter Address',
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style:
                    TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: 350,
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
                    maxLines: 3,
                    controller: area,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Area',
                      labelStyle:TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      hintText: 'Enter Area',
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style:
                    TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: 350,
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
                    maxLines: 3,
                    controller: city,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'City',
                      labelStyle:TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      hintText: 'Enter City',
                      hintStyle:TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style:
                    TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Container(
                width: 350,
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
                    controller: landMark,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'LandMark',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      hintText: 'Enter LandMark',
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style:
                    TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Container(
                width: 350,
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
                    controller: state,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'State',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      hintText: 'Enter State',
                      hintStyle:TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style:
                    TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Container(
                width: 350,
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
                    controller: pincode,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Pincode',
                      labelStyle:TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      hintText: 'Enter Pincode',
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius:
                        const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style:
                    TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel')),
        TextButton(onPressed: () async {
          bool pressed = await alert(
              context,
              'Do you want update customer address?');

          if (pressed) {
            FirebaseFirestore.instance
                .collection('orders')
                .doc(widget.orderId)
                .update({
              'shippingAddress.name':name.text,
              'shippingAddress.address':address.text,
              'shippingAddress.area':area.text,
              'shippingAddress.city':city.text,
              'shippingAddress.landMark':landMark.text,
              'shippingAddress.pincode':pincode.text,
              'shippingAddress.state':state.text,
            });
            Navigator.pop(context);
            Navigator.pop(context);
            showUploadMessage(context, 'Address Updated...');
          }

        }, child: Text('Update')),

      ],
    );
  }
}
