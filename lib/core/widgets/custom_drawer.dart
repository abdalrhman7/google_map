import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/helper/extensions.dart';
import 'package:google_maps/core/routing/app_router.dart';
import 'package:google_maps/core/routing/routes.dart';
import 'package:google_maps/core/utlis/string_constants.dart';
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
          const SizedBox(
            height: 120,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                StringConstants.appSettings,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              context.pushNamed(Routes.myAddressesScreen , arguments: cubit.currentLocation);
            },
            title: const Text(
              StringConstants.myAddresses,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
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