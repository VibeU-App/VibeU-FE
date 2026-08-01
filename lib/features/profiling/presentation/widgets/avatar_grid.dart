import 'package:flutter/material.dart';
import 'package:dice_bear/dice_bear.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

Widget get _randomAvatar => DiceBearRequest<DiceBearPersonasOptions>(
  style: DiceBearStyle.personas,
  coreOptions: DiceBearCoreOptions(
    seed: DateTime.now().microsecondsSinceEpoch.toString()
  ),
).toImage();



class AvatarGridController {
  _AvatarGridState? _state;

  void refresh() {
    _state?.refresh();
  }
}

class AvatarGrid extends StatefulWidget {
  final int itemCount;
  final int crossAxisCount;
  final double itemSize;
  final Duration animationDuration;
  final VoidCallback onTap;
  final ValueChanged<bool> onRefresh;
  final AvatarGridController controller;

  const AvatarGrid({
    super.key,
    required this.onTap,
    required this.onRefresh,
    required this.controller,
    this.itemCount = 9,
    this.crossAxisCount = 3,
    this.itemSize = 15.0,
    this.animationDuration = const Duration(milliseconds: 100),
  });

  @override
  State<AvatarGrid> createState() => _AvatarGridState();
}

class _AvatarGridState extends State<AvatarGrid> {
  final _gridKey = GlobalKey<AnimatedGridState>();
  final List<Widget> _avatars = [];

  @override
  void initState() {
    super.initState();
    widget.controller._state = this;
    _requestAvatars();
  }

  @override
  void dispose() {
    widget.controller._state = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5,
      child: AnimatedGrid(
        key: _gridKey,
        initialItemCount: widget.itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          childAspectRatio: 1,
        ),
        itemBuilder: (_, index, animation) {
          return _Slot(
            onPressed: widget.onTap,
            animation: animation,
            icon: _avatars[index],
            iconSize: widget.itemSize,
          );
        },
      )
    );
  }

  Future<void> refresh() async {
    widget.onRefresh(true);
    while (_avatars.isNotEmpty) {
      final index = _avatars.length - 1;
      final removed = _avatars.removeAt(index);
      _gridKey.currentState!.removeItem(
        index,
        (_, animation) {
          return _Slot(
            onPressed: () {},
            animation: animation,
            icon: removed,
            iconSize: widget.itemSize,
          );
        },
        duration: widget.animationDuration,
      );
      await Future.delayed(widget.animationDuration);
    }
    
    _requestAvatars();

    for (int i = 0; i < widget.itemCount; i++) {
      _gridKey.currentState!.insertItem(i, duration: widget.animationDuration);
      await Future.delayed(widget.animationDuration);
    }
    widget.onRefresh(false);
  }

  void _requestAvatars() {
    for (int i = 0; i < widget.itemCount; i++) {
      _avatars.add(_randomAvatar);
    }
  }
}

class _Slot extends StatelessWidget {
  final VoidCallback onPressed;
  final Animation<double> animation;
  final Widget icon;
  final double iconSize;

  const _Slot({
    required this.onPressed,
    required this.animation,
    required this.icon,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      ),
      child: IconButton.outlined(
        iconSize: iconSize,
        icon: icon,
        onPressed: onPressed,
        color: AppColors.background900,
        highlightColor: AppColors.primary500,
      ),
    );
  }
}
