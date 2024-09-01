import 'package:flutter/material.dart';

import 'package:nav2_devanshi_garg/main.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildButton(
              title: 'Gallery',
              onPress: () => (Router.of(context).routerDelegate as MyRouterDelegate).myRoute = MyRoute.gallery,
            ),
            const SizedBox(width: 10),
            _buildButton(
              title: 'See All',
              onPress: () => (Router.of(context).routerDelegate as MyRouterDelegate).myRoute = MyRoute.seeAll,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({required String title, required Function() onPress}) {
    const imageUrl =
        'https://images.unsplash.com/photo-1574367157590-3454fe866961?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NDF8fGdhbGxlcnl8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60';

    return GestureDetector(
      onTap: onPress,
      child: SizedBox(
        width: 500,
        height: 650,
        child: Card(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(imageUrl, fit: BoxFit.fill),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GalleryPage extends StatefulWidget {
  const GalleryPage(this.tab, {Key? key}) : super(key: key);

  final int tab;

  @override
  GalleryPageState createState() => GalleryPageState();
}

class GalleryPageState extends State<GalleryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // irá gerenciar o estado requerido pelo TabBar e TabBarView
    _tabController = TabController(initialIndex: widget.tab, length: 2, vsync: this)..addListener(_onTabIndexChange);
  }

  @override
  void didUpdateWidget(GalleryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // atualiza com o novo indice quando o widget atualizar
    _tabController.index = widget.tab;
  }

  @override
  Widget build(BuildContext context) {
    const src =
        'https://images.unsplash.com/flagged/photo-1572392640988-ba48d1a74457?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxzZWFyY2h8MzV8fGFydHxlbnwwfHwwfA%3D%3D&auto=format&fit=crop&w=800&q=60';
    const src2 =
        'https://images.unsplash.com/photo-1578926288207-a90a5366759d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mzd8fGFydHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60';
    const src3 =
        'https://images.unsplash.com/photo-1579541814924-49fef17c5be5?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxzZWFyY2h8NzN8fGFydHxlbnwwfHwwfA%3D%3D&auto=format&fit=crop&w=800&q=60';
    const src4 =
        'https://images.unsplash.com/photo-1511108690759-009324a90311?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTJ8fGJvb2slMjBjb3ZlcnxlbnwwfHwwfA%3D%3D&auto=format&fit=crop&w=800&q=60';
    const src5 =
        'https://images.unsplash.com/photo-1544947950-fa07a98d237f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MjR8fGJvb2slMjBjb3ZlcnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60';
    const src6 =
        'https://images.unsplash.com/photo-1603289847962-9da9640785e3?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mzl8fGJvb2slMjBjb3ZlcnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.brush)),
            Tab(icon: Icon(Icons.book)),
          ],
        ),
        title: const Text('Gallery', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(padding: const EdgeInsets.symmetric(horizontal: 16), height: 500, child: Image.network(src)),
                Container(padding: const EdgeInsets.symmetric(horizontal: 16), height: 500, child: Image.network(src2)),
                Container(padding: const EdgeInsets.symmetric(horizontal: 16), height: 500, child: Image.network(src3)),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(padding: const EdgeInsets.symmetric(horizontal: 16), height: 500, child: Image.network(src4)),
                Container(padding: const EdgeInsets.symmetric(horizontal: 16), height: 500, child: Image.network(src5)),
                Container(padding: const EdgeInsets.symmetric(horizontal: 16), height: 500, child: Image.network(src6)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTabIndexChange() {
    if (_tabController.indexIsChanging) {
      return;
    }

    final MyRouterDelegate state = Router.of(context).routerDelegate as MyRouterDelegate;
    if (state.tab == _tabController.index) {
      return;
    }

    Router.navigate(context, () {
      state.tab = _tabController.index;
    });
  }
}

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imgSrc2 =
        'https://images.unsplash.com/flagged/photo-1572392640988-ba48d1a74457?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxzZWFyY2h8MzV8fGFydHxlbnwwfHwwfA%3D%3D&auto=format&fit=crop&w=800&q=60';
    var imgSrc3 =
        'https://images.unsplash.com/photo-1578926288207-a90a5366759d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mzd8fGFydHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60';
    var imgSrc4 =
        'https://images.unsplash.com/photo-1579541814924-49fef17c5be5?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxzZWFyY2h8NzN8fGFydHxlbnwwfHwwfA%3D%3D&auto=format&fit=crop&w=800&q=60';
    var imgSrc5 =
        'https://images.unsplash.com/photo-1511108690759-009324a90311?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTJ8fGJvb2slMjBjb3ZlcnxlbnwwfHwwfA%3D%3D&auto=format&fit=crop&w=800&q=60';
    var imgSrc6 =
        'https://images.unsplash.com/photo-1544947950-fa07a98d237f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MjR8fGJvb2slMjBjb3ZlcnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60';
    var imgSrc7 =
        'https://images.unsplash.com/photo-1603289847962-9da9640785e3?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mzl8fGJvb2slMjBjb3ZlcnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: const Text('See All', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildItem(context, imgSrc: imgSrc2, title: 'Renaissance', rating: '4.5'),
            _buildItem(context, imgSrc: imgSrc3, title: 'Motherly Love', rating: '4.5'),
            _buildItem(context, imgSrc: imgSrc4, title: 'Serenity', rating: '4.0'),
            _buildItem(context, imgSrc: imgSrc5, title: 'Your Soul is a River', rating: '4.0'),
            _buildItem(context, imgSrc: imgSrc6, title: 'Milk and Honey', rating: '4.5'),
            _buildItem(context, imgSrc: imgSrc7, title: 'Russian Novel', rating: '3.5')
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, {required String imgSrc, required String title, required String rating}) {
    const data = 'ki';

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 300,
            child: Image.network(imgSrc),
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => (Router.of(context).routerDelegate as MyRouterDelegate).myRoute = MyRoute.more,
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  data,
                  softWrap: true,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, height: 1.5),
                ),
                const SizedBox(height: 55),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 10),
                    Text(rating),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ContentDetail extends StatefulWidget {
  const ContentDetail({Key? key}) : super(key: key);

  @override
  _ContentDetailState createState() => _ContentDetailState();
}

class _ContentDetailState extends State<ContentDetail> {
  @override
  Widget build(BuildContext context) {
    var src =
        'https://images.unsplash.com/flagged/photo-1572392640988-ba48d1a74457?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxzZWFyY2h8MzV8fGFydHxlbnwwfHwwfA%3D%3D&auto=format&fit=crop&w=800&q=60';
    var data = 'ki 2';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: const Text('Details', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 100, child: Image.network(src)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Renaissance', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 35),
                  Text(
                    data,
                    softWrap: true,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20, height: 1.5),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
