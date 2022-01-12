import 'package:flutter/material.dart';
import 'package:sqfliteproject/database_helper.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqflite Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                int? i = await DatabaseHelper.instance
                    .insert({DatabaseHelper.columnName: ' tarun'});
                print(i);
              },
              child: Text(
                'insert',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.green.shade900),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                List<Map<String, dynamic>> queryRows =
                    await DatabaseHelper.instance.queryAll();
                print(queryRows);
              },
              child: Text(
                'Query',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.blue.shade900),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                int updatedId = await DatabaseHelper.instance.update({
                  DatabaseHelper.columnId: 5,
                  DatabaseHelper.columnName: 'Marks'
                });
                print(updatedId);
              },
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.brown.shade500),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                int rowsEffected = await DatabaseHelper.instance.delete(4);
                print(rowsEffected);
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red.shade900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
