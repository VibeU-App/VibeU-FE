import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vibeu_fe/features/Me/presentation/views/me_view.dart';
import 'package:vibeu_fe/features/Me/presentation/widgets/vibe_bottom_nav_bar.dart';
import 'package:vibeu_fe/features/newsfeed/presentation/views/newsfeed_view.dart';
import 'package:vibeu_fe/routing/routes.dart';

class ActiveNavIndexNotifier extends Notifier<int> {
  @override
  int build() => 4; // Default to Me profile tab (4)

  void setIndex(int index) {
    state = index;
  }
}

final activeNavIndexProvider =
    NotifierProvider<ActiveNavIndexNotifier, int>(() => ActiveNavIndexNotifier());

class MainNavigationView extends ConsumerStatefulWidget {
  final int initialIndex;

  const MainNavigationView({
    super.key,
    this.initialIndex = 4,
  });

  @override
  ConsumerState<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends ConsumerState<MainNavigationView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && ref.read(activeNavIndexProvider) != widget.initialIndex) {
        ref.read(activeNavIndexProvider.notifier).setIndex(widget.initialIndex);
      }
    });
  }

  @override
  void didUpdateWidget(MainNavigationView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIndex != widget.initialIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && ref.read(activeNavIndexProvider) != widget.initialIndex) {
          ref.read(activeNavIndexProvider.notifier).setIndex(widget.initialIndex);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeIndex = ref.watch(activeNavIndexProvider);
    final stackIndex = activeIndex == 1 ? 0 : 1;

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: stackIndex,
        children: const [
          NewsfeedView(showBottomNavBar: false),
          MeView(showBottomNavBar: false),
        ],
      ),
      bottomNavigationBar: VibeBottomNavBar(
        selectedIndex: activeIndex,
        onItemTapped: (index) {
          if (index == 1 || index == 4) {
            ref.read(activeNavIndexProvider.notifier).setIndex(index);
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Feature coming soon!'),
                duration: Duration(milliseconds: 1000),
              ),
            );
          }
        },
        onPlusTapped: () => context.push(Routes.createPost),
      ),
    );
  }
}
