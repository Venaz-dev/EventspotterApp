class LoginModel {
  LoginModel({
    required this.user,
    required this.token,
    required this.message,
  });
  late final User user;
  late final String token;
  late final String message;

  LoginModel.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    _data['token'] = token;
    _data['message'] = message;
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.ipAddress,
    required this.latLng,
    required this.isOnline,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.mobileIsPrivate,
    required this.avatar,
    required this.messengerColor,
    required this.darkMode,
    required this.activeStatus,
    required this.role,
    // required this.isBlock,
    required this.useLocation,
    required this.allowDirectMessage,
    required this.profilePrivate,
    required this.profilePicture,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String ipAddress;
  late final String latLng;
  late final String isOnline;
  late final String phoneNumber;
  late final String createdAt;
  late final String updatedAt;
  late final String mobileIsPrivate;
  late final String avatar;
  late final String messengerColor;
  late final String darkMode;
  late final String activeStatus;
  late final String role;
  // late final String isBlock;
  late final String useLocation;
  late final String allowDirectMessage;
  late final String profilePrivate;
  late final ProfilePicture? profilePicture;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    ipAddress = json['ip_address'];
    latLng = json['lat_lng'] ?? '';
    isOnline = json['is_online'];
    phoneNumber = json['phone_number'] ?? '';
    mobileIsPrivate = json['mobile_is_private'] ?? '0';
    // isBlock =json['isBlock'];
    useLocation = json['use_location'] ?? '1';
    allowDirectMessage = json['allow_direct_message'] ?? '1';
    profilePrivate = json['profile_private'] ?? '1';
    if (json['profile_picture'] != null) {
      profilePicture = (ProfilePicture.fromJson(json['profile_picture']));
    } else {
      profilePicture = ProfilePicture(
          id: 0,
          image: "images/user.jpeg",
          userId: "0",
          createdAt: "112",
          updatedAt: "12332");
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['ip_address'] = ipAddress;
    _data['lat_lng'] = latLng;
    _data['is_online'] = isOnline;
    _data['phone_number'] = phoneNumber;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['mobile_is_private'] = mobileIsPrivate;
    _data['avatar'] = avatar;
    _data['messenger_color'] = messengerColor;
    _data['dark_mode'] = darkMode;
    _data['active_status'] = activeStatus;
    _data['role'] = role;
    // _data['is_block'] = isBlock;
    _data['use_location'] = useLocation;
    _data['allow_direct_message'] = allowDirectMessage;
    _data['profile_private'] = profilePrivate;
     _data['profile_picture'] = profilePicture;
    return _data;
  }
}

class ProfilePicture {
  ProfilePicture({
    required this.id,
    required this.image,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String image;
  late final String userId;
  late final String createdAt;
  late final String updatedAt;

  ProfilePicture.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    image = json['image'] ?? '';
    userId = json['user_id'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
  }
}
