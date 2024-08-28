import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/helper/extensions.dart';
import 'package:google_maps/core/routing/routes.dart';
import 'package:google_maps/features/addresses/logic/manage_address_cubit/manage_address_cubit.dart';
import 'package:google_maps/features/addresses/ui/widgets/address_card_widget.dart';

class MyAddressesScreen extends StatelessWidget {
  const MyAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ManageAddressCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Addresses'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return const AddressCardWidget();
                },
                itemCount: 3,
              ),
            ),
            const SizedBox(height: 18),
            InkWell(
              onTap: () async {
                var result = await context.pushNamed(Routes.addAddressScreen , arguments:cubit);
                // if (result != null) {
                //   cubit.getAddressData();
                // }
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
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
