import 'package:bloc_with_stream/posts/bloc/post_bloc.dart';
import 'package:bloc_with_stream/posts/views/bottom_loader.dart';
import 'package:bloc_with_stream/posts/views/post_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsList extends StatefulWidget {
  const PostsList({Key? key}) : super(key: key);

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state.status.isFailure) {
          return const Center(child: Text('failed to fetch posts'));
        }

        if (state.status.isSuccess) {
          if (state.posts.isEmpty) {
            return const Center(child: Text('no posts'));
          }
          return ListView.builder(
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              return index >= state.posts.length ? const BottomLoader() : PostListItem(post: state.posts[index]);
            },
            // caso não seja o limite, ele sempre terá +1 para conter o BottomLoader()
            itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1,
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _onScroll() {
    // se cheogu no bottom, ele manda recarregar mais items
    if (_isBottom) context.read<PostBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // deve ser bottom quando passar de 90%
    // o motivo é pra pegar os itens antes de chegar o bottom e sempre ter itens mostrando como se fossem infinitos
    return currentScroll >= (maxScroll * 0.9);
  }
}
