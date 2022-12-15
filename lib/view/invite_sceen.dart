import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cubit/repository/getteamsandinviteRepo.dart';
import '../cubit/teamslistandinvite/teams_invite_cubit.dart';
import 'home_screen.dart';

class TeamrolesModal {
  bool? isSelected;
  String? atime;


  TeamrolesModal({this.isSelected = false,this.atime,});
}


class InvitePage extends StatefulWidget {
  const InvitePage({Key? key}) : super(key: key);

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {

  var emailController = TextEditingController();

  bool _isloading=false;
  String? error;
  String isselectedval = "Admin";
  GlobalKey<ScaffoldState> _key = GlobalKey();

  List<TeamrolesModal> teamroles = [];

  late GetteamCubit getteamsandinviteCubit;


  void teamroalbottombar(BuildContext context) async{

    final rolevalue = await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (ctx) {
          return SingleChildScrollView(
            child: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30), topRight: Radius.circular(30)),

                ),
                height: MediaQuery.of(context).size.height * 0.46,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35,left: 20,right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Team roles",
                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),
                            ),


                            Padding(
                              padding: const EdgeInsets.only(top: 20,bottom: 20),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: teamroles.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 5, right: 5,top: 8),
                                        child: InkWell(
                                          onTap: () {
                                            teamroles[index].isSelected = true;
                                            for (int i = 0; i < teamroles.length; i++) {
                                              if (i == index) {
                                              } else {
                                                teamroles[i].isSelected = false;
                                              }
                                            }
                                            Navigator.pop(context,teamroles[index].atime);

                                          },
                                          child: Container(
                                            height:43,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: teamroles[index].isSelected == true? Colors.transparent : Colors.grey.shade400.withOpacity(0.4), //color of shadow
                                                  spreadRadius: 1, //spread radius
                                                  blurRadius: 0, // blur radius
                                                  offset:
                                                  Offset(0, 2), // changes position of shadow
                                                ),
                                                //you can set more BoxShadow() here
                                              ],
                                              borderRadius: BorderRadius.circular(10),
                                              color:  teamroles[index].isSelected == true
                                                  ? Colors.cyan.shade50
                                                  : Colors.transparent,
                                            ),
                                            child:  Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: Text("${teamroles[index].atime}",

                                                    style: TextStyle(color: teamroles[index].isSelected == true
                                                        ? Colors.cyan
                                                        : Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),

                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),






                          ],
                        ),
                      )),
                ),
              ),
            ),
          );
        });
    if(rolevalue!=null){
      setState(() {
        isselectedval=rolevalue as String;
      });
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getteamsandinviteCubit = GetteamCubit(GetTeamview());

    log("klhxlijhdiojshdoshd");

    teamroles = [
      TeamrolesModal( atime: "Admin",isSelected: true,),
      TeamrolesModal( atime: "Approver",),
      TeamrolesModal( atime: "Preparer",),
      TeamrolesModal(atime: "Viewer"),
      TeamrolesModal(atime: "Employee"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        body: SingleChildScrollView(
          child: BlocProvider(
              create: (context) =>   getteamsandinviteCubit,
              child: BlocListener<GetteamCubit, GetteamState>(
                bloc:  getteamsandinviteCubit,
                listener: (context, state) {
                  if (state is IvitememberLoading) {

                  } else if (state is IvitememberSuccess) {

                    Fluttertoast.showToast(
                        msg: 'Invite member successfully',
                        backgroundColor: Colors.green,
                        textColor: Colors.white);


                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => Home(),
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

                    setState(() {
                      _isloading=false;
                    });


                    emailController.clear();


                  } else if (state is IvitememberFail) {

                    error =state.error;

                    Fluttertoast.showToast(
                        msg: error.toString(),
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);


                    setState(() {
                      _isloading=false;
                    });
                  }
                },
                child: BlocBuilder<GetteamCubit, GetteamState>(
                    builder: (context, state) {
                      if (state is IvitememberLoading) {
                        return homeform();
                      }  else if (state is IvitememberSuccess) {
                        return  homeform();
                      } else if (state is IvitememberFail) {
                        return homeform();
                      } else {
                        return  homeform();
                      }
                    }),
              )),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 5,left: 20,right: 20),
          child: Container(
            width: 400,
            height: 45,
            child: TextButton(
              child: _isloading ?  const Padding(padding: EdgeInsets.all(10.0), child: SizedBox(
                  height: 25,
                  width: 10,
                  child: CircularProgressIndicator(strokeWidth: 1,)),) : Text(
               "Continue",
             style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
              ),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                primary: Colors.white,
                backgroundColor: Colors.cyan,
              ),
              onPressed:(){

                String isselectedvalcheking(){
                  switch(isselectedval.toLowerCase()){
                    case 'admin':return "1";
                    case 'approver':return "2";
                    case 'preparer':return "3";
                    case 'viewer':return "4";
                    case 'employee':return "5";
                    default: return "1";
                  }
                }

                if (emailController.text.isEmpty) {

                  Fluttertoast.showToast(
                      msg: "Please enter your email address",
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0);


          } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)) {


                  Fluttertoast.showToast(
                      msg: "Please enter valid email address",
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0);
    }
    else{

    setState(() {
    _isloading = true;
    });
    log("##################"+emailController.text.toString());
    getteamsandinviteCubit.InviteNewmember(emailController.text,isselectedvalcheking());

    }


  }





            ),
          ),
        ),

        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget homeform(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [


            Padding(
              padding: const EdgeInsets.only(top: 40,left: 10),
              child: Row(
                children: [
                IconButton(
                    onPressed:(){
                      Navigator.pop(context);
                   },
                    icon: Icon(Icons.arrow_back_ios,size: 25,))
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20,left: 20),
              child: Row(
                children: const [
                  Text(
                    "Invite",
                    style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),
                  ),

                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 20,top: 10),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
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
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Center(
                  child: TextField(
                    controller:  emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      //floatingLabelBehavior: true,
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      labelText: "Business email",
                      filled: false,

                      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 0.0, top: 16.0),


                    ),
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
              child: Container(
                height: 60,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              isselectedval.toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),

                        ],
                      ),
                    ),

                    Expanded(child: SizedBox()),

                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          splashColor: Colors.white,
                          splashRadius: 3,
                          onPressed:() {
                            teamroalbottombar(context);
                          },
                          icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.cyan,size: 30,)),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );

  }


}
