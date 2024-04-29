class Categories {
  List<String> categories = ['general', 'sport', 'economy', 'technology', 'health', 'world', 'magazine'];

  Future<List<String>> getCategories() async {
    return categories;
  }
}
