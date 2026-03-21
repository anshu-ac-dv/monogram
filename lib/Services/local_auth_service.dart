import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class LocalAuthService {
  static final _auth = LocalAuthentication();

  static Future<bool> _canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;

      return await _auth.authenticate(
        localizedReason: 'Please authenticate to access Monogram',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
        authMessages: const [
          AndroidAuthMessages(
            signInTitle: 'Biometric authentication required',
            cancelButton: 'No thanks',
          ),
        ],
      );
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
