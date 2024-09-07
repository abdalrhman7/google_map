import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/core/helper/extensions.dart';
import 'package:google_maps/core/theming/styles.dart';
import 'package:google_maps/core/utlis/spacing.dart';
import 'package:google_maps/features/settings/logic/setting_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localization.settings,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 0.5,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  child: BlocBuilder<SettingCubit, SettingState>(
                    builder: (context, state) {
                      final cubit = context.read<SettingCubit>();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.localization.languages,
                            style: TextStyles.font16BlackW500,
                          ),
                          const Divider(thickness: 1),
                          ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            title: Text(
                              context.localization.english,
                              style: TextStyles.font16BlackW500,
                            ),
                            trailing: Radio(
                              value: 'en',
                              groupValue: cubit.currentLanguageCode,
                              onChanged: (value) {
                                cubit.toEnglish();
                              },
                              activeColor: Colors.purple,
                            ),
                          ),
                          ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            title: Text(
                              context.localization.arabic,
                              style: TextStyles.font16BlackW500,
                            ),
                            trailing: Radio(
                              value: 'ar',
                              groupValue: cubit.currentLanguageCode,
                              onChanged: (value) {
                                cubit.toArabic();
                              },
                              activeColor: Colors.purple,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
