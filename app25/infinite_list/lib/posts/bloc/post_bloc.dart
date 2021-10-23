import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:infinite_list/posts/models/post.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(_onPostFetched, transformer: throttleDroppable(_throttleDuration));
  }

  static const _throttleDuration = Duration(milliseconds: 500);
  static const _postLimit = 20;

  final http.Client httpClient;

  Future<void> _onPostFetched(PostFetched event, Emitter<PostState> emit) async {
    // não atualiza mais o estado em caso chegar no maximo
    if (state.hasReachedMax) {
      return;
    }
    try {
      // quando é a primeira vez, ele chama e envia os dados retornados
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      }
      // recupera os proximos posts
      final posts = await _fetchPosts(state.posts.length);
      emit(posts.isEmpty
          // se nao chegar mais posts, entao coloca como
          // chegou ao fim da lista
          ? state.copyWith(hasReachedMax: true)
          // se chegar, ele concatena com os posts da lista anterior
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: false,
            ));
    } catch (e) {
      // caso há algum erro, retorna falha
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Post.fromMap(json);
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}

// One optimization we can make is to debounce the Events in order to prevent
// spamming our API unnecessarily. We can do this by overriding the transform method in our PostBloc.
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}
