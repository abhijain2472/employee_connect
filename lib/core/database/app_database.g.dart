// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $EmployeeItemTable extends EmployeeItem
    with TableInfo<$EmployeeItemTable, EmployeeItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeeItemTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleIdMeta = const VerificationMeta('roleId');
  @override
  late final GeneratedColumn<String> roleId = GeneratedColumn<String>(
      'role_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'end_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [employeeId, name, roleId, startDate, endDate];
  @override
  String get aliasedName => _alias ?? 'employee_item';
  @override
  String get actualTableName => 'employee_item';
  @override
  VerificationContext validateIntegrity(Insertable<EmployeeItemData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('role_id')) {
      context.handle(_roleIdMeta,
          roleId.isAcceptableOrUnknown(data['role_id']!, _roleIdMeta));
    } else if (isInserting) {
      context.missing(_roleIdMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId};
  @override
  EmployeeItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmployeeItemData(
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      roleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role_id'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date'])!,
    );
  }

  @override
  $EmployeeItemTable createAlias(String alias) {
    return $EmployeeItemTable(attachedDatabase, alias);
  }
}

class EmployeeItemData extends DataClass
    implements Insertable<EmployeeItemData> {
  final String employeeId;
  final String name;
  final String roleId;
  final String startDate;
  final String endDate;
  const EmployeeItemData(
      {required this.employeeId,
      required this.name,
      required this.roleId,
      required this.startDate,
      required this.endDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['employee_id'] = Variable<String>(employeeId);
    map['name'] = Variable<String>(name);
    map['role_id'] = Variable<String>(roleId);
    map['start_date'] = Variable<String>(startDate);
    map['end_date'] = Variable<String>(endDate);
    return map;
  }

  EmployeeItemCompanion toCompanion(bool nullToAbsent) {
    return EmployeeItemCompanion(
      employeeId: Value(employeeId),
      name: Value(name),
      roleId: Value(roleId),
      startDate: Value(startDate),
      endDate: Value(endDate),
    );
  }

  factory EmployeeItemData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmployeeItemData(
      employeeId: serializer.fromJson<String>(json['employeeId']),
      name: serializer.fromJson<String>(json['name']),
      roleId: serializer.fromJson<String>(json['roleId']),
      startDate: serializer.fromJson<String>(json['startDate']),
      endDate: serializer.fromJson<String>(json['endDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeId': serializer.toJson<String>(employeeId),
      'name': serializer.toJson<String>(name),
      'roleId': serializer.toJson<String>(roleId),
      'startDate': serializer.toJson<String>(startDate),
      'endDate': serializer.toJson<String>(endDate),
    };
  }

  EmployeeItemData copyWith(
          {String? employeeId,
          String? name,
          String? roleId,
          String? startDate,
          String? endDate}) =>
      EmployeeItemData(
        employeeId: employeeId ?? this.employeeId,
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );
  @override
  String toString() {
    return (StringBuffer('EmployeeItemData(')
          ..write('employeeId: $employeeId, ')
          ..write('name: $name, ')
          ..write('roleId: $roleId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(employeeId, name, roleId, startDate, endDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmployeeItemData &&
          other.employeeId == this.employeeId &&
          other.name == this.name &&
          other.roleId == this.roleId &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate);
}

class EmployeeItemCompanion extends UpdateCompanion<EmployeeItemData> {
  final Value<String> employeeId;
  final Value<String> name;
  final Value<String> roleId;
  final Value<String> startDate;
  final Value<String> endDate;
  final Value<int> rowid;
  const EmployeeItemCompanion({
    this.employeeId = const Value.absent(),
    this.name = const Value.absent(),
    this.roleId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmployeeItemCompanion.insert({
    required String employeeId,
    required String name,
    required String roleId,
    required String startDate,
    required String endDate,
    this.rowid = const Value.absent(),
  })  : employeeId = Value(employeeId),
        name = Value(name),
        roleId = Value(roleId),
        startDate = Value(startDate),
        endDate = Value(endDate);
  static Insertable<EmployeeItemData> custom({
    Expression<String>? employeeId,
    Expression<String>? name,
    Expression<String>? roleId,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (employeeId != null) 'employee_id': employeeId,
      if (name != null) 'name': name,
      if (roleId != null) 'role_id': roleId,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmployeeItemCompanion copyWith(
      {Value<String>? employeeId,
      Value<String>? name,
      Value<String>? roleId,
      Value<String>? startDate,
      Value<String>? endDate,
      Value<int>? rowid}) {
    return EmployeeItemCompanion(
      employeeId: employeeId ?? this.employeeId,
      name: name ?? this.name,
      roleId: roleId ?? this.roleId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (roleId.present) {
      map['role_id'] = Variable<String>(roleId.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeeItemCompanion(')
          ..write('employeeId: $employeeId, ')
          ..write('name: $name, ')
          ..write('roleId: $roleId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDataBase extends GeneratedDatabase {
  _$AppDataBase(QueryExecutor e) : super(e);
  late final $EmployeeItemTable employeeItem = $EmployeeItemTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [employeeItem];
}
