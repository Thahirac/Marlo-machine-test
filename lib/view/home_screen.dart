import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marlo/view/invite_sceen.dart';

import '../cubit/repository/getteamsandinviteRepo.dart';
import '../cubit/teamslistandinvite/teams_invite_cubit.dart';
import '../main.dart';
import '../modals/Getteam_class.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var searchController = TextEditingController();

  GlobalKey<ScaffoldState> _key = GlobalKey();

  late GetteamCubit getteamsCubit;

  List<Contact> getcontacts = [];

  List<Invite> getinvites = [];
  bool isseeall1 = false;
  bool isseeall2 = false;

  int _selectedIndex = 2;
  static const List<Widget> _widgetOptions = <Widget>[];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getteamsCubit = GetteamCubit(GetTeamview());
    getteamsCubit.GetteamGet();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text("Marlo Bank"),
          centerTitle: true,
          backgroundColor: Colors.cyan,
          actions: [
            IconButton(
                icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () {
                  MyApp.themeNotifier.value =
                  MyApp.themeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                })
          ],
        ),
        body: SingleChildScrollView(
          child: BlocProvider(
              create: (context) => getteamsCubit,
              child: BlocListener<GetteamCubit, GetteamState>(
                bloc: getteamsCubit,
                listener: (context, state) {
                  if (state is GetteamInitial) {}
                  if (state is GetteamLoading) {
                  } else if (state is GetteamSuccess) {
                    getcontacts = state.teamsandinviteListdata;
                    getinvites = state.inviteListdata;
                  } else if (state is GetteamFail) {
                    //   Utils.showDialouge(context, AlertType.error, "Oops!", state.msg);
                  }
                },
                child: BlocBuilder<GetteamCubit, GetteamState>(
                    builder: (context, state) {
                  // print("gjgfjhfjf" + cart_count.toString());
                  if (state is GetteamInitial) {
                    return Column(
                      children: const [
                        SizedBox(
                          height: 390,
                        ),
                        Center(
                          child: CupertinoActivityIndicator(
                            radius: 10,
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is GetteamLoading) {
                    return Column(
                      children: const [
                        SizedBox(
                          height: 390,
                        ),
                        Center(
                          child: CupertinoActivityIndicator(
                            radius: 10,

                          ),
                        ),
                      ],
                    );
                  } else if (state is GetteamSuccess) {
                    return homeform();
                  } else if (state is GetteamFail) {
                    return homeform();
                  } else {
                    return homeform();
                  }
                }),
              )),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add_rounded,
            size: 30,
          ),
          backgroundColor: Colors.cyan,
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => InvitePage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = Offset(1.0, 0.0);
                  var end = Offset.zero;
                  var tween = Tween(begin: begin, end: end);
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 500),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 28,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.attach_money_rounded,
                  size: 28,
                ),
                label: 'Loan',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.book_online_outlined,
                  size: 28,
                ),
                label: 'Contracts',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.groups_outlined,
                  size: 28,
                ),
                label: 'Teams',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.contact_support_outlined,
                  size: 28,
                ),
                label: 'Chat',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.cyan,
            unselectedItemColor: Colors.grey,

            iconSize: 30,
            onTap: _onItemTapped,
            elevation: 10),
      ),
    );
  }

  Widget homeform() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20),
              child: Row(
                children: const [
                  Text(
                    "Teams",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.search_rounded,
                      color: Colors.grey,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All people - " + getcontacts.length.toString(),
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isseeall1 = !isseeall1;
                            });
                          },
                          child: Text(
                            isseeall1 ? "Less" : "See All",
                            style: const TextStyle(
                                color: Colors.cyan,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: SizedBox(
                child: ListView.builder(
                    itemCount: isseeall1 ? getcontacts.length : 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20, top: 10),
                        child: Container(
                          height: 65,
                          width: 335,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400
                                    .withOpacity(0.4), //color of shadow
                                spreadRadius: 1, //spread radius
                                blurRadius: 0, // blur radius
                                offset:
                                Offset(0, 2), // changes position of shadow
                              ),
                              //you can set more BoxShadow() here
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent.shade400,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  getcontacts[index]
                                                          .firstname?[0]
                                                          .toUpperCase()
                                                          .toString() ??
                                                      "N",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  getcontacts[index]
                                                          .lastname?[0]
                                                          .toUpperCase()
                                                          .toString() ??
                                                      "N",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getcontacts[index]
                                                  .firstname
                                                  .toString() +
                                              " " +
                                              getcontacts[index]
                                                  .lastname
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          getcontacts[index].isactive == "true"
                                              ? "Active"
                                              : "Inactive",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  getcontacts[index].roleName.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Invited people - " + getinvites.length.toString(),
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isseeall2 = !isseeall2;
                            });
                          },
                          child: Text(
                            isseeall2 ? "Less" : "See All",
                            style: TextStyle(
                                color: Colors.cyan,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: SizedBox(
                child: ListView.builder(
                    itemCount: isseeall2 ? getinvites.length : 2,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20, top: 10),
                        child: Container(
                          height: 65,
                          width: 335,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400
                                    .withOpacity(0.4), //color of shadow
                                spreadRadius: 1, //spread radius
                                blurRadius: 0, // blur radius
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                              //you can set more BoxShadow() here
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.brown.shade300,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  getinvites[index]
                                                          .email?[0]
                                                          .toUpperCase()
                                                          .toString() ??
                                                      "",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  getinvites[index]
                                                          .email?[1]
                                                          .toUpperCase()
                                                          .toString() ??
                                                      "",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  getinvites[index]
                                                      .email
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600),

                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              getinvites[index].configName.toString(),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),

                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
