import 'package:authentification/profile/profilemain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authentification/logged/Start.dart';
 // import 'package:authentification/Start.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../home/dashboard/dashbord_view.dart';
import '../home/dashboard/location_view.dart';
import '../home/discover/discover_view.dart';
import '../home/article/articles_view.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _currentIndex = 1;
  final List<Widget> _children = [
    DiscoverPage(),
    DashbordView(),
    ArticlesPage(),
  ];
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travelaza"),
        backgroundColor: Colors.purple,
        elevation: 4.0,
        actions: [
          IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profilesetup()),
              ),
            },
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.map_rounded,
                  size: 25, color: Color.fromARGB(255, 110, 32, 9)),
              label: 'Discover'),
          BottomNavigationBarItem(
              icon: new Icon(Icons.dashboard_rounded,
                  size: 40, color: Color.fromARGB(255, 110, 32, 9)),
              label: 'Dashbord'),
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.library_books_rounded,
                size: 25,
                color: Color.fromARGB(255, 110, 32, 9),
              ),
              label: 'Articles'),
        ],
      ),

      // content : !isloggedin
      //       ? CircularProgressIndicator()
      //       : Column(
      //           children: <Widget>[
      //             SizedBox(height: 10.0),
      //             Container(
      //               height: 300,
      //               // child: Image(
      //               //   image: AssetImage("images/welcome.png"),
      //               //   fit: BoxFit.contain,
      //               // ),
      //             ),

      // Container(
      //   child: Text(
      //     "Hello ${user.displayName} you are Logged in as ${user.email}",
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //         fontSize: 20.0, fontWeight: FontWeight.bold),
      //   ),
      // ),
      // RaisedButton(
      //   padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
      //   onPressed: signOut,
      //   child: Text('Signout',
      //       style: TextStyle(
      //           color: Colors.white,
      //           fontSize: 20.0,
      //           fontWeight: FontWeight.bold)),
      //   color: Colors.lightBlue,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20.0),
      //   ),
      // )
      //               ],
      //  ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
