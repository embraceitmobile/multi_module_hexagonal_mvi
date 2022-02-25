import 'package:flutter/material.dart';
import 'package:identity/ui/shared_widgets/form/base_form.dart';

class PasswordFormInputWidget extends StatelessWidget {
  final PasswordFormInput formInput;
  final InputDecoration inputDecoration;

  const PasswordFormInputWidget({
    Key? key,
    required this.formInput,
    this.inputDecoration = const InputDecoration(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: formInput.inputType,
      controller: formInput.controller,
      obscureText: true,
      autocorrect: false,
      enableSuggestions:false,
      decoration: inputDecoration.copyWith(
        labelText: formInput.caption,
        hintText: formInput.hint,
      ),
    );
  }
}
