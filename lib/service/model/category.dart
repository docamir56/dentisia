class CategoryModel {
  String title;
  String image;
  CategoryModel({required this.image, required this.title});

  factory CategoryModel.fromJson({required Map<String, dynamic> data}) {
    return CategoryModel(image: data['image'], title: data['title']);
  }
}
