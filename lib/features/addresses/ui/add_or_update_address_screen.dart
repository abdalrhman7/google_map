import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps/core/helper/extensions.dart';
import 'package:google_maps/core/theming/styles.dart';
import 'package:google_maps/core/utlis/spacing.dart';
import 'package:google_maps/core/utlis/string_constants.dart';
import 'package:google_maps/core/widgets/base_text_form_field.dart';
import 'package:google_maps/features/addresses/data/model/address_model.dart';
import 'package:google_maps/features/addresses/logic/manage_address_cubit/manage_address_cubit.dart';
import 'package:google_maps/l10n/app_localizations.dart';

class AddOrUpdateAddressScreen extends StatefulWidget {
  const AddOrUpdateAddressScreen({super.key, required this.addressMap});

  final Map<String, dynamic> addressMap;

  @override
  State<AddOrUpdateAddressScreen> createState() =>
      _AddOrUpdateAddressScreenState();
}

class _AddOrUpdateAddressScreenState extends State<AddOrUpdateAddressScreen> {
  bool isUpdate = false;

  @override
  void initState() {
    if (widget.addressMap['isUpdate'] == true) {
      var cubit = context.read<ManageAddressCubit>();
      final AddressModel addressModel = widget.addressMap['address'];
      cubit.streetNameController.text =
          addressModel.streetName;
      cubit.cityNameController.text =
          addressModel.cityName;
      cubit.countryNameController.text =
          addressModel.countryName;
      isUpdate = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ManageAddressCubit>();
    return Scaffold(
      appBar: AppBar(
        title:  Text(isUpdate ? context.localization.updateAddress : context.localization.addNewAddress),
      ),
      body: Form(
        key: cubit.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                 context.localization.street,
                style: TextStyles.font16BlackW500,
              ),
              horizontalSpacing(4),
              BaseTextFormField(
                hintText: context.localization.enterYourStreetName,
                hintStyle: const TextStyle(color: Colors.grey),
                validator: (v) {
                  if (v!.isEmpty) {
                    return context.localization.streetNameCannotBeEmpty;
                  } else {
                    return null;
                  }
                },
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                textAlign: TextAlign.start,
                controller: cubit.streetNameController,
              ),
              horizontalSpacing(10),
               Text(
                context.localization.city,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              horizontalSpacing(4),
              BaseTextFormField(
                hintText: context.localization.enterYourCityName,
                hintStyle: const TextStyle(color: Colors.grey),
                validator: (v) {
                  if (v!.isEmpty) {
                    return context.localization.cityNameCannotBeEmpty;
                  } else {
                    return null;
                  }
                },
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                textAlign: TextAlign.start,
                controller: cubit.cityNameController,
              ),
              horizontalSpacing(10),
               Text(
                 context.localization.country,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              BaseTextFormField(
                hintText: context.localization.enterYourCountryName,
                hintStyle: const TextStyle(color: Colors.grey),
                validator: (v) {
                  if (v!.isEmpty) {
                    return context.localization.countryNameCannotBeEmpty;
                  } else {
                    return null;
                  }
                },
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                textAlign: TextAlign.start,
                controller: cubit.countryNameController,
              ),
              const SizedBox(height: 10),
               Text(
                context.localization.location,
                style: TextStyles.font16BlackW500,
              ),
              const SizedBox(height: 4),
              BaseTextFormField(
                hintText: context.localization.location,
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                readOnly: true,
                textAlign: TextAlign.start,
                controller: cubit.locationController,
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  if (cubit.formKey.currentState!.validate()) {
                    if (isUpdate) {
                      await cubit.updateAddress(widget.addressMap['addressIndex']);
                    } else {
                      await cubit.saveAddress();
                      await cubit.loadSavedAddresses();
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isUpdate
                        ? context.localization.updateAddress
                        : context.localization.addAddress,
                    style: TextStyles.font16BlackW500.copyWith(color: Colors.white),
                  ),
                ),
              ),
              horizontalSpacing(14),
            ],
          ),
        ),
      ),
    );
  }
}
