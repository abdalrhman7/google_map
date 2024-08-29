import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/helper/extensions.dart';
import 'package:google_maps/core/routing/routes.dart';
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
          arguments: cubit,
        );
      },
      child: const SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline,
                size: 32, color: Colors.purple),
            Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
            Text(
              'Add New Address',
            ),
          ],
        ),
      ),
    );
  }
}