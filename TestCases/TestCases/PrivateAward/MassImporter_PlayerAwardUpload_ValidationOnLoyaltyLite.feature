@Sequential@Release_15.0@MassImporterPrivatePlayerAward_LoyaltyLite@Desktop
Feature: MassImporter_PlayerAwardUpload_ValidationOnLoyaltyLite

#******************************************************************************
#**  Feature File                 : OL_MassImporter_PlayerAwardUpload_ValidationOnLoyaltyLite.feature
#**  Feature Name                 :  Void Bucket Award From Loyalty Lite and upload player Award from Mass Importer
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 583170,589249
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  05/24/2022     Pooja Kashyap            Initial Draft
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
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID107  |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID108  |

Scenario:002-  Enable "PRIVATEAWARDUPLOAD" permission to upload Private Bucket Award via Mass Importer.(TC 583170)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	#Search Permission
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User enters text "ASSIGNBULKPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	#Verify Permission Name, Category and Description
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.tbl_PermissionTable_EditPermissions" is present "true" on UI with parameters
		| Key            | Value                                               |
		| PermissionName | ASSIGNBULKPRIVATEAWARD                              |
		| Category       | Mass Importer                                       |
		| Description    | ALLOW A USER TO ASSIGN A PRIVATE BUCKET AWARD BATCH |
	#Enable the PRIVATEAWARDUPLOAD Permission check
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value                  |
		| permissionname | ASSIGNBULKPRIVATEAWARD |
	#Verify Permission has enabled or not
	Then User verifies attribute "title" value "Checked" of element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value                  |
		| permissionname | ASSIGNBULKPRIVATEAWARD |
	# Save the Permission
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI
	#Enable the SC_VIEWASSIGNPRIVATEAWARD Permission check
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "SC_VIEWASSIGNPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.tbl_PermissionTable_EditPermissions" is present "true" on UI with parameters
		| Key            | Value                                                               |
		| PermissionName | SC_VIEWASSIGNPRIVATEAWARD                                           |
		| Category       | Loyalty Lite                                                        |
		| Description    | IN LOYALTY LITE, VIEW AND ASSIGN A PRIVATE BUCKET AWARD TO A PLAYER |
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value                     |
		| permissionname | SC_VIEWASSIGNPRIVATEAWARD |
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI

Scenario: 003 -  Verify that uploaded Private Player award should be visible under 'Show Bucket Awards' on Loyalty Lite(TC 583170)
	# Assign Private Award to Player from Mass Importer
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Mass Importer\ATI.Loyalty.MassImporter.exe"
	Given User types text "<#Halo_username#>" in "MI_Login.txt_UserID"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "MI_Login.Domain_DropDown" by "value"
	Given User clicks on "MI_Login.btn_SignIn"
	When User waits "25" seconds
	Given User selects option "Player Award" of element "MI_Login.SelectUpdateType_Dropdown" by "value"
	When User generates a "UniqueString" with "PlayerAward:4" for key "PlayerAward"
	#Upload Bucket Award via Mass Importer
	When User "creates" excel file "<$PlayerAward$>" with sheet "Player_Award" in "xls" format with data
		| UniversalPlayerId | Award Type            |
		| <$PLAYER_ID107$>  | <#PrivateAwardPromo#> |
		| <$PLAYER_ID108$>  | <#PrivateAwardPromo#> |
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
	#Verify Private Bucket Award, uploaded by mass importer has been added to player
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "2" seconds
	Given User clears "OLL_MAIN_NAV.txt_PlayerID_Search"
	Given User types text "<$PLAYER_ID107$>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	#Go to Player History
	Given User clicks on "LLSideNavigation.lbl_PlayerHistory"
	#Click on Bucket Award
	Given User clicks on "LLSideNavigation.lnk_BucketAwards"
	#Click on Bucket Award
	Given User types text "<#PrivateAwardPromo#>" in "LLPlayerAward.txtplayerbucketawardsearch"
	Given User clicks on "LLPlayerAward.btnassignedawardsearch"
	Given User clicks on "LLPlayerAward.lbl_AddedAwardName"
	Given User clicks on "LLPlayerAward.btnviewbucketawarddetail"
	#Verify the details
	When User gets attribute "Value" value of "LLBucketAwardDetails.txtBucketAwardName" element to save with key "BucketAwardName"
	When User performs string operation "stringEquals" of provided value "<$BucketAwardName$>" with "<#PrivateAwardPromo#>"
	When User gets attribute "Value" value of "LLBucketAwardDetails.lblStartDate" element to save with key "AwardStartDate"
	When User performs string operation "stringEquals" of provided value "<$AwardStartDate$>" with "5/11/2022 12:00:00 AM"
	When User gets attribute "Value" value of "LLBucketAwardDetails.lblEndDate" element to save with key "AwardEndDate"
	When User performs string operation "stringEquals" of provided value "<$AwardEndDate$>" with "5/30/2024 12:00:00 AM"
	When User gets attribute "Value" value of "LLBucketAwardDetails.lblStatus" element to save with key "AwardStatus"
	When User performs string operation "stringEquals" of provided value "<$AwardStatus$>" with "Active"
	When User gets attribute "Value" value of "LLBucketAwardDetails.lblIssuedAmount" element to save with key "IssuedAmount"
	When User performs string operation "stringEquals" of provided value "<$IssuedAmount$>" with "$100.00"
	When User gets attribute "Value" value of "LLBucketAwardDetails.lblRedeemedAmount" element to save with key "RedeemedAmount"
	When User performs string operation "stringEquals" of provided value "<$RedeemedAmount$>" with "$0.00"
	When User gets attribute "Value" value of "LLBucketAwardDetails.lblAvailableamount" element to save with key "AvailableAmount"
	When User performs string operation "stringEquals" of provided value "<$AvailableAmount$>" with "$0.00"
	When User gets attribute "Value" value of "LLBucketAwardDetails.lblUserID" element to save with key "UserID"
	When User performs string operation "stringEquals" of provided value "<$UserID$>" with "oladmin"
	Given User clicks on "LLBucketAwardDetails.btn_Close_AwardDetailsPopup"
	Given User closes application

