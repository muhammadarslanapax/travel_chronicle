// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventLocalDBModelAdapter extends TypeAdapter<EventLocalDBModel> {
  @override
  final int typeId = 0;

  @override
  EventLocalDBModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventLocalDBModel(
      timestamp: fields[0] as int,
      name: fields[1] as String,
      images: (fields[2] as List?)?.cast<String>(),
      placeName: fields[3] as String?,
      userId: fields[4] as String?,
      userName: fields[5] as String?,
      userImage: fields[6] as String?,
      userLocation: fields[7] as String?,
      tripName: fields[8] as String?,
      location: fields[9] as String?,
      dateStart: fields[10] as int,
      dateEnd: fields[11] as int?,
      hotelName: fields[12] as String?,
      companionsNames: (fields[13] as List?)?.cast<String>(),
      aboutTrip: fields[14] as String?,
      stamp: fields[15] as String?,
      imageTitle: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EventLocalDBModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.images)
      ..writeByte(3)
      ..write(obj.placeName)
      ..writeByte(4)
      ..write(obj.userId)
      ..writeByte(5)
      ..write(obj.userName)
      ..writeByte(6)
      ..write(obj.userImage)
      ..writeByte(7)
      ..write(obj.userLocation)
      ..writeByte(8)
      ..write(obj.tripName)
      ..writeByte(9)
      ..write(obj.location)
      ..writeByte(10)
      ..write(obj.dateStart)
      ..writeByte(11)
      ..write(obj.dateEnd)
      ..writeByte(12)
      ..write(obj.hotelName)
      ..writeByte(13)
      ..write(obj.companionsNames)
      ..writeByte(14)
      ..write(obj.aboutTrip)
      ..writeByte(15)
      ..write(obj.stamp)
      ..writeByte(16)
      ..write(obj.imageTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventLocalDBModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
