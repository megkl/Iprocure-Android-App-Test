import 'dart:convert';

QuantityType quantityTypeFromMap(String str) => QuantityType.fromMap(json.decode(str));

String quantityTypeToMap(QuantityType data) => json.encode(data.toMap());

class QuantityType {
    QuantityType({
        this.id,
        this.quantityTypeName,
    });

    int id;
    String quantityTypeName;

    factory QuantityType.fromMap(Map<String, dynamic> map) => QuantityType(
        id: map["id"],
        quantityTypeName: map["quantityTypeName"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "quantityTypeName": quantityTypeName,
    };
}
