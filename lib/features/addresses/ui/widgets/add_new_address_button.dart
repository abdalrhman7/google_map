import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps/core/helper/extensions.dart';
import 'package:google_maps/core/routing/routes.dart';
import 'package:google_maps/core/theming/styles.dart';
import 'package:google_maps/features/addresses/logic/manage_address_cubit/manage_address_cubit.dart';

class AddNewAddressButton extends StatelessWidget {
  const AddNewAddressButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ManageAddressCubit>();
    return InkWell(
      onTap: () async {
        await context.pushNamed(
          Routes.addAddressScreen,
          arguments: {
            'cubit': cubit,
            'isEdit': false,
          }
          ,
        );
      },
      child:  SizedBox(
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle_outline,
                size: 32, color: Colors.purple),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
            Text(
              context.localization.addNewAddress,
            ),
          ],
        ),
      ),
    );
  }
}