import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:identity/identity.dart';
import 'package:identity/ui/screens/user_profile/widgets/user_profile_avatar.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileSuccess extends StatelessWidget {
  final User user;

  const UserProfileSuccess({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _UserProfileBody(user: user),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class _UserProfileBody extends StatelessWidget {
  final User user;

  const _UserProfileBody({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UserProfileAvatar.medium(
                imageUrl: user.imageUrl,
                userName: user.username,
              ),
              if (user.name != null)
                Text(
                  user.name!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(color: Colors.white),
                ),
              if (user.email != null)
                Text(
                  user.email!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.white),
                ),
              if (user.address != null) _UserAddress(address: user.address!),
              if (user.website != null || user.phone != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (user.website != null)
                        ElevatedButton(
                          onPressed: () => launch(
                              (user.website ?? "").contains("http")
                                  ? user.website!
                                  : "http://${user.website}"),
                          child: FaIcon(FontAwesomeIcons.globe,
                              color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(8),
                            primary: Colors.pink,
                            onPrimary: Colors.red,
                            elevation: 0,
                          ),
                        ),
                      if (user.phone != null)
                        ElevatedButton(
                          onPressed: () => launch("tel:${user.phone!}"),
                          child: Icon(Icons.call, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(8),
                            primary: Colors.pink,
                            onPrimary: Colors.red,
                            elevation: 0,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        if (user.company != null) _UserCompany(company: user.company!)
      ],
    );
  }
}

class _UserAddress extends StatelessWidget {
  final Address address;

  const _UserAddress({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: address.geo == null
          ? null
          : () {
              final mapSchema = "https://www.google.com/maps/dir/?api=1"
                  "&destination=${address.geo?.lat},${address.geo?.lng}"
                  "&travelmode=driving&dir_action=navigate";

              canLaunch(mapSchema).then((_) => launch(mapSchema));
            },
      icon: Icon(
        Icons.location_pin,
        color: Colors.white,
      ),
      label: Text(
        "${address.street}, ${address.city}",
        style: Theme.of(context)
            .textTheme
            .bodyText2
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}

class _UserCompany extends StatelessWidget {
  final Company company;

  const _UserCompany({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "About ${company.name}",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          if (company.catchPhrase != null)
            Text(
              company.catchPhrase!,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.start,
            ),
          if (company.bs != null)
            Text(
              company.bs!,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.start,
            )
        ],
      ),
    );
  }
}
