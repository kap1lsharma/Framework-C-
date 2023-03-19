@Release_15.0 @Group_Player_Archival @Configure_Enrollment @Web
Feature: OL_AR_Configure_Enrollment Verify that a new configuration 'Include Archived Accounts' is added to the Enrollment Configuration.

#***********************************************************************
#** Feature File                    : OL_AR_Configure_Enrollment
#** Feature Name                    : Verify that a new configuration 'Include Archived Accounts' is added to the Enrollment Configuration.
#** Test Case ID					: 466543,466548,466544
#** Defect/Bug Linked(if any)       : 591530
#**********************************************************************/
#**  Created Date:       Author:                 # Comments
#**  16/05/2022          Ajay Dahiya
#*****************************************************************/
Scenario: 001 - Verify 'Include Archived Accounts' is added under Configure Enrollment ( TC ID - 466543 )
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Configure Enrollment" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "1" seconds
	Given User clicks on "MAIN_NAV_BOX.CONFIGURE_ENROLLMENT_LINK"
	# enable duplicate chk from others tab
	Given User clicks on "PLAYER_ENROLL_CONFIG.tabPlayerEnrolConfig" with parameters
		| Key            | Value     |
		| playerEnrolTab | Duplicate |
	Then User verifies that element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateArchived_CheckBox" is present "true" on UI
	Then User "checks" element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateArchived_CheckBox"
	Given User clicks on "PLAYER_ENROLL_CONFIG.SAVE_BTN"
	Then User verifies that element "PLAYER_ENROLL_CONFIG.txtUpdateMsg" is present "true" on UI with parameters
		| Key  | Value                                  |
		| Text | Duplicate criteria saved successfully. |

Scenario Outline: 002 Making Test Data for Enrolling with Include Archived Account (TC ID- 466548 ) (Bug ID-591530)
	#User login to web-app
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User enroll a player in web-app
	When User generates a "UniqueString" with "AjayPlayer_:4" for key "FirstName"
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	When User waits "2" seconds
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID =  '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "Same_FIRST_NAME"
	#User search player archival status under player function
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	Given User enters text "Player Archival Status" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archivalstatus"
	When User waits "2" seconds
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	#User process Archival on the player
	Given User enters text "<#Halo_password#>" in "lylPage_Archival_Sts.txt_Password"
	Given User selects option "<archive_reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Archival>" in "lylPage_Archival_Sts.txt_comment"
	Given User clicks on "lylPage_Archival_Sts.btn_archive"
	When User waits "3" seconds
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI
	#User enroll a player in web-app
	When User "refresh" the browser
	When User waits "3" seconds
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID_2" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	#User verifies Duplicate popup is appearing
	Then User verifies that element "lylENROLL_PLAYER.mic_Duplicate_Account_Notfication" is present "true" on UI
	#To Verify existing player detail in the duplicate check pop up window
	Given User clicks without delay on "lylENROLL_PLAYER.dupcheck_existing_player" with parameters
		| Key               | Value         |
		| UniversalPlayerID | <$PLAYER_ID$> |
	Then User verifies that element "lylENROLL_PLAYER.dupcheck_patron_act" is present "true" on UI with parameters
		| Key      | Value         |
		| infoitem | <$PLAYER_ID$> |
	Given User clicks on "lylENROLL_PLAYER.dupcheck_viewpatron_okbtn"
	#To Click on the ignore button to close duplicate check pop-up window
	Given User clicks on "lylENROLL_PLAYER.btn_dupcheckignore"

	Examples:
		| archive_reason           | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |

Scenario: 003 - Verify 'Include Archived Accounts' is unchecked to reset under Configure Enrollment ( TC ID - 466544 )
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Configure Enrollment" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "1" seconds
	Given User clicks on "MAIN_NAV_BOX.CONFIGURE_ENROLLMENT_LINK"
	# enable duplicate chk from others tab
	Given User clicks on "PLAYER_ENROLL_CONFIG.tabPlayerEnrolConfig" with parameters
		| Key            | Value     |
		| playerEnrolTab | Duplicate |
	Then User verifies that element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateArchived_CheckBox" is present "true" on UI
	Then User "Unchecks" element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateArchived_CheckBox"
	Given User clicks on "PLAYER_ENROLL_CONFIG.SAVE_BTN"
	Then User verifies that element "PLAYER_ENROLL_CONFIG.txtUpdateMsg" is present "true" on UI with parameters
		| Key  | Value                                  |
		| Text | Duplicate criteria saved successfully. |

Scenario Outline: 004 Making Test Data for Enrolling without Include Archived Account (TC ID- 466548 )
	#User login to web-app
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User enroll a player in web-app
	When User generates a "UniqueString" with "AjayPlayer_:4" for key "FirstName"
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	When User waits "2" seconds
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID =  '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "Same_FIRST_NAME"
	#User search player archival status under player function
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	Given User enters text "Player Archival Status" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archivalstatus"
	When User waits "2" seconds
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	#User process Archival on the player
	Given User enters text "<#Halo_password#>" in "lylPage_Archival_Sts.txt_Password"
	Given User selects option "<archive_reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Archival>" in "lylPage_Archival_Sts.txt_comment"
	Given User clicks on "lylPage_Archival_Sts.btn_archive"
	When User waits "2" seconds
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI
	#User enroll a player in web-app
	When User "refresh" the browser
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID_2" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	#User verifies Duplicate popup is not appearing
	Then User verifies that element "lylENROLL_PLAYER.mic_Duplicate_Account_Notfication" is present "false" on UI

	Examples:
		| archive_reason           | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |