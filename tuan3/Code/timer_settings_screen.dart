// lib/screens/timer_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerSettingsScreen extends StatefulWidget {
  const TimerSettingsScreen({super.key});
  @override State<TimerSettingsScreen> createState() => _TimerSettingsScreenState();
}

class _TimerSettingsScreenState extends State<TimerSettingsScreen> {
  int _seconds = 30;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadTimer();
  }

  Future<void> _loadTimer() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _seconds = prefs.getInt('traffic_timer') ?? 30);
  }

  Future<void> _saveTimer() async {
    setState(() => _saving = true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('traffic_timer', _seconds);
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã lưu thời gian đèn')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cấu hình thời gian đèn')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Thời gian đèn: $_seconds giây', style: const TextStyle(fontSize: 18)),
            Slider(
              min: 10, max: 120, divisions: 11,
              value: _seconds.toDouble(),
              onChanged: (v) => setState(() => _seconds = v.round()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () => setState(() => _seconds -= 5), child: const Text('-5s')),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: () => setState(() => _seconds += 5), child: const Text('+5s')),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saving ? null : _saveTimer,
              child: _saving ? const CircularProgressIndicator(color: Colors.white) : const Text('Lưu thay đổi'),
            ),
          ],
        ),
      ),
    );
  }
}