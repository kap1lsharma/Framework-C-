@Release_15.0@Report@Web@Group_Player_Archival
Feature: OL_AR_Account_Access_Report Verify Inactive Row is getting reflected on archived account

#******************************************************************************************************
#** Feature File                    : OL_AR_Account_Access_Report
#** Feature Name                    : Verify archival row is getting added for archived patron
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 449172
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  11/07/2022           Ajay Dahiya              Initial Draft
#**************************************************************************************************/
Scenario Outline: 001 Making Test Data when User is able to archive player
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

	Examples:
		| archive_reason           | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |

Scenario:002  - Validate the Header of Account Access Report(Tc 449172 )
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Account Access Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                 |
		| ReportName | Account Access Report |
	#Verify Private Filter exist in report
	Then User verifies that element "OLW_Acnt_Status_Chng.txt_Universal_Id" is present "true" on UI
	Given User enters text "<$PLAYER_ID$>" in "OLW_Acnt_Status_Chng.txt_Universal_Id"
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_Acnt_Access_RPT.txt_Account_Access_Report" is present "true" on UI
	#Verify in Details Header Private column has added
	Then User verifies that element "OLW_Acnt_Access_RPT.tbl_Details_Column" is present "true" on UI with parameters
		| Key              | Value            |
		| Access_Date_Time | Access Date Time |
		| Universal_ID     | Universal ID     |
		| Player_Name      | Player Name      |
		| Player_Property  | Player Property  |
		| User             | User             |
		| Account_Status   | Account Status   |
		| Failed           | Failed           |
		| Comments         | Comments         |

Scenario Outline:003  - Validate Details section is displaying a row with ARCHIVED as Account Status (Tc 449172 )
	#Get Current Date
	When User generates a "getDate" with "yyyy-MM-dd hh:mm:ss" for key "currendate"
	#Update Reserved Date Time
	When User performs action "subtractdays" of "1" on dateTime "<$currendate$>" with format "yyyy-MM-dd hh:mm:ss" to save the result for key "LogDateTime"
	When User executes query "update UC_AUD_PlayerAccessLog set LogDateTime = '<$LogDateTime$>'  where UniversalPlayerID = '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>"
	#Date of Archival Processed
	When User runs query "select  Top(1) FORMAT( LogDateTime,'M/d/yyyy h:mm tt')  from UC_AUD_PlayerAccessLog where UniversalPlayerID = '<$PLAYER_ID$>' order by LogDateTime desc" with connection "<#Halo_db_connectionstring#>" and save with key "LatestLogDate"
	When User runs query "select  Top(1) Trim(AccountStatus)  from UC_AUD_PlayerAccessLog where UniversalPlayerID = '<$PLAYER_ID$>' order by LogDateTime desc" with connection "<#Halo_db_connectionstring#>" and save with key "AccountStatus"
	When User runs query "select  Top(1) Comments  from UC_AUD_PlayerAccessLog where UniversalPlayerID = '<$PLAYER_ID$>' order by LogDateTime desc" with connection "<#Halo_db_connectionstring#>" and save with key "Comments"
	#User set PropertyID
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	##get firstname and last name
	When User runs query "select lastname from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "Lastname"
	When User runs query "select FirstName from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName"
	When User saves string operation "append" of provided value "<$Lastname$>" with ", " to key "Lastnameupdated"
	When User saves string operation "append" of provided value "<$Lastnameupdated$>" with " <$FirstName$>" to key "PlayerName"
	# User login from Web-App
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Account Access Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                 |
		| ReportName | Account Access Report |
	#Verify Private Filter exist in report
	Then User verifies that element "OLW_Acnt_Status_Chng.txt_Universal_Id" is present "true" on UI
	Given User enters text "<$PLAYER_ID$>" in "OLW_Acnt_Status_Chng.txt_Universal_Id"
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_Acnt_Access_RPT.txt_Account_Access_Report" is present "true" on UI
	#Verify in Details Data of the Archived Player column has added
	Then User verifies that element "OLW_Acnt_Access_RPT.tbl_Details_Column_Account_Sts" is present "true" on UI with parameters
		| Key              | Value             |
		| Access_Date_Time | <$LatestLogDate$> |
		| Universal_ID     | <$PLAYER_ID$>     |
		| Player_Name      | <$PlayerName$>    |
		| Player_Property  | <$PropertyName$>  |
		| User             | <#Halo_username#> |
		| Account_Status   | <$AccountStatus$> |
		| Comments         | <$Comments$>      |

