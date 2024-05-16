import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_haberler/product/model/shared_preferences.dart';

class ProfilFirebase {
  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
    SharedInit.instance.sharedPreferences.clear();
    print("çıkış yapıldı");
  }
}
