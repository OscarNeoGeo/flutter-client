import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'payment_model.g.dart';

abstract class PaymentListResponse implements Built<PaymentListResponse, PaymentListResponseBuilder> {

  factory PaymentListResponse([void updates(PaymentListResponseBuilder b)]) = _$PaymentListResponse;
  PaymentListResponse._();

  BuiltList<PaymentEntity> get data;

  static Serializer<PaymentListResponse> get serializer => _$paymentListResponseSerializer;
}

abstract class PaymentItemResponse implements Built<PaymentItemResponse, PaymentItemResponseBuilder> {

  factory PaymentItemResponse([void updates(PaymentItemResponseBuilder b)]) = _$PaymentItemResponse;
  PaymentItemResponse._();

  PaymentEntity get data;

  static Serializer<PaymentItemResponse> get serializer => _$paymentItemResponseSerializer;
}


class PaymentFields {
  static const String amount = 'amount';
  static const String transactionReference = 'transactionReference';
  static const String paymentDate = 'paymentDate';
  static const String paymentTypeId = 'paymentTypeId';
  static const String invoiceId = 'invoiceId';
  static const String invoiceNumber = 'invoiceNumber';
  static const String privateNotes = 'privateNotes';
  static const String exchangeRate = 'exchangeRate';
  static const String exchangeCurrencyId = 'exchangeCurrencyId';
  static const String paymentStatusId = 'paymentStatusId';

  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}

abstract class PaymentEntity extends Object with BaseEntity implements Built<PaymentEntity, PaymentEntityBuilder> {

  static int counter = 0;
  factory PaymentEntity() {
    return _$PaymentEntity._(
      id: --PaymentEntity.counter,
      amount: 0.0,
      transactionReference: '',
      paymentDate: convertDateTimeToSqlDate(),
      paymentTypeId: 0,
      invoiceId: 0,
      clientId: 0,
      invoiceNumber: '',
      privateNotes: '',
      exchangeRate: 0.0,
      exchangeCurrencyId: 0,
      refunded: 0.0,
      paymentStatusId: 0,
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }
  PaymentEntity._();

  @override
  EntityType get entityType {
    return EntityType.payment;
  }

  double get amount;

  double get refunded;

  @BuiltValueField(wireName: 'payment_status_id')
  int get paymentStatusId;

  @BuiltValueField(wireName: 'transaction_reference')
  String get transactionReference;

  @BuiltValueField(wireName: 'payment_date')
  String get paymentDate;

  @BuiltValueField(wireName: 'payment_type_id')
  int get paymentTypeId;

  @BuiltValueField(wireName: 'invoice_id')
  int get invoiceId;

  @nullable
  @BuiltValueField(wireName: 'client_id')
  int get clientId;

  @BuiltValueField(wireName: 'invoice_number')
  String get invoiceNumber;

  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @BuiltValueField(wireName: 'exchange_rate')
  double get exchangeRate;

  @BuiltValueField(wireName: 'exchange_currency_id')
  int get exchangeCurrencyId;
  
  int compareTo(PaymentEntity credit, String sortField, bool sortAscending) {
    int response = 0;
    final PaymentEntity paymentA = sortAscending ? this : credit;
    final PaymentEntity paymentB = sortAscending ? credit: this;

    switch (sortField) {
      case PaymentFields.amount:
        response = paymentA.amount.compareTo(paymentB.amount);
        break;
      case PaymentFields.transactionReference:
        response = paymentA.transactionReference.compareTo(paymentB.transactionReference);
        break;
      case PaymentFields.paymentDate:
        response = paymentA.paymentDate.compareTo(paymentB.paymentDate);
        break;
      case PaymentFields.updatedAt:
        response = paymentA.updatedAt.compareTo(paymentB.updatedAt);
        break;
    }
    
    return response;
  }

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    if (transactionReference.toLowerCase().contains(filter)) {
      return true;
    } else if (privateNotes.toLowerCase().contains(filter)) {
      return true;
    }

    return false;
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    if (transactionReference.toLowerCase().contains(filter)) {
      return transactionReference;
    } else if (privateNotes.toLowerCase().contains(filter)) {
      return privateNotes;
    }

    return null;
  }

  @override
  String get listDisplayName {
    return invoiceNumber;
  }

  @override
  double get listDisplayAmount => amount;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  static Serializer<PaymentEntity> get serializer => _$paymentEntitySerializer;
}
