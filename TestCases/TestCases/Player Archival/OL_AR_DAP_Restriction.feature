@Release_15.0 @Group_Player_Archival @Restrict_DAP @Web
Feature: OL_AR_DAP_Restriction Verify that DAP player is not getting archived.

#******************************************************************************************************
#** Feature File                    : OL_AR_DAP_Restriction
#** Feature Name                    : Verify that DAP player is not getting archived.
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 465675
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  26/06/2022           Ajay Dahiya              Initial Draft
#**************************************************************************************************/
Scenario Outline: 001 Verify that DAP player is not getting archived.
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User search DAP Player
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<#DAPPlayer#>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	#User search player archival status under player function
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
	#User switches to default frame
	Given User switches to frame "default"
	#User verifies Function not allowed due to DAP Status on player
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds

	Examples:
		| archive_reason           | Comment_For_Archival      | givenErrorMessage                          |
		| Instructed by Management | Comment Line For Archival | Function not allowed due to account status |

Scenario Outline: 002  Verify Normal player is able to mark the player archive
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

	Examples:
		| archive_reason           | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |