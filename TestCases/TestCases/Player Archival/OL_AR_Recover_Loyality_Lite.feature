@Release_15.0 @Group_Player_Archival @Recover@Desktop
Feature: OL_AR_Recover_Loyality_Lite Verify that User is able to recover the archived player through Loyality Lite

#******************************************************************************************************
#** Feature File                    : OL_AR_Recover_Loyality_Lite
#** Feature Name                    : Verify that User is able to recover the archived player through Loyality Lite
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 465650, 465766, 465765, 465790
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  26/06/2022           Ajay Dahiya              Initial Draft
#**************************************************************************************************/
Scenario: 001 Verifying UC_L_Overridelog have successful value is getting generated
	#User login from web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Function Authorization" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_functional_authorization"
	Given User clicks on "lylFuncton_Authorze.txt_Function_search_box"
	# Verify that Manual Player Recovery is listed in the Manage Function list of Function Authorizations
	Then User verifies text - "Manual Player Recovery" is present on page
	Given User clicks on "MANAGE_FUNCTION.SELECT_FUNCTION_NAME" with parameters
		| Key           | Value                  |
		| function_name | Manual Player Recovery |
	#Verify Password as required and Visible check boxes unchecked
	Given User clicks on "lylFuncton_Authorze.chk_Password_Required"
	When User waits "2" seconds
	Given User clicks on "lylFuncton_Authorze.chk_Password_Visible"
	When User waits "2" seconds
	#User is able to Save Function details.
	Given User clicks on "MANAGE_FUNCTION.FUNCTION_SAVE_BUTTON"
	Then User verifies text - "Function detail saved successfully." is present on page
	#Verify Password as required and Visible check boxes checked
	Given User clicks on "lylFuncton_Authorze.chk_Password_Required"
	When User waits "2" seconds
	Given User clicks on "lylFuncton_Authorze.chk_Password_Visible"
	When User waits "2" seconds
	#User is able to Save Function details.
	Given User clicks on "MANAGE_FUNCTION.FUNCTION_SAVE_BUTTON"
	Then User verifies text - "Function detail saved successfully." is present on page
	#User verifies new log is getting generated after functional Authorization change have successful
	When User runs query "Select OriginalValue from  dbo.UC_L_Overridelog Order By OverrideLogId desc OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY" with connection "<#Halo_db_connectionstring#>" and save with key "Original_Value"
	When User performs string operation "stringEquals" of provided value "<$Original_Value$>" with "Successful"

Scenario Outline: 002 Making Test Data when User is able to recover the archived player
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
	When User executes query "Update PlayerArchivingDetails set StopCodeStatus='P' where playerid=<$REAL_PLAYER_ID$> and StopCodeStatus = 'T'" with connection "<#Halo_db_connectionstring#>"

	Examples:
		| archive_reason           | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |

Scenario Outline: 002 Recover Player using Loyality Lite (TC ID- 465650, 465766, 465765, 465790)
	#User set PropertyID
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	#User switches to Loyality Lite Application
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	#User verify player search in LL
	Given User clicks on "LLPlayerArchival.chk_Include_Archived_Accounts"
	Given User types text "<$PLAYER_ID$>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	When User waits "2" seconds
	#User clicks on AR indicator
	Given User clicks on "LLPlayerArchival.btn_AR_indicator"
	#User provides data to Recover Player
	Given User types text "<#Halo_password#>" in "LLPlayerArchival.txt_PasswordTextBox"
	Given User selects option "<recover_reason>" of element "LLPlayerArchival.mic_ReasonBox_Dropdown" by "value"
	Given User types text "<Comment_For_Recover>" in "LLPlayerArchival.txt_CommentBox"
	Given User clicks on "LLPlayerArchival.btn_Recover"
	When User waits "2" seconds
	Given User clicks on "LLPlayerArchival.btn_Confirm"
	When User waits "2" seconds
	Given User clicks on "LLPlayerArchival.btn_Close"
	#User verifes AR button is not on player
	When User gets attribute "visible" value of "LLPlayerArchival.btn_AR_indicator" element to save with key "AR_Button_Visibility"
	When User performs string operation "stringEquals" of provided value "<AR_Button_Visible>" with "<$AR_Button_Visibility$>"
	#User count in UserTransactionLog table
	When User runs query "SELECT Count(1) FROM UC_X_UserTransactionLog WHERE PlayerID = <$REAL_PLAYER_ID$> and PropertyID= <$PropertyID$>  and userID= '<#Halo_username#>' And UsertransactionTypeId in(233,232) ORDER BY 1 DESC" with connection "<#Halo_db_connectionstring#>" and save with key "Row_Count"
	When User performs string operation "stringEquals" of provided value "<$Row_Count$>" with "3"

	Examples:
		| recover_reason | Comment_For_Recover      | AR_Button_Visible |
		| Employee Error | Comment Line For Recover | False             |

Scenario: 003-Close all instance of Loyalty Lite Desktop application.
	When User switch to window application "ATI.Loyalty.Lite.Client.exe"
	Given User closes application