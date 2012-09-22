Feature: User edits preferences
  In order to customize the experience
  A user
  Should be able to go to their profile and change their preferences

Background: Default site and messageboard
    Given the default "public" website domain is "example.com"
      And the default website has a messageboard named "thredded"
      And I am signed in as "Joel"
      And I am a member of "thredded"
      And "thredded" is "public"

  Scenario: User changes at notification settings
    When I go to my profile page
    And I enable the '@ notification' preference
    And I submit the preference form
    Then I should be notified when someone mentions "@joel"

    # user preferences
    # ****************
    #
    # * mail me when:
    # - someone @ mentions me
    # - someone sends me a private message
    # - there is a new thread on ________
    # - anyone posts to _______
    # 
    # * send me a digest of the following forums _________
    # - digest should be thread title and up to last 
