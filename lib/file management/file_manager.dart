import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

class FileManager{

  String? fileName;
  File? xcellFile;



  Future<File?> getXcellFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );
      if(result != null) {
        xcellFile = File(result.files.single.path!);
        fileName = basename(xcellFile!.path);
        return xcellFile;
      } else {
        throw 'File not found';
      }     
  }

}