Scenario:004-  Verify the Category and Description of the Permission: SC_VOIDPRIVATEAWARD. (TC 589249)
	Given User switch to "web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	When User waits "2" seconds
	#Search Permission
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User enters text "SC_VOIDPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Verify Permission Name, Category and Description
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.tbl_PermissionTable_EditPermissions" is present "true" on UI with parameters
		| Key            | Value                                                                         |
		| PermissionName | SC_VOIDPRIVATEAWARD                                                           |
		| Category       | Loyalty Lite                                                                  |
		| Description    | ALLOWS A USER TO VOID PRIVATE BUCKET AWARD ASSIGNED TO PLAYER IN LOYALTY LITE |
	When User waits "5" seconds
	#Enable the PRIVATEAWARDUPLOAD Permission check
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value               |
		| permissionname | SC_VOIDPRIVATEAWARD |
	#Verify Permission has enabled or not
	Then User verifies attribute "title" value "Checked" of element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value               |
		| permissionname | SC_VOIDPRIVATEAWARD |
	# Save the Permission
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI

Scenario: 005-   Verify User is able to Void a Private Bucket Award from Loyalty Lite. (TC 589249)
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	Given User clears "OLL_MAIN_NAV.txt_PlayerID_Search"
	Given User types text "<$PLAYER_ID107$>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	#Go to Player History
	Given User clicks on "LLSideNavigation.lbl_PlayerHistory"
	#Click on Bucket Award
	Given User clicks on "LLSideNavigation.lnk_BucketAwards"
	#Click on Bucket Award
	Given User types text "<#PrivateAwardPromo#>" in "LLPlayerAward.txtplayerbucketawardsearch"
	Given User clicks on "LLPlayerAward.btnassignedawardsearch"
	Given User clicks on "LLPlayerAward.lbl_AddedAwardName"
	Given User clicks on "LLPlayerAward.btn_VoidBucketAward"
	Then User verifies that element "LLPlayerAward.lbl_VoidBucketAwardConfirmation_Popup" is present "true" on UI
	Given User clicks on "LLPlayerAward.btnConfirmationOK"
	Given User clicks on "LLPlayerAward.btnSuccessOK"
	Then User verifies that element "LLPlayerAward.lblNoAwardfound" is present "true" on UI
	Given User closes application

Scenario: 006-  Verify Users without permission "SC_VOIDPRIVATEAWARD" will not be able to Void Private Awards to a player.(TC 589249)
	Given User switch to "web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	#Search Permission
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User enters text "SC_VOIDPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	#Verify Permission Name, Category and Description
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.tbl_PermissionTable_EditPermissions" is present "true" on UI with parameters
		| Key            | Value                                                                         |
		| PermissionName | SC_VOIDPRIVATEAWARD                                                           |
		| Category       | Loyalty Lite                                                                  |
		| Description    | ALLOWS A USER TO VOID PRIVATE BUCKET AWARD ASSIGNED TO PLAYER IN LOYALTY LITE |
	When User waits "5" seconds
	#Enable the PRIVATEAWARDUPLOAD Permission check
	Then User "unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value               |
		| permissionname | SC_VOIDPRIVATEAWARD |
	#Verify Permission has enabled or not
	Then User verifies attribute "title" value "Unchecked" of element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value               |
		| permissionname | SC_VOIDPRIVATEAWARD |
	# Save the Permission
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI
	#Verify if Permission "SC_VOIDPRIVATEAWARD" is not enabled then user should not be able to void award from LL
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	When User waits "2" seconds
	Given User clicks on "OLL_LOGIN.btn_Submit"
	Given User clears "OLL_MAIN_NAV.txt_PlayerID_Search"
	Given User types text "<$PLAYER_ID108$>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	#Go to Player History and select Bucket Award
	Given User clicks on "LLSideNavigation.lbl_PlayerHistory"
	Given User clicks on "LLSideNavigation.lnk_BucketAwards"
	#Search Bucket Award
	Given User types text "<#PrivateAwardPromo#>" in "LLPlayerAward.txtplayerbucketawardsearch"
	Given User clicks on "LLPlayerAward.btnassignedawardsearch"
	Given User clicks on "LLPlayerAward.lbl_AddedAwardName"
	#Verify Void button is enabled or not
	When User gets attribute "enabled" value of "LLPlayerAward.btn_VoidBucketAward" element to save with key "AwardStatus"
	When User performs string operation "stringEquals" of provided value "<$AwardStatus$>" with "False"
	Given User closes application

Scenario: 007-Close all Instance of Mass Importer desktop application.
	When User switch to window application "ATI.Loyalty.MassImporter.exe"
	Given User closes application

Scenario: 008-Close all instance of Loyalty Lite Desktop application.
	When User switch to window application "ATI.Loyalty.Lite.Client.exe"
	Given User closes application