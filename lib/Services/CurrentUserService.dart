import '../Models/User.dart';

class CurrentUserService {
  static final CurrentUserService _instance = CurrentUserService._internal();

  User? CurrentUser = User();

  factory CurrentUserService() {
    return _instance;
  }

  CurrentUserService._internal() {
    // initialization logic
  }
}
