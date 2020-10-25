import 'package:flutter/material.dart';
import 'package:my_shop/screens/orders_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 180,
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                CircleAvatar(
                  minRadius: 35,
                  child: Icon(Icons.person, size: 45),
                ),
                SizedBox(height: 10),
                Text(
                  'Ekansh Saxena',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            context: context,
            title: 'Shop',
            iconName: Icons.list,
            tapHandler: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          buildListTile(
            context: context,
            title: 'Orders',
            iconName: Icons.payment,
            tapHandler: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}

ListTile buildListTile(
    {BuildContext context,
    String title,
    IconData iconName,
    Function tapHandler}) {
  return ListTile(
    leading: Icon(iconName),
    title: Text(
      title,
      style: Theme.of(context).textTheme.button,
    ),
    onTap: tapHandler,
  );
}
