import 'package:flutter/material.dart';
import 'package:freelance/Helper_functions/kit.dart';
import 'package:freelance/Widget/BottomAppBar_.dart';
import 'package:freelance/Widget/Drawer_app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Archives extends StatefulWidget {
  const Archives({Key? key}) : super(key: key);

  @override
  _ArchivesState createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> {
  bool isLoading = false;
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response =
          await http.get(Uri.parse("https://bb.egyticsports.com/public/api/fun"));
      print(response.body);

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData != null) {
          if (responseData is List) {
            data = List<Map<String, dynamic>>.from(responseData);
          } else if (responseData is Map) {
            data = List<Map<String, dynamic>>.from(responseData['data'] ?? []);
          } else {
            print('Invalid response format');
          }

          // Print data for debugging
          print('Data after fetching: $data');
        } else {
          print('Response data is null');
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF67CF6B),
          title: Text(
            'سجالات السحب',
            style: TextStyle_(fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
                  child: DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: Center(
                          child: Text('التاريخ', style: TextStyle(fontSize: 15, fontFamily: 'Al-Jazeera')),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text('الوقت', style: TextStyle(fontSize: 15, fontFamily: 'Al-Jazeera')),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text('الموقع', style: TextStyle(fontSize: 15, fontFamily: 'Al-Jazeera')),
                        ),
                      ),
                      // Add more columns as needed
                    ],
                    rows: data
                        .asMap()
                        .entries
                        .map(
                          (entry) => DataRow(
                            color: MaterialStateColor.resolveWith(
                              (states) => entry.key.isEven
                                  ? Colors.white // Change the even row color
                                  : Colors.grey[200] ?? Color(0x00000000),
                            ), // Provide a default color
                            cells: [
                              DataCell(
                                Text(
                                  entry.value['datex'] ?? '',
                                  style: TextStyle(
                                    color: Color(0xFF266828), // Change the text color
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  entry.value['timex'] ?? '',
                                  style: TextStyle(
                                    color: Color(0xFF266828), // Change the text color
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  entry.value['Functionx'].toString().toUpperCase() ?? '',
                                  style: TextStyle(
                                    color: Color(0xFF266828), // Change the text color
                                  ),
                                ),
                              ),
                              // Add more cells corresponding to additional columns
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
        drawer: Drawer_app(),
        bottomNavigationBar: BottomAppBar_(),
      ),
    );
  }
}
