import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController ctrl;
  final String labeltext;
  final String hinttext;
   CustomTextField({Key? key,  required this.ctrl, required this.labeltext, required this.hinttext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
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
            controller: ctrl,
            obscureText: false,
            decoration: InputDecoration(
              labelText:labeltext,
              labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                color: Color(0xFF8B97A2),
                fontWeight: FontWeight.w500,
              ),
              hintText:hinttext,
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
            style:
            TextStyle(
              fontFamily: 'Montserrat',
              color: Color(0xFF8B97A2),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
