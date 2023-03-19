@Release_15.0 @Group_Player_Archival @Include_Archived_Accounts_Search @Web
Feature: OL_AR_Player_Search Verify Include archived accounts in player search

#******************************************************************************************************
#** Feature File                    : OL_AR_Player_Search
#** Feature Name                    : Verify Include archived accounts in player search
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 459526,459532,459793,459802,459874,460938
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  16/05/2022           Ajay Dahiya
#**************************************************************************************************/
Scenario: 001 Verify that "Include Archived Accounts" check box displays in Player Search (TC ID- 459526,459532,459793)
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User verifies uncheck Include Archived Accounts doesn't contains Archived accounts
	Given User clicks on "lylPlayer_Search.btn_search_dropdown"
	Then User verifies that element "lylPlayer_Search.btn_chck_arch_accnt" is present "true" on UI
	Then User verifies attribute "selected" value "false" of element "lylPlayer_Search.btn_chck_arch_accnt"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	Then User verifies that element "lylPlayer_Search.lbl_brown_color_search_result" is present "false" on UI
	When User waits "2" seconds
	#User verifies Check Include Archived Accounts should contains Archived accounts in color code 8b4513
	Given User clicks on "lylPlayer_Search.btn_search_dropdown"
	Given User clicks on "lylPlayer_Search.btn_chck_arch_accnt"
	When User waits "1" seconds
	Then User verifies attribute "selected" value "true" of element "lylPlayer_Search.btn_chck_arch_accnt"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	
Scenario: 002 Making Test Data for Deceased and Verify Deceased player is appearing without Include Archived Accounts on it ( TC ID - 459802 )
	#User login to web-app
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User enroll a player in web-app
	When User generates a "UniqueString" with "AjayPlayer_Deceased_:4" for key "FirstName"
	When User waits "2" seconds
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	When User waits "2" seconds
	When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID =  '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "First_Name"
	When User "refresh" the browser
	# User search a player
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	# User Deceased a player
	Given User clicks on "DASHBOARD.CONTACT_INFO_TAB"
	Given User clicks on "CONTACT_INFO.CONTACT_DECEASED_CHECKBOX"
	Given User clicks on "CONTACT_INFO.CONTACT_INFO_SAVE"
	Given User clicks on "DASHBOARD.PLAYER_INFO_TAB"
	Then User verifies that element "PLAYER_INFO.DE_FLAG" is present "true" on UI
	When User waits "1" seconds
	#User search Deceased player
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "AjayPlayer_Deceased_" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Search.txt_Player_ID_In_Grid_Result" is present "true" on UI with parameters
		| Key       | Value          |
		| FirstName | <$First_Name$> |

Scenario Outline: 003 Archiving Deceased and Verify Deceased player is appearing with Include Archived Accounts on it ( TC ID - 459874,460938 )
	#User login to web-app
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User search player deceased
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
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
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI
	#User search Deceased Archived player
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "AjayPlayer_Deceased_" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Search.btn_search_dropdown"
	Given User clicks on "lylPlayer_Search.btn_chck_arch_accnt"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Search.lbl_brown_color_search_result" is present "true" on UI with parameters
		| Key       | Value          |
		| FirstName | <$First_Name$> |

	Examples:
		| archive_reason           | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |

Scenario: 004 Making Test Data for Victim and Verify Victim player is appearing without Include Archived Accounts on it ( TC ID - 459802 )
	#User login to web-app
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	# User find victim player from Unimerge
	When User runs query "SELECT Top(1) B.UniversalPlayerID FROM UC_PL_MergedPlayers A INNER JOIN UC_PL_Player B ON A.VictimPlayerID=B.PlayerID order by 1 desc" with connection "<#Halo_db_connectionstring#>" and save with key "PLAYER_ID"
	When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID =  '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "First_Name"
	When User "refresh" the browser
	#User search Victim player
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "Victim" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Search.txt_Player_ID_In_Grid_Result" is present "true" on UI with parameters
		| Key       | Value          |
		| FirstName | <$First_Name$> |

Scenario Outline: 005 Archiving Victim and Verify Victim player is appearing with Include Archived Accounts on it ( TC ID - 459874,460938 )
	#User login to web-app
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User search player deceased
	When User runs query "SELECT Top(1) B.UniversalPlayerID FROM UC_PL_MergedPlayers A INNER JOIN UC_PL_Player B ON A.VictimPlayerID=B.PlayerID order by 1 desc" with connection "<#Halo_db_connectionstring#>" and save with key "PLAYER_ID"
	When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID =  '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "First_Name"
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
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
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI
	#User search Victim Archived player
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "Victim" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Search.btn_search_dropdown"
	Given User clicks on "lylPlayer_Search.btn_chck_arch_accnt"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Search.lbl_brown_color_search_result" is present "true" on UI with parameters
		| Key       | Value          |
		| FirstName | <$First_Name$> |

	Examples:
		| archive_reason           | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |