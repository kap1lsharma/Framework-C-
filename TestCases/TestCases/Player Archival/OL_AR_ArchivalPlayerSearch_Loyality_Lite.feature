@Release_15.0 @Group_Player_Archival @Player_Archive_in_Loyality_Lite @Desktop
Feature: OL_AR_Archival_Loyality_Lite Verifing search flow of Archival of a Player through Loyality Lite

#***********************************************************************
#** Feature File                    : OL_AR_Archival_Loyality_Lite
#** Feature Name                    : Verifing flow of searching an archived Player through Loyality Lite
#** Test Case ID					: 475932
#** Defect/Bug Linked(if any)       :
#**********************************************************************/
#**  Created Date:       Author:                 # Comments
#**  06/28/2022          Nidhi Vasudev			   Intial Draft

#*****************************************************************/

Scenario Outline: 001 include archived account checked check box is present on LL (TC ID - 477175)
	##User switches to Loyality Lite Application
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	#User verify player search in LL
	#User verify player search in LL
    When User gets attribute "visible" value of "LLSideNavigation.lblIncludeArchivedAccount" element to save with key "Label_IncludeArchivedAccount_Visibility"
    When User performs string operation "stringEquals" of provided value "<IncludeArchiveAccount_Visible>" with "<$Label_IncludeArchivedAccount_Visibility$>"
	Examples:
       | IncludeArchiveAccount_Visible |
       | True                          |


#Attribute Default action is not part of attribute list": Needs to be raised to Automation team
#Scenario Outline: 002 include archived account checked check box is default unchecked on LL (TC ID - 477175) 
#	Given User switch to "desktop" application
#	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
#	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
#	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
#	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
#	Given User clicks on "OLL_LOGIN.btn_Submit"
#	When User waits "4" seconds
#	When User gets attribute "DefaultAction" value of "LLPlayerArchival.chk_Include_Archived_Accounts" element to save with key "Checkbox_IncludeArchivedAccounts"
#    When User performs string operation "stringEquals" of provided value "<Check_includearchiveaccount>" with "<$Checkbox_IncludeArchivedAccounts$>"
#	Examples:
#       | Check_includearchiveaccount |
#       | False                     |


Scenario Outline: 003 Archival Player search with include archived account checked on LL (TC ID - 477176)
	
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
    Given User types text "<#ArchivePlayer#>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
    When User waits "2" seconds
    Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
    When User waits "3" seconds
    #User verifes AR button is present on player
    When User gets attribute "visible" value of "LLPlayerArchival.btn_AR_indicator" element to save with key "AR_Button_Visibility"
    When User performs string operation "stringEquals" of provided value "<AR_Button_Visible>" with "<$AR_Button_Visibility$>"
	Examples:
       | AR_Button_Visible |
       |  True            |

Scenario Outline: 004 Archival Player search with include archived account unchecked on LL - Player not found (TC ID - 477176)
	
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	#User verify player search in LL
	#User verify player search in LL
   # Given User clicks on "LLPlayerArchival.chk_Include_Archived_Accounts"
    Given User types text "<#ArchivePlayer#>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
    When User waits "2" seconds
    Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
    When User waits "3" seconds
    #User verifes Player Not Found text on page
    When User gets attribute "visible" value of "LLPlayerArchival.lblPlayerNotFound" element to save with key "Label_Player_Not_Found"
    When User performs string operation "stringEquals" of provided value "<Player_not_found_label>" with "<$Label_Player_Not_Found$>"
	Examples:
       | Player_not_found_label |
        |  True            |

