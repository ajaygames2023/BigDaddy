import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Toggle extends StatelessWidget {
  const Toggle({
    required this.value,
    this.onChanged,
    super.key});
  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
  activeColor: Colors.amber,
  activeTrackColor: Colors.cyan,
  inactiveThumbColor: Colors.blueGrey.shade600,
  inactiveTrackColor: Colors.grey.shade400,
  splashRadius: 10.0,
  value: value,
  onChanged: onChanged,
    );
  }
}