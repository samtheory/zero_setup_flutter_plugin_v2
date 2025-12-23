import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

/// A custom elevated button with consistent styling
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.borderRadius,
    this.padding,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
        foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
        elevation: elevation ?? AppConstants.defaultElevation,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? AppConstants.defaultBorderRadius),
        ),
      ),
      child: child,
    );
  }
}
