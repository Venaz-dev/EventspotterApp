class ChatModel {
  ChatModel({
    required this.data,
  });
  late final Data data;

  ChatModel.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.fromUser,
    required this.toUser,
    required this.content,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.dateTimeStr,
    required this.dateHumanReadable,
    required this.fromUserName,
    required this.fromUserId,
    required this.toUserName,
    required this.toUserId,
  });
  late final FromUser fromUser;
  late final ToUser toUser;
   String ?content;
  late final String updatedAt;
  late final String createdAt;
  late final int id;
  late final String dateTimeStr;
  late final String dateHumanReadable;
  late final String fromUserName;
  late final int fromUserId;
  late final String toUserName;
  late final String toUserId;

  Data.fromJson(Map<String, dynamic> json) {
    fromUser = FromUser.fromJson(json['from_user']);
    toUser = ToUser.fromJson(json['to_user']);
    content = json['content']??"No";
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    dateTimeStr = json['dateTimeStr'];
    dateHumanReadable = json['dateHumanReadable'];
    fromUserName = json['fromUserName'];
    fromUserId = json['from_user_id'];
    toUserName = json['toUserName'];
    toUserId = json['to_user_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['from_user'] = fromUser.toJson();
    _data['to_user'] = toUser.toJson();
    _data['content'] = content;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    _data['id'] = id;
    _data['dateTimeStr'] = dateTimeStr;
    _data['dateHumanReadable'] = dateHumanReadable;
    _data['fromUserName'] = fromUserName;
    _data['from_user_id'] = fromUserId;
    _data['toUserName'] = toUserName;
    _data['to_user_id'] = toUserId;
    return _data;
  }
}

class FromUser {
  FromUser({
    required this.id,
    required this.name,
    required this.email,
    required this.ipAddress,
    required this.latLng,
    required this.isOnline,
    this.emailVerifiedAt,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    required this.messengerColor,
    required this.darkMode,
    required this.activeStatus,
    this.profileImage,
    required this.mobileIsPrivate,
    required this.role,
    this.isBlock,
    required this.useLocation,
    required this.allowDirectMessage,
    required this.profilePrivate,
    required this.lastSeen,
    this.profilePicture,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String ipAddress;
  late final String latLng;
  late final String isOnline;
  late final Null emailVerifiedAt;
  late final String phoneNumber;
  late final String createdAt;
  late final String updatedAt;
  late final String avatar;
  late final String messengerColor;
  late final String darkMode;
  late final String activeStatus;
  late final Null profileImage;
  late final String mobileIsPrivate;
  late final String role;
  late final Null isBlock;
  late final String useLocation;
  late final String allowDirectMessage;
  late final String profilePrivate;
  late final String lastSeen;
  late final Null profilePicture;

  FromUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    ipAddress = json['ip_address'];
    latLng = json['lat_lng'];
    isOnline = json['is_online'];
    emailVerifiedAt = null;
    phoneNumber = json['phone_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    avatar = json['avatar'];
    messengerColor = json['messenger_color'];
    darkMode = json['dark_mode'];
    activeStatus = json['active_status'];
    profileImage = null;
    mobileIsPrivate = json['mobile_is_private'];
    role = json['role'];
    isBlock = null;
    useLocation = json['use_location'];
    allowDirectMessage = json['allow_direct_message'];
    profilePrivate = json['profile_private'];
    lastSeen = json['last_seen'];
    profilePicture = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['ip_address'] = ipAddress;
    _data['lat_lng'] = latLng;
    _data['is_online'] = isOnline;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['phone_number'] = phoneNumber;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['avatar'] = avatar;
    _data['messenger_color'] = messengerColor;
    _data['dark_mode'] = darkMode;
    _data['active_status'] = activeStatus;
    _data['profile_image'] = profileImage;
    _data['mobile_is_private'] = mobileIsPrivate;
    _data['role'] = role;
    _data['is_block'] = isBlock;
    _data['use_location'] = useLocation;
    _data['allow_direct_message'] = allowDirectMessage;
    _data['profile_private'] = profilePrivate;
    _data['last_seen'] = lastSeen;
    _data['profile_picture'] = profilePicture;
    return _data;
  }
}

class ToUser {
  ToUser({
    required this.id,
    required this.name,
    required this.email,
    required this.ipAddress,
    required this.latLng,
    required this.isOnline,
    this.emailVerifiedAt,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    required this.messengerColor,
    required this.darkMode,
    required this.activeStatus,
    this.profileImage,
    required this.mobileIsPrivate,
    required this.role,
    this.isBlock,
    required this.useLocation,
    required this.allowDirectMessage,
    required this.profilePrivate,
    required this.lastSeen,
    this.profilePicture,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String ipAddress;
  late final String latLng;
  late final String isOnline;
  late final Null emailVerifiedAt;
  late final String phoneNumber;
  late final String createdAt;
  late final String updatedAt;
  late final String avatar;
  late final String messengerColor;
  late final String darkMode;
  late final String activeStatus;
  late final Null profileImage;
  late final String mobileIsPrivate;
  late final String role;
  late final Null isBlock;
  late final String useLocation;
  late final String allowDirectMessage;
  late final String profilePrivate;
  late final String lastSeen;
  late final Null profilePicture;

  ToUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    ipAddress = json['ip_address'];
    latLng = json['lat_lng'];
    isOnline = json['is_online'];
    emailVerifiedAt = null;
    phoneNumber = json['phone_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    avatar = json['avatar'];
    messengerColor = json['messenger_color'];
    darkMode = json['dark_mode'];
    activeStatus = json['active_status'];
    profileImage = null;
    mobileIsPrivate = json['mobile_is_private'];
    role = json['role'];
    isBlock = null;
    useLocation = json['use_location'];
    allowDirectMessage = json['allow_direct_message'];
    profilePrivate = json['profile_private'];
    lastSeen = json['last_seen'];
    profilePicture = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['ip_address'] = ipAddress;
    _data['lat_lng'] = latLng;
    _data['is_online'] = isOnline;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['phone_number'] = phoneNumber;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['avatar'] = avatar;
    _data['messenger_color'] = messengerColor;
    _data['dark_mode'] = darkMode;
    _data['active_status'] = activeStatus;
    _data['profile_image'] = profileImage;
    _data['mobile_is_private'] = mobileIsPrivate;
    _data['role'] = role;
    _data['is_block'] = isBlock;
    _data['use_location'] = useLocation;
    _data['allow_direct_message'] = allowDirectMessage;
    _data['profile_private'] = profilePrivate;
    _data['last_seen'] = lastSeen;
    _data['profile_picture'] = profilePicture;
    return _data;
  }
}
