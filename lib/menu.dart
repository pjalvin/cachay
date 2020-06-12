import 'package:cachay/main.dart';
import 'package:cachay/menu/cuenta.dart';
import 'package:cachay/menu/game.dart';
import 'package:cachay/menu/inicio.dart';
import 'package:cachay/menu/rank.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  TabController tabcon;
  int selectedpage = 0;
  var _pages = [
    Inicio(),
    Game(),
    Rank(),
    Cuenta()
  ];
  PreloadPageController controlerpage = PreloadPageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabcon = new TabController(length: 4, vsync: this,initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                  child: PreloadPageView(
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (page) {
                      setState(() {
                        selectedpage = page;
                      });
                      tabcon.animateTo(page,duration: Duration(milliseconds: 0));
                    },
                    preloadPagesCount: 4,
                    controller: controlerpage,
                    children: _pages,
                  ),
              )
          ),
          menuWIdget()
        ],
      ),
    );
  }

  Widget menuWIdget() {
    return Container(
      color: color3,
      height: 50,
      child: TabBar(

        indicatorColor: color5,

        labelStyle: TextStyle(
            fontFamily: 'CenturyGothic', fontWeight: FontWeight.bold),
        indicator: BoxDecoration(color: color5),
        controller: tabcon,
        labelColor: Colors.white,
        onTap: (index) {
          setState(() {
            selectedpage = index;
          });
          controlerpage.jumpToPage(index);
        },
        unselectedLabelColor: Colors.white.withOpacity(0.5),
        tabs: <Widget>[
          Tab(

            icon: Icon(Icons.home, color: selectedpage!=0?color6:color7, size: 30,),
          ),
          Tab(
              child: Image.asset("assets/dice.png", height: 30,color: selectedpage!=1?color6:color7,)
          ),
          Tab(
              child: Image.asset("assets/trofeo.png", height: 25,color: selectedpage!=2?color6:color7)
          ),
          Tab(
            icon: Icon(Icons.person_outline, color: selectedpage!=3?color6:color7, size: 30,),
          )
        ],
      ),
    );
  }
}
  class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
  BuildContext context, Widget child, AxisDirection axisDirection) {
  return child;
  }}
