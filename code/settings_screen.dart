import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final double fontSize;
  final Function(bool, double) onSave;

  const SettingsScreen({super.key, required this.isDarkMode, required this.fontSize, required this.onSave});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  late bool _darkMode;
  late double _fontSize;

  @override
  void initState() {
    super.initState();
    _darkMode = widget.isDarkMode;
    _fontSize = widget.fontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Chế độ tối'),
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
            ),
            const SizedBox(height: 12),
            Text('Kích thước chữ: ${_fontSize.toStringAsFixed(0)}'),
            Slider(
              min: 12,
              max: 24,
              divisions: 6,
              value: _fontSize,
              label: '${_fontSize.toStringAsFixed(0)}',
              onChanged: (v) => setState(() => _fontSize = v),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSave(_darkMode, _fontSize);
                Navigator.pop(context);
              },
              child: const Text('Lưu cài đặt'),
            )
          ],
        ),
      ),
    );
  }
}
