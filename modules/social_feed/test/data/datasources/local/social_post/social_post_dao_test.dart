import 'package:drift/native.dart';
import 'package:social_feed/data/datasources/local/social_post/daos/social_post_dao.dart';
import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'package:social_feed/data/datasources/local/social_post_comment/daos/social_post_comment_dao.dart';
import 'package:test/test.dart';
import 'package:core/core_pure_dart.dart';

import '../mocks/mock_social_post_comments.dart';
import '../mocks/mock_social_posts.dart';

void main() {
  late SocialFeedDatabase database;
  late SocialPostDao socialPostDao;
  late SocialPostCommentDao socialPostCommentDao;

  setUp(() {
    database = SocialFeedDatabase(NativeDatabase.memory());
    socialPostDao = SocialPostDao(database);
    socialPostCommentDao = SocialPostCommentDao(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('test posts with no comments', () {
    test('correct single post with no comments is saved and retrieved',
        () async {
      await socialPostDao.insertOrUpdatePost(singlePost1);
      final fetchResult = await socialPostDao.allPosts;

      expect(fetchResult.length, 1);
    });

    test(
        'on inserting multiple posts, the corresponding number of items'
        'are retrieved', () async {
      await socialPostDao.insertOrUpdatePost(singlePost1);
      await socialPostDao.insertOrUpdatePost(singlePost2);
      await socialPostDao.insertOrUpdatePost(singlePost3);
      final fetchResult = await socialPostDao.allPosts;

      expect(fetchResult.length, 3);
    });

    test(
        'on inserting a list of posts, the corresponding number of items are retrieved',
        () async {
      final postsCount = multiplePosts.length;
      await socialPostDao.insertOrUpdatePosts(multiplePosts);

      final fetchResult = await socialPostDao.allPosts;

      expect(fetchResult.length, postsCount);
    });

    test(
        'on inserting a post, the corresponding entry is emitted in the watcher',
        () async {
      await socialPostDao.insertOrUpdatePost(singlePost1);
      socialPostDao.observeAllPosts.listen(expectAsync1((event) {
        expect(event.length, 1);
        expect(event.first.successOrNull?.id, singlePost1.id);
      }));
    });

    test(
        'on inserting a post, the corresponding entry is emitted in the watcher',
        () async {
      await socialPostDao.insertOrUpdatePost(singlePost1);
      await socialPostDao.insertOrUpdatePost(singlePost2);
      await socialPostDao.insertOrUpdatePost(singlePost3);
      socialPostDao.observeAllPosts.listen(expectAsync1((event) {
        expect(event.length, 3);
        expect(event.last.successOrNull?.id, singlePost3.id);
      }));
    });

    test(
        'on inserting a post, the corresponding entry is emitted in the watcher',
        () async {
      socialPostDao.observeAllPosts
          .listen(expectAsync1((event) {}, count: 4, max: 4));

      await socialPostDao.insertOrUpdatePost(singlePost1);
      await socialPostDao.insertOrUpdatePost(singlePost2);
      await socialPostDao.insertOrUpdatePost(singlePost3);
    });

    test(
        'on inserting a list of posts, the corresponding entries are emitted in the watcher',
        () async {
      var count = 0;
      final emitOrder = [0, multiplePosts.length];
      socialPostDao.observeAllPosts.listen(expectAsync1((event) {
        expect(event.length, emitOrder[count]);
        count++;
      }, count: 2, max: 2));

      await socialPostDao.insertOrUpdatePosts(multiplePosts);
    });

    test('on clearing table, all items are removed', () async {
      await socialPostDao.insertOrUpdatePosts(multiplePosts);
      expect((await socialPostDao.allPosts).length, multiplePosts.length);

      await socialPostDao.clearPosts();
      expect((await socialPostDao.allPosts).length, 0);
    });
  });

  group('test posts with comments', () {
    test('correct single post with comments is saved and retrieved', () async {
      await socialPostDao.insertOrUpdatePost(singlePostWithComments1);
      final fetchResult = await socialPostDao.allPosts;

      expect(fetchResult.length, 1);
      expect(fetchResult.first.comments.length, 1);
    });

    test('correct single post with multiple comments is saved and retrieved',
        () async {
      await socialPostDao.insertOrUpdatePost(singlePostWithMultiComments);
      final fetchResult = await socialPostDao.allPosts;

      expect(fetchResult.length, 1);
      expect(fetchResult.first.comments.length, commentsForPost1.length);
    });

    test('comments in post are updated on inserting comments separately',
        () async {
      await socialPostDao.insertOrUpdatePost(singlePost1);
      final fetchResult = await socialPostDao.allPosts;

      expect(fetchResult.length, 1);

      await socialPostCommentDao.insertOrUpdateComments(commentsForPost1);
      final fetchResult2 = await socialPostDao.allPosts;

      expect(fetchResult2.first.comments.length, commentsForPost1.length);
    });

    test('watcher emits values when either posts or comments are updated',
        () async {
      var counter = 0;
      final jobEmitOrder = [0, 1, 1];
      final commentEmitOrder = [0, 0, 4];
      socialPostDao.observeAllPosts.listen(expectAsync1((event) {
        expect(event.length, jobEmitOrder[counter]);
        if (event.isNotEmpty) {
          expect(event.first.successOrNull?.comments.length,
              commentEmitOrder[counter]);
        }
        counter++;
      }, count: 3, max: 3));

      await socialPostDao.insertOrUpdatePost(singlePost1);
      await socialPostCommentDao.insertOrUpdateComments(commentsForPost1);
    });
  });
}
