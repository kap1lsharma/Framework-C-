@Sequential@Release_15.0@MassImporterPrivatePlayerAward_WebApp@Desktop
Feature: MassImporter_AssignPlayerAward_Validation Webapp

#******************************************************************************
#**  Feature File                 : OL_MassImporter_AssignPlayerAward_Validation Webapp.feature
#**  Feature Name                 : Assign Player Award via Mass Importer and validate on Webapp
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 583178,583170,583185
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  05/30/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/
Scenario Outline: 001-Enroll Player using WebApp
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Enroll Player" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "MAIN_NAV_BOX.ENROLL_PLAYER"
	Given User selects option "<enrollType>" of element "ENROLL_PLAYER.ENROLL_TYPE_DROPDOWN" by "visibletext"
	Given User selects option "<prefixType>" of element "ENROLL_PLAYER.ID_PREFIX_DROPDOWN" by "visibletext"
	When User generates a "RandomAlphabetic" with "5" for key "player_name"
	Given User enters text "<$player_name$>" in "ENROLL_PLAYER.ID_FIRST_NAME_TEXTBOX"
	Given User enters text "<middleName>" in "ENROLL_PLAYER.ID_MIDDLE_NAME_TEXTBOX"
	Given User enters text "<lastName>" in "ENROLL_PLAYER.ID_LAST_NAME_TEXTBOX"
	Given User selects option "<suffix>" of element "ENROLL_PLAYER.ID_SUFFIX_DROPDOWN" by "visibletext"
	Given User enters text "<bday>" in "ENROLL_PLAYER.ID_BDAY_TEXTBOX"
	Given User selects option "<gender>" of element "ENROLL_PLAYER.ID_PLAYER_GENDER_DROPDOWN" by "visibletext"
	Given User selects option "<idType>" of element "ENROLL_PLAYER.ID_TYPE_DROPDOWN" by "visibletext"
	When User waits "4" seconds
	Given User enters text "<id>" in "ENROLL_PLAYER.ID_TEXT_TEXTBOX"
	When User waits "4" seconds
	Given User enters text "<bday>" in "ENROLL_PLAYER.ID_DOB_TEXTBOX"
	When User waits "4" seconds
	Given User enters text "<expireDate>" in "ENROLL_PLAYER.ID_EXPIRY_DATE_TEXTBOX"
	Given User selects option "<country>" of element "ENROLL_PLAYER.ID_COUNTRY_DROPDOWN" by "visibletext"
	When User waits "4" seconds
	Given User selects option "<state>" of element "ENROLL_PLAYER.ID_STATE_DROPDOWN" by "visibletext"
	When User waits "2" seconds
	Given User selects option "<nationality>" of element "ENROLL_PLAYER.ID_NATIONALITY_DROPDOWN" by "visibletext"
	Given User selects option "<gender>" of element "ENROLL_PLAYER.ID_GENDER_DROPDOWN" by "visibletext"
	Given User clears "ENROLL_PLAYER.SSN_TEXTBOX"
	Given User enters text "<ssn>" in "ENROLL_PLAYER.SSN_TEXTBOX"
	#Address Information
	Then User "checks" element "ENROLL_PLAYER.ADDRESS_OPTIN_CHECKBOX"
	Given User selects option "<addressType>" of element "ENROLL_PLAYER.ADDRESS_TYPE_DROPDOWN" by "visibletext"
	When User waits "2" seconds
	Given User enters text "Test Address Line 1" in "ENROLL_PLAYER.ADDRESS_LINE1_TEXTBOX"
	Given User enters text "Test Address Line 2" in "ENROLL_PLAYER.ADDRESS_LINE2_TEXTBOX"
	Given User enters text "<city>" in "ENROLL_PLAYER.ADDRESS_CITY_TEXTBOX"
	Given User selects option "<country>" of element "ENROLL_PLAYER.ADDRESS_COUNTRY_DROPDOWN" by "visibletext"
	When User waits "2" seconds
	Given User selects option "<state>" of element "ENROLL_PLAYER.ADDRESS_STATE_DROPDOWN" by "visibletext"
	When User waits "2" seconds
	Given User enters text "<zip>" in "ENROLL_PLAYER.ADDRESS_ZIPCODE_TEXTBOX"
	Given User enters text "<zipFour>" in "ENROLL_PLAYER.ADDRESS_ZIP_PLUS_FOUR_TEXTBOX"
	#PIN Information
	Given User enters text "<pin>" in "ENROLL_PLAYER.PIN_TEXTBOX"
	Given User enters text "<pin>" in "ENROLL_PLAYER.PIN_AGAIN_TEXTBOX"
	When User scrolls till element "ENROLL_PLAYER.ENROLL_BUTTON"
	When User waits "2" seconds
	Given User clicks on "ENROLL_PLAYER.ENROLL_BUTTON"
	When User waits "4" seconds
	When User gets attribute "getText" value of "PLAYER_INFO.PLAYER_ID_SPAN" element to save with key "<PLAYER_ID_Key>"
	When User runs query "select P.PropertyName from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"

	Examples:
		| BucketAmount | enrollType | prefixType | middleName | lastName  | suffix | bday       | gender | idType        | id          | expireDate | country | state   | country2 | state2  | nationality | addressType | addressLine          | city    | zip    | zipFour | fromDate   | toDate     | addressType2 | city2   | zip2   | zipFour2 | fromDate2  | toDate2    | teleType | teleNo     | teleStatus | emailType | email   | emailStatus | socialType | socialAccount  | smsType  | pin  | Permission | sms       | PLAYER_ID          | ssn       | PLAYER_ID_Key |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID161  |

