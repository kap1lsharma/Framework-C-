@Release_15.0 @Group_Player_Archival @Transportation_Management @Web
Feature: OL_AR_Transportation_Management Verify Exclude archived accounts from Transportation Management Groups

#******************************************************************************************************
#** Feature File                    : OL_AR_Transportation_Management
#** Feature Name                    : Verify Exclude archived accounts from Transportation Management Groups
#** Defect/Bug Linked(if any)       : 593699,594103
#** TFS TC ID Linked                : 470195,470100
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  30/05/2022           Ajay Dahiya
#**************************************************************************************************/
Scenario Outline: 001 Making Test Data For Offer provided on Archived Player
	#User login to web-app
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User enroll a player in web-app
	When User generates a "UniqueString" with "AjayPlayer_:4" for key "FirstName"
	When User waits "2" seconds
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	When User waits "2" seconds
	When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID =  '<$PLAYER_ID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "FIRST_NAME"
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

	Examples:
		| archive_reason           | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |

Scenario Outline: 002-Verify that Archived accounts can not be added to a Transportation Management group. (TC ID - 470100 ) (Bug Id - 593699 )
	#User login to web-app
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Transportation Management" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.TRANSPORATION_MANAGEMENT_LINK"
	#Add Agreement.
	Given User switches to frame "default"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.AGREEMENTS_LINK"
	When User waits "1" seconds
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.AGREEMENTS_FRAME"
	When User waits "1" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.ADD_AGREEMENT_BUTTON"
	When User waits "1" seconds
	Given User switches to frame "default"
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.ADD_NEW_AGREEMENT_FRAME"
	When User waits "1" seconds
	When User generates a "UniqueString" with "Agreement_Auto_:4" for key "agreementName"
	Given User enters text "<$agreementName$>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_NAME_TEXTBOX"
	Given User enters text "<agreementDesc>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_DESCRIPTION_TEXTBOX"
	Given User enters text "<tourCost>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_TOURCOST_TEXTBOX"
	Given User enters text "<originCity>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_ORIGINCITY_TEXTBOX"
	Given User selects option "<$PropertyName$>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_DESTINATION_DROPDOWN" by "visibletext"
	Given User selects option "<#Transportation_Operator#>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_OPERATOR_DROPDOWN" by "visibletext"
	Given User enters text "<benefitsDescription>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_BENEFITS_DESCRIPTION_TEXTBOX"
	Given User selects option "<#Transportation_Carrier#>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_CARRIER_DROPDOWN" by "visibletext"
	Given User enters text "<maxPassengers>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_PASSEN_TEXTBOX"
	Given User enters text "<charterNumber>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_CHARTER_TEXTBOX"
	When User waits "2" seconds
	# Create a schedule
	When User generates a "UniqueString" with "Schedule_Auto:4" for key "SCHEDULE_NAME"
	Given User enters text "^$SCHEDULE_NAME$^" in "TRANSPORTATION_MANAGEMENT.SCHEDULE_NAME_TEXTBOX"
	When User waits "2" seconds
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "DBcurrenttime"
	And User performs action "adddays" of "3" on dateTime "<$DBcurrenttime$>" with format "MM/dd/yyyy" to save the result for key "EndDate"
	Given User enters text "<$DBcurrenttime$>" in "TRANSPORTATION_MANAGEMENT.Schedule_StartDate"
	Given User enters text "<startTime>" in "TRANSPORTATION_MANAGEMENT.ARRIVALTIME_TEXTBOX"
	When User waits "2" seconds
	Given User enters text "<$EndDate$>" in "TRANSPORTATION_MANAGEMENT.Schedule_EndDate"
	Given User enters text "<endTime>" in "TRANSPORTATION_MANAGEMENT.DEPARTTIME_TEXTBOX"
	When User waits "2" seconds
	When User scrolls till element "TRANSPORTATION_MANAGEMENT.CHK_PROMO"
	When User waits "2" seconds
	Then User "checks" element "TRANSPORTATION_MANAGEMENT.CHK_PROMO"
	When User waits "2" seconds
	Given User enters text "20" in "TRANSPORTATION_MANAGEMENT.TXT_PROMO"
	When User waits "2" seconds
	Given User enters text "2" in "TRANSPORTATION_MANAGEMENT.TXT_EXPIRATION"
	When User waits "2" seconds
	When User scrolls till element "TRANSPORTATION_MANAGEMENT.LETTER_TEMPLATE_DROPDOWN"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.LETTER_TEMPLATE_DROPDOWN"
	When User waits "4" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.Letter_Temp_option" with parameters
		| Key     | Value                       |
		| options | <#Transportation_Template#> |
	When User waits "4" seconds
	Given User enters text "2" in "TRANSPORTATION_MANAGEMENT.TXT_MEALS"
	Given User enters text "2" in "TRANSPORTATION_MANAGEMENT.TXT_CO_OP"
	Given User enters text "2" in "TRANSPORTATION_MANAGEMENT.TXT_OTHER_DEBT"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnAddschedule"
	When User waits "4" seconds
	When User scrolls till element "TRANSPORTATION_MANAGEMENT.SAVE_SCHEDULE_BUTTON"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.SAVE_SCHEDULE_BUTTON"
	When User waits "2" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.BTN_OK"
	Given User switches to frame "default"
	When User waits "2" seconds
	When User "refresh" the browser
	When User waits "2" seconds
	#Move on to Schedule tab add a player and mark that Arrived.
	When User waits "1" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkSchedules"
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.AGREEMENTS_FRAME"
	When User waits "1" seconds
	# First schedule making in arrived status
	Given User clicks on "TRANSPORTATION_MANAGEMENT.tblSchedulerow" with parameters
		| Key            | Value                      |
		| startDateValue |                            |
		| arrivalTime    |                            |
		| endDateValue   |                            |
		| departTime     |                            |
		| confirmNo      |                            |
		| carrierText    | <#Transportation_Carrier#> |
		| manifestValue  |                            |
		| offerText      |                            |
		| schStatus      | Pending                    |
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnView"
	When User waits "1" seconds
	Given User switches to frame "default"
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.ADD_NEW_AGREEMENT_FRAME"
	When User waits "1" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnEdit"
	When User waits "2" seconds
	Given User selects option "Arrived" of element "TRANSPORTATION_MANAGEMENT.lstStatusschedule" by "visibletext"
	When User waits "1" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnArrivedok"
	When User waits "1" seconds
	#Adding a Player to Schedule
	When User scrolls till element "TRANSPORTATION_MANAGEMENT.ADD_PLAYER_BUTTON"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.ADD_PLAYER_BUTTON"
	Given User switches to frame "default"
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.SEARCH_PLAYER_FRAME"
	Given User enters text "<#ArchivePlayer#>" in "TRANSPORTATION_MANAGEMENT.SEARCH_UNIVERSALID_TEXTBOX"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.SEARCH_UNIVERSALID_BUTTON"
	When User waits "2" seconds
	Given User clicks on "OLW_Transportation_M.tbl_grid_data" with parameters
		| Key       | Value    |
		| fName     | Test     |
		| lName     | Pin      |
		| playerDOB | 1/1/1990 |
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnSelecttour"
	When User waits "4" seconds
	When User gets attribute "getText" value of "OLW_Transportation_M.txt_archive_err_messge" element to save with key "messagearchivepatron"
	When User performs string operation "stringEquals" of provided value "<$messagearchivepatron$>" with "<archivepatronerror>"
	Given User clicks on "OLW_Transportation_M.btn_Conflit_ok"

	Examples:
		| startTime | endTime   | benefitsDescription | expDate  | charterNumber | maxPassengers | originCity | tourCost | agreementDesc  | archivepatronerror         |
		| 12:01  AM | 10:00  PM | Benefit Description | 4/4/2019 | 9             | 5             | Dallas     | 20       | Agreement Desc | ERROR - ARCHIVED PATRON(S) |

