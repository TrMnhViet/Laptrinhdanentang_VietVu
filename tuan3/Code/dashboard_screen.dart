// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// IMPORT ĐÚNG ĐƯỜNG DẪN
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../bloc/auth_event.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // SỬA: Dùng List<Map<String, Object>> + const đúng cách
  static const List<Map<String, Object>> zones = [
    {
      'name': 'Ngã tư A',
      'density': 'Cao',
      'color': Colors.red,
      'icon': Icons.warning,
      'status': 'Ùn tắc'
    },
    {
      'name': 'Ngã tư B',
      'density': 'Trung bình',
      'color': Colors.orange,
      'icon': Icons.info,
      'status': 'Bình thường'
    },
    {
      'name': 'Ngã tư C',
      'density': 'Thấp',
      'color': Colors.green,
      'icon': Icons.check_circle,
      'status': 'Thông thoáng'
    },
  ];

  Future<bool> _showLogoutDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Xác nhận'),
            content: const Text('Bạn có chắc muốn đăng xuất?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Hủy')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Đăng xuất'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final username = state is AuthAuthenticated ? state.username : 'Người dùng';
            return Text('Xin chào, $username');
          },
        ),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () => Navigator.pushNamed(context, '/settings')),
          IconButton(icon: const Icon(Icons.lightbulb), onPressed: () => Navigator.pushNamed(context, '/control')),
          IconButton(icon: const Icon(Icons.timer), onPressed: () => Navigator.pushNamed(context, '/timer')),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () async {
              if (await _showLogoutDialog(context)) {
                context.read<AuthBloc>().add(AuthLogoutRequested());
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.green, Colors.lightGreen]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                Text('HỆ THỐNG ĐÈN GIAO THÔNG', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('3 ngã tư • Đang hoạt động', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: zones.length,
              itemBuilder: (context, i) {
                final z = zones[i];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: z['color'] as Color,
                      child: Icon(z['icon'] as IconData, color: Colors.white),
                    ),
                    title: Text(z['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Mật độ: ${z['density']} • ${z['status']}'),
                    trailing: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: z['color'] as Color),
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Gửi lệnh đến ${z['name']}')),
                      ),
                      icon: const Icon(Icons.send, size: 16),
                      label: const Text('Điều khiển'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}