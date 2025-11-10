// lib/screens/control_screen.dart
import 'package:flutter/material.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});
  @override State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  final Map<String, bool> _manualMode = {
    'Ngã tư A': false,
    'Ngã tư B': false,
    'Ngã tư C': false,
  };

  final Map<String, Color> _lightColors = {
    'Ngã tư A': Colors.red,
    'Ngã tư B': Colors.red,
    'Ngã tư C': Colors.red,
  };

  void _toggleManual(String zone) {
    setState(() {
      _manualMode[zone] = !_manualMode[zone]!;
      if (!_manualMode[zone]!) {
        _lightColors[zone] = Colors.red; // Tự động: đỏ mặc định
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_manualMode[zone]! ? 'Chuyển sang thủ công: $zone' : 'Tự động: $zone'),
        backgroundColor: _manualMode[zone]! ? Colors.orange : Colors.green,
      ),
    );
  }

  void _changeLight(String zone, Color color) {
    if (_manualMode[zone]!) {
      setState(() => _lightColors[zone] = color);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$zone: ${color == Colors.green ? 'XANH' : color == Colors.yellow ? 'VÀNG' : 'ĐỎ'}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Điều khiển thủ công'),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _manualMode.keys.map((zone) {
          return Card(
            elevation: 6,
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(zone, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Switch(
                        value: _manualMode[zone]!,
                        activeColor: Colors.orange,
                        onChanged: (_) => _toggleManual(zone),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        color: _lightColors[zone],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: _lightColors[zone]!.withOpacity(0.6), blurRadius: 20, spreadRadius: 5),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _lightButton(zone, Colors.red, 'ĐỎ'),
                      _lightButton(zone, Colors.yellow, 'VÀNG'),
                      _lightButton(zone, Colors.green, 'XANH'),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _lightButton(String zone, Color color, String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
      ),
      onPressed: _manualMode[zone]! ? () => _changeLight(zone, color) : null,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }
}