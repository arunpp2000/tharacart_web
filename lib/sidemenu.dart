import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharacart_web/userprofile.dart';

import 'colapseItem.dart';
import 'login/login.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  _SideMenuState createState() => _SideMenuState();
}

int selectedTab = 0;
int subTab = 0;

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff062944),
      width: 240,
      child: Theme(
        data: ThemeData(
          highlightColor: Color(0xff062944),
        ),
        child: Scrollbar(
          child: ListView(
            children: [
              SizedBox(height: 10),
              UserProfile(),
              Column(
                children: [
                  Divider(
                    color: Colors.blueGrey.shade800,
                  ),
                  //DASHBOARD
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: selectedTab == 0
                          ? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            )
                          : null,
                    ),
                    // color: Color(0xFF1a2226),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          print(selectedTab);
                          print(subTab);
                          widget._tabController.animateTo((0));
                          selectedTab = 0;
                          subTab = 0;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.dashboard,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey.shade800,
                  ),
                  //Orders
                  InkWell(
                    onTap: () {},
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: Colors.white,
                        iconSize: 14,
                      ),
                      header: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          border: selectedTab == 1
                              ? Border(
                                  left: BorderSide(
                                    color: Color(0xff0087cd),
                                    width: 3,
                                  ),
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              FontAwesomeIcons.truck,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Orders",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((1));
                                    selectedTab = 1;
                                    subTab = 1;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "B2C Orders",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 1
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 1
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((2));
                                    selectedTab = 1;
                                    subTab = 2;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "B2B Orders",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 2
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 2
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((3));
                                    selectedTab = 1;
                                    subTab = 3;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Return Orders",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 3
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 3
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((4));
                                    selectedTab = 1;
                                    subTab = 4;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Failed Orders",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 4
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 4
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((5));
                                    selectedTab = 1;
                                    subTab = 5;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Quotation",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 5
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 5
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                          ],
                        ),
                      ),
                      collapsed: SizedBox(),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey.shade800,
                  ),
                  //products
                  InkWell(
                    onTap: () {},
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: Colors.white,
                        iconSize: 14,
                      ),
                      header: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          border: selectedTab == 2
                              ? Border(
                                  left: BorderSide(
                                    color: Color(0xff0087cd),
                                    width: 3,
                                  ),
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              FontAwesomeIcons.cartShopping,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Products",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((6));
                                    selectedTab = 2;
                                    subTab = 6;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Add Products",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 6
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 6
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((7));
                                    selectedTab = 2;
                                    subTab = 7;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Product List",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 7
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 7
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((8));
                                    selectedTab = 2;
                                    subTab = 8;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Add Category",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 8
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 8
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((9));
                                    selectedTab = 2;
                                    subTab = 9;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Category List",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 9
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 9
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((10));
                                    selectedTab = 2;
                                    subTab = 10;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Add Brand",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 10
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 10
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((11));
                                    selectedTab = 2;
                                    subTab = 11;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Brand List",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 11
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 11
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                          ],
                        ),
                      ),
                      collapsed: SizedBox(),
                    ),
                  ),

                  Divider(
                    color: Colors.blueGrey.shade800,
                  ),
                  //banners
                  InkWell(
                    onTap: () {},
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: Colors.white,
                        iconSize: 14,
                      ),
                      header: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          border: selectedTab == 3
                              ? Border(
                                  left: BorderSide(
                                    color: Color(0xff0087cd),
                                    width: 3,
                                  ),
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              FontAwesomeIcons.inbox,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Banners",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((12));
                                    selectedTab = 3;
                                    subTab = 12;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "B2B Banner",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 12
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 12
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((13));
                                    selectedTab = 3;
                                    subTab = 13;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "B2C Banner",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 13
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 13
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                          ],
                        ),
                      ),
                      collapsed: SizedBox(),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey.shade800,
                  ),
                  //admin users
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: selectedTab == 4
                          ? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            )
                          : null,
                    ),
                    // color: Color(0xFF1a2226),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          print(selectedTab);
                          print(subTab);
                          widget._tabController.animateTo((14));
                          selectedTab = 4;
                          subTab = 0;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.supervised_user_circle_sharp,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Admin Users",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey.shade800,
                  ),
                  //users
                  InkWell(
                    onTap: () {},
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: Colors.white,
                        iconSize: 14,
                      ),
                      header: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          border: selectedTab == 5
                              ? Border(
                            left: BorderSide(
                              color: Color(0xff0087cd),
                              width: 3,
                            ),
                          )
                              : null,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              FontAwesomeIcons.users,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Users",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((15));
                                    selectedTab = 5;
                                    subTab = 14;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Users",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 14
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 14
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((16));
                                    selectedTab = 5;
                                    subTab = 15;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Deleted Users",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 15
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 15
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                          ],
                        ),
                      ),
                      collapsed: SizedBox(),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey.shade800,
                  ),
                  //b2b request
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: selectedTab == 6
                          ? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            )
                          : null,
                    ),
                    // color: Color(0xFF1a2226),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          print(selectedTab);
                          print(subTab);
                          widget._tabController.animateTo((17));
                          selectedTab = 7;
                          subTab = 0;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.request_page,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "B2b Request",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey.shade800,
                  ),
                  //logictsics
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: selectedTab == 7
                          ? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            )
                          : null,
                    ),
                    // color: Color(0xFF1a2226),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          print(selectedTab);
                          print(subTab);
                          widget._tabController.animateTo((18));
                          selectedTab = 8;
                          subTab = 0;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.manage_accounts,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Logistics",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey.shade800,
                  ),
                  //referral request
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: selectedTab == 8
                          ? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            )
                          : null,
                    ),
                    // color: Color(0xFF1a2226),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          print(selectedTab);
                          print(subTab);
                          widget._tabController.animateTo((19));
                          selectedTab = 8;
                          subTab = 0;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.archive_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Referral Request",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //Deals
                  //deals
                  // Container(
                  //   height: 30,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     border: selectedTab == 0
                  //         ? Border(
                  //             left: BorderSide(
                  //               color: Color(0xff0087cd),
                  //               width: 3,
                  //             ),
                  //           )
                  //         : null,
                  //   ),
                  //   // color: Color(0xFF1a2226),
                  //   child: InkWell(
                  //     onTap: () {
                  //       setState(() {
                  //         print(selectedTab);
                  //         print(subTab);
                  //         widget._tabController.animateTo((21));
                  //         selectedTab = 10;
                  //         subTab = 0;
                  //       });
                  //     },
                  //     child: Row(
                  //       children: [
                  //         SizedBox(
                  //           width: 10,
                  //         ),
                  //         Icon(
                  //           Icons.handshake,
                  //           color: Colors.white,
                  //           size: 18,
                  //         ),
                  //         SizedBox(
                  //           width: 7,
                  //         ),
                  //         Text(
                  //           "Deals",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Divider(
                    color: Colors.blueGrey.shade800,
                  ),
                  //documents
                  InkWell(
                    onTap: () {},
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: Colors.white,
                        iconSize: 14,
                      ),
                      header: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          border: selectedTab == 9
                              ? Border(
                            left: BorderSide(
                              color: Color(0xff0087cd),
                              width: 3,
                            ),
                          )
                              : null,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.document_scanner_sharp,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Documents",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [
                            // InkWell(
                            //     onTap: () {
                            //       setState(() {
                            //         widget._tabController.animateTo((20));
                            //         selectedTab = 9;
                            //         subTab = 1;
                            //       });
                            //     },
                            //     child: ColaspeItem(
                            //       label: "OrderList",
                            //       icon: Icons.stop_rounded,
                            //       style: TextStyle(
                            //           color: subTab == 1
                            //               ? Colors.blue.shade300
                            //               : Colors.grey,
                            //           fontWeight: subTab == 1
                            //               ? FontWeight.bold
                            //               : FontWeight.normal),
                            //     )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((20));
                                    selectedTab = 9;
                                    subTab = 16;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Coupons",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 16
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 16
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                          ],
                        ),
                      ),
                      collapsed: SizedBox(),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey.shade800,
                  ),
                  //reports
                  InkWell(
                    onTap: () {},
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: Colors.white,
                        iconSize: 14,
                      ),
                      header: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          border: selectedTab == 10
                              ? Border(
                            left: BorderSide(
                              color: Color(0xff0087cd),
                              width: 3,
                            ),
                          )
                              : null,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.report,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Reports",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((21));
                                    selectedTab = 10;
                                    subTab = 17;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "B2c Report",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 17
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 17
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((22));
                                    selectedTab = 10;
                                    subTab = 18;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "B2b Reports",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 18
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 218
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                          ],
                        ),
                      ),
                      collapsed: SizedBox(),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey.shade800,
                  ),
                  //settings
                  InkWell(
                    onTap: () {},
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: Colors.white,
                        iconSize: 14,
                      ),
                      header: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          border: selectedTab == 11
                              ? Border(
                            left: BorderSide(
                              color: Color(0xff0087cd),
                              width: 3,
                            ),
                          )
                              : null,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Settings",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((23));
                                    selectedTab = 11;
                                    subTab = 19;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Groups",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 19
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 19
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((24));
                                    selectedTab = 11;
                                    subTab = 20;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "SMTP",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 20
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 20
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((25));
                                    selectedTab = 11;
                                    subTab = 21;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Medal",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 21
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 21
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((26));
                                    selectedTab = 11;
                                    subTab = 22;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Running Message",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 22
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 22
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((27));
                                    selectedTab = 11;
                                    subTab = 23;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Add Contact",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 23
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 23
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((28));
                                    selectedTab = 11;
                                    subTab = 24;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Add Notification",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 24
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 24
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((29));
                                    selectedTab = 11;
                                    subTab = 15;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Add Announcement",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 15
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 15
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((30));
                                    selectedTab = 11;
                                    subTab = 26;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Survey",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 26
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 26
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((31));
                                    selectedTab = 11;
                                    subTab = 27;
                                  });
                                },
                                child: ColaspeItem(
                                  label: "Survey List ",
                                  icon: Icons.stop_rounded,
                                  style: TextStyle(
                                      color: subTab == 27
                                          ? Colors.blue.shade300
                                          : Colors.grey,
                                      fontWeight: subTab == 27
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )),
                          ],
                        ),
                      ),
                      collapsed: SizedBox(),
                    ),
                  ),
                  // LOGOUT
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: Text('Logout !'),
                            content: Text('Do you Want to Logout ?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(alertDialogContext);
                                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.remove('isLoggedIn');
                                  userLogged = false;
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginPageWidget()),
                                          (route) => false);
                                },
                                child: Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: CustomSideMenuItem(
                      title: 'Logout',
                      icon: Icons.logout,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
class CustomSideMenuItem extends StatelessWidget {
  const CustomSideMenuItem({
    Key? key,
    this.icon,
    this.iconSize = 18,
    this.iconColor = Colors.white,
    this.title,
    this.titleStyle,
    this.onTap,
    this.backColor,
  }) : super(key: key);

  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final Color? backColor;
  final String? title;
  final TextStyle? titleStyle;

  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        color: backColor,
        child: Row(
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              title!,
              style: titleStyle ??
                  TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}