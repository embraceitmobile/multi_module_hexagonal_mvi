import 'package:drift/native.dart';
import 'package:social_feed/data/datasources/local/social_post/daos/social_post_dao.dart';
import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'package:test/test.dart';

import '../mocks/mock_social_posts.dart';

void main() {
  late SocialFeedDatabase database;
  late SocialPostDao dao;

  setUp(() {
    database = SocialFeedDatabase(NativeDatabase.memory());
    dao = SocialPostDao(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('correct single post with no comments is saved and retrieved', () async {
    await dao.insertOrUpdatePost(singlePost1);
    final fetchResult = await dao.allPosts;

    expect(fetchResult.length, 1);
  });

  test(
      'on inserting multiple posts, the corresponding number of items'
          'are retrieved', () async {
    await dao.insertOrUpdatePost(singlePost1);
    await dao.insertOrUpdatePost(singlePost2);
    await dao.insertOrUpdatePost(singlePost3);
    final fetchResult = await dao.allPosts;

    expect(fetchResult.length, 3);
  });

  test(
      'on inserting a list of posts, the corresponding number of items are retrieved',
          () async {
        final postsCount = multiplePosts.length;
        await dao.insertOrUpdatePosts(multiplePosts);

        final fetchResult = await dao.allPosts;

        expect(fetchResult.length, postsCount);
      });

  test(
      'on inserting a post, the corresponding entry is emitted in the watcher',
          () async {
        await dao.insertOrUpdatePost(singlePost1);
        dao.observeAllPosts.listen(expectAsync1((event) {
          expect(event.length, 1);
          expect(event.first.id, singlePost1.id);
        }));
      });

  test(
      'on inserting a post, the corresponding entry is emitted in the watcher',
          () async {
        await dao.insertOrUpdatePost(singlePost1);
        await dao.insertOrUpdatePost(singlePost2);
        await dao.insertOrUpdatePost(singlePost3);
        dao.observeAllPosts.listen(expectAsync1((event) {
          expect(event.length, 3);
          expect(event.last.id, singlePost3.id);
        }));
      });

  test(
      'on inserting a post, the corresponding entry is emitted in the watcher',
          () async {
        dao.observeAllPosts.listen(expectAsync1((event) {}, count: 4, max: 4));

        await dao.insertOrUpdatePost(singlePost1);
        await dao.insertOrUpdatePost(singlePost2);
        await dao.insertOrUpdatePost(singlePost3);
      });

  test(
      'on inserting a list of posts, the corresponding entries are emitted in the watcher',
          () async {
        var count = 0;
        final emitOrder = [0, multiplePosts.length];
        dao.observeAllPosts.listen(expectAsync1((event) {
          expect(event.length, emitOrder[count]);
          count++;
        }, count: 2, max: 2));

        await dao.insertOrUpdatePosts(multiplePosts);
      });

  test('on clearing table, all items are removed', () async {
    await dao.insertOrUpdatePosts(multiplePosts);
    expect((await dao.allPosts).length, multiplePosts.length);

    await dao.clearPosts();
    expect((await dao.allPosts).length, 0);
  });
}
