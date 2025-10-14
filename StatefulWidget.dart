import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyHomePage()));

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _count = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('StatefulWidget Demo')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Giá trị: $_count', style: TextStyle(fontSize: 28)),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () => setState(() => _count++),
            child: Text('Tăng'),
          ),
        ],
      ),
    ),
  );
  @override
  void dispose() {
    super.dispose();
  }
}
