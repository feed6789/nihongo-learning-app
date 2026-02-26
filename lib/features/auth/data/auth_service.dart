// lib/features/auth/data/auth_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _client = Supabase.instance.client;

  User? get currentUser => _client.auth.currentUser;

  // Đăng nhập
  Future<AuthResponse> signInEmail(String email, String password) async {
    try {
      return await _client.auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'Đăng nhập thất bại. Vui lòng thử lại.';
    }
  }

  // Đăng ký
  Future<AuthResponse> signUpEmail(String email, String password) async {
    try {
      return await _client.auth.signUp(email: email, password: password);
    } on AuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'Đăng ký thất bại. Vui lòng thử lại.';
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
  
  // Google Login (Cần setup trên Supabase Dashboard trước mới chạy được)
  Future<void> signInWithGoogle() async {
    try {
      await _client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.flutter://login-callback',
      );
    } catch (e) {
      throw 'Lỗi Google Sign-In: $e';
    }
  }

  // Hàm helper để dịch lỗi sang tiếng Việt
  String _handleAuthError(AuthException error) {
    switch (error.message) {
      case 'Invalid login credentials':
        return 'Email hoặc mật khẩu không đúng.';
      case 'User already registered':
        return 'Email này đã được đăng ký.';
      default:
        return error.message; // Trả về lỗi gốc nếu không biết
    }
  }
}