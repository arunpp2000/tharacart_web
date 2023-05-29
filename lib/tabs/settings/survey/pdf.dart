import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../orders/b2c/pdf.Api.dart';





var image;


var format = NumberFormat.simpleCurrency(locale: 'en_in');

class ReportPDF {
  static Future<File> generate(String title,QuerySnapshot data) async {
    final pdf = Document();
    pdf.addPage(MultiPage(
      build: (context) =>
      [
        pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.SizedBox(height: 50),
              pw.Text(title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              pw.Text('Total : ' + data.docs.length.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              pw.SizedBox(height: 50),

              pw.Table.fromTextArray(
                  context: context,
                  headers: [
                    'Sl.No',
                    'Submitted Date',
                    'Name'
                  ],
                  data: List.generate(data.docs.length, (index) {
                    return [
                      (index + 1).toString(),
                      data.docs[index]['date'].toDate().toString().substring(
                          0, 16),
                      data.docs[index]['userName']
                    ];
                  })

              ),
              pw.SizedBox(height: 30),

            ]
        ),
      ],
    ));


    //web
    // final bytes = pdf.save();
    // final blob = html.Blob([bytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(
    //     await generate());
    // final anchor =
    // html.document.createElement('a') as html.AnchorElement
    //   ..href = url
    //   ..style.display = 'none'
    //   ..download = 'some_name.pdf';
    // html.document.body.children.add(anchor);
    // anchor.click();
    // html.document.body.children.remove(anchor);
    // html.Url.revokeObjectUrl(url);

    //
    // print('bbbbbbbbbbbbbbbbbbbbbbbb');

    //android

    // if(kIsWeb){
      await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
    // }
    // else{
    return PdfApi.saveSurveyDocument(name: '$title.pdf', pdf: pdf);
    //}
  }


}