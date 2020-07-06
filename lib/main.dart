//import 'dart:convert';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';


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
      home: MyHomePage(title: 'Ejemplo'),
    );
  }
}

  List _sections = [
      {
          "id": 0,
          "name": "Hamburguesas",
          "foods": [
            {
              "name" : "Wooper Jr", 
              "description": "Rica hamburguesa !!!", 
              "price" : 12.00,
              "image": "assets/img/burguer.jpg"
            },
            {
              "name" : "Famous Star", 
              "description": "Hamburguesa más grande", 
              "price" : 12.00,
              "image": "assets/img/burguer2.jpeg"
            },
            {
              "name" : "Tocino Burguer", 
              "description": "Incluye rico tocino", 
              "price" : 12.00,
              "image": "assets/img/burguer3.jpeg"
            },
          ]
      },
      {
          "id": 1,
          "name": "Tacos",
          "foods": [
            {
              "name" : "Deshebrada", 
              "description": "Tacos deshebrada", 
              "price" : 12.00,
              "image": "assets/img/tacos1.jpg"
            },
            {
              "name" : "Chicharron", 
              "description": "", 
              "price" : 12.00,
              "image": "assets/img/tacos2.jpeg"
            },
            {
              "name" : "Frijoles", 
              "description": "", 
              "price" : 12.00,
              "image": "assets/img/tacos3.jpeg"
            },
          ]
      },
      {
          "id": 2,
          "name": "Bebidas",
          "foods": [
            {
              "name" : "Seven Up", 
              "description": "500ml", 
              "price" : 12.00,
              "image": "assets/img/sevenup.jpg"
            },
            {
              "name" : "Coca Cola", 
              "description": "600ml", 
              "price" : 12.00,
              "image": "assets/img/cocacola.jpeg"
            },
            {
              "name" : "Fanta", 
              "description": "700ml", 
              "price" : 12.00,
              "image": "assets/img/fanta.jpeg"
            },
          ]
      },
      {
          "id": 3,
          "name": "Tortas",
          "foods": [
            {
              "name" : "Torta de pierna", 
              "description": "Con aguacate", 
              "price" : 12.00,
              "image": "assets/img/tortapierna.jpg"
            },
            {
              "name" : "Torta de jamón", 
              "description": "Con queso", 
              "price" : 12.00,
              "image": "assets/img/tortajamon.jpeg"
            },
            {
              "name" : "Torta de Bistec", 
              "description": "Con lechuga, aguacate y queso", 
              "price" : 12.00,
              "image": "assets/img/tortabistec.jpg"
            },
          ]
      },
      {
          "id": 4,
          "name": "Pasteles",
          "foods": [
            {
              "name" : "Pastel de Yogut", 
              "description": "Relleno de yogurt", 
              "price" : 150.00,
              "image": "assets/img/pastelyogurt.jpg"
            },
            {
              "name" : "Paste de Chocolate", 
              "description": "Cubierto de chocolate", 
              "price" : 160.00,
              "image": "assets/img/pastelchoco.jpg"
            },
            {
              "name" : "Pastel de Bombon", 
              "description": "Dulces bombones", 
              "price" : 170.00,
              "image": "assets/img/pastelbombon.jpg"
            },
          ]
      }
  ];

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

  int    tabIndex = 0;
  double tabBarHeight = 0;

  //List<double> positions = [290.0, 648.0, 1006.0];  // Posiciones de scroll de cada sección
  List<double> positions = new List<double>();

  ScrollController _scrollController = new ScrollController();
  TabController _tabController;

  bool isAnimated = false;

  double labelHeight = 20.0;
  double cardHeight  = 100.0;

  Color theme = Colors.white;

  void scrollToOffset(double offset) {
    //var y = offset + _scrollController.position.pixels; // Desde la posicion en la que estoy actualmente

    isAnimated = true;

    var y = offset;
    _scrollController.animateTo(
      y,
      duration: Duration(milliseconds: 250),
      curve: Curves.ease,
    ).whenComplete(() => isAnimated = false);
  }

  @override
  void initState() { 
    super.initState();

    _tabController = new TabController(length: _sections.length, vsync: this);
    _scrollController.addListener(() {

      if(!isAnimated){

        // Si el scroll esta dentro del limite
        if(_tabController.index > 0){ // Hacia arriba
          if(_scrollController.position.pixels <= positions[_tabController.index - 1]){ 
          
            _tabController.index--;
          }
        }

        if(_tabController.index < _tabController.length - 1){ // Hacia abajo

          if(_scrollController.position.pixels >= positions[_tabController.index + 1] - 100){

            _tabController.index++;
          }
        }
      }

       print('ScrollPosition: ${_scrollController.position.pixels}');
    });
  }


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: DefaultTabController(
        length: _tabController.length,
        child: CustomScrollView(
          physics: new ClampingScrollPhysics(), // Evitar que rebote el scroll
          controller: _scrollController,
          slivers: <Widget>[

            // Encabezado de la aplicación
            _crearAppbar(),

            SliverPersistentHeader(
              delegate: _SliverAppBarRestaurantInfo(
                minExtent: 100,
                maxExtent: 100
              ),
              pinned: false,
            ),

            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                _getTabBar()
              ),
              pinned: true,
            ),

            // Contenido del cuerpo de la aplicación
            SliverList(
              delegate: SliverChildListDelegate(
                  // Cargar 'Widgets'
                  _getMenu()
              ),
            )

          ]
        )

      ),
    );
  }


