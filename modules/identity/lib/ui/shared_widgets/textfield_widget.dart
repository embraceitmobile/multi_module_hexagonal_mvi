import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData? icon;
  final String? hint;
  final String? errorText;
  final bool isObscure;
  final bool isIcon;
  final bool autoFocus;
  final bool enabled;
  final bool autocorrect;
  final bool enableSuggestions;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final InputDecoration? decoration;
  final VoidCallback? onTap;

  const TextFieldWidget({
    Key? key,
    this.decoration,
    this.icon,
    this.hint,
    this.errorText,
    this.isObscure = false,
    this.autocorrect = false,
    this.inputType,
    this.enableSuggestions = false,
    this.textController,
    this.isIcon = true,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.autoFocus = false,
    this.enabled = true,
    this.inputAction,
    this.onChanged,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        enabled: enabled,
        onTap: onTap,
        autocorrect: autocorrect ,
        enableSuggestions: enableSuggestions,
        controller: textController,
        focusNode: focusNode,
        onSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        autofocus: autoFocus,
        textInputAction: inputAction,
        obscureText: this.isObscure,
        maxLength: 50,
        textAlignVertical: TextAlignVertical.bottom,
        keyboardType: this.inputType,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.normal),
        decoration: decoration ??
            InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8, horizontal: 12.0),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(5.0),
                ),
                borderSide: new BorderSide(
                  color: Theme.of(context)
                      .textTheme
                      .headline6!
                      .color!
                      .withOpacity(0.25),
                  width: 1.0,
                ),
              ),
              hintText: this.hint,
              labelText: this.hint,
              hintStyle: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: hintColor, fontWeight: FontWeight.normal),
              errorText: errorText,
              errorStyle: TextStyle(fontSize: 11.0),
              counterText: '',
              icon: this.isIcon ? Icon(this.icon, color: iconColor) : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(5.0),
                ),
                borderSide: new BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.0,
                ),
              ),
            ),
      ),
    );
  }
}
