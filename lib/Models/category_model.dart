import 'dart:convert';

Category categoryFromMap(String str) => Category.fromMap(json.decode(str));

String categoryToMap(Category data) => json.encode(data.toMap());

class Category {
    Category({
        this.id,
        this.categoryName,
    });

    int id;
    String categoryName;

    factory Category.fromMap(Map<String, dynamic> map) => Category(
        id: map["id"],
        categoryName: map["categoryName"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "categoryName": categoryName,
    };
}
