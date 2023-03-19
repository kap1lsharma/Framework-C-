@Release_15.0 @Group_Player_Archival @Recover_Player @Web
Feature: OL_AR_RECOVERARCHIVEDPLAYER Verify that the Recover button based on permission RECOVERARCHIVEDPLAYER set.

#******************************************************************************************************
#** Feature File                    : OL_AR_RECOVERARCHIVEDPLAYER
#** Feature Name                    : Verify that the Recover button based on permission RECOVERARCHIVEDPLAYER set.
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 465770,465741,465747,465757,465765,465766
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  18/04/2022           Ajay Dahiya
#**  12/05/2022           Ajay Dahiya              Made somechanges as per standard defined in tags and file name
#**  30/05/2022			  Ajay Dahiya			   Added validation as per Product Backlog Item 359660: Recover Archived Account
#**************************************************************************************************/
Scenario Outline: 001 Verify that the Recover button is active as per permission RECOVERARCHIVEDPLAYER set. ( TC ID- 465765,465766,465650,465766,465790 )
	#User set PropertyID
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = 'Loyalty Universe'" with connection "<#Halo_db_connectionstring#>" and save with key "Loyality_PropertyID"
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.GROUP_PERMISSIONS_LINK"
	#User navigate to RECOVERARCHIVEDPLAYER permission under Group Permission
	Given User selects option "<#Halo_ADGroup_1#>" of element "USER_GROUP_PERMISSIONS.USER_GROUP_DROPDOWN" by "visibletext"
	Given User clicks on "USER_GROUP_PERMISSIONS.EDIT_FUNCTIONS_BUTTON"
	Given User clears "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User enters text "RECOVERARCHIVEDPLAYER" in "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User clicks on "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_BUTTON"
	#User checks RECOVERARCHIVEDPLAYER Permisison is checked.
	Then User "checks" element "USER_GROUP_PERMISSIONS.PERMISSION_NAME_CHECKBOX" with parameters
		| Key            | Value                 |
		| permissionname | RECOVERARCHIVEDPLAYER |
	When User waits "2" seconds
	#User verifies Description and Catgory of Permission
	Then User verifies attribute "innerText" value "ALLOWS A USER TO RECOVER AN ARCHIVED PLAYER" of element "lylGroup_Permission.mic_desc_text"
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
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID =  '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "REAL_PLAYER_ID"
	#User search player archival status under player function
	Given User enters text "Player Archival Status" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archivalstatus"
	When User waits "2" seconds
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
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
	#User verifies count of Log Table in UC_X_UserTransactionLog
	When User runs query "SELECT Count(3) FROM UC_X_UserTransactionLog WHERE PlayerID= <$REAL_PLAYER_ID$> AND userid= '<#Halo_username#>' And UsertransactionTypeId in(233,232) ORDER BY 1 DESC" with connection "<#Halo_db_connectionstring#>" and save with key "Row_Count"
	When User performs string operation "stringEquals" of provided value "<$Row_Count$>" with "5"
	#User verifies count of Log Table in UC_L_Overridelog
	When User runs query "SELECT Count(1) FROM UC_L_Overridelog WHERE PlayerID= <$REAL_PLAYER_ID$> AND CreatedBy= '<#Halo_username#>' And Comments ='<Comment_For_Recover>' ORDER BY 1 DESC" with connection "<#Halo_db_connectionstring#>" and save with key "Row_Count_1"
	When User performs string operation "stringEquals" of provided value "<$Row_Count_1$>" with "1"
	#User verifies Archive Button and Donot Archive is appearing
	Given User enters text "Player Archival Status" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylPlayer_Function.lnk_player_archivalstatus"
	When User waits "4" seconds
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	Then User verifies that element "lylPage_Archival_Sts.btn_archive" is present "true" on UI
	Then User verifies that element "lylPage_Archival_Sts.btn_donot_archive" is present "true" on UI

	Examples:
		| archive_reason           | Comment_For_Archival      | recover_reason | Comment_For_Recover       |
		| Instructed by Management | Comment Line For Archival | Employee Error | Comment Line For Recovery |

Scenario Outline: 002 Verify that the Recover button is disabled for users who don't have RECOVERARCHIVEDPLAYER permission
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.GROUP_PERMISSIONS_LINK"
	#User navigate to RECOVERARCHIVEDPLAYER permission under Group Permission
	Given User selects option "<#Halo_ADGroup_1#>" of element "USER_GROUP_PERMISSIONS.USER_GROUP_DROPDOWN" by "visibletext"
	Given User clicks on "USER_GROUP_PERMISSIONS.EDIT_FUNCTIONS_BUTTON"
	Given User clears "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User enters text "RECOVERARCHIVEDPLAYER" in "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User clicks on "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_BUTTON"
	#User checks RECOVERARCHIVEDPLAYER Permisison is checked.
	Then User "Unchecks" element "USER_GROUP_PERMISSIONS.PERMISSION_NAME_CHECKBOX" with parameters
		| Key            | Value                 |
		| permissionname | RECOVERARCHIVEDPLAYER |
	When User waits "2" seconds
	#User verifies Description and Catgory of Permission
	Then User verifies attribute "innerText" value "ALLOWS A USER TO RECOVER AN ARCHIVED PLAYER" of element "lylGroup_Permission.mic_desc_text"
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
	#User verifies button of recover is diabled
	Then User verifies attribute "disabled" value "true" of element "lylPage_Archival_Sts.btn_recover"

	Examples:
		| archive_reason           | Comment_For_Archival      | recover_reason | Comment_For_Recover       |
		| Instructed by Management | Comment Line For Archival | Employee Error | Comment Line For Recovery |

Scenario: 003 Reenabling the RECOVERARCHIVEDPLAYER permission
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.GROUP_PERMISSIONS_LINK"
	#User navigate to RECOVERARCHIVEDPLAYER permission under Group Permission
	Given User selects option "<#Halo_ADGroup_1#>" of element "USER_GROUP_PERMISSIONS.USER_GROUP_DROPDOWN" by "visibletext"
	Given User clicks on "USER_GROUP_PERMISSIONS.EDIT_FUNCTIONS_BUTTON"
	Given User clears "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User enters text "RECOVERARCHIVEDPLAYER" in "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User clicks on "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_BUTTON"
	#User checks RECOVERARCHIVEDPLAYER Permisison is checked.
	Then User "Checks" element "USER_GROUP_PERMISSIONS.PERMISSION_NAME_CHECKBOX" with parameters
		| Key            | Value                 |
		| permissionname | RECOVERARCHIVEDPLAYER |
	When User waits "2" seconds
	#User save permission
	When User scrolls till element "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	Given User clicks on "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	When User waits "2" seconds