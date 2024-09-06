import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/helper/extensions.dart';
import 'package:google_maps/core/routing/routes.dart';
import 'package:google_maps/core/theming/styles.dart';
import 'package:google_maps/features/google_map/logic/google_map_cubit/google_map_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   var cubit = context.read<GoogleMapCubit>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
           SizedBox(
            height: 120,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                context.localization.appSettings,
                style:  TextStyles.font18BlackW700.copyWith(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              context.pushNamed(Routes.myAddressesScreen , arguments: cubit.currentLocation);
            },
            title:  Text(
              context.localization.myAddresses,
              style:  TextStyles.font16BlackW500,
            ),
            trailing:  const Icon(Icons.arrow_forward_ios , size: 16,),
          ),
          const Divider(
            color: Colors.grey,
            height: 1,
            thickness: .5,
          ),
          ListTile(
            onTap: () {
              context.pushNamed(Routes.settingScreen);
            },
            title:  Text(
              context.localization.settings,
              style: TextStyles.font16BlackW500,
            ),
            trailing:  const Icon(Icons.arrow_forward_ios , size: 16,),
          ),
          const Divider(
            color: Colors.grey,
            height: 1,
            thickness: .5,
          )
        ],
      ),
    );
  }
}