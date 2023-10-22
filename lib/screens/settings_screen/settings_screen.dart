import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:ti_bank/custom_theme.dart';
import 'package:ti_bank/routes.dart';
import 'package:ti_bank/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Конфигурация',
                style: context.textTheme.displayLarge,
              ),
            ),
            const SizedBox(height: 32),
            SettingsButton(
              iconPath: 'assets/privacy_policy.svg',
              title: 'Политика безопасности',
              onTap: () => _onPrivacyPolicyTap(context),
            ),
            SettingsButton(
              iconPath: 'assets/terms_of_use.svg',
              title: 'Правила использования',
              onTap: () => _onTermsOfUseTap(context),
            ),
            SettingsButton(
              iconPath: 'assets/privacy_policy.svg',
              title: 'Поддержка',
              onTap: () => _onSupportTap(context),
            ),
            SettingsButton(
              iconPath: 'assets/rate_app.svg',
              title: 'Оценить нас',
              onTap: () => InAppReview.instance
                  .openStoreListing(appStoreId: '6470149790'),
            ),
          ],
        ),
      ),
    );
  }

  void _onTermsOfUseTap(BuildContext context) {
    context.pushNamed(Routes.ll,
        extra:
            'https://docs.google.com/document/d/1tU-7guKiZ-6tWa_NsRLnoXyrs455tl9YFvP6tFpWDbY/edit?usp=sharing');
  }

  void _onPrivacyPolicyTap(BuildContext context) {
    context.pushNamed(Routes.ll,
        extra:
            'https://docs.google.com/document/d/1i97UTfz-iJVN9jfMunT4hYDbDDaDQfi6IID9yFLjyII/edit?usp=sharing');
  }

  void _onSupportTap(BuildContext context) {
    context.pushNamed(Routes.ll, extra: 'https://forms.gle/7csP8RmbH8smDfcv5');
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  final String iconPath;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: CustomTheme.blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
