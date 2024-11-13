import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ExcelSheetManager{

  Excel? excel;
  String? excelFileName;

  bool openExcel(File excelFile){
    try{
      excelFileName = basename(excelFile.path);
      var bytes = excelFile.readAsBytesSync();
       if (bytes.isEmpty) {
      throw 'Le fichier est vide ou inaccessible.';
    }
      excel = Excel.decodeBytes(bytes);
    } catch(e){
      throw '$e';
    } 
    return true;
  } 

  Future<bool> saveExcel() async {
    try{
      var filesBytes = excel!.save();
    var dir = await getDownloadsDirectory();
    File(join(dir!.path,excelFileName))
    ..createSync(recursive: true)
    ..writeAsBytesSync(filesBytes!);
    } catch(e) {
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
    return true;
  }

  bool addDataInExcel(String cellId, String type, String content){
    //Ici je hardcode le nom de ma sheet mais plus tard faut pas faire comme ca
    Sheet sheet;
    if(excel != null ) {
      sheet = excel!['Feuil1'];
    } else {
      Fluttertoast.showToast(
        msg: "No excel selected",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
    var cell = sheet.cell(CellIndex.indexByString(cellId));
    switch(type){
      case "Text":
        cell.value = TextCellValue(content);
        break;
      case "Int":
        try{
          var intData = int.parse(content);
          cell.value = IntCellValue(intData);
        } catch (e) {
          //TODO : Erreur de parse
          return false;
        }
        break;
    }
    return true;
  }
}