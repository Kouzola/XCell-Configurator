import 'dart:io';
import 'package:flutter/material.dart';
import 'package:xcell_configurator/file%20management/excel_sheeet_manager.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key, required this.file});

  final File file;

  @override
  State<ConfigPage> createState() => _ConfigPageState();

  
}

class _ConfigPageState extends State<ConfigPage> {

  
  //ExcelSheet Manager
  ExcelSheetManager excelSheetManager = ExcelSheetManager();
  
  @override
  void initState() {
    super.initState();
    excelSheetManager.openExcel(widget.file);   
  }
  //Liste qui va stocker nos TextField
  List<Map<String,TextEditingController>> fieldsList = [];
  bool isAddButtonEnabled = true;
  void toggleAddConfigButton(){
        if(isAddButtonEnabled) {
        isAddButtonEnabled = false;
      } else {
        isAddButtonEnabled = true;
      }
  }

  void _addTextFields(){
    setState(() {
      fieldsList.add({
        'cellule' : TextEditingController(),
        'type': TextEditingController(),
        'content': TextEditingController(),
      });
      toggleAddConfigButton();
          });
  }

  void exportModifiedExcel(){
    for(var cell in fieldsList){
        excelSheetManager.addDataInExcel(cell['cellule']!.text, cell['type']!.text, cell['content']!.text);
    }
    excelSheetManager.saveExcel();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [Flexible(
            child: ListView.builder(
              itemCount: fieldsList.length,
              itemBuilder: (context, index) {
                return Row(
                children: [ Flexible(
                  child: TextField(
                    controller: fieldsList[index]['cellule'],
                    decoration: const InputDecoration(
                      hintText: 'Cellule'),)
                      ), Flexible(
                        child: TextField(
                          controller: fieldsList[index]['type'],
                          decoration: const InputDecoration(
                            hintText: 'Type'
                          )
                        )
                      ),Flexible(
                        child: TextField(
                          controller: fieldsList[index]['content'],
                          decoration: const InputDecoration(
                            hintText: 'Content'
                          ),
                        )),
                        GestureDetector(
                          onTap: () {
                            setState((){
                            fieldsList.removeAt(index);
                            toggleAddConfigButton();
                            });                            
                          },
                          child: const Icon(Icons.highlight_remove)
                        ),
                      ],);
              }             
            ),
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.center,  
                child: ElevatedButton(
                  onPressed: isAddButtonEnabled ? _addTextFields : null, 
                  child: const Text(
                    "Add data"),
                  )),Align(
                alignment: Alignment.center,  
                child: ElevatedButton(
                  onPressed: exportModifiedExcel, 
                  child: const Text(
                    "Export"),
                  )),
                  

            ],
          ),
              
          ]
        ),
      )
    );
  }

  @override
  void dispose() {
    for(var controller in fieldsList){
      controller['cellule']?.dispose();
      controller['type']?.dispose();
      controller['content']?.dispose();
    }
    super.dispose();
  }
}
  //TODO : Ré-activer le bouton lorsque tous les champs de config sont complétés
  //TODO : Dropdown-List pour les differents type de données de case d'excel
  //TODO : ProgressBar avec un 100 % finish quand l'excel est exporté. => donc faudra retirer le writeSync etc.