import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/helper/extensions.dart';
import 'package:google_maps/core/utlis/string_constants.dart';
import 'package:google_maps/features/addresses/logic/manage_address_cubit/manage_address_cubit.dart';
import 'package:google_maps/features/addresses/ui/widgets/address_card_widget.dart';

class AddressCardBlocConsumer extends StatelessWidget {
  const AddressCardBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ManageAddressCubit>();
    return BlocConsumer<ManageAddressCubit, ManageAddressState>(
      listener: (context, state) {
        if (state is SavedAddressSuccess) {
          cubit.resetForm();
          context.pop();
        }
      },
      builder: (context, state) {
        if (state is LoadSavedAddressesLoading) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        } else if (state is EmptySavedAddresses) {
          return const Expanded(
            child: Center(
                child: Text(
              StringConstants.noAddressesFound,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )),
          );
        }
        return Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return AddressCardWidget(
                savedAddresses: cubit.savedAddresses[index],
                addressIndex: index,
              );
            },
            itemCount: cubit.savedAddresses.length,
          ),
        );
      },
    );
  }
}
