import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/features/addresses/logic/manage_address_cubit/manage_address_cubit.dart';
import 'package:google_maps/features/addresses/ui/widgets/add_new_address_button.dart';
import 'package:google_maps/features/addresses/ui/widgets/address_card_bloc_consumer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyAddressesScreen extends StatefulWidget {
  const MyAddressesScreen({super.key, required this.currentLocation});

  final LatLng currentLocation;

  @override
  State<MyAddressesScreen> createState() => _MyAddressesScreenState();
}

class _MyAddressesScreenState extends State<MyAddressesScreen> {
  @override
  void initState() {
    context.read<ManageAddressCubit>().locationController.text =
        '${widget.currentLocation.latitude} , ${widget.currentLocation.longitude}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ManageAddressCubit>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: BlocBuilder<ManageAddressCubit, ManageAddressState>(
          buildWhen: (previous, current) => current is ToggleIsAddressSelected,
          builder: (context, state) {
            return AppBar(
              title: const Text('Addresses'),
              actions: [
                cubit.isAddressSelected
                    ? IconButton(
                        onPressed: () {
                          cubit.removeSelectedAddresses();
                        },
                        icon: const Icon(Icons.delete))
                    : const SizedBox.shrink(),
                cubit.isAddressSelected
                    ? TextButton(
                        onPressed: () {
                          cubit.selectAllAddress();
                        },
                        child: const Text('Select All'))
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (cubit.isAddressSelected) {
            // cubit.clearSelectedAddresses();
          }
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AddressCardBlocConsumer(),
              SizedBox(height: 18),
              AddNewAddressButton(),
              SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
