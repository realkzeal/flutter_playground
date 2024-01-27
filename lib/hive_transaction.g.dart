// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveTransactionAdapter extends TypeAdapter<HiveTransaction> {
  @override
  final int typeId = 1;

  @override
  HiveTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTransaction(
      id: fields[0] as String,
      name: fields[1] as String,
      type: fields[2] as String,
      amount: fields[5] as double,
      status: fields[4] as String,
      reference: fields[3] as String,
      date: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveTransaction obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.reference)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.amount)
      ..writeByte(6)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
