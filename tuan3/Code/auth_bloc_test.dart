// test/auth_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projectltdnt/bloc/auth_bloc.dart';
import 'package:projectltdnt/bloc/auth_event.dart';
import 'package:projectltdnt/bloc/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    mockPrefs = MockSharedPreferences();
    when(() => mockPrefs.setString(any(), any())).thenAnswer((_) async => true);
    when(() => mockPrefs.remove(any())).thenAnswer((_) async => true);
  });

  group('AuthBloc', () {
    blocTest<AuthBloc, AuthState>(
      'AppStarted - no user - AuthUnauthenticated',
      build: () => AuthBloc(prefs: mockPrefs),
      setUp: () {
        when(() => mockPrefs.getString('username')).thenReturn(null);
      },
      act: (bloc) => bloc.add(AppStarted()),
      expect: () => [AuthUnauthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      'Login success',
      build: () => AuthBloc(prefs: mockPrefs),
      act: (bloc) => bloc.add(const AuthLoginRequested(username: 'admin', password: '1234')),
      wait: const Duration(seconds: 2),
      expect: () => [AuthLoading(), AuthAuthenticated('admin')],
      verify: (_) { // THÊM (_) =>
        verify(() => mockPrefs.setString('username', 'admin')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'Logout',
      build: () => AuthBloc(prefs: mockPrefs),
      seed: () => AuthAuthenticated('admin'),
      act: (bloc) => bloc.add(AuthLogoutRequested()),
      expect: () => [AuthUnauthenticated()],
      verify: (_) { // THÊM (_) =>
        verify(() => mockPrefs.remove('username')).called(1);
      },
    );
  });
}