Scenario:002-  Enable "PRIVATEAWARDUPLOAD" permission to upload Private Bucket Award via Mass Importer.
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	When User waits "2" seconds
	#Search Permission
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User enters text "PRIVATEAWARDUPLOAD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Verify Permission Name, Category and Description
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.tbl_PermissionTable_EditPermissions" is present "true" on UI with parameters
		| Key            | Value                                               |
		| PermissionName | PRIVATEAWARDUPLOAD                                  |
		| Category       | Mass Importer                                       |
		| Description    | ALLOW A USER TO UPLOAD A PRIVATE BUCKET AWARD BATCH |
	When User waits "5" seconds
	#Enable the PRIVATEAWARDUPLOAD Permission check
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value              |
		| permissionname | PRIVATEAWARDUPLOAD |
	#Verify Permission has enabled or not
	Then User verifies attribute "title" value "Checked" of element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value              |
		| permissionname | PRIVATEAWARDUPLOAD |
	# Save the Permission
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI
	#Enable the VIEWASSIGNPRIVATEAWARD Permission check
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "VIEWASSIGNPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value                  |
		| permissionname | VIEWASSIGNPRIVATEAWARD |
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI
	When User waits "2" seconds

Scenario: 003 -  Verify that uploaded Private bucket award should be visible under 'Show Bucket Awards' (TC 583178)
	When User runs query "Select P.CorpProp from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyCorpProp"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate"
	When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "1" on dateTime "<$startdate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Mass Importer\ATI.Loyalty.MassImporter.exe"
	Given User types text "<#Halo_username#>" in "MI_Login.txt_UserID"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "MI_Login.Domain_DropDown" by "value"
	Given User clicks on "MI_Login.btn_SignIn"
	When User waits "25" seconds
	Given User selects option "Award Type" of element "MI_Login.SelectUpdateType_Dropdown" by "value"
	When User generates a "UniqueString" with "BucketAwardType:4" for key "AwardType"
	When User generates a "UniqueString" with "Award_:5" for key "AwardName"
	#Upload Bucket Award via Mass Importer
	When User "creates" excel file "<$AwardType$>" with sheet "Award Type" in "xls" format with data
		| Name          | BucketView      | Corp Prop            | Start Date    | End Date    | Amount | IsKiosk | IsPrivate |
		| <$AwardName$> | Universal Promo | <$PropertyCorpProp$> | <$startdate$> | <$enddate$> | 10     | N       | Y         |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User types text "<$testbaseLocation$>\<$AwardType$>.xls" in "MASS_IMPORTER.BulUPdateCSV"
	When User waits "2" seconds
	When User switch to window object "BulkUpdate.frmBulkUpdateFrame"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User clicks on "MI_Login.btn_BeginBulkUpdate"
	When User waits "30" seconds
	When User switch to window object "default"
	Then User verifies that element "BulkUpdate.lblbulksuccess" is present "true" on UI
	Given User clicks on "BulkUpdate.btn_OK"
	Given User closes application
	#Verify Bucket Award uploaded by Mass Importer, displayed on View Bucket Award Screen
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#When User waits "2" seconds
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<$PLAYER_ID161$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	#When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	#When User waits "2" seconds
	Given User clicks on "OLW_BUCKET_AWARD.btn_ShowBucketAwards"
	Given User enters text "<$AwardName$>" in "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	When User gets attribute "getText" value of "OLW_BUCKET_AWARD.mic_StartDate" element with parameters to save with key "StartDate32"
		| Key       | Value         |
		| AwardName | <$AwardName$> |
	When User gets attribute "getText" value of "OLW_BUCKET_AWARD.mic_AwardEndDate" element with parameters to save with key "EndDate32"
		| Key       | Value         |
		| AwardName | <$AwardName$> |
	Then User verifies that element "OLW_BUCKET_AWARD.tbl_ViewBucketAwardTable" is present "true" on UI with parameters
		| Key            | Value           |
		| AwardName      | <$AwardName$>   |
		| AwardStartDate | <$StartDate32$> |
		| AwardEndDate   | <$EndDate32$>   |
		| BucketView     | Universal Promo |
		| AwardAmount    | $10.00          |
		| Property       | Property 1      |
		| IsPrivate      | Y               |

