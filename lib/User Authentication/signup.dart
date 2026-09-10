import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'package:crop_sentry/theme.dart';
import 'package:crop_sentry/home_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  void _signup() async {
    setState(() => _isLoading = true);
    try {
      await _authService.signUpWithEmailPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false, // Clears the back stack
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: AppTheme.statusDanger,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.primaryGreen,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.primaryGreen,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryGreen,
                    ),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _signup,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
