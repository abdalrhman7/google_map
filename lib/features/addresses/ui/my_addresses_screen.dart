import 'package:flutter/material.dart';
import 'package:google_maps/features/addresses/ui/widgets/add_new_address_button.dart';
import 'package:google_maps/features/addresses/ui/widgets/address_card_bloc_consumer.dart';

class MyAddressesScreen extends StatelessWidget {
  const MyAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Addresses'),
      ),
      body: const Padding(
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
    );
  }
}




