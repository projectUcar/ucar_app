import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ucar_app/src/screens/top_level_pages/history_screen.dart';

import '../../blocs/blocs.dart';
import '../../components/app_bar_custom.dart';
import '../../theme/themes.dart';
import '../top_level_pages/pass_home.dart';
import '../top_level_pages/profile_settings.dart';
import 'background.dart';
import 'gps_access_screen.dart';

class LandingPageArgs {
  final String name;
  final bool isDriver;

  LandingPageArgs({this.name = "nuevo", this.isDriver = false});
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.args});
  final LandingPageArgs args;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  final ValueNotifier<_LandingState> _indexNotifier = ValueNotifier<_LandingState>(const _LandingState(currentIndex: 0, loadedPages: [0,]));

  final List<BottomNavigationBarItem> _bottomNavItems = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
    BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'Mis viajes'),
    BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Ajustes'),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TripsBloc>(create: (context) => TripsBloc()),
        BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
        BlocProvider<HistoryBloc>(create: (context) => HistoryBloc()),
      ],
      child: GpsAccessScreen(
          child: ValueListenableBuilder<_LandingState>(
            valueListenable: _indexNotifier,
            builder: (context, value, _) => Scaffold(
              appBar: value.currentIndex != 2
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(50),
                    child: AppBarCustom(
                      color: MyColors.backgroundSvg,
                      text: "Hola, ${widget.args.name}",
                      leadingBoolean: false,
                    ),
                  )
                : null,
              body: Background(
                child: IndexedStack(
                  index: value.currentIndex,
                  children: [
                    const HomePassenger(key: PageStorageKey<String>("HomePassengerKEY")),
                    (value.loadedPages.contains(1)) ? HistoryScreen(key: const PageStorageKey<String>("HistoryKEY"), isDriver: widget.args.isDriver) : Container(),
                    (value.loadedPages.contains(2)) ? ProfileSettings(key: const PageStorageKey<String>("ProfileKEY"), isDriver: widget.args.isDriver) : Container(),
                  ]
                )
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: _bottomNavItems,
                currentIndex: value.currentIndex,
                onTap: (index) {
                  var pages = value.loadedPages;
                  if (!pages.contains(index)) {
                    _indexNotifier.value = value.copyWith(currentIndex: index, loadedPages: [...pages, index]);
                  }else{
                    _indexNotifier.value = value.copyWith(currentIndex: index);
                  }
                },
              ),
            ),
          ),
        ),
    );
  }
}

class _LandingState extends Equatable{
  final List<int> loadedPages;
  final int currentIndex;

  const _LandingState({required this.loadedPages, required this.currentIndex});

  _LandingState copyWith({List<int>? loadedPages, int? currentIndex}) => _LandingState(
    loadedPages: loadedPages ?? this.loadedPages,
    currentIndex: currentIndex ?? this.currentIndex
  );
  
  @override
  List<Object?> get props => [currentIndex, loadedPages];
}