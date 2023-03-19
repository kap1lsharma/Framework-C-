@Release_15.0 @Group_Player_Archival @Functional_Authorization @Web
Feature: OL_AR_MANUAL_PLAYER_RECOVERY Verify Newly added Functions Manual Player Recovery

#******************************************************************************************************
#** Feature File                    : OL_AR_MANUAL_PLAYER_RECOVERY
#** Feature Name                    : Verify Newly added Functions Manual Player Recovery
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 464319,465647,465646,465641,465645,465644
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  18/04/2022           Ajay Dahiya
#**  12/05/2022           Ajay Dahiya              Made somechanges as per standard defined in tags and file name
#**************************************************************************************************/
Scenario Outline: 001 Verify flow of Manual Player Recovery Function Authorization
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Function Authorization" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_functional_authorization"
	Given User clicks on "lylFuncton_Authorze.txt_Function_search_box"
	# Verify that Manual Player Recovery is listed in the Manage Function list of Function Authorizations
	Then User verifies text - "Manual Player Recovery" is present on page
	Given User clicks on "MANAGE_FUNCTION.SELECT_FUNCTION_NAME" with parameters
		| Key           | Value                  |
		| function_name | Manual Player Recovery |
	#Verify Password as required and Visible check boxes checked
	Given User clicks on "lylFuncton_Authorze.chk_Password_Required"
	When User waits "2" seconds
	Given User clicks on "lylFuncton_Authorze.chk_Password_Visible"
	When User waits "2" seconds
	#User is able to Save Function details.
	Given User clicks on "MANAGE_FUNCTION.FUNCTION_SAVE_BUTTON"
	Then User verifies text - "Function detail saved successfully." is present on page
	Given User clicks on "lylFuncton_Authorze.txt_Function_search_box"
	Given User clicks on "MANAGE_FUNCTION.SELECT_FUNCTION_NAME" with parameters
		| Key           | Value                  |
		| function_name | Manual Player Recovery |
	Then User verifies attribute "selected" value "false" of element "lylFuncton_Authorze.chk_Password_Required"
	Then User verifies attribute "selected" value "false" of element "lylFuncton_Authorze.chk_Password_Visible"
	Given User clicks on "lylFuncton_Authorze.chk_Password_Required"
	Given User clicks on "MANAGE_FUNCTION.FUNCTION_SAVE_BUTTON"
	Given User clicks on "lylFuncton_Authorze.txt_Function_search_box"
	Given User clicks on "MANAGE_FUNCTION.SELECT_FUNCTION_NAME" with parameters
		| Key           | Value                  |
		| function_name | Manual Player Recovery |
	Then User verifies attribute "selected" value "true" of element "lylFuncton_Authorze.chk_Password_Required"
	Then User verifies attribute "selected" value "True" of element "lylFuncton_Authorze.chk_Password_Visible"
	When User waits "2" seconds
	#User enroll a player in web-app
	When User generates a "UniqueString" with "AjayPlayer_:4" for key "FirstName"
	When User waits "2" seconds
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	When User waits "2" seconds
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID =  '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "REAL_PLAYER_ID"
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
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	#User process Archival on the player
	Given User enters text "<#Halo_password#>" in "lylPage_Archival_Sts.txt_Password"
	Given User selects option "<archive_reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Archival>" in "lylPage_Archival_Sts.txt_comment"
	Given User clicks on "lylPage_Archival_Sts.btn_archive"
	When User waits "3" seconds
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI
	#User execute query to make change in Stopcodestatus for O value to process Recovery of Player
	When User executes query "Update PlayerArchivingDetails set StopCodeStatus='P' where playerid=<$REAL_PLAYER_ID$> and StopCodeStatus = 'O'" with connection "<#Halo_db_connectionstring#>"
	#User include Archived account using checkbox in search list
	Given User clicks on "lylPlayer_Search.btn_search_dropdown"
	Given User clicks on "lylPlayer_Search.btn_chck_arch_accnt"
	When User waits "1" seconds
	#User search player archival status under player function
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "lylPage_Archival_Sts.btn_ar_indicator"
	When User waits "4" seconds
	#User process Recovery on the player
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	Given User enters text "<#Halo_password#>" in "lylPage_Archival_Sts.txt_Password"
	Given User selects option "<recover_reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Recover>" in "lylPage_Archival_Sts.txt_comment"
	Given User clicks on "lylPage_Archival_Sts.btn_recover"
	When User waits "3" seconds
	Given User clicks on "lylPage_Archival_Sts.btn_Skip_recover"
	When User waits "2" seconds
	#User verifies indicator of Archival removed from Player's dashboard
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "false" on UI

	Examples:
		| archive_reason           | Comment_For_Archival      | recover_reason | Comment_For_Recover       |
		| Instructed by Management | Comment Line For Archival | Employee Error | Comment Line For Recovery |

