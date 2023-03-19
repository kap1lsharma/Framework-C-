@Sequential@Release_15.0@AssignPrivateBucketAward@Desktop
Feature: AssignPrivateBucketAward_Via_WebAppandMassImporter.feature

#******************************************************************************
#**  Feature File                 : OL_Assign_PrivateBucketAward_via_WebAppandMassImporter.feature
#**  Feature Name                 : Assign Bucket Award via Webapp and Mass Importer
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 587274
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  05/13/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/
#
#/*************************************************************************
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

| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID211  |
| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID212  |
| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID213  |
| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID214  |
| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID215  |
| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID216  |
Scenario: 002-  Verify the UI changes on Show Award Type Screen on Bucket Award section in Web App.(TC 587274)
	#Enable the private Bucket Award Permission
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
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
	#Verify UI changes on view Bucket Award screen, Is Private column should be added
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<$PLAYER_ID211$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	When User waits "2" seconds
	Given User clicks on "OLW_BUCKET_AWARD.btn_ShowBucketAwards"
	Then User verifies that element "OLW_BUCKET_AWARD.tbl_Columns_ViewBucketAward" is present "true" on UI with parameters
		| Key              | Value             |
		| Award_Column     | Bucket Award Name |
		| StartDate_Column | Start Date        |
		| EndDate_Column   | End Date          |
		| Bucket_Column    | Bucket            |
		| Amount_Column    | Amount            |
		| Property_Column  | Property          |
		| Kiosk_Column     | Kiosk             |
		| Private_Column   | Private           |

Scenario:003- Verify the Category and Description of the Permission: VIEWASSIGNPRIVATEAWARD.(TC 587274)
	#Login to webapp and Search Group Permission
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User enters text "VIEWASSIGNPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Verify the Permssion name,category and description
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.tbl_PermissionTable_EditPermissions" is present "true" on UI with parameters
		| Key            | Value                                                            |
		| PermissionName | VIEWASSIGNPRIVATEAWARD                                           |
		| Category       | Player Functions                                                 |
		| Description    | ALLOWS A USER TO VIEW AND ASSIGN PRIVATE BUCKET AWARDS TO PLAYER |

Scenario: 004- Verify User is able to Assign a Private Bucket Award from Web App.(TC 587274)
	#Enable the private Bucket Award Permission
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
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
	#Assign Private Bucket Award to Player from Webapp
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<$PLAYER_ID212$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	When User waits "2" seconds
	Given User clicks on "OLW_BUCKET_AWARD.btn_ShowBucketAwards"
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	When User gets attribute "getText" value of "OLW_BUCKET_AWARD.mic_StartDate" element with parameters to save with key "StartDate"
		| Key       | Value                 |
		| AwardName | <#PrivateAwardPromo#> |
	When User gets attribute "getText" value of "OLW_BUCKET_AWARD.mic_AwardEndDate" element with parameters to save with key "EndDate"
		| Key       | Value                 |
		| AwardName | <#PrivateAwardPromo#> |
	Then User verifies that element "OLW_BUCKET_AWARD.tbl_ViewBucketAwardTable" is present "true" on UI with parameters
		| Key            | Value                 |
		| AwardName      | <#PrivateAwardPromo#> |
		| AwardStartDate | <$StartDate$>         |
		| AwardEndDate   | <$EndDate$>           |
		| BucketView     | Universal Promo       |
		| AwardAmount    | $100.00               |
		| Property       | Multi Property        |
		| IsPrivate      | Y                     |
	Given User clicks on "OLW_BUCKET_AWARD.tbl_ViewBucketAwardTable" with parameters
		| Key            | Value                 |
		| AwardName      | <#PrivateAwardPromo#> |
		| AwardStartDate | <$StartDate$>         |
		| AwardEndDate   | <$EndDate$>           |
		| BucketView     | Universal Promo       |
		| AwardAmount    | $100.00               |
		| Property       | Multi Property        |
		| IsPrivate      | Y                     |
	Given User clicks on "OLW_BUCKET_AWARD.btn_AddedBucketAwardToPlayer"
	When User waits "2" seconds
	Given User clicks on "OLW_BUCKET_AWARD.btn_Close_ConfirmationPopup"
	When User waits "2" seconds
	Given User clicks on "OLW_BUCKET_AWARD.btn_ReturnToPlayerBucketAwards"
	When User waits "2" seconds
	#Verify on Bucket Award Screen, Private Award has been Assigned
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_BUCKET_AWARD.txt_SearchAdded_BucketAward"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchAddedBucketAward"
	Then User verifies that element "OLW_BUCKET_AWARD.tbl_AddedBucketAward" is present "true" on UI with parameters
		| Key             | Value                 |
		| AwardName       | <#PrivateAwardPromo#> |
		| AwardStartDate  | <$StartDate$>         |
		| AwardEndDate    | <$EndDate$>           |
		| AwardAmount     | $100.00               |
		| RemainingAmount | $100.00               |
		| BucketView      | Universal Promo       |
		| Status          | Active                |
		| Property        | Multi Property        |
		| IsPrivate       | Y                     |
	Given User clicks on "OLW_BUCKET_AWARD.tbl_AddedBucketAward" with parameters
		| Key             | Value                 |
		| AwardName       | <#PrivateAwardPromo#> |
		| AwardStartDate  | <$StartDate$>         |
		| AwardEndDate    | <$EndDate$>           |
		| AwardAmount     | $100.00               |
		| RemainingAmount | $100.00               |
		| BucketView      | Universal Promo       |
		| Status          | Active                |
		| Property        | Multi Property        |
		| IsPrivate       | Y                     |
	When User waits "2" seconds

