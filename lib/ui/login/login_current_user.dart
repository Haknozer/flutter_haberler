import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_haberler/product/model/shared_preferences.dart';

class CurrentUser {
  Future setCurrentUser(FirebaseAuth firebaseAuth) async {
    FirebaseAuth.instance.currentUser != null
        ? SharedInit.instance.sharedPreferences.setBool("kullaniciAktif", true)
        : SharedInit.instance.sharedPreferences.setBool("kullaniciAktif", false);
  }

  bool getCurrentUser() {
    print(SharedInit.instance.sharedPreferences.getBool("kullaniciAktif"));
    return SharedInit.instance.sharedPreferences.getBool("kullaniciAktif") ?? false;
  }
}
