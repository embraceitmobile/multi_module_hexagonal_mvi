import 'package:flutter/material.dart';
import 'package:identity/presentation/shared_widgets/form/base_form.dart';

class TextFormInputWidget extends StatelessWidget {
  final TextFormInput formInput;
  final InputDecoration inputDecoration;

  const TextFormInputWidget(
      {Key? key,
      required this.formInput,
      this.inputDecoration = const InputDecoration()})
      : super(key: key);

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
