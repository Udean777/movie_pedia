import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/firebase_auth_provider.dart';
import 'package:movie_pedia/core/providers/wishlist_provider.dart';
import 'package:movie_pedia/presentation/profile/widgets/info_card.dart';
import 'package:movie_pedia/presentation/profile/widgets/profile_picture.dart';
import 'package:movie_pedia/presentation/profile/widgets/settings_card.dart';
import 'package:movie_pedia/presentation/profile/widgets/stat_card.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateNotifierProvider).value;
    final wishlistCount = ref.watch(wishlistCountProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ProfilePicture(colorScheme: colorScheme),
                  const SizedBox(height: 24),
                  InfoCard(
                    colorScheme: colorScheme,
                    user: user,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          colorScheme: colorScheme,
                          title: 'Wishlist',
                          count: wishlistCount.when(
                            data: (count) => count.toString(),
                            loading: () => '...',
                            error: (_, __) => '0',
                          ),
                          icon: Icons.favorite_border,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SettingsCard(colorScheme: colorScheme),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.tonal(
                      onPressed: () {
                        ref.read(authServiceProvider).signOut();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Sign Out'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
