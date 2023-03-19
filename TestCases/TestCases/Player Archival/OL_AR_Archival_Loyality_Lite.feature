@Release_15.0 @Group_Player_Archival @Player_Archive_in_Loyality_Lite @Desktop
Feature: OL_AR_Archival_Loyality_Lite Verifing Complete flow of Archival of a Player through Loyality Lite

#***********************************************************************
#** Feature File                    : OL_AR_Archival_Loyality_Lite
#** Feature Name                    : Verifing Complete flow of Archival of a Player through Loyality Lite
#** Test Case ID					: 475932
#** Defect/Bug Linked(if any)       :
#**********************************************************************/
#**  Created Date:       Author:                 # Comments
#**  06/13/2022          Ajay Dahiya			 Intial Draft
#**  27/06/2022          Ajay Dahiya             Added desktop closing scenerio at end of script
#*****************************************************************/
Scenario Outline: 001 Archival Player with Permission through Loyality Lite (TC ID - 475932)
	#User login into Web-APP
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "SC_ARCHIVEPLAYER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Add SC_ARCHIVEPLAYER permission from UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value            |
		| permissionname | SC_ARCHIVEPLAYER |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page
	#User enroll a player in web-app
	When User generates a "UniqueString" with "AjayPlayer_:4" for key "FirstName"
	When User waits "2" seconds
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	When User waits "2" seconds
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID =  '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "REAL_PLAYER_ID"
	##User switches to Loyality Lite Application
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	#User verify player search in LL
	Given User types text "<$PLAYER_ID$>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	When User waits "3" seconds
	Given User clicks on "LLSideNavigation.lblPlayerAction"
	When User waits "2" seconds
	Given User clicks on "LLSideNavigation.btn_pagedown"
	#When User scrolls till element "LLPlayerArchival.btn_Player_Archival_Status"
	Given User clicks on "LLPlayerArchival.btn_Player_Archival_Status"
	Given User types text "<#Halo_password#>" in "LLPlayerArchival.txt_PasswordTextBox"
	Given User selects option "<archive_reason>" of element "LLPlayerArchival.mic_ReasonBox_Dropdown" by "value"
	Given User types text "<Comment_For_Archival>" in "LLPlayerArchival.txt_CommentBox"
	Given User clicks on "LLPlayerArchival.btn_Archive_Player"
	#User verifes successful message on archival
	When User gets attribute "Name" value of "LLPlayerArchival.lbl_Archive_Message" element to save with key "Message"
	When User performs string operation "stringEquals" of provided value "<ArchivalMessage>" with "<$Message$>"
	When User waits "2" seconds
	Given User clicks on "LLPlayerArchival.btn_Close"
	#User verifes AR button on player
	When User gets attribute "Name" value of "LLPlayerArchival.btn_AR_indicator" element to save with key "AR_Button_Text"
	When User performs string operation "stringEquals" of provided value "<AR_Button>" with "<$AR_Button_Text$>"
	#User count in UserTransactionLog table
	When User runs query "SELECT Count(1) FROM UC_X_UserTransactionLog WHERE PlayerID= <$REAL_PLAYER_ID$> AND userid= '<#Halo_username#>' And UsertransactionTypeId in(231,228) ORDER BY 1 DESC" with connection "<#Halo_db_connectionstring#>" and save with key "Row_Count"
	When User performs string operation "stringEquals" of provided value "<$Row_Count$>" with "3"
	Given User closes application

	Examples:
		| archive_reason           | Comment_For_Archival      | ArchivalMessage             | AR_Button |
		| Instructed by Management | Comment Line For Archival | Player Archival Successful. | AR        |

Scenario Outline: 002 Archival Player without Permission through Loyality Lite (TC ID - 475932)
	#User login into Web-APP
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "SC_ARCHIVEPLAYER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Add SC_ARCHIVEPLAYER permission from UC_TechServices user group.
	Then User "Unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value            |
		| permissionname | SC_ARCHIVEPLAYER |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page
	#User enroll a player in web-app
	When User generates a "UniqueString" with "AjayPlayer_:4" for key "FirstName"
	When User waits "2" seconds
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	When User waits "2" seconds
	#User switches to Loyality Lite Application
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username_3#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	#User verify player search in LL
	Given User types text "<$PLAYER_ID$>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	When User waits "2" seconds
	Given User clicks on "LLSideNavigation.lblPlayerAction"
	Given User clicks on "LLSideNavigation.btn_pagedown"
	#When User scrolls till element "LLPlayerArchival.btn_Player_Archival_Status"
	Given User clicks on "LLPlayerArchival.btn_Player_Archival_Status"
	When User gets attribute "visible" value of "LLPlayerArchival.btn_Player_Archival_Status" element to save with key "Locator_Enable_State"
	When User performs string operation "stringEquals" of provided value "<Archival_Button_EnableorDisable>" with "<$Locator_Enable_State$>"
	Given User closes application

	Examples:
		| Archival_Button_EnableorDisable |
		| False                           |

Scenario: 003 Renabling Archival Player Permission from Web-APP
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.GROUP_PERMISSIONS_LINK"
	#User navigate to ARCHIVEPLAYER permission under Group Permission
	Given User selects option "<#Halo_ADGroup_1#>" of element "USER_GROUP_PERMISSIONS.USER_GROUP_DROPDOWN" by "visibletext"
	Given User clicks on "USER_GROUP_PERMISSIONS.EDIT_FUNCTIONS_BUTTON"
	Given User clears "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User enters text "SC_ARCHIVEPLAYER" in "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User clicks on "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_BUTTON"
	#User checks ARCHIVEPLAYER Permisison is Unchecked.
	Then User "Checks" element "USER_GROUP_PERMISSIONS.PERMISSION_NAME_CHECKBOX" with parameters
		| Key            | Value            |
		| permissionname | SC_ARCHIVEPLAYER |
	#User save permission
	When User waits "1" seconds
	When User scrolls till element "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	Given User clicks on "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	When User waits "2" seconds
	Then User verifies text - "Permissions Saved" is present on page

Scenario: 004-Close all instance of Loyalty Lite Desktop application.
	When User switch to window application "ATI.Loyalty.Lite.Client.exe"
	Given User closes application