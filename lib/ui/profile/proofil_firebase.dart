import 'package:firebase_auth/firebase_auth.dart';

class ProfilFirebase {
  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
    print("çıkış yapıldı");
  }
}
