@Release_15.0 @Group_Player_Archival @Player_Archive @Web
Feature: OL_AR_PLAYERARCHIVAL Verifing Complete flow of Archival of a Player

#***********************************************************************
#** Feature File                    : OL_AR_PLAYERARCHIVAL
#** Feature Name                    : Verifing Complete flow of Web-APP Archival of a Player
#** Test Case ID					: 461226,464318,461302,459679,459416,459417,459420,459422,459425,459676,459385
#** Defect/Bug Linked(if any)       :
#**********************************************************************/
#**  Created Date:       Author:                 # Comments
#**  04/18/2022          Ajay Dahiya
#**  12/05/2022          Ajay Dahiya              Made somechanges as per standard defined in tags and file name
#*****************************************************************/
Scenario Outline: 001 Verify Archival of a Player
	#User set PropertyID
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = 'Loyalty Universe'" with connection "<#Halo_db_connectionstring#>" and save with key "Loyality_PropertyID"
	# User login web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "AjayPlayer_:4" for key "FirstName"
	When User waits "2" seconds
	# User enroll player in web-app
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
	#User initiates Player Archival Process
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	#User verify last play date with UC_PL_PropPlay table
	When User runs query "select CONVERT(varchar,LastPlayedDate,101) as LastPlayDate from UC_PL_PropPlay where playerid = <$REAL_PLAYER_ID$>" with connection "<#Halo_db_connectionstring#>" and save with key "Last_Play_Date"
	When User gets attribute "value" value of "lylPage_Archival_Sts.txt_last_play_date" element to save with key "LastPlay_Date"
	When User performs string operation "stringEquals" of provided value "<$Last_Play_Date$>" with "<$LastPlay_Date$>"
	Given User enters text "<#Halo_password#>" in "lylPage_Archival_Sts.txt_Password"
	#User verify that 'Instructed by Management' reason is listed in the Reason dropdown
	Given User selects option "<reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Archival>" in "lylPage_Archival_Sts.txt_comment"
	Given User clicks on "lylPage_Archival_Sts.btn_archive"
	When User waits "2" seconds
	#User count in UserTransactionLog table
	When User runs query "SELECT Count(3) FROM UC_X_UserTransactionLog WHERE PlayerID= <$REAL_PLAYER_ID$> AND userid= '<#Halo_username#>' And UsertransactionTypeId in(231,228) AND PropertyID=<$PropertyID$> ORDER BY 1 DESC" with connection "<#Halo_db_connectionstring#>" and save with key "Row_Count"
	When User performs string operation "stringEquals" of provided value "<$Row_Count$>" with "1"
	#User verifies Indicator on Player's Dashboard
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI
	#User verifies on click of the Archive flag then the Player Archival Status pop-up is visible
	Given User clicks on "lylPage_Archival_Sts.btn_ar_indicator"
	When User waits "4" seconds
	#User verifes Recover button and Donot Archive button is appearing on Player Archival Status pop-up
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	Then User verifies that element "lylPage_Archival_Sts.btn_recover" is present "true" on UI
	Then User verifies attribute "disabled" value "true" of element "lylPage_Archival_Sts.btn_donot_archive"
	Then User verifies attribute "disabled" value "false" of element "lylPage_Archival_Sts.btn_recover"

	Examples:
		| reason                   | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |

Scenario Outline: 002 Archival Player without Permission
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.GROUP_PERMISSIONS_LINK"
	#User navigate to ARCHIVEPLAYER permission under Group Permission
	Given User selects option "<#Halo_ADGroup_1#>" of element "USER_GROUP_PERMISSIONS.USER_GROUP_DROPDOWN" by "visibletext"
	Given User clicks on "USER_GROUP_PERMISSIONS.EDIT_FUNCTIONS_BUTTON"
	Given User clears "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User enters text "ARCHIVEPLAYER" in "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User clicks on "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_BUTTON"
	#User checks ARCHIVEPLAYER Permisison is Unchecked.
	Then User "Unchecks" element "USER_GROUP_PERMISSIONS.PERMISSION_NAME_CHECKBOX" with parameters
		| Key            | Value         |
		| permissionname | ARCHIVEPLAYER |
	When User waits "2" seconds
	#User verifies Description and Catgory of Permission
	Then User verifies attribute "innerText" value "ALLOWS A USER TO ARCHIVE A PLAYER FROM WEB APP" of element "lylGroup_Permission.mic_desc_text"
	Then User verifies attribute "innerText" value "Player Functions" of element "lylGroup_Permission.mic_category_text"
	#User save permission
	When User scrolls till element "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	Given User clicks on "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	When User waits "2" seconds
	When User "refresh" the browser
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
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	#User process Archival on the player
	Given User enters text "<#Halo_password#>" in "lylPage_Archival_Sts.txt_Password"
	Given User selects option "<archive_reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Archival>" in "lylPage_Archival_Sts.txt_comment"
	#User verifies button of archival is diabled
	Then User verifies attribute "disabled" value "true" of element "lylPage_Archival_Sts.btn_archive"

	Examples:
		| archive_reason           | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |

Scenario: 003 Renabling Archival Player Permission
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.GROUP_PERMISSIONS_LINK"
	#User navigate to ARCHIVEPLAYER permission under Group Permission
	Given User selects option "<#Halo_ADGroup_1#>" of element "USER_GROUP_PERMISSIONS.USER_GROUP_DROPDOWN" by "visibletext"
	Given User clicks on "USER_GROUP_PERMISSIONS.EDIT_FUNCTIONS_BUTTON"
	Given User clears "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User enters text "ARCHIVEPLAYER" in "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User clicks on "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_BUTTON"
	#User checks ARCHIVEPLAYER Permisison is Unchecked.
	Then User "Checks" element "USER_GROUP_PERMISSIONS.PERMISSION_NAME_CHECKBOX" with parameters
		| Key            | Value         |
		| permissionname | ARCHIVEPLAYER |
	#User save permission
	When User waits "1" seconds
	When User scrolls till element "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	Given User clicks on "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	When User waits "2" seconds