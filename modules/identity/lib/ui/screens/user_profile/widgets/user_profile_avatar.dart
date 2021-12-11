import 'package:cubivue_utils/basic_utils.dart';
import 'package:flutter/material.dart';

class UserProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? userName;
  final double size;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final Color borderColor;
  final double? borderWidth;
  final Color? textColor;
  final double? fontSize;
  final bool showDropShadow;

  const UserProfileAvatar({
    Key? key,
    this.imageUrl,
    this.userName,
    this.size = 200.0,
    this.borderColor = Colors.white,
    this.borderWidth,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
    this.showDropShadow = true,
  }) : super(key: key);

  /// Suitable for use in [AppBar]
  factory UserProfileAvatar.small({
    Key? key,
    String? imageUrl,
    String? userName,
    Color? borderColor,
    Color? backgroundColor,
    Color? textColor,
    bool showDropShadow = false,
  }) =>
      UserProfileAvatar(
        key: key,
        imageUrl: imageUrl,
        userName: userName,
        borderColor: borderColor ?? Colors.white,
        backgroundColor: backgroundColor,
        textColor: textColor,
        size: 48,
        showDropShadow: showDropShadow,
      );

  factory UserProfileAvatar.medium({
    Key? key,
    String? imageUrl,
    String? userName,
    Color? borderColor,
    Color? backgroundColor,
    Color? textColor,
    bool showDropShadow = true,
  }) =>
      UserProfileAvatar(
        key: key,
        imageUrl: imageUrl,
        userName: userName,
        borderColor: borderColor ?? Colors.white,
        backgroundColor: backgroundColor,
        textColor: textColor,
        size: 180,
        showDropShadow: showDropShadow,
      );

  factory UserProfileAvatar.large({
    Key? key,
    String? imageUrl,
    String? userName,
    Color? borderColor,
    Color? backgroundColor,
    Color? textColor,
    bool showDropShadow = true,
  }) =>
      UserProfileAvatar(
        key: key,
        imageUrl: imageUrl,
        userName: userName,
        borderColor: borderColor ?? Colors.white,
        backgroundColor: backgroundColor,
        textColor: textColor,
        size: 320,
        showDropShadow: showDropShadow,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? Theme.of(context).primaryColorDark,
          border:
              Border.all(color: borderColor, width: borderWidth ?? size / 25),
          boxShadow: !showDropShadow
              ? null
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(3, 4), // changes position of shadow
                  ),
                ],
        ),
        width: size,
        height: size,
        child: imageUrl == null
            ? _userInitials
            : Image.network(imageUrl!,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Center(
                    child: Container(
                      width: size / 4,
                      height: size / 4,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: size / 50,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => _userInitials),
      ),
    );
  }

  Widget get _userInitials => _UserInitials(
        userName: userName,
        textColor: textColor,
        fontSize: fontSize ?? size / 4,
      );
}

class _UserInitials extends StatelessWidget {
  final String? userName;
  final Color? textColor;
  final double fontSize;

  const _UserInitials({
    Key? key,
    this.userName = "",
    this.textColor,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _formattedUsername,
        style: TextStyle(
            color:
                textColor ?? Theme.of(context).primaryColorDark.byLuminance(),
            fontSize: fontSize),
      ),
    );
  }

  String get _formattedUsername {
    if (userName?.isEmpty == true) return "N/A";
    if (userName!.length < 2) return userName!;
    if (userName!.contains(" ")) {
      final userNames = userName!.split(" ");
      return "${userNames.first[0]}${userNames.last[0]}";
    }

    return userName![0];
  }
}
