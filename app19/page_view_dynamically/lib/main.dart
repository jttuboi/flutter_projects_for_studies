import 'package:flutter/material.dart';
import 'package:page_view_dynamically/content.page.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final PageController _controller = PageController(initialPage: 0);
  int _pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0.1,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: () {},
            )
          ],
        ),
        extendBodyBehindAppBar: true,

        // o page view builder é dinamico, entao ele nao cria um monte de telas e vai acumulando
        // na memoria. cada vez que ele muda de pagina completa, ele deleta o page que era o
        // anterior.
        body: PageView.builder(
          itemCount: 10,
          controller: _controller,
          itemBuilder: (context, index) {
            return Content(pageNumber: index);
          },
        ),

        // body: PageView(
        //   physics: NeverScrollableScrollPhysics(),
        //   children: [
        //     Content(pageNumber: 0),
        //     Content(pageNumber: 1),
        //     Content(pageNumber: 2),
        //     Content(pageNumber: 3),
        //   ],
        // ),
      ),
    );
  }
}

// class A {
//   int pageViewIndex = 9;
//   ActionMenu actionMenu;
//   final PageController pageController = PageController();
//   int currentPageIndex = 0;
//   int pageCount = 1;

//   void initState() { actionMenu = ActionMenu(this.addPageView, this.removePageView); }
//   addPageView() { setState(() {  pageCount++; }); }
//   removePageView(BuildContext context) {
//     if (pageCount > 1)
//       setState(() {  pageCount--;  });
//     else
//       Scaffold.of(context).showSnackBar(SnackBar(
//         content: Text("Last page"),
//       ));
//   }

//   navigateToPage(int index) {
//     pageController.animateToPage(
//       index,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.ease,
//     );
//   }

//   getCurrentPage(int page) {  pageViewIndex = page;}

//   createPage(int page) {
//     return Container(  child: Center(  child: Text('Page $page'), ), );
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: <Widget>[  actionMenu,  ],
//       ),
//       body: Container(
//         child: PageView.builder(
//           controller: pageController,
//           onPageChanged: getCurrentPage,
//           // itemCount: pageCount,
//           itemBuilder: (context, position) {
//             if (position == 5) return null;
//             return createPage(position + 1);
//           },
//         ),
//       ),
//     );
//   }

//   setState(VoidCallback call) {}
// }

// enum MenuOptions { addPageAtEnd, deletePageCurrent }
// List<Widget> listPageView = List();

// class ActionMenu extends StatelessWidget {
//   final Function addPageView, removePageView;
//   ActionMenu(this.addPageView, this.removePageView);

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<MenuOptions>(
//       onSelected: (MenuOptions value) {
//         switch (value) {
//           case MenuOptions.addPageAtEnd:
//             this.addPageView();
//             break;
//           case MenuOptions.deletePageCurrent:
//             this.removePageView(context);
//             break;
//         }
//       },
//       itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
//         PopupMenuItem<MenuOptions>(
//           value: MenuOptions.addPageAtEnd,
//           child: const Text('Add Page at End'),
//         ),
//         const PopupMenuItem<MenuOptions>(
//           value: MenuOptions.deletePageCurrent,
//           child: Text('Delete Current Page'),
//         ),
//       ],
//     );
//   }
// }
