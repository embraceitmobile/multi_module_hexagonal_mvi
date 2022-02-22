import 'package:flutter/widgets.dart';

typedef InputValidator = bool Function(String? value);

mixin FormElement {}

class FormSeparator with FormElement {}

class FormInput<T extends Object> with FormElement {
  final String caption;
  final TextEditingController controller;
  final String? hint;
  final T? data;
  final TextInputType? inputType;
  late final ValueGetter<bool>? validator;

  FormInput({
    required this.caption,
    this.hint,
    this.data,
    this.inputType,
    InputValidator? validator,
  }) : controller = TextEditingController(text: data.toString()) {
    if (validator != null) {
      this.validator = () => validator.call(controller.text);
    }
  }

  void dispose() => controller.dispose();
}

class TextFormInput extends FormInput<String> {
  TextFormInput(
      {required String caption,
      String? hint,
      String? data,
      InputValidator? validator,
      bool isSingleLine = false})
      : super(
            caption: caption,
            hint: hint,
            data: data,
            validator: validator,
            inputType:
                isSingleLine ? TextInputType.text : TextInputType.multiline);
}

class NumberFormInput extends FormInput<num> {
  NumberFormInput(
      {required String caption,
      String? hint,
      num? data,
      InputValidator? validator,
      bool signed = false,
      bool decimal = false})
      : super(
            caption: caption,
            hint: hint,
            data: data,
            validator: validator,
            inputType: signed && decimal
                ? TextInputType.numberWithOptions(
                    signed: signed, decimal: decimal)
                : TextInputType.number);
}

class PasswordFormInput extends FormInput<String> {
  PasswordFormInput(
      {required String caption,
      String? hint,
      String? data,
      InputValidator? validator})
      : super(
            caption: caption,
            hint: hint,
            data: data,
            validator: validator,
            inputType: TextInputType.visiblePassword);
}

class PhoneFormInput extends FormInput<String> {
  PhoneFormInput(
      {required String caption,
      String? hint,
      String? data,
      InputValidator? validator})
      : super(
            caption: caption,
            hint: hint,
            data: data,
            validator: validator,
            inputType: TextInputType.phone);
}

class EmailFormInput extends FormInput<String> {
  EmailFormInput(
      {required String caption,
      String? hint,
      String? data,
      InputValidator? validator})
      : super(
            caption: caption,
            hint: hint,
            data: data,
            validator: validator,
            inputType: TextInputType.emailAddress);
}

class UrlFormInput extends FormInput<String> {
  UrlFormInput(
      {required String caption,
      String? hint,
      String? data,
      InputValidator? validator})
      : super(
            caption: caption,
            hint: hint,
            data: data,
            validator: validator,
            inputType: TextInputType.url);
}

class DateTimeFormInput extends FormInput<String> {
  DateTimeFormInput(
      {required String caption,
      String? hint,
      String? data,
      InputValidator? validator})
      : super(
            caption: caption,
            hint: hint,
            data: data,
            validator: validator,
            inputType: TextInputType.datetime);
}
