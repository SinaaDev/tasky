import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../bloc/auth_cubit.dart';

class PhoneField extends StatelessWidget {
  // const PhoneField({
  //   super.key,
  //   required TextEditingController phoneNumberController,
  // }) : _phoneNumberController = phoneNumberController;
  //
  // final TextEditingController _phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 22),
      padding: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12)),
      child: InternationalPhoneNumberInput(
        maxLength: 10,
        hintText: '123 456-789',
        onInputChanged: (PhoneNumber number) {
          print(number.phoneNumber);
          BlocProvider.of<AuthCubit>(context, listen: false)
              .phoneNumber = number.phoneNumber;
        },
        // onInputValidated: (bool value) {
        //   print(value);
        // },
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        ignoreBlank: false,
        // autoValidateMode: AutovalidateMode.onUserInteraction,
        // selectorTextStyle: TextStyle(color: Colors.black),
        initialValue: PhoneNumber(isoCode: 'AF'),
        // textFieldController: _phoneNumberController,
        formatInput: false,
        keyboardType: TextInputType.number,
        inputBorder: InputBorder.none,
        onSaved: (PhoneNumber number) {
          print('Saved: ${number.phoneNumber}');
        },
      ),
    );
  }
}
