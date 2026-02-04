import 'package:get/get.dart';
import '../services/storage_service.dart';

class AuthController extends GetxController {
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _refreshFromStorage();
  }

  void _refreshFromStorage() {
    try {
      isLoggedIn.value = StorageService.isLoggedIn;
    } catch (_) {
      // StorageService may not be initialized in some test contexts.
      isLoggedIn.value = false;
    }
  }

  Future<void> setToken(String token) async {
    await StorageService.saveToken(token);
    isLoggedIn.value = true;
  }

  Future<void> logout() async {
    await StorageService.removeToken();
    await StorageService.removeUser();
    isLoggedIn.value = false;
  }
}

