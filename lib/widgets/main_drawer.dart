import 'package:flutter/material.dart';
import 'package:my_shop/screens/orders_screen.dart';
import 'package:my_shop/screens/user_product_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAvatar(
            iconName: Icons.person,
            name: 'Ekansh Saxena',
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            context: context,
            title: 'Shop',
            iconName: Icons.list,
            tapHandler: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/');
            },
          ),
          buildListTile(
            context: context,
            title: 'Orders',
            iconName: Icons.payment,
            tapHandler: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          ),
          buildListTile(
            context: context,
            title: 'Manage Products',
            iconName: Icons.edit,
            tapHandler: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(UserProductScreen.routeName);
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

class UserAvatar extends StatelessWidget {
  final IconData iconName;
  final String name;

  const UserAvatar({
    Key key,
    this.iconName,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          CircleAvatar(
            minRadius: 35,
            child: Icon(iconName, size: 45),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
