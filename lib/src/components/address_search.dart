import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ucar_app/src/theme/themes.dart';

class AddressSearch extends SearchDelegate<Placemark> {
  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(tooltip: 'Clear', icon: const Icon(Icons.clear), onPressed: () => query = '')
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    tooltip: 'Atrás',
    icon: const Icon(Icons.arrow_back_ios, color: MyColors.purpleTheme),
    onPressed: () => Navigator.pop(context, null),
  );

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) => FutureBuilder<List<Placemark>>(
    future: getSuggestions(query),
    builder: (context, snapshot) => query.isEmpty
      ? Container(padding: const EdgeInsets.all(16.0), child: const Text('Ingresa una dirección', style: CustomStyles.whiteStyle))
      :snapshot.hasError ? const Text('Sin coincidencias', style: CustomStyles.whiteStyle)
      : snapshot.hasData
      ? ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: Text('${snapshot.data?[index].name}, ${snapshot.data?[index].street}', style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize + 2)),
            subtitle: Text('${snapshot.data?[index].locality}, ${snapshot.data?[index].administrativeArea}', style: CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize)),
            onTap: () => Navigator.pop<Placemark>(context, snapshot.data?[index]),
          ),
          itemCount: snapshot.data?.length,
        )
      : Text('Cargando...', style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize)),
  );

  Future<List<Placemark>> getSuggestions(String query) async{
    try {
      final List<Placemark> places = [];
      final List<Location> locations = query.length > 6 ? await locationFromAddress(query) : List<Location>.empty();
      for (Location location in locations) {
        places.addAll(await placemarkFromCoordinates(location.latitude, location.longitude)
          .then((list) => list.where((element) => element.isoCountryCode == 'CO' && element.administrativeArea == 'Santander').toList()));
      }
      return places;
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }
}
