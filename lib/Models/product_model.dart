import 'dart:convert';

Product productFromMap(String str) => Product.fromMap(json.decode(str));

String productToMap(Product data) => json.encode(data.toMap());

class Product {
  
    int id;
    String productName;
    String productCode;
    String categoryName;
    String quantityTypeName;
    int quantity;
    String manufacturerName;
    String distributorName;
    int vatEnabled;
    double unitCost;
    double retailPrice;
    double agentPrice;
    double wholesalePrice;
    String productImage;

    Product({
        this.id,
        this.productName,
        this.productCode,
        this.categoryName,
        this.quantityTypeName,
        this.quantity,
        this.manufacturerName,
        this.distributorName,
        this.vatEnabled,
        this.unitCost,
        this.retailPrice,
        this.agentPrice,
        this.wholesalePrice,
        this.productImage,
    });

//Convert from map single object to be consumed by the views
     Product.fromMap(Map<String, dynamic> map){
        this.id = map["Id"];
        this.productName = map["ProductName"];
        this.productCode = map["ProductCode"];
        this.categoryName = map["CategoryName"];
        this.quantityTypeName = map["QuantityTypeName"];
        this.quantity = map["Quantity"];
        this.manufacturerName = map["ManufacturerName"];
        this.distributorName = map["DistributorName"];
        this.vatEnabled = map["VatEnabled"];
        this.unitCost = map["UnitCost"];
        this.retailPrice = map["RetailPrice"];
        this.agentPrice = map["AgentPrice"];
        this.wholesalePrice = map["WholesalePrice"];
        this.productImage = map["ProductImage"];
     }
       

//convert to map from single object to be consumed by database
    Map<String, dynamic> toMap() => {
        "id": id,
        "productName": productName,
        "productCode": productCode,
        "categoryName": categoryName,
        "quantityTypeName": quantityTypeName,
        "quantity": quantity,
        "manufacturerName": manufacturerName,
        "distributorName": distributorName,
        "vatEnabled": vatEnabled,
        "unitCost": unitCost,
        "retailPrice": retailPrice,
        "agentPrice": agentPrice,
        "wholesalePrice": wholesalePrice,
        "productImage": productImage
    };
}