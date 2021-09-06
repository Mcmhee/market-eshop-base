import 'package:flutter/material.dart';
import 'package:market/models/user.dart';
import 'package:market/services/auth_service.dart';

class AuthBlock extends ChangeNotifier {
  AuthBlock() {
    setUser();
  }
  final AuthService _authService = AuthService();
  // Index
  int _currentIndex = 1;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // Loading
  bool _loading = false;
  late String _loadingType;
  bool get loading => _loading;
  String get loadingType => _loadingType;
  set loading(bool loadingState) {
    _loading = loadingState;
    notifyListeners();
  }

  set loadingType(String loadingType) {
    _loadingType = loadingType;
    notifyListeners();
  }

  // Loading
  bool _isLoggedIn = true;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool isUserExist) {
    _isLoggedIn = isUserExist;
    notifyListeners();
  }

  // user
  Map _user = {
    'user_email': 'dommy@gmail.com',
    'user_display_name': 'John Doe'
  };
  Map get user => _user;
  setUser() async {
    _user = await _authService.getUser();
    if (_user.isEmpty) {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
    }
    notifyListeners();
  }

  login(UserCredential userCredential) async {
    loading = true;
    loadingType = 'login';
    await _authService.login(userCredential);
    setUser();
    loading = false;
  }

  register(User user) async {
    loading = true;
    loadingType = 'register';
    await _authService.register(user);
    loading = false;
  }

  logout() async {
    await _authService.logout();
    isLoggedIn = false;
    notifyListeners();
  }
}
