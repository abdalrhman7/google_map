import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/helper/shared_pref_helper.dart';
import 'package:google_maps/core/utlis/string_constants.dart';
import 'package:google_maps/features/addresses/data/model/address_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'manage_address_state.dart';

class ManageAddressCubit extends Cubit<ManageAddressState> {
  ManageAddressCubit() : super(ManageAddressInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController countryNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  List<AddressModel> savedAddresses = [];

  Future<void> saveAddress() async {
    final AddressModel newAddress = AddressModel(
      streetName: streetNameController.text,
      cityName: cityNameController.text,
      countryName: countryNameController.text,
      latLng: locationController.text,
    );

    savedAddresses.add(newAddress);

    final List<String> encodedAddresses =
        savedAddresses.map((address) => jsonEncode(address.toJson())).toList();

    await SharedPrefHelper.setList(StringConstants.addressesPrefKey, encodedAddresses);
    emit(SavedAddressSuccess());
  }

  Future<void> loadSavedAddresses() async {
    emit(LoadSavedAddressesLoading());
    final List storedAddresses =
        await SharedPrefHelper.getList(StringConstants.addressesPrefKey);

    if (storedAddresses.isEmpty) {
      emit(EmptySavedAddresses());
      return;
    }

    savedAddresses = storedAddresses
        .map((encodedAddress) => AddressModel.fromJson(
            jsonDecode(encodedAddress) as Map<String, dynamic>))
        .toList();
    emit(LoadSavedAddressesSuccess());
  }

  Future<void> removeAddress(int index) async {
    savedAddresses.removeAt(index);
    final List<String> encodedAddresses =
        savedAddresses.map((address) => jsonEncode(address.toJson())).toList();
    await SharedPrefHelper.setList(StringConstants.addressesPrefKey, encodedAddresses);
    if (savedAddresses.isEmpty) {
      emit(EmptySavedAddresses());
    } else {
      emit(RemoveAddressSuccess());
    }
  }

  Future<void> updateAddress(int index) async {
    final AddressModel updatedAddress = AddressModel(
      streetName: streetNameController.text,
      cityName: cityNameController.text,
      countryName: countryNameController.text,
      latLng: locationController.text,
    );
    savedAddresses[index] = updatedAddress;
    final List<String> encodedAddresses =
        savedAddresses.map((address) => jsonEncode(address.toJson())).toList();
    await SharedPrefHelper.setList(StringConstants.addressesPrefKey, encodedAddresses);
    emit(UpdateAddressSuccess());
  }

  void resetForm() {
    streetNameController.clear();
    cityNameController.clear();
    countryNameController.clear();
  }
}
