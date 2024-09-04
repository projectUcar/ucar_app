enum Cities{ 
  bucaramanga("bucaramanga"),
  floridablanca("floridablanca"),
  giron("giron"),
  piedecuesta("piedecuesta");

  final String name;
  const Cities(this.name);

  String get nameFormat {
    switch (this) {
      
      case Cities.bucaramanga:
      case Cities.floridablanca:
      case Cities.piedecuesta:
        return "${name[0].toUpperCase()}${name.substring(1)}";
      case Cities.giron:
        return "${name[0].toUpperCase()}${name.substring(1).replaceAll(RegExp("o"), "ó")}";
    }
  }

  static Cities? fromString(String? s){
    for (Cities element in Cities.values) {
      if (element.nameFormat == s) {
        return element;
      }
    }
    return null;
  }
}