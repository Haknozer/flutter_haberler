import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_haberler/product/model/news_model.dart';
import 'package:flutter_haberler/ui/login/login_current_user.dart';

class BookmarkFirestoreDatabase {
  late List<News> list;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void collectionAdd(
      {required String description, required String image, required String name, required String source}) async {
    String? key = await getToken() ?? "";
    if (key != "") {
      CollectionReference users = FirebaseFirestore.instance.collection(key);
      Map<String, String> newsData = {
        "description": description,
        "image": image,
        "name": name,
        "source": source,
      };
      print("ekleme yapıyor");
      users.doc(name).set(newsData);
    }
  }

  Future<String?> getToken() async {
    return CurrentUser().getCurrentUserToken();
  }

  Future<List<News>> getBookmarksNews() async {
    String? key = await getToken() ?? "";
    CollectionReference users = FirebaseFirestore.instance.collection(key);
    var response = await users.get();
    list = response.docs.map((e) => News.fromSnapshot(e as DocumentSnapshot<Map<String, dynamic>>)).toList();
    return list;
  }

  Future deleteBookmarksNews(String name) async {
    String? key = await getToken() ?? "";
    CollectionReference users = FirebaseFirestore.instance.collection(key);
    await users.doc(name).delete();
  }
}
