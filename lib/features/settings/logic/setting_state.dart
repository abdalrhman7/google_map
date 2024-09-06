part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class LanguageChange extends SettingState {
  final Locale locale;

  LanguageChange({required this.locale});
}

class NotificationSettingChangeLoading extends SettingState {}

class NotificationSettingChangeSuccess extends SettingState {
  final bool sendNotification;

  NotificationSettingChangeSuccess({required this.sendNotification});
}

class NotificationSettingChangeError extends SettingState {}



