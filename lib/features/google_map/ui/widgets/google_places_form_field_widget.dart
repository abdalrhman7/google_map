

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps/features/google_map/logic/google_map_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';

class GooglePlacesFormFieldWidget extends StatefulWidget {
  const GooglePlacesFormFieldWidget({
    super.key,
    required this.cubit,
  });
  final GoogleMapCubit cubit ;


  @override
  State<GooglePlacesFormFieldWidget> createState() =>
      _GooglePlacesFormFieldWidgetState();
}

class _GooglePlacesFormFieldWidgetState
    extends State<GooglePlacesFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return GooglePlacesAutoCompleteTextFormField(
      textEditingController: widget.cubit.googleMapAutoCompleteController,
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
        suffixIcon: widget.cubit.googleMapAutoCompleteController.text.isEmpty
            ? const Icon(Icons.search , size: 22,)
            : InkWell(
          onTap: () {
            widget.cubit.googleMapAutoCompleteController.clear();
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
        widget.cubit.googleMapAutoCompleteController.text = value;
      },
      getPlaceDetailWithLatLng: (prediction) {
        widget.cubit.googleMapAutoCompleteController.clear();
        FocusScope.of(context).unfocus();
        LatLng latLng = LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!));
        widget.cubit.goToSearchedLocation(latLng);
      },
      itmClick: (prediction) {
        widget.cubit.googleMapAutoCompleteController.text =
        prediction.description!;
        widget.cubit.googleMapAutoCompleteController.selection =
            TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length));
      },
    );
  }
}