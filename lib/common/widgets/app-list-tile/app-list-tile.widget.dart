import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {
  const AppListTile(
      {this.leading,
      this.textSpan,
      this.textSpan2,
      this.onTap,
      this.trailing,
      this.title,
      Key key})
      : super(key: key);

  final Widget leading;
  final TextSpan textSpan;
  final TextSpan textSpan2;
  final void Function() onTap;
  final Widget title;
  final Widget trailing;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Container(
          padding: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.6))),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () => onTap(),
            child: ListTile(
              leading: leading,
              title: title ??
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        textSpan,
                        textSpan2 ?? const TextSpan(),
                      ],
                    ),
                  ),
              trailing: trailing,
            ),
          )),
    );
  }
}
