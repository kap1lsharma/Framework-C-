@Release15.0@Player_Archival@Upload_Players_Archive@Web
Feature: OL_AR_Upload_Players_Archive

#***************************************************************************************************************
#**  Feature File                 : OL_AR_Upload_Players_Archive.feature
#**  Feature Name                 : Upload Players Archive
#**  Defect/Bug Linked(if any)    : 593623
#**  TFS TC ID Linked             : 459026,459029,459030,459108,459121,459123,459230,459228,459626,459627,465675
#**************************************************************************************************************/
#**  Created Date:          Author:                  #Comments
#**  17/05/2022            Vijay Pratap Singh
#*************************************************************************************************************/
Scenario: 001 Verify that users with PLAYERBULKARCHIVE permission should be able to access the Upload Players tab. (TC 459026)
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	Given User clicks on "MAIN_NAV_BOX.GROUP_PERMISSIONS_LINK"
	#User navigate to ARCHIVEPLAYER permission under Group Permission
	Given User selects option "<#Halo_ADGroup#>" of element "USER_GROUP_PERMISSIONS.USER_GROUP_DROPDOWN" by "visibletext"
	Given User clicks on "USER_GROUP_PERMISSIONS.EDIT_FUNCTIONS_BUTTON"
	Given User clears "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User enters text "PLAYERBULKARCHIVE" in "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User clicks on "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_BUTTON"
	#User checks PLAYERBULKARCHIVE Permisison is Checked.
	Then User verifies attribute "title" value "Checked" of element "USER_GROUP_PERMISSIONS.PERMISSION_NAME_CHECKBOX" with parameters
		| Key            | Value             |
		| permissionname | PLAYERBULKARCHIVE |
	#User check Upload Players tab in WebApp
	Given User enters text "Player Archival" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archival"
	Then User verifies that element "lylPlayer_Archival.lnk_Upload_Players" is present "true" on UI

Scenario: 002 Verify that users with no PLAYERBULKARCHIVE permission will not be able to access the Upload Players tab. (TC 459029)
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	Given User clicks on "MAIN_NAV_BOX.GROUP_PERMISSIONS_LINK"
	#User navigate to ARCHIVEPLAYER permission under Group Permission
	Given User selects option "<#Halo_ADGroup_1#>" of element "USER_GROUP_PERMISSIONS.USER_GROUP_DROPDOWN" by "visibletext"
	Given User clicks on "USER_GROUP_PERMISSIONS.EDIT_FUNCTIONS_BUTTON"
	Given User clears "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User enters text "PLAYERBULKARCHIVE" in "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User clicks on "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_BUTTON"
	#User Uncheck PLAYERBULKARCHIVE Permisison.
	Then User "Unchecks" element "USER_GROUP_PERMISSIONS.PERMISSION_NAME_CHECKBOX" with parameters
		| Key            | Value             |
		| permissionname | PLAYERBULKARCHIVE |
	#User save permission
	When User scrolls till element "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	Given User clicks on "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	Then User verifies text - "Permissions Saved" is present on page
	#User check Upload Players tab in WebApp
	Given User enters text "Player Archival" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archival"
	Then User verifies that element "lylPlayer_Archival.lnk_Upload_Players" is present "false" on UI

Scenario: 003 Verify the screen layout of Upload Players tab (TC 459030)
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User navigte to Upload Players tab in WebApp
	Given User enters text "Player Archival" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archival"
	Given User clicks on "lylPlayer_Archival.lnk_Upload_Players"
	#Verify Upload File,Download Sample,Total Records,No of Processed Records,No of Processed Records,No of Error Records,Error File text
	Then User verifies text - "Upload File" is present on page
	Then User verifies text - "Download Sample" is present on page
	Then User verifies text - "Total Records" is present on page
	Then User verifies text - "No of Processed Records" is present on page
	Then User verifies text - "No of Error Records" is present on page
	Then User verifies text - " Error File" is present on page
	#Check Add Archive, Do not Archive, Cancel, Recover button
	Then User verifies that element "lylPlayer_Archival.btn_Archive" is present "true" on UI
	Then User verifies that element "lylPlayer_Archival.btn_Donot_Archive" is present "true" on UI
	Then User verifies that element "lylPlayer_Archival.btn_Cancel_Upload_player" is present "true" on UI
	Then User verifies that element "lylPlayer_Archival.btn_Recover" is present "true" on UI