Scenario Outline: 002 Verify that data elements work as configured for manual player Recovery in Function Authorization
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Function Authorization" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_functional_authorization"
	Given User clicks on "lylFuncton_Authorze.txt_Function_search_box"
	# Verify that Manual Player Archive is listed in the Manage Function list of Function Authorizations
	Then User verifies text - "Manual Player Archive" is present on page
	Given User clicks on "MANAGE_FUNCTION.SELECT_FUNCTION_NAME" with parameters
		| Key           | Value                  |
		| function_name | Manual Player Recovery |
	#Verify Password as not required and Visible check boxes checked
	When User waits "2" seconds
	Given User clicks on "lylFuncton_Authorze.chk_Password_Required"
	When User waits "2" seconds
	#User verify save functionality is working fine
	Given User clicks on "MANAGE_FUNCTION.FUNCTION_SAVE_BUTTON"
	Then User verifies text - "Function detail saved successfully." is present on page
	Given User clicks on "lylFuncton_Authorze.txt_Function_search_box"
	Given User clicks on "MANAGE_FUNCTION.SELECT_FUNCTION_NAME" with parameters
		| Key           | Value                  |
		| function_name | Manual Player Recovery |
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
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID =  '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "REAL_PLAYER_ID"
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
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	#User process Archival on the player
	Given User enters text "<#Halo_password#>" in "lylPage_Archival_Sts.txt_Password"
	Given User selects option "<archive_reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Archival>" in "lylPage_Archival_Sts.txt_comment"
	Given User clicks on "lylPage_Archival_Sts.btn_archive"
	When User waits "3" seconds
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI
	#User count in UC_L_OverrideLog table
	When User runs query "select Count(1) from UC_L_OverrideLog where playerid = <$REAL_PLAYER_ID$> and Comments ='<Comment_For_Archival>' " with connection "<#Halo_db_connectionstring#>" and save with key "Row_Count"
	When User performs string operation "stringEquals" of provided value "<$Row_Count$>" with "1"
	#User execute query to make change in Stopcodestatus for O value to process Recovery of Player
	When User executes query "Update PlayerArchivingDetails set StopCodeStatus='P' where playerid=<$REAL_PLAYER_ID$> and StopCodeStatus = 'O'" with connection "<#Halo_db_connectionstring#>"
	#User include Archived account using checkbox in search list
	Given User clicks on "lylPlayer_Search.btn_search_dropdown"
	Given User clicks on "lylPlayer_Search.btn_chck_arch_accnt"
	When User waits "1" seconds
	#User search player archival status under player function
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "lylPage_Archival_Sts.btn_ar_indicator"
	When User waits "4" seconds
	#User process Recovery on the player
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	Given User selects option "<recover_reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Recover>" in "lylPage_Archival_Sts.txt_comment"
	Given User clicks on "lylPage_Archival_Sts.btn_recover"
	When User waits "3" seconds
	Given User clicks on "lylPage_Archival_Sts.btn_Skip_recover"
	When User waits "2" seconds
	#User verifies indicator of Archival removed from Player's dashboard
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "false" on UI

	Examples:
		| archive_reason           | Comment_For_Archival      | recover_reason | Comment_For_Recover       |
		| Instructed by Management | Comment Line For Archival | Employee Error | Comment Line For Recovery |

Scenario: 003 Re-Enabling Password as mandatory
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Function Authorization" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_functional_authorization"
	Given User clicks on "lylFuncton_Authorze.txt_Function_search_box"
	# Verify that Manual Player Archive is listed in the Manage Function list of Function Authorizations
	Then User verifies text - "Manual Player Archive" is present on page
	Given User clicks on "MANAGE_FUNCTION.SELECT_FUNCTION_NAME" with parameters
		| Key           | Value                  |
		| function_name | Manual Player Recovery |
	#Verify Password as not required and Visible check boxes checked
	When User waits "2" seconds
	Given User clicks on "lylFuncton_Authorze.chk_Password_Required"
	When User waits "2" seconds
	#User verify save functionality is working fine
	Given User clicks on "MANAGE_FUNCTION.FUNCTION_SAVE_BUTTON"
	Then User verifies text - "Function detail saved successfully." is present on page