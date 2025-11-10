// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  final void Function(bool, double) onThemeChanged;
  final bool initialDarkMode;
  final double initialFontSize;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.initialDarkMode,
    required this.initialFontSize,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _darkMode;
  late double _fontSize;

  @override
  void initState() {
    super.initState();
    _darkMode = widget.initialDarkMode;
    _fontSize = widget.initialFontSize;
  }

  /// LƯU CÀI ĐẶT VÀO SharedPreferences
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _darkMode);
    await prefs.setDouble('fontSize', _fontSize);

    // GỌI HÀM CẬP NHẬT THEME TỪ main.dart
    widget.onThemeChanged(_darkMode, _fontSize);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã lưu cài đặt thành công!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.pop(context); // Quay lại Dashboard
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt hệ thống'),
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DARK MODE
            Card(
              elevation: 3,
              child: SwitchListTile(
                title: const Text('Chế độ tối', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Bật/tắt giao diện tối'),
                value: _darkMode,
                activeColor: Colors.blue,
                onChanged: (value) => setState(() => _darkMode = value),
              ),
            ),
            const SizedBox(height: 16),

            // FONT SIZE
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Kích thước chữ', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Hiện tại: ${_fontSize.toStringAsFixed(0)}', style: const TextStyle(color: Colors.grey)),
                    Slider(
                      min: 12,
                      max: 24,
                      divisions: 6,
                      value: _fontSize,
                      label: _fontSize.toStringAsFixed(0),
                      activeColor: Colors.blue,
                      onChanged: (value) => setState(() => _fontSize = value),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // NÚT LƯU
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save, size: 20),
                label: const Text('Lưu cài đặt', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                ),
                onPressed: _saveSettings,
              ),
            ),
          ],
        ),
      ),
    );
  }
}