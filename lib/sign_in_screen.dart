import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.onSignedIn});

  final VoidCallback onSignedIn;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController(text: 'alphainvent@gmail.com');
  final _passwordController = TextEditingController(text: 'password');
  bool _obscurePassword = true;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_emailController.text.trim().isEmpty || _passwordController.text.isEmpty) {
      setState(() => _error = 'Enter an email and password to continue.');
      return;
    }
    widget.onSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 70, 28, 30),
          child: Column(
            children: [
              const Text('Sign In', style: TextStyle(color: Color(0xFF3157C9), fontSize: 42, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              const Text('A small social workspace for photos, music, and cards.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF69748D), fontSize: 16, height: 1.4)),
              const SizedBox(height: 36),
              Row(children: [
                Expanded(child: _socialButton(Icons.facebook_rounded, 'Facebook')),
                const SizedBox(width: 14),
                Expanded(child: _socialButton(Icons.g_mobiledata_rounded, 'Google')),
              ]),
              const SizedBox(height: 28),
              Row(children: [const Expanded(child: Divider(color: Color(0xFFD9DFEA))), Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: Text('Or', style: TextStyle(color: Color(0xFF3B4352)))), const Expanded(child: Divider(color: Color(0xFFD9DFEA)))]),
              const SizedBox(height: 28),
              TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: _inputDecoration('Email address')),
              const SizedBox(height: 16),
              TextField(controller: _passwordController, obscureText: _obscurePassword, onSubmitted: (_) => _login(), decoration: _inputDecoration('Password').copyWith(suffixIcon: IconButton(tooltip: _obscurePassword ? 'Show password' : 'Hide password', onPressed: () => setState(() => _obscurePassword = !_obscurePassword), icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: const Color(0xFF536079))))),
              Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () {}, child: const Text('Forgot Password?', style: TextStyle(color: Color(0xFF7B879C))))),
              if (_error != null) Padding(padding: const EdgeInsets.only(bottom: 10), child: Text(_error!, style: const TextStyle(color: Colors.red))),
              SizedBox(width: double.infinity, height: 56, child: ElevatedButton(onPressed: _login, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3861F5), foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: const Text('Log In', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)))),
              const SizedBox(height: 24),
              TextButton(onPressed: _login, child: const Text.rich(TextSpan(style: TextStyle(color: Color(0xFF485269), fontSize: 16), children: [TextSpan(text: 'Don’t have account? '), TextSpan(text: 'Sign Up', style: TextStyle(color: Color(0xFF3861F5), fontWeight: FontWeight.w700))]))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, String label) => OutlinedButton.icon(onPressed: _login, icon: Icon(icon, color: const Color(0xFF2F60D7), size: 25), label: Text(label, style: const TextStyle(color: Color(0xFF536079), fontWeight: FontWeight.w600)), style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFFF5F8FC), side: BorderSide.none, minimumSize: const Size.fromHeight(56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))));

  InputDecoration _inputDecoration(String label) => InputDecoration(labelText: label, labelStyle: const TextStyle(color: Color(0xFF69748D)), filled: true, fillColor: const Color(0xFFF5F8FC), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF3861F5), width: 1.5)), contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18));
}