Scenario Outline: 003 Verify that users receives an archive specific error if there is an archived account on the list to upload to a transportation management group. (TC ID - 470195 ) (Defect ID - 594103 )
	#User login to web-app
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Transportation Management" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.TRANSPORATION_MANAGEMENT_LINK"
	#Add Agreement.
	Given User switches to frame "default"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.AGREEMENTS_LINK"
	When User waits "1" seconds
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.AGREEMENTS_FRAME"
	When User waits "1" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.ADD_AGREEMENT_BUTTON"
	When User waits "1" seconds
	Given User switches to frame "default"
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.ADD_NEW_AGREEMENT_FRAME"
	When User waits "1" seconds
	When User generates a "UniqueString" with "Agreement_Auto_:4" for key "agreementName"
	Given User enters text "<$agreementName$>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_NAME_TEXTBOX"
	Given User enters text "<agreementDesc>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_DESCRIPTION_TEXTBOX"
	Given User enters text "<tourCost>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_TOURCOST_TEXTBOX"
	Given User enters text "<originCity>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_ORIGINCITY_TEXTBOX"
	Given User selects option "<$PropertyName$>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_DESTINATION_DROPDOWN" by "visibletext"
	Given User selects option "<#Transportation_Operator#>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_OPERATOR_DROPDOWN" by "visibletext"
	Given User enters text "<benefitsDescription>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_BENEFITS_DESCRIPTION_TEXTBOX"
	Given User selects option "<#Transportation_Carrier#>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_CARRIER_DROPDOWN" by "visibletext"
	Given User enters text "<maxPassengers>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_PASSEN_TEXTBOX"
	Given User enters text "<charterNumber>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_CHARTER_TEXTBOX"
	When User waits "2" seconds
	# Create a schedule
	When User generates a "UniqueString" with "Schedule_Auto:4" for key "SCHEDULE_NAME"
	Given User enters text "^$SCHEDULE_NAME$^" in "TRANSPORTATION_MANAGEMENT.SCHEDULE_NAME_TEXTBOX"
	When User waits "2" seconds
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "DBcurrenttime"
	And User performs action "adddays" of "3" on dateTime "<$DBcurrenttime$>" with format "MM/dd/yyyy" to save the result for key "EndDate"
	Given User enters text "<$DBcurrenttime$>" in "TRANSPORTATION_MANAGEMENT.Schedule_StartDate"
	Given User enters text "<startTime>" in "TRANSPORTATION_MANAGEMENT.ARRIVALTIME_TEXTBOX"
	When User waits "2" seconds
	Given User enters text "<$EndDate$>" in "TRANSPORTATION_MANAGEMENT.Schedule_EndDate"
	Given User enters text "<endTime>" in "TRANSPORTATION_MANAGEMENT.DEPARTTIME_TEXTBOX"
	When User waits "2" seconds
	When User scrolls till element "TRANSPORTATION_MANAGEMENT.CHK_PROMO"
	When User waits "2" seconds
	Then User "checks" element "TRANSPORTATION_MANAGEMENT.CHK_PROMO"
	When User waits "2" seconds
	Given User enters text "20" in "TRANSPORTATION_MANAGEMENT.TXT_PROMO"
	When User waits "2" seconds
	Given User enters text "2" in "TRANSPORTATION_MANAGEMENT.TXT_EXPIRATION"
	When User waits "2" seconds
	When User scrolls till element "TRANSPORTATION_MANAGEMENT.LETTER_TEMPLATE_DROPDOWN"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.LETTER_TEMPLATE_DROPDOWN"
	When User waits "4" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.Letter_Temp_option" with parameters
		| Key     | Value                       |
		| options | <#Transportation_Template#> |
	When User waits "4" seconds
	Given User enters text "2" in "TRANSPORTATION_MANAGEMENT.TXT_MEALS"
	Given User enters text "2" in "TRANSPORTATION_MANAGEMENT.TXT_CO_OP"
	Given User enters text "2" in "TRANSPORTATION_MANAGEMENT.TXT_OTHER_DEBT"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnAddschedule"
	When User waits "4" seconds
	When User scrolls till element "TRANSPORTATION_MANAGEMENT.SAVE_SCHEDULE_BUTTON"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.SAVE_SCHEDULE_BUTTON"
	When User waits "2" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.BTN_OK"
	Given User switches to frame "default"
	When User waits "2" seconds
	When User "refresh" the browser
	When User waits "2" seconds
	#Move on to Schedule tab add a player and mark that Arrived.
	When User waits "1" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkSchedules"
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.AGREEMENTS_FRAME"
	When User waits "1" seconds
	# First schedule making in arrived status
	Given User clicks on "TRANSPORTATION_MANAGEMENT.tblSchedulerow" with parameters
		| Key            | Value                      |
		| startDateValue |                            |
		| arrivalTime    |                            |
		| endDateValue   |                            |
		| departTime     |                            |
		| confirmNo      |                            |
		| carrierText    | <#Transportation_Carrier#> |
		| manifestValue  |                            |
		| offerText      |                            |
		| schStatus      | Pending                    |
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnView"
	When User waits "1" seconds
	Given User switches to frame "default"
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.ADD_NEW_AGREEMENT_FRAME"
	When User waits "1" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnEdit"
	When User waits "2" seconds
	Given User selects option "Arrived" of element "TRANSPORTATION_MANAGEMENT.lstStatusschedule" by "visibletext"
	When User waits "1" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnArrivedok"
	When User waits "1" seconds
	#Importing File in Schedule contains Archive Player
	When User scrolls till element "OLW_Transportation_M.btn_Import_File"
	Given User clicks on "OLW_Transportation_M.btn_Import_File"
	Given User switches to frame "default"
	Given User switches to frame "OLW_Transportation_M.frm_BrowseFile"
	When User generates a "UniqueString" with "BulkArchivePlayers:4" for key "BulkArchivePlayers"
	When User "creates" excel file "<$BulkArchivePlayers$>" with sheet "PlayerArchiveSample" in "csv" format with data
		| Patron Universal ID |
		| <$PLAYER_ID$>       |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	When User waits "2" seconds
	Given User enters text "<$testbaseLocation$>\<$BulkArchivePlayers$>.csv" in "OLW_Transportation_M.btn_FileuploadPlayer"
	When User waits "4" seconds
	Given User clicks on "OLW_Transportation_M.btn_Ok_Fileupload"
	When User gets attribute "getText" value of "OLW_Transportation_M.txt_archive_err_messge" element to save with key "messagearchivepatron"
	When User performs string operation "stringEquals" of provided value "<$messagearchivepatron$>" with "<archivepatronerror>"
	Given User clicks on "OLW_Transportation_M.btn_Conflit_ok"

	Examples:
		| startTime | endTime   | benefitsDescription | expDate  | charterNumber | maxPassengers | originCity | tourCost | agreementDesc  | archivepatronerror         |
		| 12:01  AM | 10:00  PM | Benefit Description | 4/4/2019 | 9             | 5             | Dallas     | 20       | Agreement Desc | ERROR - ARCHIVED PATRON(S) |