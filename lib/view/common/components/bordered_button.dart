import 'package:fit_board/configs/constants.dart';
import 'package:flutter/material.dart';

class BorderedButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget? child;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const BorderedButton({
    Key? key,
    this.onTap,
    this.child,
    this.borderColor,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    BorderRadius radius = borderRadius ?? BorderRadius.circular(AppUIConfiguration.borderRadius);

    return InkWell(
      onTap: onTap,
      borderRadius: radius,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? themeData.backgroundColor,),
          borderRadius: radius,
        ),
        child: child,
      ),
    );
  }
}