Scenario: 005- Verify Users without permission "VIEWASSIGNPRIVATEAWARD" will not be able to assign Private Awards to a player.(TC 587274)
	#Login to webapp and search Group Permission
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User enters text "VIEWASSIGNPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Disable the Group Permission
	Then User "unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value                  |
		| permissionname | VIEWASSIGNPRIVATEAWARD |
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI
	When User waits "2" seconds
	#Assign Private Bucket Award via Webapp
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<$PLAYER_ID213$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	When User waits "2" seconds
	Given User clicks on "OLW_BUCKET_AWARD.btn_ShowBucketAwards"
	#Verify Private filter is not displayed on View bucket award screen, if VIEWASSIGNPRIVATEAWARD permission is not enabled.
	Then User verifies that element "OLW_BUCKET_AWARD.lbl_PrivateLabel_Filter" is present "false" on UI
	#Verify Private column is not displayed in Header
	Then User verifies that element "OLW_BUCKET_AWARD.tbl_Columns_ViewBucketAward" is present "false" on UI with parameters
		| Key              | Value             |
		| Award_Column     | Bucket Award Name |
		| StartDate_Column | Start Date        |
		| EndDate_Column   | End Date          |
		| Bucket_Column    | Bucket            |
		| Amount_Column    | Amount            |
		| Property_Column  | Property          |
		| Kiosk_Column     | Kiosk             |
		| Private_Column   | Private           |
	#Search Private Award, no Private Award should not get in result.
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	#Then User verifies that element "OLW_BUCKET_AWARD.lbl_NoBucketAwardMsg" is present "true" on UI
	Then User verifies that element "OLW_BUCKET_AWARD.lbl_NoBucketAwardavailable_Msg" is present "true" on UI

