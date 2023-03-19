@Release_15.0 @Group_Player_Archival @Deceased_Player @Web
Feature: OL_AR_DECEASED_PLAYERARCHIVAL Verify that Deceased players are marked archived as per the schedule defined

#***********************************************************************
#** Feature File                    : OL_AR_DECEASED_PLAYERARCHIVAL
#** Feature Name                    : Verify that Deceased players are marked archived as per the schedule defined
#** Test Case ID					: 460260
#** Defect/Bug Linked(if any)       :
#**********************************************************************/
#**  Created Date:       Author:                 # Comments
#**  04/18/2022          Ajay Dahiya
#**  12/05/2022           Ajay Dahiya              Made somechanges as per standard defined in tags and file name
#*****************************************************************/
Scenario: 001 Making Test Data for Deceased
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
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID =  '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "REAL_PLAYER_ID"
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	#User perform Adjustment on player
	When  User generates a "randomalphabetic" with "12" for key "Comment"
	When User runs query "select BDN.Name from UC_X_BucketDisplayName BDN, UC_X_BucketType BT where BT.BucketTypeName = 'Tier Points' and BT.BucketTypeID = BDN.BucketTypeID" with connection "<#Halo_db_connectionstring#>" and save with key "Bucket"
	Given User clicks on "MAIN_NAV_BOX.PLAYER_FUNCTIONS_LINK"
	Given User clicks on "MAIN_NAV_BOX.ADJUST_BUCKET_VALUE"
	When User waits "2" seconds
	When EB User perform adjustment with function Authorization check "N" with parameters
		| BucketView | Property         | Amount | Reason | Comment     |
		| <$Bucket$> | <$PropertyName$> | 54     |        | <$Comment$> |
	When User waits "2" seconds
	When User "refresh" the browser
	# User updating Transaction DTO date to pick the patron
	When User executes query "Update [EB].[Transactions] set TransactionDTO='2021-09-12 01:40:55.4989602 -08:00' where PlayerID= <$REAL_PLAYER_ID$>" with connection "<#Halo_db_connectionstring#>"
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

Scenario: 002 Excluding Adjusments on the account
	#User search player archival under player function
	# User login web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Player Archival" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylPlayer_Function.lnk_player_archival"
	When User waits "2" seconds
	#User provide input in Config tab under Player Archival
	Given User selects option "Adjustments" of element "lylPlayer_Archival.mic_exclude_activities_dropdown" by "visibletext"
	Given User clicks on "lylPlayer_Archival.btn_deassign_act"
	Given User clicks on "lylPlayer_Archival.btn_save"
	When User waits "1" seconds

Scenario Outline: 003 - Creation of Schedule and Execution of Player Archive Schedule Job
	#User search player archival under player function
	# User login web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Player Archival" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylPlayer_Function.lnk_player_archival"
	When User waits "2" seconds
	#User provide input in Config tab under Player Archival
	Given User selects option "<Include_Activity>" of element "lylPlayer_Archival.mic_includedactivities_dropdown" by "visibletext"
	Given User clicks on "lylPlayer_Archival.btn_include_act"
	When User waits "1" seconds
	Given User clicks on "lylPlayer_Archival.txt_inactivity_days"
	Given User clears "lylPlayer_Archival.txt_inactivity_days"
	Given User enters text "<Inactivity_Days>" in "lylPlayer_Archival.txt_inactivity_days"
	Given User selects option "<Exceed_Freq>" of element "lylPlayer_Archival.mic_dropdown_days_selection" by "visibletext"
	Given User clicks on "lylPlayer_Archival.btn_save"
	When User waits "1" seconds
	#User make changes in ArchiveRuleExecutionLogs to run Job
	When User runs query "Select ArchiveRuleExecutionLogID from ArchiveRuleExecutionLogs Order By ArchiveRuleExecutionLogID Desc OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY" with connection "<#Halo_db_connectionstring#>" and save with key "ArchiveRuleExecutionLogID"
	When User executes query "Update ArchiveRuleExecutionLogs set ExecutionDTO=format(cast(DATEADD(DAY,-2,GETDATE()) AS DATE), 'MM/dd/yyyy') Where ArchiveRuleExecutionLogID = <$ArchiveRuleExecutionLogID$>" with connection "<#Halo_db_connectionstring#>"
	#User provide input in Schedule tab under Player Archival
	Given User clicks on "lylPlayer_Archival.lnk_Schedule"
	When User waits "1" seconds
	Given User clicks on "lylPlayer_Archival.rdb_schedule_option" with parameters
		| Key         | Value               |
		| Radio_Value | One Time Occurrence |
	#User find current Date and Time
	When User runs query "SELECT CONVERT(VARCHAR(10), CAST(DATEADD(minute,-4,GETDATE()) AS TIME), 0)  AS Schedule_Time" with connection "<#Halo_db_connectionstring#>" and save with key "Schedule_Time"
	When User runs query "SELECT format(cast(GETDATE() AS DATE), 'MM/dd/yyyy') AS Schedule_Day" with connection "<#Halo_db_connectionstring#>" and save with key "Schedule_Day"
	Given User clears "lylPlayer_Archival.mic_Date"
	Given User enters text "<schedule_day>" in "lylPlayer_Archival.mic_Date"
	Given User clears "lylPlayer_Archival.mic_time"
	Given User enters text "<schedule_time>" in "lylPlayer_Archival.mic_time"
	Given User clicks on "lylPlayer_Archival.btn_save"
	When User waits "1" seconds
	# Running Player Archive Schedule Job
	When User waits "3" seconds
	When User execute command "<PlayerArchiveScheduleJobPath>" on system "<#TaskCoordIP#>"

	Examples:
		| Include_Activity | Inactivity_Days | Exceed_Freq | schedule_day     | schedule_time     | PlayerArchiveScheduleJobPath                                                                                               |
		| Adjustments      | 180             | Days        | <$Schedule_Day$> | <$Schedule_Time$> | C:\Program Files\Aristocrat\OASIS LOYALTY\TaskCoordinator\PlayerArchivalSchedule\OasisLoyalty.PlayerArchiveScheduleJob.exe |

Scenario: 004 -Verify Archiving of Deceased players (TC ID - 460260 )
	# User login web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User include Archived account using checkbox in search list
	When User waits "60" seconds
	Given User clicks on "lylPlayer_Search.btn_search_dropdown"
	Given User clicks on "lylPlayer_Search.btn_chck_arch_accnt"
	When User waits "1" seconds
	#User search player archival status under player function
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	#User process Archival on the player
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI