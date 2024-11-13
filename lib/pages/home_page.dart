import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xcell_configurator/main.dart';
import 'package:xcell_configurator/pages/config_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var excelFileName = appState.fileName;
    var excelFile = appState.selectedFile;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(alignment: Alignment.centerLeft, child: Text('Excel Name: $excelFileName',style: const TextStyle(fontSize: 20))),
          ),
          const SizedBox(height: 350,),
          ElevatedButton(onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder:  (context) => ConfigPage(file: excelFile!),),
            );
          },
                        child: const Text('Config my XCell')),
          ElevatedButton(onPressed: appState.selectFile, child: const Text('Select new Template'))
        ],
      ),
    );
  }
}
