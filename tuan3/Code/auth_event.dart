// // lib/bloc/auth_event.dart
// import 'package:equatable/equatable.dart';

// abstract class AuthEvent extends Equatable {
//   const AuthEvent();

//   @override
//   List<Object?> get props => [];
// }

// class AuthLoginRequested extends AuthEvent {
//   final String username;
//   final String password;

//   const AuthLoginRequested({required this.username, required this.password});

//   @override
//   List<Object?> get props => [username, password];
// }

// class AuthLogoutRequested extends AuthEvent {}
// lib/bloc/auth_event.dart
// lib/bloc/auth_event.dart
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// Sự kiện khởi động app → kiểm tra người dùng đã đăng nhập chưa
class AppStarted extends AuthEvent {}

// Sự kiện đăng nhập
class AuthLoginRequested extends AuthEvent {
  final String username;
  final String password;

  const AuthLoginRequested({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

// Sự kiện đăng xuất
class AuthLogoutRequested extends AuthEvent {}
