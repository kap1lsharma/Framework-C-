@Release_15.0 @Group_Player_Archival @Functional_Authorization @Web
Feature: OL_AR_MANUAL_PLAYER_ARCHIVAL Verify Newly added Functions Manual Player Archive

#******************************************************************************************************
#** Feature File                    : OL_AR_MANUAL_PLAYER_ARCHIVAL
#** Feature Name                    : Verify Newly added Functions Manual Player Archive
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 462782,462780,460950,461275,460947
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  18/04/2022           Ajay Dahiya
#**  12/05/2022           Ajay Dahiya              Made somechanges as per standard defined in tags and file name
#**************************************************************************************************/
Scenario Outline: 001 Function Authorization for Manual Archived Accounts
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Function Authorization" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_functional_authorization"
	Given User clicks on "lylFuncton_Authorze.txt_Function_search_box"
	# Verify that Manual Player Archive is listed in the Manage Function list of Function Authorizations
	Then User verifies text - "Manual Player Archive" is present on page
	Given User clicks on "MANAGE_FUNCTION.SELECT_FUNCTION_NAME" with parameters
		| Key           | Value                 |
		| function_name | Manual Player Archive |
	#Verify Password as required and Visible check boxes checked
	Given User clicks on "lylFuncton_Authorze.chk_Password_Required"
	When User waits "2" seconds
	Given User clicks on "lylFuncton_Authorze.chk_Password_Visible"
	When User waits "2" seconds
	Given User clicks on "MANAGE_FUNCTION.FUNCTION_SAVE_BUTTON"
	Then User verifies text - "Function detail saved successfully." is present on page
	Given User clicks on "lylFuncton_Authorze.txt_Function_search_box"
	Given User clicks on "MANAGE_FUNCTION.SELECT_FUNCTION_NAME" with parameters
		| Key           | Value                 |
		| function_name | Manual Player Archive |
	Then User verifies attribute "selected" value "false" of element "lylFuncton_Authorze.chk_Password_Required"
	Then User verifies attribute "selected" value "false" of element "lylFuncton_Authorze.chk_Password_Visible"
	Given User clicks on "lylFuncton_Authorze.chk_Password_Required"
	Given User clicks on "MANAGE_FUNCTION.FUNCTION_SAVE_BUTTON"
	Given User clicks on "lylFuncton_Authorze.txt_Function_search_box"
	Given User clicks on "MANAGE_FUNCTION.SELECT_FUNCTION_NAME" with parameters
		| Key           | Value                 |
		| function_name | Manual Player Archive |
	Then User verifies attribute "selected" value "True" of element "lylFuncton_Authorze.chk_Password_Required"
	Then User verifies attribute "selected" value "True" of element "lylFuncton_Authorze.chk_Password_Visible"
	When User waits "2" seconds
	#User enroll a player in web-app
	When User generates a "UniqueString" with "AjayPlayer_:4" for key "FirstName"
	When User waits "2" seconds
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	When User waits "2" seconds
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	#User search player archival status under player function
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User enters text "Player Archival Status" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylPlayer_Function.lnk_player_archivalstatus"
	When User waits "4" seconds
	#User initiates Player Archival Process
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	Given User selects option "<reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Archival>" in "lylPage_Archival_Sts.txt_comment"
	Given User clicks on "lylPage_Archival_Sts.btn_archive"
	When User waits "2" seconds
	#User verifies Password-Required text error is appearing
	Then User verifies text - "Enter Your Password" is present on page
	#Verify Successfull text of Player archival is not appearing.
	Then User verifies that element "lylPage_Archival_Sts.lb_Action_Message" is present "false" on UI

	Examples:
		| reason                   | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |

Scenario Outline: 002 Password Not Required Test in Function Authorization for Manual Archived Accounts
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Function Authorization" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_functional_authorization"
	Given User clicks on "lylFuncton_Authorze.txt_Function_search_box"
	# Verify that Manual Player Archive is listed in the Manage Function list of Function Authorizations
	Then User verifies text - "Manual Player Archive" is present on page
	Given User clicks on "MANAGE_FUNCTION.SELECT_FUNCTION_NAME" with parameters
		| Key           | Value                 |
		| function_name | Manual Player Archive |
	#Verify Password as not required and Visible check boxes checked
	When User waits "2" seconds
	Given User clicks on "lylFuncton_Authorze.chk_Password_Required"
	When User waits "2" seconds
	#User verify save functionality is working fine
	Given User clicks on "MANAGE_FUNCTION.FUNCTION_SAVE_BUTTON"
	Then User verifies text - "Function detail saved successfully." is present on page
	Given User clicks on "lylFuncton_Authorze.txt_Function_search_box"
	Given User clicks on "MANAGE_FUNCTION.SELECT_FUNCTION_NAME" with parameters
		| Key           | Value                 |
		| function_name | Manual Player Archive |
	When User waits "2" seconds
	Then User verifies attribute "selected" value "false" of element "lylFuncton_Authorze.chk_Password_Required"
	Then User verifies attribute "selected" value "True" of element "lylFuncton_Authorze.chk_Password_Visible"
	When User waits "2" seconds
	#User enroll a player in web-app
	When User generates a "UniqueString" with "AjayPlayer_:4" for key "FirstName"
	When User waits "2" seconds
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	When User waits "2" seconds
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	#User search player archival status under player function
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User enters text "Player Archival Status" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylPlayer_Function.lnk_player_archivalstatus"
	When User waits "4" seconds
	#User initiates Player Archival Process without password
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	Given User selects option "<reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Archival>" in "lylPage_Archival_Sts.txt_comment"
	Given User clicks on "lylPage_Archival_Sts.btn_archive"
	When User waits "2" seconds
	#User verifies Indicator on Player's Dashboard
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI

	Examples:
		| reason                   | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |

Scenario: 003 Re-Enabling Password as mandatory
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Function Authorization" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_functional_authorization"
	Given User clicks on "lylFuncton_Authorze.txt_Function_search_box"
	# Verify that Manual Player Archive is listed in the Manage Function list of Function Authorizations
	Then User verifies text - "Manual Player Archive" is present on page
	Given User clicks on "MANAGE_FUNCTION.SELECT_FUNCTION_NAME" with parameters
		| Key           | Value                 |
		| function_name | Manual Player Archive |
	#Verify Password as not required and Visible check boxes checked
	Given User clicks on "lylFuncton_Authorze.chk_Password_Required"
	When User waits "2" seconds
	#User verify save functionality is working fine
	Given User clicks on "MANAGE_FUNCTION.FUNCTION_SAVE_BUTTON"
	Then User verifies text - "Function detail saved successfully." is present on page