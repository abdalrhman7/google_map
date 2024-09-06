import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/helper/shared_pref_helper.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
  String currentLanguageCode = 'en';

  Future<void> getSavedLanguage() async {
    final result = SharedPrefHelper.getString('langCode');
    currentLanguageCode = result;
    log('currentLanguageCode: $currentLanguageCode');
    emit(LanguageChange(locale: Locale(currentLanguageCode)));
  }

  Future<void> _changeLanguage(String langCode) async {
    currentLanguageCode = langCode;
    await SharedPrefHelper.setData('langCode', currentLanguageCode);
    emit(LanguageChange(locale: Locale(currentLanguageCode)));
  }

  void toArabic() => _changeLanguage('ar');

  void toEnglish() => _changeLanguage('en');
}