Scenario Outline: 004 Making Test Data when User is able to recover the archived player
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User execute query to make change in Stopcodestatus for O value to process Recovery of Player
	When User executes query "Update PlayerArchivingDetails set StopCodeStatus='P' where playerid=<$REAL_PLAYER_ID$> and StopCodeStatus = 'T'" with connection "<#Halo_db_connectionstring#>"
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
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI
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

	Examples:
		| recover_reason | Comment_For_Recover       |
		| Employee Error | Comment Line For Recovery |

Scenario:005  - Validate the Header of Account Access Report for recover player(Tc 449172 )
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Account Access Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                 |
		| ReportName | Account Access Report |
	#Verify Private Filter exist in report
	Then User verifies that element "OLW_Acnt_Status_Chng.txt_Universal_Id" is present "true" on UI
	Given User enters text "<$PLAYER_ID$>" in "OLW_Acnt_Status_Chng.txt_Universal_Id"
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_Acnt_Access_RPT.txt_Account_Access_Report" is present "true" on UI
	#Verify in Details Header Private column has added
	Then User verifies that element "OLW_Acnt_Access_RPT.tbl_Details_Column" is present "true" on UI with parameters
		| Key              | Value            |
		| Access_Date_Time | Access Date Time |
		| Universal_ID     | Universal ID     |
		| Player_Name      | Player Name      |
		| Player_Property  | Player Property  |
		| User             | User             |
		| Account_Status   | Account Status   |
		| Failed           | Failed           |
		| Comments         | Comments         |

Scenario Outline:006  - Validate Details section is displaying a row with ARCHIVED as Account Status (Tc 449172 )
	#Get Current Date
	When User generates a "getDate" with "yyyy-MM-dd hh:mm:ss" for key "currendate"
	#Update Reserved Date Time
	When User performs action "subtractdays" of "1" on dateTime "<$currendate$>" with format "yyyy-MM-dd hh:mm:ss" to save the result for key "LogDateTime"
	When User executes query "update UC_AUD_PlayerAccessLog set LogDateTime = '<$LogDateTime$>'  where UniversalPlayerID = '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>"
	#Date of Archival Processed
	When User runs query "select  Top(1) FORMAT( LogDateTime,'M/d/yyyy h:mm tt')  from UC_AUD_PlayerAccessLog where UniversalPlayerID = '<$PLAYER_ID$>' order by LogDateTime desc" with connection "<#Halo_db_connectionstring#>" and save with key "LatestLogDate"
	When User runs query "select  Top(1) Trim(AccountStatus)  from UC_AUD_PlayerAccessLog where UniversalPlayerID = '<$PLAYER_ID$>' order by LogDateTime desc" with connection "<#Halo_db_connectionstring#>" and save with key "AccountStatus"
	When User runs query "select  Top(1) Comments  from UC_AUD_PlayerAccessLog where UniversalPlayerID = '<$PLAYER_ID$>' order by LogDateTime desc" with connection "<#Halo_db_connectionstring#>" and save with key "Comments"
	#User set PropertyID
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	##get firstname and last name
	When User runs query "select lastname from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "Lastname"
	When User runs query "select FirstName from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName"
	When User saves string operation "append" of provided value "<$Lastname$>" with ", " to key "Lastnameupdated"
	When User saves string operation "append" of provided value "<$Lastnameupdated$>" with " <$FirstName$>" to key "PlayerName"
	# User login from Web-App
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Account Access Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                 |
		| ReportName | Account Access Report |
	#Verify Private Filter exist in report
	Then User verifies that element "OLW_Acnt_Status_Chng.txt_Universal_Id" is present "true" on UI
	Given User enters text "<$PLAYER_ID$>" in "OLW_Acnt_Status_Chng.txt_Universal_Id"
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_Acnt_Access_RPT.txt_Account_Access_Report" is present "true" on UI
	#Verify in Details Data of the Archived Player column has added
	Then User verifies that element "OLW_Acnt_Access_RPT.tbl_Details_Column_Account_Sts" is present "true" on UI with parameters
		| Key              | Value             |
		| Access_Date_Time | <$LatestLogDate$> |
		| Universal_ID     | <$PLAYER_ID$>     |
		| Player_Name      | <$PlayerName$>    |
		| Player_Property  | <$PropertyName$>  |
		| User             | <#Halo_username#> |
		| Account_Status   | <$AccountStatus$> |
		| Comments         | <$Comments$>      |