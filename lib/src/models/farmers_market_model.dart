class FarmersMarketModel {
  String id;
  String name;
  double distance;
  String googleLink;
  String schedule;
  String address;
  List<String> products;

  FarmersMarketModel();

  FarmersMarketModel.fromJson(Map json) {
    updateFromJson(json);
  }

  void updateFromJson(json) {
    id = json["id"];
    String combinedName = json["marketname"];
    if (combinedName != null) {
      List<String> nameSplit = combinedName.split(" ");
      distance = num.parse(nameSplit.removeAt(0));
      name = nameSplit.join(" ");
    }
    googleLink = json["GoogleLink"];
    address = json["Address"];
    schedule = json["Schedule"];
    String _products = json["products"];
    products = _products?.split(";") ?? [];
    products.forEach((product) => product.trim());
  }
}
