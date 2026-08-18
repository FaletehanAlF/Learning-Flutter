import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool rememberMe = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRememberedData();
  }

  Future<void> _loadRememberedData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedRememberMe = prefs.getBool('registerRememberMe') ?? false;
    final savedUsername = prefs.getString('registerUsername') ?? '';
    final savedPhone = prefs.getString('registerPhone') ?? '';

    setState(() {
      rememberMe = savedRememberMe;
      if (savedRememberMe) {
        _usernameController.text = savedUsername;
        _phoneController.text = savedPhone;
      }
    });
  }

  Future<void> _saveRememberedData() async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setBool('registerRememberMe', true);
      await prefs.setString('registerUsername', _usernameController.text);
      await prefs.setString('registerPhone', _phoneController.text);
    } else {
      await prefs.setBool('registerRememberMe', false);
      await prefs.remove('registerUsername');
      await prefs.remove('registerPhone');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    "https://i.pinimg.com/1200x/c8/3d/0a/c83d0a804b5194e8352e44fa0383c09b.jpg",
                    width: 260,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE10600),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Please Sign Up to Continue",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Username",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: "Masukan Username",
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Color(0xFFE10600),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                "Telepon",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Masukan Telepon",
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    color: Color(0xFFE10600),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                "Password",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Masukan Password",
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Color(0xFFE10600),
                  ),
                  suffixIcon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                "Confirm Password",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Konfirmasi Password",
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Color(0xFFE10600),
                  ),
                  suffixIcon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: const Color(0xFFE10600),
                checkColor: Colors.white,
                title: const Text(
                  "Remember Me",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                value: rememberMe,
                onChanged: (value) {
                  setState(() {
                    rememberMe = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_usernameController.text.isEmpty ||
                        _phoneController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        _confirmPasswordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Semua field harus diisi"),
                        ),
                      );
                      return;
                    }
                    if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password tidak cocok"),
                        ),
                      );
                      return;
                    }
                    final messenger = ScaffoldMessenger.of(context);
                    final nav = Navigator.of(context);
                    await _saveRememberedData();
                    if (!mounted) return;
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text("Register berhasil"),
                      ),
                    );
                    nav.pop();
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already Have Account?",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Color(0xFFE10600),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
