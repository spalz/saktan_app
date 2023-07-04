import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saktan_app/pages/settings/settings.dart';
import 'package:saktan_app/widgets/widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? backgroundColor;
  final TextStyle? titleTextStyle;
  final IconThemeData? iconTheme;
  final bool? centerTitle;
  final double? titleSpacing;
  final String? logo;
  final double? scrolledUnderElevation;
  final List<Widget> actions;
  final Color? actionsIconTheme;
  final bool? settings;

  const CustomAppBar({
    Key? key,
    this.title,
    this.backgroundColor = Colors.white,
    this.titleTextStyle = const TextStyle(
      fontFamily: "Montserrat",
      fontSize: 19,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    this.iconTheme = const IconThemeData(color: Colors.black),
    this.centerTitle = true,
    this.titleSpacing = 0,
    this.logo,
    this.scrolledUnderElevation = 0,
    this.actions = const [],
    this.actionsIconTheme = Colors.black,
    this.settings = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String settingsIconSvg = 'assets/images/icons/action_settings.svg';
    final Widget settingsIcon = SvgPicture.asset(
      settingsIconSvg,
      width: 28,
      colorFilter: ColorFilter.mode(
        actionsIconTheme ?? Colors.black,
        BlendMode.srcIn,
      ),
    );

    Widget? logoWidget;
    if (logo != null) {
      if (logo == 'saktan') {
        const String saktanLogoSvg = 'assets/images/logo/saktan.svg';
        logoWidget = SvgPicture.asset(
          saktanLogoSvg,
          width: 100,
          alignment: Alignment.topLeft,
          semanticsLabel: 'Saktan',
        );
      } else if (logo == 'indigo') {
        const String indigoLogoSvg = 'assets/images/logo/indigo.svg';
        logoWidget = SvgPicture.asset(
          indigoLogoSvg,
          width: 100,
          alignment: Alignment.topLeft,
          semanticsLabel: 'Indigo',
        );
      }
    }

    return AppBar(
      title: logoWidget ??
          (Text(
            title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
      backgroundColor: backgroundColor,
      titleTextStyle: titleTextStyle,
      iconTheme: iconTheme,
      titleSpacing: logo != null ? 23 : titleSpacing,
      centerTitle: centerTitle,
      elevation: scrolledUnderElevation,
      actions: settings == true
          ? [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        settings: const RouteSettings(name: '/settings'),
                        builder: (context) => const SettingsPage()));
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      SaktanIcons.settings,
                      size: 30,
                    ),
                  )),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
