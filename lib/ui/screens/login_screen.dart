import 'package:flutter/material.dart';

// Isso deve ser isolado no login_controller.dart depois
class LoginController {
  bool login(String email, String password) {
    // Lógica mock (exemplo)
    return email == "admin@aloy.dev" && password == "123456";
  }
}
// FIM CONTROLLER

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1B), // fundo escuro
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Column(
                  children: [
                    Text(
                      "Bem-vindo!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Acesse sua conta",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Endereço de Email",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _emailController,
                hint: "Digite seu email aqui...",
              ),
              const SizedBox(height: 16),
              const Text(
                "Senha",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _passwordController,
                hint: "Digite sua senha aqui...",
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Não possui conta? Clique aqui",
                    style: TextStyle(color: Colors.white),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFD3664),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        print("Email: $email");
                        print("Senha: $password");

                        if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Por favor, preencha todos os campos."),
                            ),
                            );
                            return;
                        }

                        final loginController = LoginController();
                        final isAuthenticated = loginController.login(email, password);

                        if (isAuthenticated) {
                            Navigator.pushReplacementNamed(context, '/home');
                        } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Credenciais inválidas."),
                            ),
                            );
                        }
                    },
                    child: const Text(
                      "Entrar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF1C1C2E),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
