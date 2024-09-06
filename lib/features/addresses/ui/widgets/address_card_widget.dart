import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/helper/extensions.dart';
import 'package:google_maps/core/routing/routes.dart';
import 'package:google_maps/core/theming/styles.dart';
import 'package:google_maps/core/utlis/spacing.dart';
import 'package:google_maps/core/utlis/string_constants.dart';
import 'package:google_maps/features/addresses/data/model/address_model.dart';
import 'package:google_maps/features/addresses/logic/manage_address_cubit/manage_address_cubit.dart';

class AddressCardWidget extends StatelessWidget {
  const AddressCardWidget({
    super.key,
    required this.savedAddresses,
    required this.addressIndex,
    this.cardColor,
    this.isClickable = true,
  });

  final AddressModel savedAddresses;
  final Color? cardColor;
  final bool isClickable;

  final int addressIndex;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ManageAddressCubit>();
    return Card(
      color: cardColor,
      child: Column(
        children: [
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  savedAddresses.streetName,
                  style: TextStyles.font14BlackW500,
                ),
                horizontalSpacing(4),
                Text(
                  savedAddresses.cityName,
                  style:
                      TextStyles.font14BlackW500.copyWith(color: Colors.grey),
                ),
              ],
            ),
            subtitle: Text(
              savedAddresses.countryName,
              style: TextStyles.font14BlackW500.copyWith(color: Colors.grey),
            ),
          ),
          Row(
            children: [
              TextButton.icon(
                onPressed: isClickable
                    ? () async {
                        context.pushNamed(Routes.addAddressScreen, arguments: {
                          'cubit': cubit,
                          'address': savedAddresses,
                          'isEdit': true,
                          'addressIndex': addressIndex
                        });
                      }
                    : null,
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
                label: Text(
                  context.localization.edit,
                  style:
                      TextStyles.font14BlackW500.copyWith(color: Colors.green),
                ),
              ),
              TextButton.icon(
                onPressed: isClickable
                    ? () {
                        cubit.removeAddress(addressIndex);
                      }
                    : null,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                label: Text(
                  context.localization.delete,
                  style: TextStyles.font14BlackW500.copyWith(color: Colors.red),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
