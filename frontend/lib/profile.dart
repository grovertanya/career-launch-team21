import 'package:flutter/material.dart';
import 'package:frontend/profile_view.dart';

class Profile extends StatelessWidget {
  const Profile({required this.usernameP, super.key});
  final String usernameP;

  @override
  Widget build(BuildContext context) {
    return ProfileView(usernamePV: usernameP);
  }
}