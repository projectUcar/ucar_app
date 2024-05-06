enum Cities{ 
  bucaramanga, floridablanca, giron, piedecuesta;

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
}