Scenario: 006- Verify Users with permission "ASSIGNBULKPRIVATEAWARD" will only be able to assign Private Awards to a player through Mass Importer. (TC 587274)
	#Enable Group permission "ASSIGNBULKPRIVATEAWARD"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User enters text "ASSIGNBULKPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value                  |
		| permissionname | ASSIGNBULKPRIVATEAWARD |
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI
	When User waits "2" seconds
	# Assign Private Award to Player from Mass Importer
	When User runs query "Select P.CorpProp from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyCorpProp"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate"
	When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "1" on dateTime "<$startdate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Mass Importer\ATI.Loyalty.MassImporter.exe"
	Given User types text "<#Halo_username#>" in "MI_Login.txt_UserID"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "MI_Login.Domain_DropDown" by "value"
	When User waits "4" seconds
	Given User clicks on "MI_Login.btn_SignIn"
	When User waits "25" seconds
	Given User selects option "Player Award" of element "MI_Login.SelectUpdateType_Dropdown" by "value"
	When User generates a "UniqueString" with "PlayerAward:4" for key "PlayerAward"
	#Upload Bucket Award via Mass Importer
	When User "creates" excel file "<$PlayerAward$>" with sheet "Player_Award" in "xls" format with data
		| UniversalPlayerId | Award Type            |
		| <$PLAYER_ID214$>  | <#PrivateAwardPromo#> |
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
	Given User enters text "<$PLAYER_ID214$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	When User waits "2" seconds
	#Verify Private Bucket Award assigned or not to player
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_BUCKET_AWARD.txt_SearchAdded_BucketAward"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchAddedBucketAward"
	When User gets attribute "getText" value of "OLW_BUCKET_AWARD.mic_PlayerBuckeAward_StartDate" element with parameters to save with key "StartDate1"
		| Key       | Value                 |
		| AwardName | <#PrivateAwardPromo#> |
	When User gets attribute "getText" value of "OLW_BUCKET_AWARD.mic_PlayerBucketAwardEndDate" element with parameters to save with key "EndDate1"
		| Key       | Value                 |
		| AwardName | <#PrivateAwardPromo#> |
	Then User verifies that element "OLW_BUCKET_AWARD.tbl_AddedBucketAward" is present "true" on UI with parameters
		| Key             | Value                 |
		| AwardName       | <#PrivateAwardPromo#> |
		| AwardStartDate  | <$StartDate1$>        |
		| AwardEndDate    | <$EndDate1$>          |
		| AwardAmount     | $100.00               |
		| RemainingAmount | $0.00                 |
		| BucketView      | Universal Promo       |
		| Status          | Active                |
		| Property        | Multi Property        |
		| IsPrivate       | Y                     |

Scenario: 007- Verify Users without permission "ASSIGNBULKPRIVATEAWARD" will not be able to assign Private Awards to a player through Mass Importer. (TC 587274)
	# Disable Group Permission "ASSIGNBULKPRIVATEAWARD"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User enters text "ASSIGNBULKPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	Then User "unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value                  |
		| permissionname | ASSIGNBULKPRIVATEAWARD |
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI
	When User waits "2" seconds
	# verify user is not able to assign Private Award from Massimporter, When "ASSIGNBULKPRIVATEAWARD" permission is disabled
	When User runs query "Select P.CorpProp from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyCorpProp"
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Mass Importer\ATI.Loyalty.MassImporter.exe"
	Given User types text "<#Halo_username#>" in "MI_Login.txt_UserID"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "MI_Login.Domain_DropDown" by "value"
	When User waits "4" seconds
	Given User clicks on "MI_Login.btn_SignIn"
	When User waits "25" seconds
	Given User selects option "Player Award" of element "MI_Login.SelectUpdateType_Dropdown" by "value"
	When User generates a "UniqueString" with "PlayerAward:4" for key "PlayerAward"
	#Upload Player Award via Mass Importer
	When User "creates" excel file "<$PlayerAward$>" with sheet "Player_Award" in "xls" format with data
		| UniversalPlayerId | Award Type            |
		| <$PLAYER_ID215$>  | <#PrivateAwardPromo#> |
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
	#Verify On webapp Private Award assigned or not to player
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<$PLAYER_ID215$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	When User waits "2" seconds
	#Verify Private Bucket Award not assigned to player via Mass Importer, When "ASSIGNBULKPRIVATEAWARD" permission is disabled
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_BUCKET_AWARD.txt_SearchAdded_BucketAward"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchAddedBucketAward"
	Then User verifies that element "OLW_BUCKET_AWARD.lbl_NoBucketAwardavailable_Msg" is present "true" on UI

