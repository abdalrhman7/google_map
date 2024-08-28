import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/widgets/base_text_form_field.dart';
import 'package:google_maps/features/addresses/logic/manage_address_cubit/manage_address_cubit.dart';


class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
     var cubit = context.read<ManageAddressCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Address'),
      ),
      body: Form(
        key: cubit.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Street',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              BaseTextFormField(
                hintText: 'enterYourStreetName',
                hintStyle: const TextStyle(color: Colors.grey),
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Street Name Cannot Be Empty';
                  } else {
                    return null;
                  }
                },
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                textAlign: TextAlign.start,
                controller: cubit.streetNameController,
              ),
              const SizedBox(height: 10),
              const Text(
                'City',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              BaseTextFormField(
                hintText: 'Enter Your City Name',
                hintStyle: const TextStyle(color: Colors.grey),
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'City Name Cannot Be Empty';
                  } else {
                    return null;
                  }
                },
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                textAlign: TextAlign.start,
                controller: cubit.cityNameController,
              ),
              const SizedBox(height: 10),
              const Text(
                'Country',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              BaseTextFormField(
                hintText: 'Country Your City Name',
                hintStyle: const TextStyle(color: Colors.grey),
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Country Name Cannot Be Empty';
                  } else {
                    return null;
                  }
                },
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                textAlign: TextAlign.start,
                controller: cubit.countryNameController,
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  if (cubit.formKey.currentState!.validate()) {
                  await  cubit.saveAddress();
                   await cubit.loadSavedAddresses();
                  }},
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Add Address',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}
