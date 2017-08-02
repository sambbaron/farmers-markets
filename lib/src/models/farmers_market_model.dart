class FarmersMarketModel {
  String id;
  String name;
  double distance;
  String googleLink;
  String scheduleHtml;
  String address;
  List<String> products = [];

  FarmersMarketModel();

  FarmersMarketModel.fromSearchJson(Map json) {
    id = json["id"];
    String combinedName = json["marketname"];
    if (combinedName != null) {
      List<String> nameSplit = combinedName.split(" ");
      distance = num.parse(nameSplit.removeAt(0));
      name = nameSplit.join(" ");
    }
  }

  void fromDetailJson(Map json) {
    googleLink = json["GoogleLink"];
    address = json["Address"];
    scheduleHtml = json["Schedule"];
    String _products = json["Products"];
    products = _products?.split(";") ?? [];
    products.forEach((product) => product.trim());
  }

  String get productsLabel => products.join(", ");
}
