import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:xcell_configurator/file%20management/file_manager.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'XCell Configurator',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white, 
            surface:Colors.white )
            ),
            debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}


class AppState extends ChangeNotifier{

  final FileManager _fileManager = FileManager();
  String? fileName;
  File? selectedFile;
  
  Future<void> selectFile() async {
    try {
      selectedFile = await _fileManager.getXcellFile();
      if (selectedFile != null) {
          fileName = _fileManager.fileName;
      }
    } catch(e) {
      Fluttertoast.showToast(
        msg: "No file selected",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    notifyListeners();
  }

}




