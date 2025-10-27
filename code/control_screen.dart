import 'package:flutter/material.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});
  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  bool lightOn = false;

  void _toggleLight() {
    setState(() => lightOn = !lightOn);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(lightOn ? 'Bật chế độ tự động' : 'Tắt chế độ')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Điều khiển đèn')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(lightOn ? Icons.traffic : Icons.traffic_outlined, size: 120, color: lightOn ? Colors.green : Colors.red),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _toggleLight, child: Text(lightOn ? 'Tắt đèn' : 'Bật đèn')),
          ],
        ),
      ),
    );
  }
}