Scenario: 008- Verify Users will be able to filter for Private Bucket Awards.(TC 587274)
	#Enable the private Bucket Award Permission
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User enters text "VIEWASSIGNPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value                  |
		| permissionname | VIEWASSIGNPRIVATEAWARD |
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI
	#Go to Bucket Awards
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<$PLAYER_ID216$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	When User waits "2" seconds
	Given User clicks on "OLW_BUCKET_AWARD.btn_ShowBucketAwards"
	#Verify Private Award Filter and it's Dropdown opion on bucket Award View Screen
	Then User verifies that element "OLW_BUCKET_AWARD.lbl_PrivateLabel_Filter" is present "true" on UI
	Then User verifies that element "OLW_BUCKET_AWARD.Private_Dropdown_Options" is present "true" on UI with parameters
		| Key      | Value      |
		| Option 1 | Select All |
		| Option 2 | Yes        |
		| Option 3 | No         |
	#Select option "Yes" from Private filter and verify only Private Bucket Award should get in result
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	Given User selects option "Yes" of element "OLW_BUCKET_AWARD.Private_DropDown" by "visibletext"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	When User gets attribute "getText" value of "OLW_BUCKET_AWARD.mic_StartDate" element with parameters to save with key "StartDate2"
		| Key       | Value                 |
		| AwardName | <#PrivateAwardPromo#> |
	When User gets attribute "getText" value of "OLW_BUCKET_AWARD.mic_AwardEndDate" element with parameters to save with key "EndDate2"
		| Key       | Value                 |
		| AwardName | <#PrivateAwardPromo#> |
	Then User verifies that element "OLW_BUCKET_AWARD.tbl_ViewBucketAwardTable" is present "true" on UI with parameters
		| Key            | Value                 |
		| AwardName      | <#PrivateAwardPromo#> |
		| AwardStartDate | <$StartDate2$>        |
		| AwardEndDate   | <$EndDate2$>          |
		| BucketView     | Universal Promo       |
		| AwardAmount    | $100.00               |
		| Property       | Multi Property        |
		| IsPrivate      | Y                     |
	#Non Private Award should not get in Result, when Option "Yes" is selected from Private bucket award Dropdown.
	Given User clears "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User enters text "<#NonPrivateAward#>" in "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	Given User selects option "Yes" of element "OLW_BUCKET_AWARD.Private_DropDown" by "visibletext"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	Then User verifies that element "OLW_BUCKET_AWARD.lbl_NoBucketAwardavailable_Msg" is present "true" on UI
	#Select option "No" from Private filter then only Non Private Award should be visible
	Given User clears "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User enters text "<#NonPrivateAward#>" in "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	Given User selects option "No" of element "OLW_BUCKET_AWARD.Private_DropDown" by "visibletext"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	When User gets attribute "getText" value of "OLW_BUCKET_AWARD.mic_StartDate" element with parameters to save with key "StartDate3"
		| Key       | Value               |
		| AwardName | <#NonPrivateAward#> |
	When User gets attribute "getText" value of "OLW_BUCKET_AWARD.mic_AwardEndDate" element with parameters to save with key "EndDate3"
		| Key       | Value               |
		| AwardName | <#NonPrivateAward#> |
	Then User verifies that element "OLW_BUCKET_AWARD.tbl_ViewBucketAwardTable" is present "true" on UI with parameters
		| Key            | Value               |
		| AwardName      | <#NonPrivateAward#> |
		| AwardStartDate | <$StartDate3$>      |
		| AwardEndDate   | <$EndDate3$>        |
		| BucketView     | Universal Promo     |
		| AwardAmount    | $10.00              |
		| Property       | Property 1          |
		| IsPrivate      | N                   |
	#Private Award should not visible, if option is selected as NO
	Given User clears "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	Given User selects option "No" of element "OLW_BUCKET_AWARD.Private_DropDown" by "visibletext"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	Then User verifies that element "OLW_BUCKET_AWARD.lbl_NoBucketAwardavailable_Msg" is present "true" on UI
	#Private Award should be visible, if option is selected as "Select All"
	Given User clears "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	Given User selects option "Select All" of element "OLW_BUCKET_AWARD.Private_DropDown" by "visibletext"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	Then User verifies that element "OLW_BUCKET_AWARD.tbl_ViewBucketAwardTable" is present "true" on UI with parameters
		| Key            | Value                 |
		| AwardName      | <#PrivateAwardPromo#> |
		| AwardStartDate | <$StartDate2$>        |
		| AwardEndDate   | <$EndDate2$>          |
		| BucketView     | Universal Promo       |
		| AwardAmount    | $100.00               |
		| Property       | Multi Property        |
		| IsPrivate      | Y                     |
	# Non Private Award should be visible,if option is selected as "Select All"
	Given User clears "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User enters text "<#NonPrivateAward#>" in "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	Given User selects option "Select All" of element "OLW_BUCKET_AWARD.Private_DropDown" by "visibletext"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	Then User verifies that element "OLW_BUCKET_AWARD.tbl_ViewBucketAwardTable" is present "true" on UI with parameters
		| Key            | Value               |
		| AwardName      | <#NonPrivateAward#> |
		| AwardStartDate | <$StartDate3$>      |
		| AwardEndDate   | <$EndDate3$>        |
		| BucketView     | Universal Promo     |
		| AwardAmount    | $10.00              |
		| Property       | Property 1          |
		| IsPrivate      | N                   |

