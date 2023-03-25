
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async{
    final path = (await getExternalStorageDirectory())?.path;
    final file =  File('$path/$fileName');
    await file.writeAsBytes(bytes,flush: true);
  }
  static Future<File> saveB2CDocument({
    String? name,
    Document? pdf,
  }) async {
    final bytes = await pdf!.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');


    var directory = await getExternalStorageDirectory();
    String outputFile =
        directory!.path + "/B2C/INVOICE/$name.pdf";

    File(outputFile)
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes);



    print(file);

    await file.writeAsBytes(await pdf!.save());

    return file;
  }
  static Future<File> saveB2BDocument({
    String? name,
    Document? pdf,
  }) async {
    final bytes = await pdf!.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');


    var directory = await getExternalStorageDirectory();
    String outputFile =
        directory!.path + "/B2B/INVOICE/$name.pdf";

    File(outputFile)
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes);



    print(file);

    await file.writeAsBytes(await pdf.save());

    return file;
  }
  static Future<File> saveb2cReturnedDocument({
    String? name,
    Document? pdf,
  }) async {
    final bytes = await pdf!.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');


    var directory = await getExternalStorageDirectory();
    String outputFile =
        directory!.path + "/B2C/RTO/$name.pdf";

    File(outputFile)
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes);



    print(file);

    await file.writeAsBytes(await pdf.save());

    return file;
  }
  static Future<File> saveb2bReturnedDocument({
    String? name,
    Document? pdf,
  }) async {
    final bytes = await pdf?.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');


    var directory = await getExternalStorageDirectory();
    String outputFile =
        directory!.path + "/B2B/RTO/$name.pdf";

    File(outputFile)
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes!);



    print(file);

    await file.writeAsBytes(await pdf!.save());

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
// class PdfApi {
//   static Future<File> generateInvoice() async {
//     final pdf = Document();
//
//     return saveDocument(name: 'Invoice.pdf',pdf:pdf);
//   }
//
//   static Future openFile(File file) async {
//     final url = file.path;
//     await OpenFile.open(url);
//   }
//
//   static Future<File> saveDocument({
//     String name, Document pdf
//   }) async{
//     final bytes =await pdf.save();
//     final dir =await getApplicationDocumentsDirectory();
//         final file = File('${dir.path}/$name');
//     await file.writeAsBytes(bytes);
//     return file;
//   }
// }