Scenario: 004 Verify the functionality of Upload File (TC 459108)
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#Enroll Player
	When User generates a "RandomAlphabetic" with "5" for key "player_name"
	When Loyalty User Enroll Player via Webapp with "<$player_name$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	#User navigte to Upload Players tab in WebApp
	Given User enters text "Player Archival" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archival"
	Given User clicks on "lylPlayer_Archival.lnk_Upload_Players"
	#User create and upload excel file
	When  User generates a "UniqueString" with "BulkArchivePlayers:3" for key "BulkArchivePlayers"
	When User "creates" excel file "<$BulkArchivePlayers$>" with sheet "PlayerArchiveSample" in "xlsx" format with data
		| Universal IDs |
		| <$PLAYER_ID$> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User enters text "<$testbaseLocation$>\<$BulkArchivePlayers$>.xlsx" in "lylPlayer_Archival.btn_Choose_File"
	#User clicks on "Archive button"
	Given User clicks on "lylPlayer_Archival.btn_Archive"
	#Vaidate Data on Grid
	Then User verifies that element "lylPlayer_Archival.mic_Upload_File_Success_Grid" is present "true" on UI with parameters
		| Key                     | Value |
		| Total Records           | 1     |
		| No of Processed Records | 1     |
		| No of Error Records     | 0     |
		| Error File              |       |
	#Check error message if user tries to upload a file other than .xlsx file
	When  User generates a "UniqueString" with "BulkArchivePlayers:4" for key "BulkArchivePlayers"
	When User "creates" excel file "<$BulkArchivePlayers$>" with sheet "PlayerArchiveSample" in "xls" format with data
		| Universal IDs |
		| <$PLAYER_ID$> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User enters text "<$testbaseLocation$>\<$BulkArchivePlayers$>.xls" in "lylPlayer_Archival.btn_Choose_File"
	Given User clicks on "lylPlayer_Archival.btn_Archive"
	Then User verifies text - "Please select valid .xlsx file" is present on page
	Given User enters text "<$testbaseLocation$>\<$BulkArchivePlayers$>.xls" in "lylPlayer_Archival.btn_Choose_File"
	Given User clicks on "lylPlayer_Archival.btn_Donot_Archive"
	Then User verifies text - "Please select valid .xlsx file" is present on page

Scenario: 005 Verify the functionality of Grid for invalid list of Players (TC 459121)
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#Enroll Player
	When User generates a "RandomAlphabetic" with "5" for key "player_name"
	When Loyalty User Enroll Player via Webapp with "<$player_name$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	#User navigte to Upload Players tab in WebApp
	Given User enters text "Player Archival" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archival"
	Given User clicks on "lylPlayer_Archival.lnk_Upload_Players"
	#User create and upload excel file
	When  User generates a "UniqueString" with "BulkArchivePlayers:3" for key "BulkArchivePlayers"
	When User "creates" excel file "<$BulkArchivePlayers$>" with sheet "PlayerArchiveSample" in "xlsx" format with data
		| Universal IDs |
		| <PLAYER_ID>   |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User enters text "<$testbaseLocation$>\<$BulkArchivePlayers$>.xlsx" in "lylPlayer_Archival.btn_Choose_File"
	#User clicks on "Archive button"
	Given User clicks on "lylPlayer_Archival.btn_Archive"
	#Vaidate Data on Grid
	Then User verifies that element "lylPlayer_Archival.mic_Upload_File_Error_Grid" is present "true" on UI with parameters
		| Key                     | Value      |
		| Total Records           | 1          |
		| No of Processed Records | 0          |
		| No of Error Records     | 1          |
		| Error File              | Error File |

