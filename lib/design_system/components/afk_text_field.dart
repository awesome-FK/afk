import 'package:flutter/material.dart';

import '../foundations/radius/afk_radius.dart';
import '../foundations/spacing/afk_spacing.dart';
import '../theme/afk_theme_colors.dart';

class AfkTextField extends StatelessWidget {
  const AfkTextField({
    required this.controller,
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.autofillHints,
    this.prefix,
    this.suffix,
  });

  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final Iterable<String>? autofillHints;
  final Widget? prefix;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    final AfkThemeColors colors = AfkThemeColors.of(context);
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AfkRadius.md),
      borderSide: BorderSide(color: colors.border),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null) ...<Widget>[
          Text(label!, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: AfkSpacing.sm),
        ],
        TextField(
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          enabled: enabled,
          autofillHints: autofillHints,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            prefixIcon: prefix,
            suffixIcon: suffix,
            filled: true,
            fillColor: colors.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AfkSpacing.lg,
              vertical: AfkSpacing.lg,
            ),
            border: border,
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: BorderSide(color: colors.primaryText, width: 1.5),
            ),
            errorBorder: border.copyWith(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            focusedErrorBorder: border.copyWith(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
