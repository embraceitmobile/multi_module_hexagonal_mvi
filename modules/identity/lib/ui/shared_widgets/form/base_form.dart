import 'package:flutter/widgets.dart';

typedef InputValidator<T> = bool Function(T? value);

mixin FormElement {}

class FormSeparator with FormElement {}

abstract class FormInput<T extends Object> with FormElement {
  final String caption;
  final TextEditingController _controller;
  final String? hint;
  final TextInputType? inputType;

  ValueGetter<bool>? get validator;

  T? get data;

  FormInput({
    required this.caption,
    this.hint,
    this.inputType,
    T? data,
  }) : _controller = TextEditingController(text: data.toString());

  void dispose() => _controller.dispose();
}

abstract class StringFormInput extends FormInput<String> {
  late final InputValidator<String>? _validator;

  StringFormInput(
      {required String caption,
      String? hint,
      String? data,
      InputValidator<String>? validator,
      TextInputType? inputType})
      : _validator = validator,
        super(caption: caption, hint: hint, data: data, inputType: inputType);

  @override
  String? get data => _controller.text;

  @override
  ValueGetter<bool>? get validator {
    if (_validator == null) return null;
    return () => _validator!.call(data);
  }
}

class NumberFormInput extends FormInput<num> {
  late final InputValidator<num>? _validator;

  NumberFormInput(
      {required String caption,
      String? hint,
      num? data,
      InputValidator<num>? validator,
      bool signed = false,
      bool decimal = false})
      : _validator = validator,
        super(
            caption: caption,
            hint: hint,
            data: data,
            inputType: signed && decimal
                ? TextInputType.numberWithOptions(
                    signed: signed, decimal: decimal)
                : TextInputType.number);

  @override
  num? get data => num.tryParse(_controller.text);

  @override
  ValueGetter<bool>? get validator {
    if (_validator == null) return null;
    return () => _validator!.call(data);
  }
}

class TextFormInput extends StringFormInput {
  TextFormInput(
      {required String caption,
      String? hint,
      String? data,
      InputValidator<String>? validator,
      bool isSingleLine = false})
      : super(
            caption: caption,
            hint: hint,
            data: data,
            inputType:
                isSingleLine ? TextInputType.text : TextInputType.multiline);
}

class PasswordFormInput extends StringFormInput {
  PasswordFormInput(
      {required String caption,
      String? hint,
      String? data,
      InputValidator<String>? validator})
      : super(
            caption: caption,
            hint: hint,
            data: data,
            inputType: TextInputType.visiblePassword);
}

class PhoneFormInput extends StringFormInput {
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

class EmailFormInput extends StringFormInput {
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

class UrlFormInput extends StringFormInput {
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

class DateTimeFormInput extends FormInput<DateTime> {
  late final InputValidator<DateTime>? _validator;

  DateTimeFormInput(
      {required String caption,
      String? hint,
      DateTime? data,
      InputValidator<DateTime>? validator})
      : super(
            caption: caption,
            hint: hint,
            data: data,
            inputType: TextInputType.datetime);

  @override
  DateTime? get data => DateTime.tryParse(_controller.text);

  @override
  ValueGetter<bool>? get validator {
    if (_validator == null) return null;
    return () => _validator!.call(data);
  }
}
