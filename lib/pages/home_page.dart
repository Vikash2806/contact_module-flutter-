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
    final csvString = await rootBundle.loadString('assets/data.csv');// In this line, the rootBundle.loadString() method is used to asynchronously load the contents of a CSV file named data.csv from the assets folder. The await keyword is used to pause the execution of the function until the file is loaded, and the result is assigned to the csvString variable.
    final csvParsed = CsvToListConverter().convert(csvString);// Here, the csvString obtained from the previous step is parsed into a structured format. The CsvToListConverter().convert() method is used to convert the CSV string into a list of lists, where each inner list represents a row of data. The resulting parsed data is stored in the csvParsed variable.
    setState(() {
      csvData = csvParsed;//the value is passes to csdData which is defined above..
    });
  }

  List<String> getStudioNames() {
    //returns each name not completely..
    final studioData = csvData.where((row) => row[2] == 'Studios').toList();
    return studioData.map((row) => row[1].toString()).toList();
  }

  List<String> getAssociateDirectorNames() {
    final associateDirectorData =
    csvData.where((row) => row[2] == 'Associate Directors').toList();
    return associateDirectorData.map((row) => row[1].toString()).toList();// the transformation function (row) => row[1].toString() retrieves the value from the second column (row[1]) of each row and converts it to a string using toString()
  }

  List<dynamic> getDetailsByName(String name) {
    return csvData.firstWhere((row) => row[1] == name, orElse: () => []);//It searches for the first element in the list that satisfies a given condition. In this case, the condition is defined using a lambda function (row) => row[1] == name. It checks if the value in the second column (row[1]) of a row is equal to the provided name parameter.
  }//The row parameter in the lambda function represents each element (row) of the csvData list that is being checked.

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