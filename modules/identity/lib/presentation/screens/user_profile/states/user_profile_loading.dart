import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserProfileLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white24,
        child: ListView(
          children: [
            // Avatar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
              ),
            ),
            //User name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.grey[300],
                ),
              ),
            ),
            //Email address
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 64.0,
                vertical: 8,
              ),
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.grey[300],
                ),
              ),
            ),
            //Divider
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                height: 2,
                color: Colors.grey[300],
              ),
            ),
            //About company
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 128, top: 16),
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.grey[300],
                ),
              ),
            ),
            //Company catch phrase
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 80, top: 8),
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.grey[300],
                ),
              ),
            ),
            //Company bs
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 100, top: 8),
              child: Container(
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.grey[300],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
