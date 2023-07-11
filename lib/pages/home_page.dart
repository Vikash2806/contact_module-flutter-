import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> csvData = [];

  @override
  void initState() {
    super.initState();
    loadCsvData();
  }

  Future<void> loadCsvData() async {
    final csvString = await rootBundle.loadString('assets/data.csv');
    final csvParsed = CsvToListConverter().convert(csvString);
    setState(() {
      csvData = csvParsed;
    });
  }

  List<String> getStudioNames() {
    final studioData = csvData.where((row) => row[2] == 'Studios').toList();
    return studioData.map((row) => row[1].toString()).toList();
  }

  List<String> getAssociateDirectorNames() {
    final associateDirectorData =
    csvData.where((row) => row[2] == 'Associate Directors').toList();
    return associateDirectorData.map((row) => row[1].toString()).toList();
  }

  List<dynamic> getDetailsByName(String name) {
    return csvData.firstWhere((row) => row[1] == name, orElse: () => []);
  }

  void navigateToDetailsPage(List<dynamic> details) {
    Navigator.pushNamed(
      context,
      '/details',
      arguments: details,
    );
  }

  void navigateToNamesPage(List<String> names) {
    Navigator.pushNamed(
      context,
      '/names',
      arguments: {
        'names': names,
        'csvData': csvData,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.lightBlueAccent.shade100,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              tileColor: Color(0xFF4361ee),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              title: Text('Studios',style: TextStyle(color: Colors.white),),
              onTap: () {
                final studioNames = getStudioNames();
                navigateToNamesPage(studioNames);
              },
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              tileColor: Color(0xFF4361ee),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              title: Text('Associate Directors',style: TextStyle(color: Colors.white),),
              onTap: () {
                final associateDirectorNames = getAssociateDirectorNames();
                navigateToNamesPage(associateDirectorNames);
              },
            ),
          ],
        ),
      ),
    );
  }
}