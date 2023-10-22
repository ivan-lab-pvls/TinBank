import 'package:firebase_core/firebase_core.dart';
import 'package:ti_bank/constants.dart';
import 'package:ti_bank/custom_theme.dart';
import 'package:ti_bank/data/incomes_change_notifier.dart';
import 'package:ti_bank/ncsa.dart';
import 'package:ti_bank/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fire.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationServiceFb().activate();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );

  final shPrefs = await SharedPreferences.getInstance();

  runApp(MyApp(shPrefs));
}

class MyApp extends StatefulWidget {
  const MyApp(this._shPrefs, {super.key});

  final SharedPreferences _shPrefs;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Constants.hgfhgdfgdfvdfvsdf = fsadfsdacdsagfdsbsfdbgfdhgdf(
        Constants.hgfhgdfgdfvdfvsdf,
        Constants.gappingfsdsfdsaterfearvcawdewfdfgsdfgsd);
    Constants.fdsadasffgshjfggdfsregfdsgfdsgds = fsadfsdacdsagfdsbsfdbgfdhgdf(
        Constants.fdsadasffgshjfggdfsregfdsgfdsgds,
        Constants.gappingfsdsfdsaterfearvcawdewfdfgsdfgsd);
    Constants.xsaxsadsaf = fsadfsdacdsagfdsbsfdbgfdhgdf(Constants.xsaxsadsaf,
        Constants.gappingfsdsfdsaterfearvcawdewfdfgsdfgsd);
    Constants.gdsfvds = fsadfsdacdsagfdsbsfdbgfdhgdf(
        Constants.gdsfvds, Constants.gappingfsdsfdsaterfearvcawdewfdfgsdfgsd);
    Constants.sxafds12 = fsadfsdacdsagfdsbsfdbgfdhgdf(
        Constants.sxafds12, Constants.gappingfsdsfdsaterfearvcawdewfdfgsdfgsd);
  }

  String fsadfsdacdsagfdsbsfdbgfdhgdf(String input, int shift) {
    StringBuffer result = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      int charCode = input.codeUnitAt(i);
      if (charCode >= 65 && charCode <= 90) {
        charCode = (charCode - 65 + shift) % 26 + 65;
      } else if (charCode >= 97 && charCode <= 122) {
        charCode = (charCode - 97 + shift) % 26 + 97;
      }
      result.writeCharCode(charCode);
    }
    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: widget._shPrefs,
      child: ChangeNotifierProvider(
        create: (context) => IncomesChangeNotifier(widget._shPrefs)..init(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.theme,
          routerConfig: Routes.routes,
        ),
      ),
    );
  }
}
