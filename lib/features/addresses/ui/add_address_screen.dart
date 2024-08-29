import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/utlis/string_constants.dart';
import 'package:google_maps/core/widgets/base_text_form_field.dart';
import 'package:google_maps/features/addresses/logic/manage_address_cubit/manage_address_cubit.dart';


class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
     var cubit = context.read<ManageAddressCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.addNewAddress),
      ),
      body: Form(
        key: cubit.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                StringConstants.street,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              BaseTextFormField(
                hintText: StringConstants.enterYourStreetName,
                hintStyle: const TextStyle(color: Colors.grey),
                validator: (v) {
                  if (v!.isEmpty) {
                    return StringConstants.streetNameCannotBeEmpty;
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
                StringConstants.city,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              BaseTextFormField(
                hintText: StringConstants.enterYourCityName,
                hintStyle: const TextStyle(color: Colors.grey),
                validator: (v) {
                  if (v!.isEmpty) {
                    return StringConstants.cityNameCannotBeEmpty;
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
                StringConstants.country,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              BaseTextFormField(
                hintText: StringConstants.cityNameCannotBeEmpty,
                hintStyle: const TextStyle(color: Colors.grey),
                validator: (v) {
                  if (v!.isEmpty) {
                    return StringConstants.countryNameCannotBeEmpty;
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
                    StringConstants.addAddress,
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