Scenario Outline: 005 Archiving the deceased Player and search in LL (TC ID - 477178)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User enroll a player in web-app
	When User generates a "UniqueString" with "Nidhi:4" for key "FirstName"
	When User waits "2" seconds
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Female   | Driver's License   |
	When User waits "2" seconds
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	# User Deceased a player
	Given User clicks on "DASHBOARD.CONTACT_INFO_TAB"
	Given User clicks on "CONTACT_INFO.CONTACT_DECEASED_CHECKBOX"
	Given User clicks on "CONTACT_INFO.CONTACT_INFO_SAVE"
	#Given User clicks on "DASHBOARD.PLAYER_INFO_TAB"
	#Then User verifies that element "PLAYER_INFO.DE_FLAG" is present "true" on UI

	#User search player archival status under player function
	#Given User clicks on "lylPlayer_Search.lnk_player_search"
	#When User waits "2" seconds
	Given User enters text "Player Archival Status" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylPlayer_Function.lnk_player_archivalstatus"
	When User waits "4" seconds
	#User initiates Player Archival Process
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	Given User selects option "<reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Archival>" in "lylPage_Archival_Sts.txt_comment"
	Given User enters text "<Password>" in "lylPage_Archival_Sts.txt_Password"
	Given User clicks on "lylPage_Archival_Sts.btn_archive"
	When User waits "3" seconds
	#User verifies Indicator on Player's Dashboard
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI
	##User switches to Loyality Lite Application
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	#User verify player search in LL
	#User verify player search in LL
    Given User clicks on "LLPlayerArchival.chk_Include_Archived_Accounts"
    Given User types text "<$PLAYER_ID$>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
    When User waits "2" seconds
    Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
    When User waits "3" seconds
    #User verifes AR button is present on player
    When User gets attribute "visible" value of "LLPlayerArchival.btn_AR_indicator" element to save with key "AR_Button_Visibility"
    When User performs string operation "stringEquals" of provided value "<AR_Button_Visible>" with "<$AR_Button_Visibility$>"

	Examples:
		| reason                   | Comment_For_Archival      | Password  | AR_Button_Visible |
		| Instructed by Management | Comment Line For Archival | Password1 | True              |


	# Searching the archvived deceased player without checking the include archived player checkbox
	Scenario Outline: 006 Searching the archived merged player without checking the checkbox (TC ID - 477178)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User enroll a player in web-app
	When User generates a "UniqueString" with "Nidhi:4" for key "FirstName"
	When User waits "2" seconds
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Female   | Driver's License   |
	When User waits "2" seconds
	# User Deceased a player
	Given User clicks on "DASHBOARD.CONTACT_INFO_TAB"
	Given User clicks on "CONTACT_INFO.CONTACT_DECEASED_CHECKBOX"
	Given User clicks on "CONTACT_INFO.CONTACT_INFO_SAVE"
	#Given User clicks on "DASHBOARD.PLAYER_INFO_TAB"
	#Then User verifies that element "PLAYER_INFO.DE_FLAG" is present "true" on UI
	When User waits "2" seconds
	#User search player archival status under player function
	Given User enters text "Player Archival Status" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylPlayer_Function.lnk_player_archivalstatus"
	When User waits "4" seconds
	#User initiates Player Archival Process
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	Given User selects option "<reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Archival>" in "lylPage_Archival_Sts.txt_comment"
	Given User enters text "<Password>" in "lylPage_Archival_Sts.txt_Password"
	Given User clicks on "lylPage_Archival_Sts.btn_archive"
	When User waits "3" seconds
	#User verifies Indicator on Player's Dashboard
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI
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
    #User verifes Player Not Found text on page
    When User gets attribute "visible" value of "LLPlayerArchival.lblPlayerNotFound" element to save with key "Label_Player_Not_Found"
    When User performs string operation "stringEquals" of provided value "<Player_not_found_label>" with "<$Label_Player_Not_Found$>"
	Examples:
      	| reason | Comment_For_Archival | Password | Player_not_found_label |
      	| Instructed by Management | Comment Line For Archival | Password1 | True   |

Scenario Outline: 007 Archiving the merged Player and search in LL (TC ID - 477178)

	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	#User verify player search in LL
	#User verify player search in LL
    Given User clicks on "LLPlayerArchival.chk_Include_Archived_Accounts"
    Given User types text "<#MergePlayer#>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
    When User waits "2" seconds
    Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
    When User waits "3" seconds
    #User verifes AR button is present on player
    When User gets attribute "visible" value of "LLPlayerArchival.btn_AR_indicator" element to save with key "AR_Button_Visibility"
    When User performs string operation "stringEquals" of provided value "<AR_Button_Visible>" with "<$AR_Button_Visibility$>"

	Examples:
		| AR_Button_Visible        |
		| True |

Scenario Outline: 008 Archiving the merged Player and search in LL (TC ID - 477178) (Bug ID: 597779 )

	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	#User verify player search in LL
	#User verify player search in LL
    #Given User clicks on "LLPlayerArchival.chk_Include_Archived_Accounts"
    Given User types text "<#MergePlayer#>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
    When User waits "2" seconds
    Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
    When User waits "3" seconds
    #User verifes AR button is present on player
    When User gets attribute "visible" value of "LLPlayerArchival.lblPlayerNotFound" element to save with key "Label_Player_Not_Found"
    When User performs string operation "stringEquals" of provided value "<Player_not_found_label>" with "<$Label_Player_Not_Found$>"

	Examples:
		| Player_not_found_label       |
		| True |


Scenario: 009-Close all instance of Loyalty Lite Desktop application.
	When User switch to window application "ATI.Loyalty.Lite.Client.exe"
	Given User closes application