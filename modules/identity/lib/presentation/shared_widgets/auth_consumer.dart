import 'dart:async';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:identity/identity.dart';
import 'package:identity/presentation/shared_widgets/centered_progress_indicator.dart';

class AuthConsumer extends StatefulWidget {
  final Widget loader;
  final Widget? child;
  final ValueSetter<BuildContext>? onAuthenticated;
  final ValueSetter<BuildContext>? onUnauthenticated;
  final ValueSetter<Exception>? onError;

  const AuthConsumer(
      {Key? key,
      this.loader = const CenteredProgressIndicator(),
      this.onAuthenticated,
      this.onUnauthenticated,
      this.onError,
      this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AutConsumerState();
}

class _AutConsumerState extends State<AuthConsumer> {
  late final StreamSubscription<Resource<AuthState>>
      _observeAuthStateSubscription;

  @override
  void initState() {
    super.initState();
    _observeAuthStateSubscription = getIt<AuthListener>()
        .observeAuthState()
        .listen((state) => state.maybeWhen(
              success: (authenticated) {
                switch (authenticated as AuthState) {
                  case AuthState.Authenticated:
                    if (widget.onAuthenticated != null)
                      widget.onAuthenticated!(context);
                    break;
                  case AuthState.Unauthenticated:
                    if (widget.onUnauthenticated != null)
                      widget.onUnauthenticated!(context);
                    break;
                }
                return null;
              },
              error: (error) {
                if (widget.onError != null)
                  widget.onError!(error);
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.toString()),
                      duration: Duration(seconds: 6),
                    ),
                  );
                }
                return null;
              },
              orElse: () {
                //Do nothing on DateState.loading and DateState.nothing
                return null;
              },
            ));
  }

  @override
  void dispose() {
    super.dispose();
    _observeAuthStateSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Resource<AuthState>>(
      stream: getIt<AuthListener>().observeAuthState(),
      initialData: Resource.nothing(),
      builder: (context, snapshot) => AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: snapshot.requireData.maybeWhen<Widget>(
            loading: (_) => Stack(
                  alignment: Alignment.center,
                  children: [
                    if (widget.child != null) widget.child!,
                    widget.loader,
                  ],
                ),
            orElse: () => widget.child ?? SizedBox.shrink()),
      ),
    );
  }
}