Scenario: 004- Verify a verified user is able to assign Private awards to a Patron via Mass Importer.  (TC 583170)
	# Assign Private Award to Player from Mass Importer
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Mass Importer\ATI.Loyalty.MassImporter.exe"
	Given User types text "<#Halo_username#>" in "MI_Login.txt_UserID"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "MI_Login.Domain_DropDown" by "value"
	When User waits "4" seconds
	Given User clicks on "MI_Login.btn_SignIn"
	When User waits "25" seconds
	Given User selects option "Player Award" of element "MI_Login.SelectUpdateType_Dropdown" by "value"
	When User generates a "UniqueString" with "PlayerPrivateAward:4" for key "PlayerAward"
	#Upload Bucket Award via Mass Importer
	When User "creates" excel file "<$PlayerAward$>" with sheet "Player_Award" in "xls" format with data
		| UniversalPlayerId | Award Type            |
		| <$PLAYER_ID161$>  | <#PrivateAwardPromo#> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User types text "<$testbaseLocation$>\<$PlayerAward$>.xls" in "MASS_IMPORTER.BulUPdateCSV"
	When User waits "2" seconds
	When User switch to window object "BulkUpdate.frmBulkUpdateFrame"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User clicks on "MI_Login.btn_BeginBulkUpdate"
	When User waits "20" seconds
	When User switch to window object "default"
	Then User verifies that element "BulkUpdate.lblbulksuccess" is present "true" on UI
	Given User clicks on "BulkUpdate.btn_OK"
	Given User closes application
	#Verify On webapp Private Bucket Award has been assigned to player
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<$PLAYER_ID161$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	When User waits "2" seconds
	#Verify Private Bucket Award assigned or not to player
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_BUCKET_AWARD.txt_SearchAdded_BucketAward"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchAddedBucketAward"
	When User gets attribute "getText" value of "OLW_BUCKET_AWARD.mic_PlayerBuckeAward_StartDate" element with parameters to save with key "StartDate31"
		| Key       | Value                 |
		| AwardName | <#PrivateAwardPromo#> |
	When User gets attribute "getText" value of "OLW_BUCKET_AWARD.mic_PlayerBucketAwardEndDate" element with parameters to save with key "EndDate31"
		| Key       | Value                 |
		| AwardName | <#PrivateAwardPromo#> |
	Then User verifies that element "OLW_BUCKET_AWARD.tbl_AddedBucketAward" is present "true" on UI with parameters
		| Key             | Value                 |
		| AwardName       | <#PrivateAwardPromo#> |
		| AwardStartDate  | <$StartDate31$>       |
		| AwardEndDate    | <$EndDate31$>         |
		| AwardAmount     | $100.00               |
		| RemainingAmount | $0.00                 |
		| BucketView      | Universal Promo       |
		| Status          | Active                |
		| Property        | Multi Property        |
		| IsPrivate       | Y                     |

