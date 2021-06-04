import 'package:flutter/material.dart';
import 'package:flutter_commun_app/ui/theme/theme.dart';

abstract class CustomBottomSheet {
  static final CustomBottomSheet _instance = CustomBottomSheetImpl();

  /// access to the Singleton instance of CustomBottomSheet
  static CustomBottomSheet get instance => _instance;

  /// Short form to access the instance of CustomBottomSheet
  static CustomBottomSheet get I => _instance;

  void displayBottomSheet(BuildContext context,
      {List<PrimarySheetButton> sheetButton, Widget headerChild});
}

class CustomBottomSheetImpl implements CustomBottomSheet {
  @override
  void displayBottomSheet(BuildContext context,
      {List<PrimarySheetButton> sheetButton, Widget headerChild}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext _) {
        return BottomSheet(
          onClosing: () {},
          enableDrag: false,
          builder: (_) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return SizedBox(
                            width: constraints.maxWidth,
                            child: headerChild,
                          );
                        },
                      ).extended,
                      CircleAvatar(
                        radius: 15,
                        foregroundColor: context.theme.iconTheme.color,
                        backgroundColor: context.onPrimary,
                        child: const Icon(Icons.close),
                      ).ripple(() {
                        Navigator.pop(context);
                      })
                    ],
                  ).pV(15),
                  ...[
                    for (var item in sheetButton) item,
                  ],
                  const SizedBox(height: 30)
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class PrimarySheetButton extends StatelessWidget {
  const PrimarySheetButton(
      {Key key, this.title, this.icon, this.onPressed, this.color})
      : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecorations.decoration(context,
            borderRadius: 10, offset: const Offset(0, 0), blurRadius: 0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyles.headline14(context)
                    .copyWith(color: color ?? context.bodyTextColor)),
            Icon(icon, color: color ?? context.bodyTextColor)
          ],
        )).ripple(onPressed, radius: 10).pV(10);
  }
}
