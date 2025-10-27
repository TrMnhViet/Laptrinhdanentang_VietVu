import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final List<Map<String, dynamic>> zones = [
    {'name': 'Ngã tư A', 'density': 'Cao', 'color': Colors.red},
    {'name': 'Ngã tư B', 'density': 'Trung bình', 'color': Colors.orange},
    {'name': 'Ngã tư C', 'density': 'Thấp', 'color': Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bảng điều khiển'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.tips_and_updates),
            onPressed: () => Navigator.pushNamed(context, '/control'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: zones.length,
        itemBuilder: (context, index) {
          final zone = zones[index];
          return Card(
            color: zone['color'].withOpacity(0.12),
            child: ListTile(
              title: Text(zone['name']),
              subtitle: Text('Mật độ: ${zone['density']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  // placeholder: mở màn hình detail/command
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gửi lệnh điều khiển cho ${zone['name']}')),
                  );
                },
                child: const Text('Điều khiển'),
              ),
            ),
          );
        },
      ),
    );
  }
}
