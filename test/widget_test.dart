import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  test('Project serializes to the Django REST Framework schema', () {
    const project = Project(
      title: 'My Portfolio',
      description: 'A personal portfolio app.',
      techStack: 'Flutter, Django',
      projectUrl: 'https://example.com',
      projectImageUrl: 'https://example.com/image.png',
    );

    final json = project.toJson();

    expect(json['title'], 'My Portfolio');
    expect(json['description'], 'A personal portfolio app.');
    expect(json['tech_stack'], 'Flutter, Django');
    expect(json['project_url'], 'https://example.com');
    expect(json['project_image_url'], 'https://example.com/image.png');
    expect(json.containsKey('id'), isFalse);
  });

  test('Project deserializes a response without project_image_url', () {
    final project = Project.fromJson(const {
      'id': '2b1f0e5c-0000-4000-8000-000000000000',
      'title': 'My Portfolio',
      'description': 'A personal portfolio app.',
      'tech_stack': 'Flutter, Django',
      'project_url': 'https://example.com',
    });

    expect(project.id, '2b1f0e5c-0000-4000-8000-000000000000');
    expect(project.projectImageUrl, '');
  });

  testWidgets('home screen renders the portfolio actions', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final apiClient = ApiClient(
      client: MockClient((request) async => http.Response('[]', 200)),
    );
    await tester.pumpWidget(MyApp(apiClient: apiClient));

    expect(find.text('Welcome to MyPortfolio Mobile!'), findsOneWidget);
    expect(find.text('View Projects'), findsWidgets);
    expect(find.text('Add Project'), findsWidgets);
  });
}
