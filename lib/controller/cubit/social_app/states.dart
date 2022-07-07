

abstract class SocialAppStates {}

class IntialSocialAppStates extends SocialAppStates {}
class SocialAppLoadingStates extends SocialAppStates {}
class SocialAppScuccessStates extends SocialAppStates {}
class SocialAppErrorStates extends SocialAppStates {}

class SocialBottomNavigationBarstate extends SocialAppStates{}

class SocialNewsPostState extends SocialAppStates{}


class SocialCoverImagePickedSuccessState extends SocialAppStates {}

class SocialCoverImagePickedErorrState extends SocialAppStates {}

class SocialProfileImagePickedSuccessState extends SocialAppStates {}

class SocialProfileImagePickedErorrState extends SocialAppStates {}

class SocialProfileImagePickedLoadingState extends SocialAppStates {}

class SocialUploadImageProfileSuccessStates extends SocialAppStates {}

class SocialUploadImageProfileErorrStates extends SocialAppStates {}

class SocialUploadImageCoverSuccessStates extends SocialAppStates {}

class SocialUploadImageCoverErorrStates extends SocialAppStates {}

class SocialUserImagesUpdateloadingStates extends SocialAppStates {}
class SocialUserUpdateSuccessStates extends SocialAppStates {}

class SocialUserUpdateErorrStates extends SocialAppStates {}

class SocialUpdateUserloadingStates extends SocialAppStates {}

class SocialPostImagePickedSuccessState extends SocialAppStates {}

class SocialPostImagePickedErorrState extends SocialAppStates {}

//class SocialUploadPostImageloadingStates extends SocialAppStates {}

class SocialUploadPostImageSuccessStates extends SocialAppStates {}

class SocialUploadPostImageErorrStates extends SocialAppStates {}

class SocialCreatePostLoadingStates extends SocialAppStates {}

class SocialCreatePostSuccessStates extends SocialAppStates {}

class SocialCreatePostErorrStates extends SocialAppStates {}

class SocialRemovePostImageStates extends SocialAppStates {}


class SocialGetPostsLoadingState extends SocialAppStates {}

class SocialGetPostsSucsessState extends SocialAppStates {}

class SocialGetPostsErorrState extends SocialAppStates {
  final String erorr;

  SocialGetPostsErorrState(this.erorr);
}

class SocialPostLikesLoadingState extends SocialAppStates {}

class SocialPostLikesSucsessState extends SocialAppStates {}

class SocialPostLikesErorrState extends SocialAppStates {
  final String erorr;

  SocialPostLikesErorrState(this.erorr);
}

class SocialPostCommentsLoadingState extends SocialAppStates {}

class SocialPostCommentsSuccsessState extends SocialAppStates {}

class SocialPostCommentsErorrState extends SocialAppStates {
  final String erorr;

  SocialPostCommentsErorrState(this.erorr);
}

class SocialCreateCommentLoadingStates extends SocialAppStates {}

class SocialCreateCommentSuccessStates extends SocialAppStates {}

class SocialCreateCommentErorrStates extends SocialAppStates {}

class SocialCommentImagePickedSuccessState extends SocialAppStates {}

class SocialCommentImagePickedErorrState extends SocialAppStates {}

class SocialUploadCommentImageErorrStates extends SocialAppStates {}

class SocialGetCommentsLoadingState extends SocialAppStates {}

class SocialGetCommentsSuccsessState extends SocialAppStates {}

class SocialGetCommentsErorrState extends SocialAppStates {
  final String erorr;

  SocialGetCommentsErorrState(this.erorr);
}

class SocialGetAllUsersLoadingState extends SocialAppStates {}

class SocialGetAllUsersSuccessState extends SocialAppStates {}

class SocialGetAllUsersErorrState extends SocialAppStates {
  final String erorr;

  SocialGetAllUsersErorrState(this.erorr);
}

//
class SocialSendMessageLoadingState extends SocialAppStates {}

class SocialSendMessageSuccessState extends SocialAppStates {}

class SocialSendMessageErorrState extends SocialAppStates {
  final String erorr;

  SocialSendMessageErorrState(this.erorr);
}

class SocialGetMessageSuccessState extends SocialAppStates {}

class SocialGetMessageLoginState extends SocialAppStates {}

class SocialGetUserPostsLengthSuccessState extends SocialAppStates {}

class SocialGetUserPostsLengthLoadingState extends SocialAppStates {}

class SocialGetUserPostsLengthErorrState extends SocialAppStates {}

class SocialGetUserFollowersLengthSuccessState extends SocialAppStates {}

class SocialGetUserFollowersLengthLoadingState extends SocialAppStates {}

class SocialGetUserFollowersLengthErorrState extends SocialAppStates {}

class SocialAddToFavoritesSuccessState extends SocialAppStates {}

class SocialAddToFavoritesLoadingState extends SocialAppStates {}

class SocialAddToFavoritesErorrState extends SocialAppStates {}

class SocialGetFavoritesSuccessState extends SocialAppStates {}

class SocialGetFavoritesLoadingState extends SocialAppStates {}

class SocialGetFavoritesErorrState extends SocialAppStates {}

class SocialRemoveFromFavoritesSuccessState extends SocialAppStates {}

class SocialRemoveFromFavoritesLoadingState extends SocialAppStates {}

class SocialRemoveFromFavoritesErorrState extends SocialAppStates {}

class SocialUserSignOutSuccessState extends SocialAppStates {}

class SocialUserSignOutErorrState extends SocialAppStates {}

class SocialAddToWatchLaterSuccessState extends SocialAppStates {}

class SocialAddToWatchLaterLoadingState extends SocialAppStates {}

class SocialAddToWatchLaterErorrState extends SocialAppStates {}

class SocialGetWatchLaterSuccessState extends SocialAppStates {}

class SocialGetWatchLaterLoadingState extends SocialAppStates {}

class SocialGetWatchLaterErorrState extends SocialAppStates {}
