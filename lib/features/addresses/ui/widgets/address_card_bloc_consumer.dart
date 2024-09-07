import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/helper/extensions.dart';
import 'package:google_maps/core/utlis/string_constants.dart';
import 'package:google_maps/features/addresses/logic/manage_address_cubit/manage_address_cubit.dart';
import 'package:google_maps/features/addresses/ui/widgets/address_card_widget.dart';

class AddressCardBlocConsumer extends StatefulWidget {
  const AddressCardBlocConsumer({
    super.key,
  });

  @override
  State<AddressCardBlocConsumer> createState() => _AddressCardBlocConsumerState();
}

class _AddressCardBlocConsumerState extends State<AddressCardBlocConsumer> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ManageAddressCubit>();
    return BlocConsumer<ManageAddressCubit, ManageAddressState>(
      listener: (context, state) {
        if (state is SavedAddressSuccess || state is UpdateAddressSuccess) {
          cubit.resetForm();
          context.pop();
        }
      },
      builder: (context, state) {
        if (state is LoadSavedAddressesLoading) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        } else if (state is EmptySavedAddresses) {
          return  Expanded(
            child: Center(
                child: Text(
                  context.localization.noAddressesFound,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )),
          );
        }
        return Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if (cubit.selectedAddresses.isNotEmpty) {
                    cubit.selectedAddresses
                            .contains(cubit.savedAddresses[index])
                        ? cubit.selectedAddresses
                            .remove(cubit.savedAddresses[index])
                        : cubit.selectedAddresses
                            .add(cubit.savedAddresses[index]);
                    if (cubit.selectedAddresses.isEmpty) {
                      cubit.toggleIsAddressSelected();
                    }
                    setState(() {
                    });
                    print(cubit.isAddressSelected);
                  }
                },
                onLongPress: () {
                  if (cubit.selectedAddresses.isEmpty) {
                    cubit.selectedAddresses.add(cubit.savedAddresses[index]);
                    cubit.toggleIsAddressSelected();
                  }
                },
                child: BlocBuilder<ManageAddressCubit, ManageAddressState>(
                  buildWhen: (previous, current) =>
                      current is ToggleIsAddressSelected,
                  builder: (context, state) {
                    return AddressCardWidget(
                      savedAddresses: cubit.savedAddresses[index],
                      addressIndex: index,
                      cardColor: cubit.selectedAddresses
                              .contains(cubit.savedAddresses[index])
                          ? Colors.grey.shade400
                          : null,
                      isClickable:
                          cubit.selectedAddresses.isNotEmpty ? false : true,
                    );
                  },
                ),
              );
            },
            itemCount: cubit.savedAddresses.length,
          ),
        );
      },
    );
  }
}