Scenario: 006 Verify the functionality of Do not Archive, Add Archive button (TC 459123,459228)
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#Enroll Player
	When User generates a "RandomAlphabetic" with "5" for key "player_name"
	When Loyalty User Enroll Player via Webapp with "<$player_name$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	#User navigte to Upload Players tab in WebApp
	Given User enters text "Player Archival" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archival"
	Given User clicks on "lylPlayer_Archival.lnk_Upload_Players"
	#User create and upload excel file
	When  User generates a "UniqueString" with "BulkArchivePlayers:3" for key "BulkArchivePlayers"
	When User "creates" excel file "<$BulkArchivePlayers$>" with sheet "PlayerArchiveSample" in "xlsx" format with data
		| Universal IDs |
		| <$PLAYER_ID$> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User enters text "<$testbaseLocation$>\<$BulkArchivePlayers$>.xlsx" in "lylPlayer_Archival.btn_Choose_File"
	#User clicks on Do not Archive button
	Given User clicks on "lylPlayer_Archival.btn_Donot_Archive"
	#Vaidate Data on Grid
	Then User verifies that element "lylPlayer_Archival.mic_Upload_File_Success_Grid" is present "true" on UI with parameters
		| Key                     | Value |
		| Total Records           | 1     |
		| No of Processed Records | 1     |
		| No of Error Records     | 0     |
		| Error File              |       |
	#User click on Archive selecting same file
	Given User enters text "<$testbaseLocation$>\<$BulkArchivePlayers$>.xlsx" in "lylPlayer_Archival.btn_Choose_File"
	Given User clicks on "lylPlayer_Archival.btn_Archive"
	#Vaidate Data on Grid
	Then User verifies that element "lylPlayer_Archival.mic_Upload_File_Error_Grid" is present "true" on UI with parameters
		| Key                     | Value      |
		| Total Records           | 1          |
		| No of Processed Records | 0          |
		| No of Error Records     | 1          |
		| Error File              | Error File |

Scenario: 007 Verify uploading already archived player record is considered as error record. (TC 459123)
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#Enroll Player
	When User generates a "RandomAlphabetic" with "5" for key "player_name"
	When Loyalty User Enroll Player via Webapp with "<$player_name$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	#User navigte to Upload Players tab in WebApp
	Given User enters text "Player Archival" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archival"
	Given User clicks on "lylPlayer_Archival.lnk_Upload_Players"
	#User create and upload excel file
	When  User generates a "UniqueString" with "BulkArchivePlayers:3" for key "BulkArchivePlayers"
	When User "creates" excel file "<$BulkArchivePlayers$>" with sheet "PlayerArchiveSample" in "xlsx" format with data
		| Universal IDs |
		| <$PLAYER_ID$> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User enters text "<$testbaseLocation$>\<$BulkArchivePlayers$>.xlsx" in "lylPlayer_Archival.btn_Choose_File"
	#User clicks on Archive button
	Given User clicks on "lylPlayer_Archival.btn_Archive"
	#Vaidate Data on Grid
	Then User verifies that element "lylPlayer_Archival.mic_Upload_File_Success_Grid" is present "true" on UI with parameters
		| Key                     | Value |
		| Total Records           | 1     |
		| No of Processed Records | 1     |
		| No of Error Records     | 0     |
		| Error File              |       |
	#Uploading already archived player
	Given User enters text "<$testbaseLocation$>\<$BulkArchivePlayers$>.xlsx" in "lylPlayer_Archival.btn_Choose_File"
	#User clicks on Archive button
	Given User clicks on "lylPlayer_Archival.btn_Archive"
	#Vaidate Data on Grid
	Then User verifies that element "lylPlayer_Archival.mic_Upload_File_Error_Grid" is present "true" on UI with parameters
		| Key                     | Value      |
		| Total Records           | 1          |
		| No of Processed Records | 0          |
		| No of Error Records     | 1          |
		| Error File              | Error File |
	#User clicks on Add Archive without selecting file.
	Given User clicks on "lylPlayer_Archival.lnk_Upload_Players"
	Given User clicks on "lylPlayer_Archival.btn_Archive"
	Then User verifies text - "Please select valid .xlsx file" is present on page
	#User clicks on Do not Archive without selecting file.
	Given User clicks on "lylPlayer_Archival.btn_Donot_Archive"
	Then User verifies text - "Please select valid .xlsx file" is present on page

Scenario: 008 Verify the functionality of Cancel button. (TC 459230)
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#Enroll Player
	When User generates a "RandomAlphabetic" with "5" for key "player_name"
	When Loyalty User Enroll Player via Webapp with "<$player_name$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	#User navigte to Upload Players tab in WebApp
	Given User enters text "Player Archival" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archival"
	Given User clicks on "lylPlayer_Archival.lnk_Upload_Players"
	#User create and upload excel file
	When  User generates a "UniqueString" with "BulkArchivePlayers:3" for key "BulkArchivePlayers"
	When User "creates" excel file "<$BulkArchivePlayers$>" with sheet "PlayerArchiveSample" in "xlsx" format with data
		| Universal IDs |
		| <$PLAYER_ID$> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User enters text "<$testbaseLocation$>\<$BulkArchivePlayers$>.xlsx" in "lylPlayer_Archival.btn_Choose_File"
	#User clicks on cancel button
	Given User clicks on "lylPlayer_Archival.btn_Cancel_Upload_player"
	Then User verifies text - "You have a file pending for upload. Do you want to cancel?" is present on page
	#User click on No button
	Given User clicks on "lylPlayer_Archival.btn_No"
	Given User clicks on "lylPlayer_Archival.btn_Cancel_Upload_player"
	Given User clicks on "lylPlayer_Archival.btn_Yes"

