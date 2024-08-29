import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/helper/shared_pref_helper.dart';
import 'package:google_maps/features/addresses/data/model/address_model.dart';

part 'manage_address_state.dart';

class ManageAddressCubit extends Cubit<ManageAddressState> {
  ManageAddressCubit() : super(ManageAddressInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController countryNameController = TextEditingController();
  List<AddressModel> savedAddresses = [];

  Future<void> saveAddress() async {
    final AddressModel newAddress = AddressModel(
      streetName: streetNameController.text,
      cityName: cityNameController.text,
      countryName: countryNameController.text,
    );

    savedAddresses.add(newAddress);

    final List<String> encodedAddresses =
        savedAddresses.map((address) => jsonEncode(address.toJson())).toList();

    await SharedPrefHelper.setList('addresses', encodedAddresses);
    emit(SavedAddressSuccess());
  }

  Future<void> loadSavedAddresses() async {
    emit(LoadSavedAddressesLoading());
    final List<String> storedAddresses =
        await SharedPrefHelper.getList('addresses');

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
    await SharedPrefHelper.setList('addresses', encodedAddresses);
    if (savedAddresses.isEmpty) {
      emit(EmptySavedAddresses());
    } else {
      emit(RemoveAddressSuccess());
    }
  }

  void resetForm() {
    streetNameController.clear();
    cityNameController.clear();
    countryNameController.clear();
  }
}
