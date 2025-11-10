// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'bloc/auth_bloc.dart';
// import 'screen/login_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => AuthBloc(),
//       child: MaterialApp(
//         title: 'Flutter BLoC Login Demo',
//         theme: ThemeData(primarySwatch: Colors.blue),
//         home: LoginScreen(),
//       ),
//     );
//   }
// }
//---------------------------------
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// BLoC
import 'bloc/auth_bloc.dart';
import 'bloc/auth_state.dart';
import 'bloc/auth_event.dart';

// Screens
import 'screen/login_screen.dart';
import 'screen/dashboard_screen.dart';
import 'screen/control_screen.dart';
import 'screen/settings_screen.dart';
import 'screen/timer_settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TrafficApp());
}

class TrafficApp extends StatefulWidget {
  const TrafficApp({Key? key}) : super(key: key);

  @override
  State<TrafficApp> createState() => _TrafficAppState();
}

class _TrafficAppState extends State<TrafficApp> {
  bool _isDarkMode = false;
  double _fontSize = 16.0;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  /// Tải theme từ SharedPreferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? false;
      _fontSize = prefs.getDouble('fontSize') ?? 16.0;
    });
  }

  /// Cập nhật theme khi người dùng thay đổi
  void _updateTheme(bool darkMode, double fontSize) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', darkMode);
    await prefs.setDouble('fontSize', fontSize);
    setState(() {
      _isDarkMode = darkMode;
      _fontSize = fontSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()..add(AppStarted())),
      ],
      child: MaterialApp(
        title: 'Hệ Thống Đèn Giao Thông',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: _isDarkMode ? Brightness.dark : Brightness.light,
          textTheme: TextTheme(bodyMedium: TextStyle(fontSize: _fontSize)),
          colorSchemeSeed: Colors.green,
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
        routes: {
          '/dashboard': (_) => const DashboardScreen(),
          '/control': (_) => const ControlScreen(),
          '/settings': (_) => SettingsScreen(
                onThemeChanged: _updateTheme,
                initialDarkMode: _isDarkMode,
                initialFontSize: _fontSize,
              ),
          '/timer': (_) => const TimerSettingsScreen(),
        },
      ),
    );
  }
}

/// =======================================================================
/// AUTHWRAPPER – QUẢN LÝ TRẠNG THÁI LOGIN/LOGOUT
/// =======================================================================
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthAuthenticated) {
          // Nếu đã đăng nhập → Dashboard
          return const DashboardScreen();
        } else {
          // Nếu chưa đăng nhập → Login
          return const LoginScreen();
        }
      },
    );
  }
}
