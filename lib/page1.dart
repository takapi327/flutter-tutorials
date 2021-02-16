import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Image.asset(
                      'assets/images/map.png',
                      width:  600,
                      height: 140,
                      fit:    BoxFit.fitWidth,
                    ),
                    titleSection(),
                    buttonSection(context),
                    textSection(),
                    navigateButton(context)
                  ],
                ),
              )
            ],
          )
        ),
      ]
    );
  }

  Widget titleSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerlan',
                  style: TextStyle(
                      color: Colors.grey[500]
                  ),
                ),
              ],
            ),
          ),
          FavoriteWidget(),
        ],
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize:      MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize:   12,
              fontWeight: FontWeight.w400,
              color:      color,
            ),
          ),
        ),
      ],
    );
  }

  Widget buttonSection(BuildContext context) {
    final Color color = Theme.of(context).accentColor;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call,    'Call'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share,   'SHARE')
        ],
      ),
    );
  }

  Widget textSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );
  }

  Widget navigateButton(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text('Navigator test'),
        onPressed: () {
          Navigator.pushNamed(
              context,
              '/test/1'
          );
        },
      ),
    );
  }
}

class NavigatorTest extends StatelessWidget {
  final String id;

  NavigatorTest({
    this.id
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
            child: Text('Back! $id'),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ),
    );
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorite    = true;
  int  _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child:   IconButton(
            padding:   EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon:      (_isFavorite ? Icon(Icons.star) : Icon(Icons.star_border)),
            color:     Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorite) {
        _favoriteCount -= 1;
        _isFavorite    = false;
      } else {
        _favoriteCount += 1;
        _isFavorite     = true;
      }
    });
  }
}
