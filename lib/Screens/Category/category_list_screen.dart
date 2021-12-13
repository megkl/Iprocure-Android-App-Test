import 'package:flutter/material.dart';
import 'package:iprocure_app/Models/product_model.dart';
import 'package:iprocure_app/Screens/home_screen.dart';
import 'package:iprocure_app/Screens/product/add_product_screen.dart';
import 'package:iprocure_app/helper/database_helper.dart';
import 'package:iprocure_app/widgets/category_widget.dart';
import 'package:iprocure_app/widgets/constants.dart';
import 'package:iprocure_app/widgets/screen_navigation.dart';
import 'package:iprocure_app/widgets/search_bar_widget.dart';
import 'package:sqflite/sqflite.dart';

class CategoryListScreen extends StatefulWidget {
  final String categoryName;
 CategoryListScreen({ Key key,this.categoryName}) : super(key: key);

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
   DatabaseHelper dbHelper = DatabaseHelper();
  List<Product> productList;
  int count = 0;
  List<String> categoryList = [
    'All'
    'Cereal Seeds',
    'Minerals',
    'Equipment'
  ];
  List<int> tapped = [];
   
  @override
  void initState() {
    super.initState();
     setState(() {
       
    });
  }
   @override
  Widget build(BuildContext context) {
    if (productList == null) {
      productList = [];
      updateListView();
    }

     return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Product Inventory", style: listTitle),
          leading: Icon(Icons.arrow_back_ios, color: Colors.black),
          actions: [
            InkWell(
              onTap: () {
                navigateToCreateNewProduct();
              },
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("Create new",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 17
                    )),
              ),
            )
          ],
        ),
        body: Stack(
          children: [
              //Search bar 
            InkWell(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(productList: productList),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.77,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.2)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Search by product, manufacturer and code",
                                style: smallStyle),
                            SizedBox(width: 12),
                            Align(
                                child: Icon(Icons.search_sharp,
                                    color: Colors.grey.withOpacity(0.7),
                                    size: 30))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.2)),
                          child: Icon(Icons.qr_code_sharp,size: 30,color: Colors.grey.withOpacity(0.8)),
                    )
                  ],
                ),
              ),
            ),
            
            //Categories
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                       return GestureDetector(
                        onTap: () async {
                          CircularProgressIndicator(color: Colors.amber);
                          await dbHelper.getCategoryList(categoryList[index]);
                          if (tapped.contains(index)) {
                            this.setState(() {
                              tapped.remove(index);
                            });
                          } else {
                            this.setState(() {
                              tapped.add(index);
                            });
                          }
                          changeScreen(
                              context,
                              CategoryListScreen(
                                categoryName: categoryList[index],
                              ));
                        },
                        child: Container(
                          width: 110,
                          height: 100,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                      child: Align(
                                    alignment: Alignment.topLeft,
                                  )),
                                  Center(
                                      child: Text(categoryList[index],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: tapped.contains(index)
                                                  ? Colors.red
                                                  : Colors.black)))
                                ],
                              )),
                        ),
                      );
                   }),
              ),
            ),
            SizedBox(height: 20),
            
            //Product List
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: getProductList(),
            ),
          ],
        ));
  }

  ListView getProductList() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
    return Container(
      padding: EdgeInsets.all(6),
      height: 180,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              //color: Colors.amber,
              width: MediaQuery.of(context).size.width * .3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  // image: DecorationImage(
                    
                  //   fit: BoxFit.cover,
                  // ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 1,
                      color: Colors.black12,
                    )
                  ]),
              child: Stack(fit: StackFit.expand, children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white,
                        //Colors.black87,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        20,
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0,left: 5, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              Icons.directions,
                              color: Colors.white,
                              size: 20,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                )),
                          )
                        ],
                      ),
                    )),
              ]
              ),
            ),
          ),
                     _buildDescription(context, position),
          
        ],
      ),
    );
   },
    );
  }

 Align _buildDescription(BuildContext context, int position) {
    
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
            width: MediaQuery.of(context).size.width * .62,
            height: 200,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 1,
                    color: Colors.black12,
                  )
                ]),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${(this.productList[position].productCode) + " - " + this.productList[position].productName + " - " + this.productList[position].quantity.toString()+this.productList[position].quantityTypeName}",
                    style: descText
                  ),
                  Row(children: <Widget>[
                    Text(this.productList[position].distributorName, style: headerNotesStyle)
                  ]),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('Ksh ',
                          style: listTitle),
                      Text(this.productList[position].unitCost.toString(),
                          style: listTitle),
                      Text("${this.productList[position].distributorName}",
                          style: descText)
                    ],
                  ),
                  ])));
  }
  
  void navigateToCreateNewProduct() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddProductScreen();
    }));
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Product>> productListFuture = dbHelper.getCategoryList(widget.categoryName);
      productListFuture.then((productList) {
        setState(() {
          this.productList = productList;
          this.count = productList.length;
        });
      });
    });
  }

  void _addProduct(BuildContext context, Product product) async {
    int result = await dbHelper.insertProduct(product);
    if (result != 0) {
      _showSnackBar(context, 'Product added Successfully');
      updateListView();
    }
  }

  void _updateProduct(BuildContext context, Product product) async {
    int result = await dbHelper.updateProduct(product);
    if (result != 0) {
      _showSnackBar(context, 'Product updated Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
