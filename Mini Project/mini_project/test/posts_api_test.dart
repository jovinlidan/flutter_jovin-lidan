import 'package:mini_project/model/api/post_api.dart';
import 'package:mini_project/services/services.dart';
import 'package:mini_project/view_models/posts_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

// import 'contact_api_test.mocks.dart';

@GenerateMocks([PostAPI])
void main() {
  group('Contact API', () {
    // MockContactAPI contactAPI = MockContactAPI();
    test('get all posts returns state', () async {
      var postViewModel = PostsViewModel();
      expect(postViewModel.posts?.status, ApiStatus.success);

      postViewModel.getPosts();
      expect(postViewModel.posts?.status, ApiStatus.loading);

      await postViewModel.getPosts();

      expect(postViewModel.posts?.status, ApiStatus.success);
    });
    // test('get all contacts returns data', () async {
    //   when(contactAPI.getContacts())
    //       .thenAnswer((_) async => <Contact>[Contact(id: 1, name: 'a', phone: '1')]);
    //   var contacts = await contactAPI.getContacts();
    //   expect(contacts.isNotEmpty, true);
    // });
  });
}
