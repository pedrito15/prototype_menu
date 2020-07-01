import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tab_bar_no_ripple/flutter_tab_bar_no_ripple.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:toggle_bar/toggle_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Ejemple'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  int currentIndex = 0;

  final  posLimit = 1753;
  int    tabIndex = 0;
  double posInitial = 0;

  ScrollController _scrollController2 = new ScrollController();
  TabController _tabController;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  bool isAnimated = false;


  EdgeInsetsGeometry titlePadding =  EdgeInsetsDirectional.only(bottom: 0);

  Color theme = Colors.white;

  void scrollToOffset(double offset) {
    //var y = offset + _scrollController2.position.pixels; // Desde la posicion en la que estoy actualmente

    isAnimated = true;
    posInitial = offset; // Actualizar posición 

    var y = offset;
    _scrollController2.animateTo(
      y,
      duration: Duration(milliseconds: 250),
      curve: Curves.ease,
    ).whenComplete(() => isAnimated = false);
  }

  @override
  void initState() { 
    super.initState();

    _tabController = new TabController(length: 6, vsync: this);

    _scrollController2.addListener(() {

      if(!isAnimated){  // Si no esta animado entonces poder cambiar 'tabbar'

        print('ScrollPosition: ${_scrollController2.position.pixels}');

        if(_scrollController2.position.pixels > posInitial + posLimit){

        _tabController.index++;
        posInitial = (posLimit * _tabController.index).toDouble();


        }else if(_scrollController2.position.pixels < posInitial){

          _tabController.index--;
          posInitial = (posLimit * _tabController.index).toDouble();

        }
      }
    });

  }


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: DefaultTabController(
        length: 6,
        child: CustomScrollView(
          controller: _scrollController2,
          slivers: <Widget>[

            // Encabezado de la aplicación
            _crearAppbar(),

            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate2(
                minExtent: 100,
                maxExtent: 100
              ),
              pinned: false,
            ),

            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  onTap: (index){
                    
                    scrollToOffset(1753.0 * index);
                    //print('Haz hecho click en el botón $index');
                  },
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: new BubbleTabIndicator(
                    indicatorHeight: 26.0,
                    indicatorColor: Colors.black,
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  ),
                  isScrollable: true,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Text('Seleccionado para ti'),
                    ),
                    Tab(
                      child: Text('Tacos'),
                    ),
                    Tab(
                      child: Text('Hamburguesas'),
                    ),
                    Tab(
                      child: Text('Tortas'),
                    ),
                    Tab(
                      child: Text('Burritos'),
                    ),
                    Tab(
                      child: Text('Bebidas'),
                    )
                  ]
                ),
              ),
              pinned: true,
            ),

            // Contenido del cuerpo de la aplicación
            SliverFixedExtentList(
              itemExtent: 150.0,
              delegate: SliverChildListDelegate(
                [
                  for(var i = 0; i < 100; i++)
                  Card(
                    color: i % 2 == 0 ? Colors.yellow : Colors.green,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 100.0,
                      child: Text(
                        'Food Container $i',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  )
                  
                ],
              ),
            ),
          ]
        )

      ),
    );
  }


Widget _crearAppbar(){

    return SliverAppBar(
      actions: <Widget>[
        IconButton(icon: Icon(Icons.search), onPressed: () {})
      ],
      snap: false,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Restaurant Name',
          style: TextStyle(fontSize: 18.0),
          textAlign: TextAlign.left,
        ),
        //titlePadding: titlePadding,  // Para quitar el pading del titulo
        collapseMode: CollapseMode.pin,
        background:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200.0,
              width: double.infinity,
              color: Colors.grey,
              child: FadeInImage(
                image: NetworkImage('https://cdn.pixabay.com/photo/2015/09/02/12/43/meal-918639_1280.jpg'),
                placeholder: AssetImage('assets/img/loading.gif'),
                fadeInDuration: Duration(milliseconds: 100),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

}


  class _SliverAppBarDelegate2 extends SliverPersistentHeaderDelegate {
    _SliverAppBarDelegate2({this.minExtent, this.maxExtent});

    final double minExtent;
    final double maxExtent;

    @override
    //double get minExtent => _myWidget.preferredSize.height;
    @override
    //double get maxExtent => _myWidget.preferredSize.height;

    @override
    Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
      return new Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Open now\nStreet Address, 299\nCity, State',
                style: TextStyle(fontSize: 15.0),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),

      );
    }

    @override
    bool shouldRebuild(_SliverAppBarDelegate2 oldDelegate) {
      return false;
    }
  }

  class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
    _SliverAppBarDelegate(this._tabBar);

    final TabBar _tabBar;

    @override
    double get minExtent => _tabBar.preferredSize.height;
    @override
    double get maxExtent => _tabBar.preferredSize.height;

    @override
    Widget build(
        BuildContext context, double shrinkOffset, bool overlapsContent) {
      return new Container(
          color: Colors.white,
          child: _tabBar,
      );
    }

    @override
    bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
      return false;
    }
  }