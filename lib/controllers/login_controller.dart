import '../services/auth_service.dart';

class LoginController {
  final AuthService _authService = AuthService();

  Future<bool> login(String email, String password) async {
    try {
      final response = await _authService.login(email, password);
      return response.token != null && response.token!.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
  
  Future<bool> isLoggedIn() async {
    return await _authService.hasToken() && await _authService.validateToken();
  }
  
  Future<void> logout() async {
    await _authService.clearToken();
  }
}
