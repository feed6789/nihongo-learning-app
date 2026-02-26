// lib/features/auth/presentation/login_page.dart

import 'package:flutter/material.dart';
import '../data/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = AuthService();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoginMode = true; // true: Login, false: Register
  bool _isLoading = false;
  bool _obscurePass = true;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();

    try {
      if (_isLoginMode) {
        // --- LOGIC ĐĂNG NHẬP ---
        await _auth.signInEmail(email, pass);
        if (mounted) {
          // Pop về trang trước và trả về true để báo hiệu reload
          Navigator.pop(context, true);
        }
      } else {
        // --- LOGIC ĐĂNG KÝ ---
        final res = await _auth.signUpEmail(email, pass);
        // Kiểm tra xem Supabase có yêu cầu confirm email không
        if (res.session == null && res.user != null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đăng ký thành công! Vui lòng kiểm tra email để xác nhận.')),
            );
            setState(() => _isLoginMode = true); // Chuyển về tab đăng nhập
          }
        } else {
          // Nếu đăng ký xong mà có session luôn (tắt confirm email)
          if (mounted) Navigator.pop(context, true);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLoginMode ? 'Đăng nhập' : 'Đăng ký')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo hoặc Icon
                Icon(Icons.lock_person, size: 80, color: Theme.of(context).primaryColor),
                const SizedBox(height: 24),

                // Email Field
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v == null || !v.contains('@') ? 'Email không hợp lệ' : null,
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: _passCtrl,
                  obscureText: _obscurePass,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePass ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscurePass = !_obscurePass),
                    ),
                  ),
                  validator: (v) => v != null && v.length < 6 ? 'Mật khẩu phải trên 6 ký tự' : null,
                ),
                const SizedBox(height: 24),

                // Nút Submit
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(_isLoginMode ? 'Đăng nhập' : 'Đăng ký tài khoản'),
                  ),
                ),
                const SizedBox(height: 16),

                // Nút chuyển đổi Login <-> Register
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLoginMode = !_isLoginMode;
                      _formKey.currentState?.reset(); // Xóa lỗi cũ
                    });
                  },
                  child: Text(_isLoginMode
                      ? 'Chưa có tài khoản? Đăng ký ngay'
                      : 'Đã có tài khoản? Đăng nhập'),
                ),
                
                // Google Sign In (Optional)
                const Divider(),
                ElevatedButton.icon(
                   icon: const Icon(Icons.g_mobiledata), // Icon Google giả lập
                   label: const Text('Tiếp tục với Google'),
                   onPressed: () => _auth.signInWithGoogle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}