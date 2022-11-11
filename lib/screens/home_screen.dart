import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../database/sp_helper.dart';
import '../pages/home.dart';
import '../utils/Colors.dart';
import '../utils/Constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  SharedPreferences sharedPreferences;

  static String name = '';
  static String email = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCredential();
  }
  getCredential() async {
  sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString("userName")!;
      email = sharedPreferences.getString("userMail")!;

    });
    print(name);
  }



  final _pages = [
    const Home(),
    const Home(),
    const Home(),
  ];

  Widget _bottomTab() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(color: context.iconColor),
      selectedItemColor: context.iconColor,
      unselectedLabelStyle: const TextStyle(color: gray),
      iconSize: 20,
      unselectedItemColor: gray,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.book_online), activeIcon: Icon(Icons.book), label: 'Books'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
       //backgroundColor: appColorPrimary,
        title: const Text('User List', style: TextStyle(color: Colors.white),),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  //   padding: EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: appBackGroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: ClipOval(
                          child: Image.asset('assets/profile.jpg'),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(name, style: const TextStyle(color: appDarkColor),),
                      Text(email, style: const TextStyle(color: appDarkColor),),
                    ],
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.home_outlined),
                title: Text('Home'),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20,),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomTab(),
      body: _pages.elementAt(_selectedIndex),
    );
  }
}
