@crud @delete_created_data
Feature: Surveys stats

  Background:
    Given I register a new "editor" and I save the request as "editor_request"
    When I store the response body as "editor_response"
    And I validate email using "editor_response._id"
    And I login to "WEB_APP" using "editor_response.primaryEmail" and "editor_request.password"
    And I store the response body as "login_response"
    And I create a survey using the Authorization "login_response.token"
    And I store the request body as "survey_request"
    And I store the response body as "survey_response"
    And I change the "survey_response._id" state to "1" with "login_response.token"

  Scenario: Verify that "/surveys/{surveyId}/stats" end point can perform "GET" request.
    Given I perform "GET" request to "/surveys/{survey_response._id}/stats"
    And I set the header "Authorization" with "Bearer {login_response.token}"
    When I send the request
    Then I expect a "200" status code
    And I store the response body as "surveys_stats_response"
    And I verify the "surveys_stats_response" schema with "get_surveys_stats" template
#    And I build the expected response with following data
#      | request_name  | survey_request                |
#      | response_name | surveys_info_response         |
#      | template_name | get_surveys_without_questions |
#    Then I verify "surveys_overview_response" with built expected response
