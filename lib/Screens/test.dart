import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enhanced Table Example'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          sortColumnIndex: 0, // Initial column to be sorted (change as needed)
          sortAscending: true, // Initial sorting order (change as needed)
          columns: [
            DataColumn(
              label: Text('Column 1'),
              tooltip: 'This is Column 1',
              numeric: false, // Whether the column should be treated as numeric
              onSort: (columnIndex, ascending) {
                // Implement your custom sorting logic
                setState(() {
                  // Update the DataTable content based on sorting
                  // You can fetch data from your data source and reorder accordingly
                });
              },
            ),
            DataColumn(
              label: Text('Column 2'),
              tooltip: 'This is Column 2',
              numeric: true,
            ),
            DataColumn(
              label: Text('Column 3'),
              tooltip: 'This is Column 3',
              numeric: false,
            ),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Row 1, Cell 1')),
              DataCell(Text('Row 1, Cell 2')),
              DataCell(Text('Row 1, Cell 3')),
            ]),
            DataRow(cells: [
              DataCell(Text('Row 2, Cell 1')),
              DataCell(Text('Row 2, Cell 2')),
              DataCell(Text('Row 2, Cell 3')),
            ]),
            // Add more DataRow widgets for additional rows
          ],
        ),
      ),
    );
  }
}
