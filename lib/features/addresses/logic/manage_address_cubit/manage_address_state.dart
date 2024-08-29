part of 'manage_address_cubit.dart';

@immutable
sealed class ManageAddressState {}

final class ManageAddressInitial extends ManageAddressState {}

final class LoadSavedAddressesLoading extends ManageAddressState {}

final class LoadSavedAddressesSuccess extends ManageAddressState {}

final class EmptySavedAddresses extends ManageAddressState {}

final class RemoveAddressSuccess extends ManageAddressState {}


final class SavedAddressSuccess extends ManageAddressState {}