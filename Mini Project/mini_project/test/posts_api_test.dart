import 'package:mini_project/model/api/post_api.dart';
import 'package:mini_project/model/post_model.dart';
import 'package:mini_project/services/services.dart';
import 'package:mini_project/view_models/posts_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import 'posts_api_test.mocks.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([PostAPI])
void main() {
  group('Post API', () {
    MockPostAPI postAPI = MockPostAPI();
    test('get all posts returns state', () async {
      var postViewModel = PostsViewModel();
      expect(postViewModel.posts?.status, ApiStatus.success);

      postViewModel.getPosts();
      expect(postViewModel.posts?.status, ApiStatus.loading);

      await postViewModel.getPosts();

      expect(postViewModel.posts?.status, ApiStatus.success);
    });
    test('get all posts returns data', () async {
      when(postAPI.getPosts()).thenAnswer((_) async => <Post>[
            Post(comments: [], createdAt: DateTime.now(), description: "TEST", sId: "1", user: [])
          ]);
      var posts = await postAPI.getPosts();
      expect(posts.isNotEmpty, true);
      expect(posts[0].description, "TEST");
    });
  });
}
