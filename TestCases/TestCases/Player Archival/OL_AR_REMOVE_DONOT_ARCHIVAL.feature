@Release_15.0 @Group_Player_Archival @Remove_Donot_Archive @Web

Feature: OL_AR_REMOVE_DONOT_ARCHIVAL Verifing Complete flow of Remove Do not Archival of a Player

#******************************************************************************************************
#** Feature File                    : OL_AR_REMOVE_DONOT_ARCHIVAL
#** Feature Name                    : Verifing Complete flow of Remove Do not Archival of a Player
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 459743
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  18/04/2022           Ajay Dahiya
#**  12/05/2022           Ajay Dahiya              Made somechanges as per standard defined in tags and file name
#**************************************************************************************************/
Scenario Outline: 001 Verifing Complete flow of Remove Do not Archival of a Player
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "AjayPlayer_:4" for key "FirstName"
	When User waits "2" seconds
	# User enroll player in web-app
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
	#User initiates Do not Player Archival Process
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	Given User enters text "<#Halo_password#>" in "lylPage_Archival_Sts.txt_Password"
	Given User selects option "<reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Archival>" in "lylPage_Archival_Sts.txt_comment"
	Given User clicks on "lylPage_Archival_Sts.btn_donot_archive"
	#User clicks on Indicator on Player's Dashboard
	Given User clicks on "lylPage_Archival_Sts.btn_na_donot_indicator"
	When User waits "2" seconds
	#User initiates Remove Do not Player Archival Process
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	Given User enters text "<#Halo_password#>" in "lylPage_Archival_Sts.txt_Password"
	Given User selects option "<reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Archival>" in "lylPage_Archival_Sts.txt_comment"
	Given User clicks on "lylPage_Archival_Sts.btn_donot_archive"
	#User verifies indicator on Player's Dashboard is not present
	Then User verifies that element "lylPage_Archival_Sts.btn_na_donot_indicator" is present "false" on UI

	Examples:
		| reason                   | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |