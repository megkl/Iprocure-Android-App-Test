import 'package:flutter_test/flutter_test.dart';
import 'package:iprocure_app/Models/product_model.dart';
import 'package:iprocure_app/helper/database_helper.dart';
import 'package:sqflite/sqflite.dart';

void main() {
test("Initializes with empty product", (){
List<Product> _product = [];

expect(_product.length, 0);
//expect(_product[0].categoryName, "Get Categories");
});
test("Get Categories", (){
DatabaseHelper databaseHelper;
List<Product> _product = [];

expect(_product[0].categoryName, 1);
});
test("Create product", (){
DatabaseHelper databaseHelper;
List<Product> _product = [];

databaseHelper.insertProduct(Product(productName: "Biodegrades", unitCost: 908, distributorName:"iprocure"));
databaseHelper.getProductList();
expect(_product[1].productName, 2);

});
}
