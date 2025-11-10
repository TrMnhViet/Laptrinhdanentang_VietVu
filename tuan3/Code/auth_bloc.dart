// // lib/bloc/auth_bloc.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'auth_event.dart';
// import 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc() : super(AuthInitial()) {
//     on<AuthLoginRequested>(_onLoginRequested);
//     on<AuthLogoutRequested>(_onLogoutRequested);
//   }

//   Future<void> _onLoginRequested(
//       AuthLoginRequested event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());

//     // giả lập login delay
//     await Future.delayed(Duration(seconds: 2));

//     // Giả lập đăng nhập thành công nếu password = "123"
//     if (event.password == "123") {
//       emit(AuthAuthenticated(event.username));
//     } else {
//       emit(AuthError("Sai username hoặc password"));
//     }
//   }

//   void _onLogoutRequested(
//       AuthLogoutRequested event, Emitter<AuthState> emit) {
//     emit(AuthUnauthenticated());
//   }
// }
//--------------------------------------
// lib/bloc/auth_bloc.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'auth_event.dart';
// import 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc() : super(AuthInitial()) {
//     on<AppStarted>(_onAppStarted);
//     on<AuthLoginRequested>(_onLoginRequested);
//     on<AuthLogoutRequested>(_onLogoutRequested);
//   }

//   Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
//     final prefs = await SharedPreferences.getInstance();
//     final username = prefs.getString('username');
//     if (username != null && username.isNotEmpty) {
//       emit(AuthAuthenticated(username));
//     } else {
//       emit(AuthUnauthenticated());
//     }
//   }

//   Future<void> _onLoginRequested(
//       AuthLoginRequested event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     await Future.delayed(const Duration(seconds: 1));

//     // Ví dụ: chỉ cho phép user = admin, pass = 1234
//     if (event.username == 'admin' && event.password == '1234') {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('username', event.username);
//       emit(AuthAuthenticated(event.username));
//     } else {
//       emit(AuthError("Sai username hoặc password"));
//     }
//   }

//   Future<void> _onLogoutRequested(
//       AuthLogoutRequested event, Emitter<AuthState> emit) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('username');
//     emit(AuthUnauthenticated());
//   }
// }
//-------------------------
// lib/bloc/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SharedPreferences? prefs; // THÊM DÒNG NÀY

  AuthBloc({this.prefs}) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  // HÀM GIÚP DÙNG prefs HOẶC getInstance()
  Future<SharedPreferences> _getPrefs() async {
    return prefs ?? await SharedPreferences.getInstance();
  }

  // APP KHỞI ĐỘNG
  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final p = await _getPrefs(); // DÙNG _getPrefs()
    final username = p.getString('username');
    if (username != null && username.isNotEmpty) {
      emit(AuthAuthenticated(username));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  // ĐĂNG NHẬP
  Future<void> _onLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));

    if (event.username == 'admin' && event.password == '1234') {
      final p = await _getPrefs(); // DÙNG _getPrefs()
      await p.setString('username', event.username);
      emit(AuthAuthenticated(event.username));
    } else {
      emit(AuthError("Sai username hoặc password"));
    }
  }

  // ĐĂNG XUẤT
  Future<void> _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    final p = await _getPrefs(); // DÙNG _getPrefs()
    await p.remove('username');
    emit(AuthUnauthenticated());
  }
}