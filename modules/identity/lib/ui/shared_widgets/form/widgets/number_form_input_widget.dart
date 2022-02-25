import 'package:flutter/material.dart';
import 'package:identity/ui/shared_widgets/form/base_form.dart';

class NumberFormInputWidget extends StatelessWidget {
  final NumberFormInput formInput;
  final InputDecoration inputDecoration;

  const NumberFormInputWidget({
    Key? key,
    required this.formInput,
    this.inputDecoration = const InputDecoration(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: formInput.inputType,
      controller: formInput.controller,
      decoration: inputDecoration.copyWith(
        labelText: formInput.caption,
        hintText: formInput.hint,
      ),
    );
  }
}
