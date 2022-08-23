// To parse this JSON data, do
//
//     final questions = questionsFromMap(jsonString);

import 'dart:convert';

Questions questionsFromMap(String str) => Questions.fromMap(json.decode(str));

String questionsToMap(Questions data) => json.encode(data.toMap());

class Questions {
  Questions({
    this.status,
    this.response,
    this.code,
  });

  dynamic status;
  List<QResponse>? response;
  dynamic code;

  factory Questions.fromMap(Map<String, dynamic> json) => Questions(
        //status: json["status"] == null ? null : json["status"],
        status: json["status"] == null ? null : json["status"],
        response: json["response"] == null
            ? []
            : List<QResponse>.from(
                json["response"].map((x) => QResponse.fromMap(x))),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null
            ? null
            : List<dynamic>.from(response!.map((x) => x.toMap())),
        "code": code == null ? null : code,
      };
}

class QResponse {
  QResponse({
    this.id,
    this.couplingType,
    this.type,
    this.question,
    this.questionOrder,
    this.parent,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.answers,
    this.subQuestion,
    this.userAnswer,
  });

  dynamic id;
  dynamic couplingType;
  dynamic type;
  dynamic question;
  dynamic questionOrder;
  dynamic parent;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  List<Answer>? answers;
  QResponse? subQuestion;
  UserAnswer? userAnswer;

  factory QResponse.fromMap(Map<String, dynamic> json) => QResponse(
        id: json["id"] == null ? null : json["id"],
        couplingType:
            json["coupling_type"] == null ? null : json["coupling_type"],
        type: json["type"] == null ? null : json["type"],
        question: json["question"] == null ? null : json["question"],
        questionOrder:
            json["question_order"] == null ? null : json["question_order"],
        parent: json["parent"] == null ? null : json["parent"],
        status: json["status"] == null ? null : json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        answers: json["answers"] == null
            ? []
            : List<Answer>.from(json["answers"].map((x) => Answer.fromMap(x))),
        subQuestion: json["sub_question"] == null
            ? null
            : QResponse.fromMap(json["sub_question"]),
        userAnswer: json["user_answer"] == null
            ? UserAnswer.fromMap({})
            : UserAnswer.fromMap(json["user_answer"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "coupling_type": couplingType == null ? null : couplingType,
        "type": type == null ? null : type,
        "question": question == null ? null : question,
        "question_order": questionOrder == null ? null : questionOrder,
        "parent": parent == null ? null : parent,
        "status": status == null ? null : status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "answers": answers == null
            ? null
            : List<dynamic>.from(answers!.map((x) => x.toMap())),
        "sub_question": subQuestion == null ? null : subQuestion!.toMap(),
        "user_answer": userAnswer == null ? null : userAnswer!.toMap(),
      };

  @override
  String toString() {
    return 'QResponse{id: $id, couplingType: $couplingType, type: $type, question: $question, questionOrder: $questionOrder, parent: $parent, status: $status, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt, answers: $answers, subQuestion: $subQuestion, userAnswer: $userAnswer}';
  }
}

class Answer {
  Answer({
    this.id,
    this.questionId,
    this.answerOption,
    this.order,
    this.answerValue,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic questionId;
  dynamic answerOption;
  dynamic order;
  dynamic answerValue;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  factory Answer.fromMap(Map<String, dynamic> json) => Answer(
        id: json["id"] == null ? null : json["id"],
        questionId: json["question_id"] == null ? null : json["question_id"],
        answerOption:
            json["answer_option"] == null ? null : json["answer_option"],
        order: json["order"] == null ? null : json["order"],
        answerValue: json["answer_value"] == null ? null : json["answer_value"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "question_id": questionId == null ? null : questionId,
        "answer_option": answerOption == null ? null : answerOption,
        "order": order == null ? null : order,
        "answer_value": answerValue == null ? null : answerValue,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class UserAnswer {
  UserAnswer({
    this.id,
    this.userId,
    this.questionId,
    this.answer,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic userId;
  dynamic questionId;
  dynamic answer;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  factory UserAnswer.fromMap(Map<String, dynamic> json) => UserAnswer(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        questionId: json["question_id"] == null ? null : json["question_id"],
        answer: json["answer"] == null ? null : json["answer"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "question_id": questionId == null ? null : questionId,
        "answer": answer == null ? null : answer,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };

  @override
  String toString() {
    return 'UserAnswer{id: $id, userId: $userId, questionId: $questionId, answer: $answer, status: $status, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
