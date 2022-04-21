import 'package:flutter/material.dart';
import '/enums/nav_item.dart';

class BottomNavBar extends StatelessWidget {
  final NavItem? navItem;
  final Function(NavItem)? onitemSelected;

  const BottomNavBar({
    Key? key,
    @required this.navItem,
    @required this.onitemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 20.0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      //landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      // type: BottomNavigationBarType.shifting,

      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      // backgroundColor: const Color(0xff96DEF4),
      iconSize: 20,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      selectedItemColor: Colors.white,
      // selectedItemColor: const Color(0XFF00286E),
      //selectedItemColor: Colors.green,
      //unselectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: NavItem.values.indexOf(navItem!),
      onTap: (index) => onitemSelected!(NavItem.values[index]),
      items: NavItem.values.map((item) {
        return BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(6.0),
            child: _itemIcon(item),
          ),
          label: '',
        );
      }).toList(),
    );
  }
}

Widget _itemIcon(NavItem item) {
  switch (item) {
    case NavItem.account:
      return Image.asset('assets/images/menu_account.png',
          height: 35.0, width: 35.0);

    case NavItem.wallet:
      return Image.asset('assets/images/menu_wallet.png',
          height: 35.0, width: 35.0);

    case NavItem.dashboard:
      return Image.asset('assets/images/bar_speaker.png',
          height: 35.0, width: 35.0);

    case NavItem.sets:
      return Image.asset('assets/images/menu_sets.png',
          height: 35.0, width: 35.0);

    case NavItem.invite:
      return Image.asset('assets/images/menu_invite.png',
          height: 35.0, width: 35.0);

    default:
      return const Icon(Icons.error);
  }
}

// String _label(NavItem item) {
//   if (item == NavItem.dashboard) {
//     return 'Home';
//   } else if (item == NavItem.wallet) {
//     return 'Add Post';
//   } else if (item == NavItem.mic) {
//     return 'Nearby';
//   } else if (item == NavItem.invite) {
//     return 'Profile';
//   }

//   return '';
// }
