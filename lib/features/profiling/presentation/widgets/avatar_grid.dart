import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

import '../controllers/profiling_state.dart';
import 'avatar_slot.dart';

class AvatarGridController {
  AvatarGridController({
    this.itemCount = 9,
  });
  
  _AvatarGridState? _state;
  bool _disposed = false;
  final _selected = ValueNotifier<int>(-1);
  final List<String> _seeds = [];
  Avatar? _avatar;

  static const Gender defaultGender = .male;
  Gender _currentGender = defaultGender;
  Gender get gender => _currentGender;

  final isRefreshing = ValueNotifier(false);
  final int itemCount;


  void dispose() {
    _disposed = true;
    _selected.dispose();
    isRefreshing.dispose();
  }

  Future<void> refresh() async {
    if (_state == null || isRefreshing.value) return;
    _selected.value = -1;
    isRefreshing.value = true;

    while(_seeds.isNotEmpty) {
      if (_disposed) return;
      final index = _seeds.length - 1;
      final removed = _seeds.removeLast();
      await _state?.buildRemovedItem(removed, _currentGender, index);
    }

    for (int index = 0; index < itemCount; index++) {
      if (_disposed) return;
      final seed = DateTime.now().microsecondsSinceEpoch.toString();
      _seeds.add(seed);
      await _state?.buildItem(index);
    }
    isRefreshing.value = false;
  }

  void selectGender(Gender gender) {
    _currentGender = gender;
    _avatar = Avatar(
      seed: _avatar?.seed,
      gender: _currentGender,
    );
    refresh();
  }

  void _setSelected(int index) {
    _selected.value = (index == _selected.value) ? -1 : index;
    _avatar = Avatar(
      seed: _selected.value == -1 ? null : _seeds[_selected.value],
      gender: _currentGender,
    );
  }

  void _init() {
    for (int i = 0; i < itemCount; i++) {
      final seed = DateTime.now().microsecondsSinceEpoch.toString();
      _seeds.add(seed);
    }
  }
}

class AvatarGrid extends StatefulWidget {
  final int crossAxisCount;
  final double itemSize;
  final Duration animationDuration;
  final AvatarGridController controller;
  final ValueChanged<Avatar?> onSelectedAvatar;

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
              return AvatarSlot(
                onPressed: () {
                  controller._setSelected(index);
                  widget.onSelectedAvatar(controller._avatar);
                },
                animation: animation,
                avatar: Avatar(
                  seed: controller._seeds[index],
                  gender: controller._currentGender,
                ),
                iconSize: widget.itemSize,
                selected: index == selected.value,
              );
            }
          );
        },
      )
    );
  }

  Future<void> buildRemovedItem(
    String seed,
    Gender gender,
    int index
  ) async {
    _gridKey.currentState!.removeItem(
      index,
      (_, animation) {
        return AvatarSlot(
          onPressed: () {},
          animation: animation,
          avatar: Avatar(seed: seed, gender: gender),
          iconSize: widget.itemSize,
          selected: index == widget.controller._selected.value,
        );
      },
      duration: widget.animationDuration,
    );
    await Future.delayed(widget.animationDuration);
  }

  Future<void> buildItem(int index) async {
    _gridKey.currentState!.insertItem(
      index,
      duration: widget.animationDuration
    );
    await Future.delayed(widget.animationDuration);
  }
}