Scenario Outline: 009- Verify Private Bucket Awards cannot be added for Deceased and Merge Victim Player. (TC 587274)
	#Login to webapp
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<PlayerID>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	#Assign Bucket Award to Deceased and Merge Victim Player, Error message should get displayed.
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	When User waits "2" seconds
	Given User clicks on "OLW_BUCKET_AWARD.btn_ShowBucketAwards"
	Then User verifies that element "OLW_BUCKET_AWARD.Alert_FunctionNotAllowed" is present "true" on UI

	Examples:
		| PlayerID           |
		| <#DeceasedPlayer#> |
		| <#MergePlayer#>    |

Scenario: 010- Verify Private Bucket Awards cannot be added to Excluded player. (TC 587274)
	#Login to webapp
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	#Disable the Group Permission DapOveride
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User enters text "DAPOVERRIDE" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Disable the Group Permission and save it
	Then User "unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value       |
		| permissionname | DAPOVERRIDE |
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI
	When User waits "2" seconds
	#Enable the Private Bucket award permission
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "VIEWASSIGNPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Enable the Group Permission VIEWASSIGNPRIVATEAWARD and save it
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value                  |
		| permissionname | VIEWASSIGNPRIVATEAWARD |
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI
	When User waits "2" seconds
	#Search Excluded Player
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<#ExcludedPlayer#>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	#Go to Bucket Award
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	When User waits "2" seconds
	Given User clicks on "OLW_BUCKET_AWARD.btn_ShowBucketAwards"
	#Search Private Bucket Award
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_BUCKET_AWARD.txt_SearchByBucketAwardName"
	Given User clicks on "OLW_BUCKET_AWARD.btn_SearchButton_ViewBucketAward"
	When User gets attribute "getText" value of "OLW_BUCKET_AWARD.mic_StartDate" element with parameters to save with key "StartDate6"
		| Key       | Value                 |
		| AwardName | <#PrivateAwardPromo#> |
	When User gets attribute "getText" value of "OLW_BUCKET_AWARD.mic_AwardEndDate" element with parameters to save with key "EndDate6"
		| Key       | Value                 |
		| AwardName | <#PrivateAwardPromo#> |
	Then User verifies that element "OLW_BUCKET_AWARD.tbl_ViewBucketAwardTable" is present "true" on UI with parameters
		| Key            | Value                 |
		| AwardName      | <#PrivateAwardPromo#> |
		| AwardStartDate | <$StartDate6$>        |
		| AwardEndDate   | <$EndDate6$>          |
		| BucketView     | Universal Promo       |
		| AwardAmount    | $100.00               |
		| Property       | Multi Property        |
		| IsPrivate      | Y                     |
	
	Given User clicks on "OLW_BUCKET_AWARD.tbl_ViewBucketAwardTable" with parameters
		| Key            | Value                 |
		| AwardName      | <#PrivateAwardPromo#> |
		| AwardStartDate | <$StartDate6$>        |
		| AwardEndDate   | <$EndDate6$>          |
		| BucketView     | Universal Promo       |
		| AwardAmount    | $100.00               |
		| Property       | Multi Property        |
		| IsPrivate      | Y                     |
	#Try to Assign Private Bucket Award to player
	Given User clicks on "OLW_BUCKET_AWARD.btn_AddedBucketAwardToPlayer"
	When User waits "2" seconds
	Then User verifies that element "OLW_BUCKET_AWARD.lbl_DAP_ExclusionAlert" is present "true" on UI


	Scenario: 011- Verify Private Bucket Awards cannot be added to Archival player.(TC 587274)
	#Login to webapp
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<#ArchivePlayer#>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.btn_search_dropdown"
	Given User clicks on "lylPlayer_Search.btn_chck_arch_accnt"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	# go to Bucket Award and try to Assign award to Archive player, Show Bucket Award Button should be disabled
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value         |
		| Dashboard_Tab | Bucket Awards |
	When User waits "2" seconds
	#Get the Attribute value
	Then User verifies attribute "disabled" value "true" of element "OLW_BUCKET_AWARD.btn_ShowBucketAwards"

	
	Scenario: 012-Close all Instance of Mass Importer desktop application.
When User switch to window application "ATI.Loyalty.MassImporter.exe"
Given User closes application




