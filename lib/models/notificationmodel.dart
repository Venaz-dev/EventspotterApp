class NotificationModel {
  NotificationModel({
    required this.success,
    required this.data,
    required this.Message,
  });
  late final bool success;
  late final List<Data> data;
  late final String Message;
  
  NotificationModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    Message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['Message'] = Message;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.message,
    required this.userId,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    required this.sentBy,
    required this.notificationType,
    required this.routeName,
  });
  late final int id;
  late final String title;
  late final String message;
  late final String userId;
  late final String isRead;
  late final String createdAt;
  late final String updatedAt;
  late final String sentBy;
  late final String notificationType;
  late final String routeName;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    message = json['message'];
    userId = json['user_id'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sentBy = json['sent_by'];
    notificationType = json['notification_type'];
    routeName = json['route_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['message'] = message;
    _data['user_id'] = userId;
    _data['is_read'] = isRead;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['sent_by'] = sentBy;
    _data['notification_type'] = notificationType;
    _data['route_name'] = routeName;
    return _data;
  }
}