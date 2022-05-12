import 'package:boxsis/page/home/home_mobile.dart';
import 'package:boxsis/page/home/home_tablet.dart';
import 'package:boxsis/page/home/web/home_web.dart';
import 'package:boxsis/uteis/responsivo.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsivo(
        mobile: HomeMobile(),
        tablet: HomeTablet(),
        web: HomeWeb(),
    );
  }
}
