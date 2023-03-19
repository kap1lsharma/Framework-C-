@Release_15.0 @Group_Player_Archival @Address_and_ID_Verification @Web
Feature: OL_AR_RECOVER_DATA_VALIDATION Verify that User is able to recover the archived player after player's Address and ID verification

#******************************************************************************************************
#** Feature File                    : OL_AR_RECOVER_DATA_VALIDATION
#** Feature Name                    : Verify that User is able to recover the archived player after player's Address and ID verification
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 471418
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  18/04/2022           Ajay Dahiya
#**  12/05/2022           Ajay Dahiya              Made somechanges as per standard defined in tags and file name
#**************************************************************************************************/
Scenario Outline: 001 Making Test Data when User is able to recover the archived player after player's Address and ID verification
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
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

	Examples:
		| archive_reason           | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |

Scenario Outline: 002 Verify Confirm button loads to Player Dashboard and Indicator on Player vanishes out (TC ID -471418 )
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
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
	#User navigate to Address and ID verification Page
	When User gets attribute "value" value of "lylPage_Archival_Sts.txt_recovery_id" element to save with key "Recovery_ID"
	When User performs string operation "stringEquals" of provided value "<$Recovery_ID$>" with "Driver's License: TUVXYZ54322"
	Then User verifies attribute "text" value "Test Address Test Address2 SAINT PETERSBURG, Florida 33701, United States" of element "lylPage_Archival_Sts.txt_recovery_address"
	Given User clicks on "lylPage_Archival_Sts.btn_confirm"
	When User waits "2" seconds
	#User verifies indicator of Archival removed from Player's dashboard
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "false" on UI

	Examples:
		| recover_reason | Comment_For_Recover       |
		| Employee Error | Comment Line For Recovery |