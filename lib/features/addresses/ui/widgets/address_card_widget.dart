import 'package:flutter/material.dart';

class AddressCardWidget extends StatelessWidget {
  const AddressCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Street',
                  style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4),
                Text(
                  'City',
                  style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w500 , color: Colors.grey),
                ),
              ],
            ),
            subtitle: Text(
              'country',
              style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w500 , color: Colors.grey),
            ),
          ),
          Row(
            children: [
              TextButton.icon(
                onPressed: () async{
                  // var result = await context.pushNamed(Routes.addAddressScreen, arguments: addressesModel);
                  // if (result != null) {
                  //   cubit.getAddressData();
                  // }
                },
                icon: const Icon(Icons.edit , color: Colors.green,) ,
                label: const Text(
                  'Edit',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.green),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  // cubit.deleteAddress(addressesModel);
                },
                icon: const Icon(Icons.delete , color: Colors.red,) ,
                label: const Text(
                  'Delete',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}