import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../blocs/blocs.dart';
import '../../components/shimmer_card.dart';
import '../../config/size_config.dart';
import '../../models/driver_result_status.dart';
import '../../routes/app_router.dart';
import '../../storage/auth_client.dart';
import '../../theme/themes.dart';
import '../../util/capitalizer.dart';
import '../../util/options/genders.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key, required this.isDriver});
  final bool isDriver;

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {

  @override
  void initState() {
    bloc.add(ProfileFetching());
    super.initState();
  }

  ProfileBloc get bloc => BlocProvider.of<ProfileBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ImageUploadFailed && !state.displayMessage) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message, style: const TextStyle(color: MyColors.textWhite)), backgroundColor: Colors.red.shade400));
        }
        if (state is ProfileReturned && state.displayMessage) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.requestState.message, style: const TextStyle(color: MyColors.textWhite)),
            backgroundColor: state.requestState.color,
            duration: const Duration(seconds: 15),
          ));
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(6),
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              if (context.mounted && state is ProfileReturned) bloc.add(ProfileFetching());
            },
            displacement: 50.0,
            color: MyColors.textGrey,
            backgroundColor: MyColors.purpleTheme,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundColor: (state is ProfileReturned) ? genderColor(state.match) : MyColors.textGrey,
                            backgroundImage: (state is CompletelyReturned)? MemoryImage(state.imageBytes): null,
                            child: (state is PartiallyReturned) ? const Icon(Icons.person_rounded, color: MyColors.primary, size: 60) : null,
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: (state is ProfileReturned) ? BoxDecoration(borderRadius: BorderRadius.circular(100), color: MyColors.purpleTheme) : null,
                            child: (state is ProfileReturned) ? IconButton(
                              padding: const EdgeInsets.all(1),
                              icon: Icon((state is CompletelyReturned) ? Icons.drive_file_rename_outline_rounded : Icons.file_upload_rounded),
                              color: Colors.black,
                              onPressed: () async{
                                if (await permissionsStatus && context.mounted) {
                                  await imageSourceModal(context, state.model);
                                }
                              },
                            ): null,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                content(context, state, () => bloc.add(ProfileFetching())),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        (!widget.isDriver) ? _bottomButton(context, MyColors.backgroundBlue, "Modo Conductor", (state is ProfileReturned) ? () async {
                            if (context.mounted) {
                              if ((state.requestState == DriverResultStatus.successful || widget.isDriver == true)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Al parecer, ya eres conductor o una solicitud a tu nombre está pendiente", style: TextStyle(color: MyColors.textWhite),),
                                    backgroundColor: MyColors.purpleTheme,
                                  )
                                );
                              }else{
                                final value = await Navigator.pushNamed<bool>(context, AppRouter.driverForm);
                                if (value == true && context.mounted) {
                                  bloc.add(const ResultEvent(driverResponseStatus: DriverResultStatus.successful));
                                }
                              }
                            }
                          }: null
                        ) : _bottomButton(context, MyColors.yellow, "Mis vehículos", () => Navigator.pushNamed(context, AppRouter.vehicles)), //Corregir
                        const SizedBox(height: 6),
                        _bottomButton(context, MyColors.danger, "Cerrar sesión", (state is! ProfileLoading) ? logOut: null)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  TextButton _bottomButton(BuildContext context, Color color, String label, VoidCallback? onPressed) => TextButton(
    onPressed: onPressed,
    style: ButtonStyle(
      foregroundColor: const MaterialStatePropertyAll(MyColors.textWhite),
      backgroundColor: MaterialStatePropertyAll(color.withOpacity(0.4)),
      minimumSize: const MaterialStatePropertyAll(Size(300, 60)),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
      side: MaterialStatePropertyAll(BorderSide(color: color))
    ),
    child: Text(label, style: const TextStyle(fontSize: Fontsizes.subTitleFontSize))
  );

  Future<void> logOut() async{
    bool successLogout = await AuthClient().logout();
    if (successLogout && context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, AppRouter.login, (_) => false);
    }else if (context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Fallo en el cierre de sesión. Inténtalo más tarde.", style: TextStyle(color: MyColors.textWhite)),
          backgroundColor: MyColors.purpleTheme,
        )
      );
    }
  }

  Future<bool> get permissionsStatus async{
    Map<Permission, PermissionStatus> statuses = await [Permission.camera, Permission.photos, Permission.manageExternalStorage].request();
    return statuses.values.every((element) => element.isGranted);
  }

  Future<void> imageSourceModal(BuildContext context, ProfileModel model) async{
    showModalBottomSheet(
      context: context,
      builder: (builder){
        return Card(
          child: Container(
            width: SizeConfig.displayWidth(context),
            height: SizeConfig.displayHeight(context) * 0.2,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      bloc.add(UploadImage.fromGallery(model));
                      Navigator.pop(context);
                    },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.image_rounded, color: MyColors.primary),
                        Text("Galería", style: TextStyle(fontSize: Fontsizes.subTitleTwoFontSize, color: MyColors.primary))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      bloc.add(UploadImage.fromCamera(model));
                      Navigator.pop(context);
                    },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_outlined, color: MyColors.primary),
                        Text("Cámara", style: TextStyle(fontSize: Fontsizes.subTitleTwoFontSize, color: MyColors.primary))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Widget content(BuildContext context, ProfileState currentState, VoidCallback reloadAction){
    if (currentState is ProfileLoading) {
      return SliverList.list(
        children: [
          SizedBox(
            height: SizeConfig.displayHeight(context) * 0.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: nameShimmerBox(context),
                ),
                emailShimmerBox(context),
                groupShimmerBox(context)
              ],
            ),
          ),
          SizedBox(height: SizeConfig.displayHeight(context) * 0.025),
          fieldShimmerBox(context),
          SizedBox(height: SizeConfig.displayHeight(context) * 0.025),
          fieldShimmerBox(context)
        ]
      );
    } else if (currentState is ProfileReturned){
      return SliverList.list(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              "${currentState.model.firstName} ${currentState.model.lastName}",
              style: const TextStyle(color: MyColors.textGrey, fontSize: Fontsizes.subTitleTwoFontSize, fontWeight: FontWeight.bold), textAlign: TextAlign.center,
            ),
          ),
          Text(currentState.model.email, style: const TextStyle(color: MyColors.textGrey, fontSize: Fontsizes.bodyTextFontSize), textAlign: TextAlign.center,),
          Text(currentState.model.carrer.toTitleCase(), style: const TextStyle(color: MyColors.textGrey, fontSize: Fontsizes.smallTextFontSize), textAlign: TextAlign.center,),
          ListTile(
            tileColor: MyColors.primary,
            leading: const Icon(Icons.phone, color: MyColors.purpleTheme),
            title: Text(currentState.model.phoneNumber, style: const TextStyle(color: MyColors.textGrey, fontSize: Fontsizes.subTitleTwoFontSize, fontWeight: FontWeight.bold)), 
            subtitle: const Text("Teléfono", style: TextStyle(color: MyColors.textGrey, fontSize: Fontsizes.bodyTextFontSize)),
            enabled: false
          ),
          ListTile(
            tileColor: MyColors.primary,
            leading: const Icon(Icons.male_rounded, color: MyColors.purpleTheme),
            title: Text(currentState.model.gender, style: const TextStyle(color: MyColors.textGrey, fontSize: Fontsizes.subTitleTwoFontSize, fontWeight: FontWeight.bold)), 
            subtitle: const Text("Género", style: TextStyle(color: MyColors.textGrey, fontSize: Fontsizes.bodyTextFontSize)),
            enabled: false
          ),
        ]
      );
    } else if (currentState is ProfileFailed){
      return SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: SizeConfig.displayHeight(context) * 0.2),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.purpleTheme, width: 5),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(iconSize: 50, onPressed: reloadAction, icon: const Icon(Icons.refresh_rounded), color: MyColors.purpleTheme),
              Text("${currentState.message}. Inténtalo de nuevo", style: const TextStyle(color: MyColors.textGrey, fontWeight: FontWeight.bold, fontSize: Fontsizes.subTitleTwoFontSize), textAlign: TextAlign.justify)
            ],
          ),
        ),
      );
    }else {
      return const SliverToBoxAdapter();
    }
  }

  ShimmerPlaceholder fieldShimmerBox(BuildContext context) => ShimmerPlaceholder(width: SizeConfig.displayWidth(context) * 0.8, height: 50, radius: 4.0);

  ShimmerPlaceholder emailShimmerBox(BuildContext context) => ShimmerPlaceholder(width: SizeConfig.displayWidth(context) * 0.5, height: 10);

  ShimmerPlaceholder groupShimmerBox(BuildContext context) => ShimmerPlaceholder(width: SizeConfig.displayWidth(context) * 0.45, height: 8);

  ShimmerPlaceholder nameShimmerBox(BuildContext context) => ShimmerPlaceholder(width: SizeConfig.displayWidth(context) * 0.6, height: 25);

  Color? genderColor(Genders? gender){
    switch (gender) {
      case Genders.masculino:
        return MyColors.backgroundBlue;
      case Genders.femenino:
        return Colors.pink.shade200;
      case Genders.otro:
        return MyColors.orangeDark;
      case Genders.reservado:
        return MyColors.purpleTheme;
      default:
        return null;
    }
  }
}