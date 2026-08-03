import 'package:flutter/material.dart';
import 'package:dice_bear/dice_bear.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/config/dicebear/presets.dart';

class AvatarGridController {
  AvatarGridController({
    this.itemCount = 9,
  });
  
  _AvatarGridState? _state;
  final _selected = ValueNotifier<int>(-1);
  final isRefreshing = ValueNotifier(false);
  final List<Widget> _avatars = [];
  final int itemCount;
  DiceBearPersonasOptions _preset = malePreset;
  Widget? get selected => (_selected.value == -1)
    ? null
    : _avatars[_selected.value];

  void dispose() {
    _selected.dispose();
    isRefreshing.dispose();
  }

  Future<void> refresh() async {
    if (_state == null || isRefreshing.value) return;
    _selected.value = -1;
    isRefreshing.value = true;
    while(_avatars.isNotEmpty) {
      final index = _avatars.length - 1;
      final removed = _avatars.removeLast();
      await _state!.buildRemovedItem(removed, index);
    }

    for (int index = 0; index < itemCount; index++) {
      final avatar = _randomAvatar;
      _avatars.add(avatar);
      await _state!.buildItem(avatar, index);
    }
    isRefreshing.value = false;
  }

  void setPreset(DiceBearPersonasOptions preset) {
    _preset = preset;
  }

  void _setSelected(int index) {
    _selected.value = (index == _selected.value) ? -1 : index;
  }

  void _init() {
    for (int i = 0; i < itemCount; i++) {
      _avatars.add(_randomAvatar);
    }
  }

  Widget get _randomAvatar => DiceBearRequest<DiceBearPersonasOptions>(
    style: DiceBearStyle.personas,
    coreOptions: DiceBearCoreOptions(
      seed: DateTime.now().microsecondsSinceEpoch.toString()
    ),
    styleOptions: _preset,
  ).toImage();
}

class AvatarGrid extends StatefulWidget {
  final int crossAxisCount;
  final double itemSize;
  final Duration animationDuration;
  final AvatarGridController controller;
  final VoidCallback onSelectedAvatar;

  const AvatarGrid({
    super.key,
    required this.controller,
    required this.onSelectedAvatar,
    this.crossAxisCount = 3,
    this.itemSize = 15.0,
    this.animationDuration = const Duration(milliseconds: 100),
  });

  @override
  State<AvatarGrid> createState() => _AvatarGridState();
}

class _AvatarGridState extends State<AvatarGrid> {
  final _gridKey = GlobalKey<AnimatedGridState>();
  @override
  void initState() {
    super.initState();
    widget.controller._state = this;
    widget.controller._init();
  }

  @override
  void dispose() {
    widget.controller._state = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final selected = controller._selected;
    return AspectRatio(
      aspectRatio: 1.0,
      child: AnimatedGrid(
        key: _gridKey,
        initialItemCount: controller.itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          crossAxisSpacing: AppSizes.s48,
          mainAxisSpacing: AppSizes.s24,
          childAspectRatio: 1,
        ),
        itemBuilder: (_, index, animation) {
          return AnimatedBuilder(
            animation: selected,
            builder: (_, _) {
              return _Slot(
                onPressed: () {
                  controller._setSelected(index);
                  widget.onSelectedAvatar();
                },
                animation: animation,
                icon: controller._avatars[index],
                iconSize: widget.itemSize,
                selected: index == selected.value,
              );
            }
          );
        },
      )
    );
  }

  Future<void> buildRemovedItem(Widget item, int index) async {
    _gridKey.currentState!.removeItem(
      index,
      (_, animation) {
        return _Slot(
          onPressed: () {},
          animation: animation,
          icon: item,
          iconSize: widget.itemSize,
          selected: index == widget.controller._selected.value,
        );
      },
      duration: widget.animationDuration,
    );
    await Future.delayed(widget.animationDuration);
  }

  Future<void> buildItem(Widget item, int index) async {
    _gridKey.currentState!.insertItem(
      index,
      duration: widget.animationDuration
    );
    await Future.delayed(widget.animationDuration);
  }
}

class _Slot extends StatelessWidget {
  final VoidCallback onPressed;
  final Animation<double> animation;
  final Widget icon;
  final double iconSize;
  final bool selected;

  const _Slot({
    required this.onPressed,
    required this.animation,
    required this.icon,
    required this.iconSize,
    required this.selected,
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
        style: IconButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          side: BorderSide(color: selected
            ? AppColors.primary500
            : Colors.transparent,
          )
        )
      ),
    );
  }
}