Scenario: 005- Verify that Private Bucket Bucket Award should not get assigned to the  Excluded Player through Mass Importer. (TC 583185)
	#DAP Override permission check
	#Login to webapp
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#Disable the Group Permission DapOveride
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User enters text "DAPOVERRIDE" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Disable the Group Permission and save it
	Then User "unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value       |
		| permissionname | DAPOVERRIDE |
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI
	#Login to webapp
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Mass Importer\ATI.Loyalty.MassImporter.exe"
	Given User types text "<#Halo_username#>" in "MI_Login.txt_UserID"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "MI_Login.Domain_DropDown" by "value"
	When User waits "4" seconds
	Given User clicks on "MI_Login.btn_SignIn"
	When User waits "25" seconds
	Given User selects option "Player Award" of element "MI_Login.SelectUpdateType_Dropdown" by "value"
	When User generates a "UniqueString" with "AwardInactivePlayer:4" for key "PlayerAward"
	#Upload Bucket Award via Mass Importer
	When User "creates" excel file "<$PlayerAward$>" with sheet "Player_Award" in "xls" format with data
		| UniversalPlayerId  | Award Type            |
		| <#ExcludedPlayer#> | <#PrivateAwardPromo#> |
		| <#MergePlayer#>    | <#PrivateAwardPromo#> |
		| <#DeceasedPlayer#> | <#PrivateAwardPromo#> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User types text "<$testbaseLocation$>\<$PlayerAward$>.xls" in "MASS_IMPORTER.BulUPdateCSV"
	When User waits "2" seconds
	When User switch to window object "BulkUpdate.frmBulkUpdateFrame"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User clicks on "MI_Login.btn_BeginBulkUpdate"
	Then User verifies that element "BulkUpdate.lbl_ErrorProgressLabel" is present "true" on UI
	When User waits "20" seconds
	When User switch to window object "default"
	Then User verifies that element "BulkUpdate.lblbulksuccess" is present "true" on UI
	Given User clicks on "BulkUpdate.btn_OK"
	Given User closes application
	#Verify on webapp Award should not get assigned to Excluded  player
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<#ExcludedPlayer#>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.btn_search_dropdown"
	Given User clicks on "lylPlayer_Search.btn_chck_arch_accnt"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	When User waits "2" seconds
	#Verify Private Bucket Award assigned or not to player
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_BUCKET_AWARD.txt_SearchAdded_BucketAward"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchAddedBucketAward"
	Then User verifies that element "OLW_BUCKET_AWARD.lbl_NoBucketAwardavailable_Msg" is present "true" on UI
	#Verify Bucket Award for Merged Player
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<#MergePlayer#>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.btn_search_dropdown"
	Given User clicks on "lylPlayer_Search.btn_chck_arch_accnt"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	When User waits "2" seconds
	#Verify Private Bucket Award assigned or not to player
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_BUCKET_AWARD.txt_SearchAdded_BucketAward"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchAddedBucketAward"
	Then User verifies that element "OLW_BUCKET_AWARD.lbl_NoBucketAwardavailable_Msg" is present "true" on UI
	#Verify Bucket Award for Deceased Player
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<#MergePlayer#>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.btn_search_dropdown"
	Given User clicks on "lylPlayer_Search.btn_chck_arch_accnt"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	When User waits "2" seconds
	#Verify Private Bucket Award assigned or not to player
	Given User enters text "<#DeceasedPlayer#>" in "OLW_BUCKET_AWARD.txt_SearchAdded_BucketAward"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchAddedBucketAward"
	Then User verifies that element "OLW_BUCKET_AWARD.lbl_NoBucketAwardavailable_Msg" is present "true" on UI

Scenario: 006- Verify that Private Bucket Bucket Award should not get assigned to the  Archival Player through Mass Importer. (TC 583185)
	#Login to webapp
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Mass Importer\ATI.Loyalty.MassImporter.exe"
	Given User types text "<#Halo_username#>" in "MI_Login.txt_UserID"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "MI_Login.Domain_DropDown" by "value"
	When User waits "4" seconds
	Given User clicks on "MI_Login.btn_SignIn"
	When User waits "25" seconds
	Given User selects option "Player Award" of element "MI_Login.SelectUpdateType_Dropdown" by "value"
	When User generates a "UniqueString" with "PlayerArchAward:4" for key "PlayerAward"
	#Upload Bucket Award via Mass Importer
	When User "creates" excel file "<$PlayerAward$>" with sheet "Player_Award" in "xls" format with data
		| UniversalPlayerId | Award Type            |
		| <#ArchivePlayer#> | <#PrivateAwardPromo#> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User types text "<$testbaseLocation$>\<$PlayerAward$>.xls" in "MASS_IMPORTER.BulUPdateCSV"
	When User waits "2" seconds
	When User switch to window object "BulkUpdate.frmBulkUpdateFrame"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User clicks on "MI_Login.btn_BeginBulkUpdate"
	When User waits "20" seconds
	When User switch to window object "default"
	Then User verifies that element "BulkUpdate.lblbulksuccess" is present "true" on UI
	Given User clicks on "BulkUpdate.btn_OK"
	Given User closes application
	#Verify on webapp Award should not get assigned to Excluded  player
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<#ArchivePlayer#>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.btn_search_dropdown"
	Given User clicks on "lylPlayer_Search.btn_chck_arch_accnt"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	When User waits "2" seconds
	#Verify Private Bucket Award assigned or not to player
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_BUCKET_AWARD.txt_SearchAdded_BucketAward"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchAddedBucketAward"
	Then User verifies that element "OLW_BUCKET_AWARD.lbl_NoBucketAwardavailable_Msg" is present "true" on UI

Scenario: 007-Close all Instance of Mass Importer desktop application.
	When User switch to window application "ATI.Loyalty.MassImporter.exe"
	Given User closes application