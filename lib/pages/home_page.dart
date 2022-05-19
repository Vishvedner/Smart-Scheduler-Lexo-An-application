import 'package:flutter_tts/flutter_tts.dart';
import 'package:smart_scheduler_marked/Widget/todo_list_widget.dart';
import 'package:smart_scheduler_marked/Widget/completed_lis_widget.dart';
import 'package:smart_scheduler_marked/Widget/add_todo_dialog_widget.dart';
import 'package:smart_scheduler_marked/api/firebase_api.dart';
import 'package:smart_scheduler_marked/api/notification_api.dart';
import 'package:smart_scheduler_marked/authentication/authservice.dart';
import 'package:smart_scheduler_marked/model/todo.dart';
import 'package:smart_scheduler_marked/provider/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:smart_scheduler_marked/provider/user_simple_sharedPreferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FlutterTts flutterTts = FlutterTts();
  speak() async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak('Ok $username' + 'I will Remind : check To-Do after every Hour');
  }

  bool isSwitched = false;

  Color colorWhite = Colors.white;
  Color colorBlack = Colors.black;

  int selectedIndex = 0;
  var textValue = 'Switch is OFF';
  final _advancedDrawerController = AdvancedDrawerController();

  String? username = UserSimplePreferences.getUsername();

  _HomePageState() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton(
        "97ac5656147b3e03d7d1f6e4824f55c32e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((complete) {
      selectedIndex = 0;
      MaterialPageRoute(builder: (context) => const HomePage());
      debugPrint("got new command ${complete.toString()}");
    });

    AlanVoice.onCommand.add((scheduled) {
      selectedIndex = 1;
      MaterialPageRoute(builder: (context) => const HomePage());
      debugPrint("got new command ${scheduled.toString()}");
    });

    AlanVoice.onCommand.add((add) {
      selectedIndex = 2;
      MaterialPageRoute(builder: (context) => const HomePage());
      debugPrint("got new command ${add.toString()}");
    });
  }

  //void _handleMenuButtonPressed() {
  // NOTICE: Manage Advanced Drawer state through the Controller.
  // _advancedDrawerController.value = AdvancedDrawerValue.visible();
  // _advancedDrawerController.showDrawer();
  //}

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    final tabs = [
      TodoListWidget(),
      CompletedListWidget(),
      AddTodoDialogWidget(),
    ];

    if (UserSimplePreferences.getMode() == 'light')
      return AdvancedDrawer(
        backdropColor: Colors.black,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: true,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 0.0,
          //   ),
          // ],
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            height: 50,
            backgroundColor: colorBlack,
            color: colorWhite,
            onTap: (index) => setState(() {
              selectedIndex = index;
            }),
            items: [
              Icon(Icons.fact_check_outlined, size: 30, color: colorBlack),
              Icon(Icons.done, size: 30, color: colorBlack),
              Icon(Icons.add, size: 30, color: colorBlack),
            ],
          ),
          body: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: colorBlack,
            body: Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StreamBuilder<List<Todo>>(
                      stream: FirebaseApi.readTodos(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          default:
                            if (snapshot.hasError) {
                              return buildText(
                                  'Something Went Wrong Try later');
                            } else {
                              final todos = snapshot.data;
                              final provider =
                                  Provider.of<TodosProvider>(context);
                              provider.setTodos(todos!);
                              return tabs[selectedIndex];
                            }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 8.0, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        if (selectedIndex == 0)
                          Text(
                            'Scheduled Tasks',
                            style: TextStyle(
                              color: colorWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        if (selectedIndex == 1)
                          Text(
                            'Completed Tasks',
                            style: TextStyle(
                              color: colorWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        if (selectedIndex == 2)
                          Text(
                            'Add a Task',
                            style: TextStyle(
                              color: colorWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        //IconButton(
                        //onPressed: _handleMenuButtonPressed,
                        //icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        //valueListenable: _advancedDrawerController,
                        //builder: (_, value, __) {
                        //return AnimatedSwitcher(
                        // duration: Duration(milliseconds: 250),
                        //child: Icon(
                        //value.visible ? Icons.clear : Icons.menu, size: 40,
                        //key: ValueKey<bool>(value.visible),
                        //),
                        //);
                        //},
                        //),
                        //),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              NotificationApi.showNotification(
                                  title: 'Ok $username',
                                  body: 'I will Remind : check Todo after every Hour',
                                  payload: 'samira');
                              setState(() {
                                speak();
                              });
                              print('volla --------------------------------------------------------------------');
                            },
                            child: Icon(
                              Icons.loop,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Reminder Interval',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          //ElevatedButton(
                          //onPressed: () => NotificationApi.showNotification(
                          //  title: 'Samira',
                          //body: 'Heyy theree !!!',
                          //payload: 'samira'),
                          //child: Text("test"),
                          //),
                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          if (isSwitched == false)
                            Icon(
                              Icons.wb_sunny,
                              color: Colors.white,
                            ),
                          if (isSwitched == true)
                            Icon(
                              Icons.nightlight_round,
                              color: Colors.white,
                            ),
                          SizedBox(
                            width: 20,
                          ),
                          if (isSwitched == false)
                            Text(
                              'Light Mode',
                              style: TextStyle(color: Colors.white),
                            ),
                          if (isSwitched == true)
                            Text(
                              'Dark Mode',
                              style: TextStyle(color: Colors.white),
                            ),
                          SizedBox(
                            width: 10,
                          ),
                          Switch(
                            onChanged: toggleSwitch,
                            value: isSwitched,
                            activeColor: Colors.blue,
                            activeTrackColor: Colors.white,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.blue,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await authService.signOut();
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.exit_to_app_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Sign Out',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.person, size: 30, color: Colors.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text('$username\'s TO-DO',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    if (UserSimplePreferences.getMode() == 'dark')
      return AdvancedDrawer(
        backdropColor: Colors.black,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: true,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 0.0,
          //   ),
          // ],
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            height: 50,
            backgroundColor: colorWhite,
            color: colorBlack,
            onTap: (index) => setState(() {
              selectedIndex = index;
            }),
            items: [
              Icon(Icons.fact_check_outlined, size: 30, color: colorWhite),
              Icon(Icons.done, size: 30, color: colorWhite),
              Icon(Icons.add, size: 30, color: colorWhite),
            ],
          ),
          body: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: colorWhite,
            body: Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StreamBuilder<List<Todo>>(
                      stream: FirebaseApi.readTodos(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          default:
                            if (snapshot.hasError) {
                              return buildText(
                                  'Something Went Wrong Try later');
                            } else {
                              final todos = snapshot.data;
                              final provider =
                                  Provider.of<TodosProvider>(context);
                              provider.setTodos(todos!);
                              return tabs[selectedIndex];
                            }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 8.0, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        if (selectedIndex == 0)
                          Text(
                            'Scheduled Tasks',
                            style: TextStyle(
                              color: colorBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        if (selectedIndex == 1)
                          Text(
                            'Completed Tasks',
                            style: TextStyle(
                              color: colorBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        if (selectedIndex == 2)
                          Text(
                            'Add a Task',
                            style: TextStyle(
                              color: colorBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        //IconButton(
                        //onPressed: _handleMenuButtonPressed,
                        //icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        //valueListenable: _advancedDrawerController,
                        //builder: (_, value, __) {
                        //return AnimatedSwitcher(
                        // duration: Duration(milliseconds: 250),
                        //child: Icon(
                        //value.visible ? Icons.clear : Icons.menu, size: 40,
                        //key: ValueKey<bool>(value.visible),
                        //),
                        //);
                        //},
                        //),
                        //),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              NotificationApi.showNotification(
                                title: 'Ok $username',
                                body: 'I will Remind : check Todo after every Hour',
                                payload: 'samira');
                              setState(() {
                                speak();
                              });
                              print('volla --------------------------------------------------------------------');
                            },
                            child: Icon(
                              Icons.loop,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Reminder Interval',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          //ElevatedButton(
                            //onPressed: () => NotificationApi.showNotification(
                              //  title: 'Samira',
                                //body: 'Heyy theree !!!',
                                //payload: 'samira'),
                            //child: Text("test"),
                          //),
                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          if (isSwitched == false)
                            Icon(
                              Icons.wb_sunny,
                              color: Colors.white,
                            ),
                          if (isSwitched == true)
                            Icon(
                              Icons.nightlight_round,
                              color: Colors.white,
                            ),
                          SizedBox(
                            width: 20,
                          ),
                          if (isSwitched == false)
                            Text(
                              'Light Mode',
                              style: TextStyle(color: Colors.white),
                            ),
                          if (isSwitched == true)
                            Text(
                              'Dark Mode',
                              style: TextStyle(color: Colors.white),
                            ),
                          SizedBox(
                            width: 10,
                          ),
                          Switch(
                            onChanged: toggleSwitch,
                            value: isSwitched,
                            activeColor: Colors.blue,
                            activeTrackColor: Colors.white,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.blue,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await authService.signOut();
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.exit_to_app_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Sign Out',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.person, size: 30, color: Colors.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text('$username\'s TO-DO',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    return AdvancedDrawer(
      backdropColor: Colors.black,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: true,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          backgroundColor: colorBlack,
          color: colorWhite,
          onTap: (index) => setState(() {
            selectedIndex = index;
          }),
          items: [
            Icon(Icons.fact_check_outlined, size: 30, color: colorBlack),
            Icon(Icons.done, size: 30, color: colorBlack),
            Icon(Icons.add, size: 30, color: colorBlack),
          ],
        ),
        body: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: colorBlack,
          body: Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: StreamBuilder<List<Todo>>(
                    stream: FirebaseApi.readTodos(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            return buildText(
                                'Something Went Wrong Try later');
                          } else {
                            final todos = snapshot.data;
                            final provider =
                            Provider.of<TodosProvider>(context);
                            provider.setTodos(todos!);
                            return tabs[selectedIndex];
                          }
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, right: 8.0, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (selectedIndex == 0)
                        Text(
                          'Scheduled Tasks',
                          style: TextStyle(
                            color: colorWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      if (selectedIndex == 1)
                        Text(
                          'Completed Tasks',
                          style: TextStyle(
                            color: colorWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      if (selectedIndex == 2)
                        Text(
                          'Add a Task',
                          style: TextStyle(
                            color: colorWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      //IconButton(
                      //onPressed: _handleMenuButtonPressed,
                      //icon: ValueListenableBuilder<AdvancedDrawerValue>(
                      //valueListenable: _advancedDrawerController,
                      //builder: (_, value, __) {
                      //return AnimatedSwitcher(
                      // duration: Duration(milliseconds: 250),
                      //child: Icon(
                      //value.visible ? Icons.clear : Icons.menu, size: 40,
                      //key: ValueKey<bool>(value.visible),
                      //),
                      //);
                      //},
                      //),
                      //),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            NotificationApi.showNotification(
                                title: 'Ok $username',
                                body: 'I will Remind : check Todo after every Hour',
                                payload: 'samira');
                            setState(() {
                              speak();
                            });
                            print('volla --------------------------------------------------------------------');
                          },
                          child: Icon(
                            Icons.loop,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Reminder Interval',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        //ElevatedButton(
                        //onPressed: () => NotificationApi.showNotification(
                        //  title: 'Samira',
                        //body: 'Heyy theree !!!',
                        //payload: 'samira'),
                        //child: Text("test"),
                        //),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        if (isSwitched == false)
                          Icon(
                            Icons.wb_sunny,
                            color: Colors.white,
                          ),
                        if (isSwitched == true)
                          Icon(
                            Icons.nightlight_round,
                            color: Colors.white,
                          ),
                        SizedBox(
                          width: 20,
                        ),
                        if (isSwitched == false)
                          Text(
                            'Light Mode',
                            style: TextStyle(color: Colors.white),
                          ),
                        if (isSwitched == true)
                          Text(
                            'Dark Mode',
                            style: TextStyle(color: Colors.white),
                          ),
                        SizedBox(
                          width: 10,
                        ),
                        Switch(
                          onChanged: toggleSwitch,
                          value: isSwitched,
                          activeColor: Colors.blue,
                          activeTrackColor: Colors.white,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.blue,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await authService.signOut();
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.exit_to_app_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Sign Out',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  Icon(Icons.person, size: 30, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text('$username\'s TO-DO',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        //colorWhite = Colors.black;
        //colorBlack = Colors.white;
        //ChangeColor();
        textValue = 'Switch Button is ON';
        UserSimplePreferences.setMode('light');
      });
      print('Switch Button is ON');
      print(UserSimplePreferences.getMode());
    } else {
      setState(() {
        isSwitched = false;
        //colorWhite = Colors.white;
        //colorBlack = Colors.black;
        //ChangeColor();
        textValue = 'Switch Button is OFF';
        UserSimplePreferences.setMode('dark');
      });
      print('Switch Button is OFF');
      print(UserSimplePreferences.getMode());
    }
  }

  ChangeColor() {
    if (UserSimplePreferences.getMode() == 'dark') {
      setState(() {
        colorWhite = Colors.black;
        colorBlack = Colors.white;
      });
    }
    if (UserSimplePreferences.getMode() == 'light') {
      setState(() {
        colorWhite = Colors.white;
        colorBlack = Colors.black;
      });
    }
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
