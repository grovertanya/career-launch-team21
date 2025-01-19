import 'package:flutter/material.dart';
import 'package:frontend/profile_view.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileView(username: 'npadmnabhan', dateJoined: '12/03/2024', rating: 4.9, ratings: 5, );
  }
}