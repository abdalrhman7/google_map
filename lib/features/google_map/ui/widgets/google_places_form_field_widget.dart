import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps/features/google_map/logic/google_map_cubit/google_map_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';

class GooglePlacesFormFieldWidget extends StatefulWidget {
  const GooglePlacesFormFieldWidget({
    super.key,
  });


  @override
  State<GooglePlacesFormFieldWidget> createState() =>
      _GooglePlacesFormFieldWidgetState();
}

class _GooglePlacesFormFieldWidgetState
    extends State<GooglePlacesFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<GoogleMapCubit>();
    return GooglePlacesAutoCompleteTextFormField(
      textEditingController: cubit.searchController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
        ),
        hintStyle: const TextStyle(
          fontSize: 15,
          color: Colors.grey,
        ),
        hintText: 'Search Location',
        suffixIcon: cubit.searchController.text.isEmpty
            ? const Icon(Icons.search , size: 22,)
            : InkWell(
          onTap: () {
            cubit.searchController.clear();
            setState(() {});
          },
          child: const Icon(Icons.close , color: Colors.red, size: 22,),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      googleAPIKey: dotenv.env['google_api_key']!,
      debounceTime: 400,
      countries: const ['EG'],
      isLatLngRequired: true,
      onChanged: (value) {
        cubit.searchController.text = value;
      },
      getPlaceDetailWithLatLng: (prediction) {
        cubit.searchController.clear();
        FocusScope.of(context).unfocus();
        LatLng latLng = LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!));
        cubit.goToSearchedLocation(latLng);
      },
      itmClick: (prediction) {
        cubit.searchController.text =
        prediction.description!;
        cubit.searchController.selection =
            TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length));
      },
    );
  }
}