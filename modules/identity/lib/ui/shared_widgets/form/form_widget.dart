import 'package:flutter/material.dart';
import 'package:identity/ui/shared_widgets/form/base_form.dart';
import 'package:identity/ui/shared_widgets/form/widgets/form_separator_widget.dart';
import 'package:identity/ui/shared_widgets/form/widgets/name_form_input_widget.dart';
import 'package:identity/ui/shared_widgets/form/widgets/number_form_input_widget.dart';
import 'package:identity/ui/shared_widgets/form/widgets/password_form_input_widget.dart';
import 'package:identity/ui/shared_widgets/form/widgets/text_form_input_widget.dart';

typedef FormInputBuilder = Widget Function(
    BuildContext context, FormElement element, InputDecoration decoration);

final Map<Type, FormInputBuilder> _fromInputMapper = {
  FormSeparator: (ctx, input, decoration) => FormSeparatorWidget(),
  NumberFormInput: (ctx, input, decoration) => NumberFormInputWidget(
      formInput: input as NumberFormInput, inputDecoration: decoration),
  NameFormInput: (ctx, input, decoration) => NameFormInputWidget(
      formInput: input as NameFormInput, inputDecoration: decoration),
  TextFormInput: (ctx, input, decoration) => TextFormInputWidget(
      formInput: input as TextFormInput, inputDecoration: decoration),
  PasswordFormInput: (ctx, input, decoration) => PasswordFormInputWidget(
      formInput: input as PasswordFormInput, inputDecoration: decoration),
};

class FormWidget extends StatefulWidget {
  final List<FormElement> formElements;
  final InputDecoration inputDecoration;

  const FormWidget({
    Key? key,
    required this.formElements,
    this.inputDecoration = const InputDecoration(),
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  Widget _mapFormInputWidget(BuildContext context, FormElement element,
          InputDecoration decoration) =>
      _fromInputMapper[element.runtimeType]
          ?.call(context, element, decoration) ??
      SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.formElements.length,
        itemBuilder: (context, index) => _mapFormInputWidget(
              context,
              widget.formElements[index],
              widget.inputDecoration,
            ));
  }
}