TabBar _getTabBar(){

  var tabBar = TabBar(
    onTap: (index){

      scrollToOffset(positions[index]);
      //print('Haz hecho click en el botón $index');
    },
    controller: _tabController,
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: new BubbleTabIndicator(
      indicatorHeight: 27.0,
      indicatorColor: Colors.black,
      tabBarIndicatorSize: TabBarIndicatorSize.tab,
    ),
    isScrollable: true,
    unselectedLabelColor: Colors.black,
    indicatorColor: Colors.white,
    tabs:
    [
      for(var i = 0; i < _tabController.length; i++)
      Tab(
        child: Text(_sections[i]['name']),
      )
    ]
  );

  tabBarHeight = tabBar.preferredSize.height; // Obtener la altura del 'tabBar'
  //print("tabBarHeight: $tabBarHeight");

  return tabBar;
}

  List<Widget> _getMenu(){
    final children = <Widget>[];
    double position = 0;

    // Agregar la posición
    double appBarHeight = 290;
    position += appBarHeight;
    
    positions.add(position);

    for(var i = 0; i < _sections.length; i++){

      children.add(
        Container(
          padding: const EdgeInsets.only(
            left: 15
          ),
          child: Text(
            _sections[i]['name'],
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: labelHeight),
          )
        )
      );

      position += tabBarHeight;
      position += labelHeight;

      for(var j = 0; j < _sections[i]['foods'].length; j++){
                        
        children.add(

          Card(
            //color: j % 2 == 0 ? Colors.yellow : Colors.green,
            child: Container(
              margin: EdgeInsets.only(bottom: 5.0),
              alignment: Alignment.center,
              width: double.infinity,
              height: cardHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 9,right: 9),
                    child:  ClipRRect(
                      child: Image.asset(_sections[i]['foods'][j]['image'], width: 80, height: 80),
                    ),
                  ),
                 
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 8),
                        Text(_sections[i]['foods'][j]['name'], style: TextStyle(fontSize: 18.0)),
                        SizedBox(height: 6),
                        Text(_sections[i]['foods'][j]['description'], style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                        SizedBox(height: 6),
                        Text('\$${_sections[i]['foods'][j]['price'].toStringAsFixed(2)}', style: TextStyle(fontSize: 17.0)),
                      ],
                      
                    )
                  )

                  
                ],
              )
              
            ),
          )
        );

        position += (cardHeight + 5); // 5 es el margen de Card
      }

      children.add(
        Divider(thickness: 2.5,)
      );

      position-=3; // Es el grueso del divider

      positions.add(position); // Agregar la posición del widget en la lista
    }

    print('$positions');
                                    
    return children;
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


  class _SliverAppBarRestaurantInfo extends SliverPersistentHeaderDelegate {
    _SliverAppBarRestaurantInfo({this.minExtent, this.maxExtent});

    final double minExtent;
    final double maxExtent;

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
    bool shouldRebuild(_SliverAppBarRestaurantInfo oldDelegate) {
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