import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFC41A3B),
        primaryColorLight: Color(0xFFFBE0E6),
        accentColor: Color(0xFF1B1F32),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = 'Dismissible';
  final _items = List<String>.generate(25, (index) => "Item ${index + 1}");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final _item = _items[index];
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            resizeDuration: Duration(seconds: 1),
            movementDuration: Duration(seconds: 1),
            background: Container(
              color: Colors.green,
              child: Icon(Icons.edit),
              // child: Text('Edit'),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: Icon(Icons.delete),
              // child: Text('Delete'),
            ),
            onDismissed: (_direction) {
              if (_direction == DismissDirection.endToStart) {
                _items.removeAt(index);
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$_item dismissed'),
                    duration: Duration(seconds: 1),
                  ),
                );
              } else if (_direction == DismissDirection.startToEnd) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$_item edited'),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  '${_items[index]}',
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