Scenario: 009 Verify that self exclusion seeded accounts can not be Archived. (TC 459626)
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	##User navigte to Upload Players tab in WebApp
	Given User enters text "Player Archival" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archival"
	Given User clicks on "lylPlayer_Archival.lnk_Upload_Players"
	#User create and upload excel file
	When  User generates a "UniqueString" with "BulkArchivePlayers:3" for key "BulkArchivePlayers"
	When User "creates" excel file "<$BulkArchivePlayers$>" with sheet "PlayerArchiveSample" in "xlsx" format with data
		| Universal IDs      |
		| <#ExcludedPlayer#> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User enters text "<$testbaseLocation$>\<$BulkArchivePlayers$>.xlsx" in "lylPlayer_Archival.btn_Choose_File"
	#User clicks on Archive button
	Given User clicks on "lylPlayer_Archival.btn_Archive"
	#Vaidate Data on Grid
	Then User verifies that element "lylPlayer_Archival.mic_Upload_File_Error_Grid" is present "true" on UI with parameters
		| Key                     | Value      |
		| Total Records           | 1          |
		| No of Processed Records | 0          |
		| No of Error Records     | 1          |
		| Error File              | Error File |

Scenario: 010 Verify that DAP accounts can not be Archived. (TC 465675)
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	##User navigte to Upload Players tab in WebApp
	Given User enters text "Player Archival" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archival"
	Given User clicks on "lylPlayer_Archival.lnk_Upload_Players"
	#User create and upload excel file
	When  User generates a "UniqueString" with "BulkArchivePlayers:3" for key "BulkArchivePlayers"
	When User "creates" excel file "<$BulkArchivePlayers$>" with sheet "PlayerArchiveSample" in "xlsx" format with data
		| Universal IDs |
		| <#DAPPlayer#> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User enters text "<$testbaseLocation$>\<$BulkArchivePlayers$>.xlsx" in "lylPlayer_Archival.btn_Choose_File"
	#User clicks on Archive button
	Given User clicks on "lylPlayer_Archival.btn_Archive"
	#Vaidate Data on Grid
	Then User verifies that element "lylPlayer_Archival.mic_Upload_File_Error_Grid" is present "true" on UI with parameters
		| Key                     | Value      |
		| Total Records           | 1          |
		| No of Processed Records | 0          |
		| No of Error Records     | 1          |
		| Error File              | Error File |

Scenario: 011 Verify that Archived, merged victims, deceased player can not be marked as Do Not Archive accounts. (TC 459627)
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	##User navigte to Upload Players tab in WebApp
	Given User enters text "Player Archival" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archival"
	Given User clicks on "lylPlayer_Archival.lnk_Upload_Players"
	#User create and upload excel file
	When  User generates a "UniqueString" with "BulkArchivePlayers:3" for key "BulkArchivePlayers"
	When User "creates" excel file "<$BulkArchivePlayers$>" with sheet "PlayerArchiveSample" in "xlsx" format with data
		| Universal IDs      |
		| <#ArchivePlayer#>  |
		| <#MergePlayer#>    |
		| <#DeceasedPlayer#> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User enters text "<$testbaseLocation$>\<$BulkArchivePlayers$>.xlsx" in "lylPlayer_Archival.btn_Choose_File"
	#User clicks on Do not Archive button
	Given User clicks on "lylPlayer_Archival.btn_Donot_Archive"
	#Vaidate Data on Grid
	Then User verifies that element "lylPlayer_Archival.mic_Upload_File_Error_Grid" is present "true" on UI with parameters
		| Key                     | Value      |
		| Total Records           | 3          |
		| No of Processed Records | 0          |
		| No of Error Records     | 3          |
		| Error File              | Error File |