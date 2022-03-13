class GetUserUpcomingEvents {
  GetUserUpcomingEvents({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final List<Data> data;
  late final String message;

  GetUserUpcomingEvents.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    print("success upcoming");
    print(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['message'] = message;

    return _data;
  }
}

class Data {
  Data({
    required this.events,
    required this.km,
  });
  late final Events events;
  late final String km;

  Data.fromJson(Map<String, dynamic> json) {
    events = Events.fromJson(json['events']);
    km = json['km'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['events'] = events.toJson();
    _data['km'] = km;
    return _data;
  }
}

class Events {
  Events({
    required this.id,
    required this.eventName,
    required this.eventDescription,
    required this.eventType,
    required this.eventDate,
    required this.location,
    required this.lat,
    required this.lng,
    required this.conditions,
    required this.userId,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
    required this.isDrafted,
    required this.ticketLink,
    required this.eventPictures,
  });
  late final int id;
  late final String eventName;
  late final String eventDescription;
  late final String eventType;
  late final String eventDate;
  late final String location;
  late final String lat;
  late final String lng;
  late final List<String> conditions;
  late final String userId;
  late final String isPublic;
  late final String createdAt;
  late final String updatedAt;
  late final String isDrafted;
  late final String ticketLink;
  late final List<EventPictures> eventPictures;

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    eventDescription = json['event_description'];
    eventType = json['event_type'];
    eventDate = json['event_date'];
    location = json['location'];
    lat = json['lat'];
    lng = json['lng'];
    conditions = List.castFrom<dynamic, String>(json['conditions']);
    userId = json['user_id'];
    isPublic = json['is_public'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDrafted = json['is_drafted'];
    ticketLink = json['ticket_link'] ?? "";
    eventPictures = List.from(json['event_pictures'])
        .map((e) => EventPictures.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['event_name'] = eventName;
    _data['event_description'] = eventDescription;
    _data['event_type'] = eventType;
    _data['event_date'] = eventDate;
    _data['location'] = location;
    _data['lat'] = lat;
    _data['lng'] = lng;
    _data['conditions'] = conditions;
    _data['user_id'] = userId;
    _data['is_public'] = isPublic;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['is_drafted'] = isDrafted;
    _data['ticket_link'] = ticketLink;
    _data['event_pictures'] = eventPictures.map((e) => e.toJson()).toList();
    return _data;
  }
}

class EventPictures {
  EventPictures({
    required this.id,
    required this.eventId,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String eventId;
  late final String imagePath;
  late final String createdAt;
  late final String updatedAt;

  EventPictures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    imagePath = json['image_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['event_id'] = eventId;
    _data['image_path'] = imagePath;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
