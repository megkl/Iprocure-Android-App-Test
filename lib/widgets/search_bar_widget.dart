
import 'package:flutter/material.dart';
import 'package:iprocure_app/Models/product_model.dart';
import 'package:iprocure_app/helper/database_helper.dart';

class DataSearch extends SearchDelegate<String> {
  List<Product> productList;
 DataSearch({ Key key,this.productList});
  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {

            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
          color: Colors.blueAccent,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {

    //return DetailsScreen();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    final myList = query.isEmpty
        ? productList
        : productList
            .where((p) => p.productName.toLowerCase().contains(query.toLowerCase()) || p.manufacturerName.toLowerCase().contains(query.toLowerCase()) ||  p.productCode.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return myList.isEmpty
        ? Text(
            'No results found...',
            style: TextStyle(fontSize: 20, ),
          )
        : ListView.builder(
            itemCount: myList.length,
            itemBuilder: (context, index) {
              final Product listitem = myList[index];
              return ListTile(
                // onTap: () {
                //   cureentProduct =
                //       propertiesList[index];
                //   showResults(context);
                // },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listitem.productName,
                      style: TextStyle(fontSize: 20),
                    ),
                    //Text(listitem.propertyTypeDetails),
                    Text(listitem.manufacturerName),
                    Text("Ksh ${listitem.unitCost}"),
                    Divider()
                  ],
                ),
              );
            },
          );
  }
}
