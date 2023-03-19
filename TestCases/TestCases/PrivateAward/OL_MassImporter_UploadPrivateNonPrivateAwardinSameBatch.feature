@Sequential@Release_15.0@Awards@desktop
Feature: OL_MassImporter_UploadPrivateNonPrivateAwardinSameBatch

#**  Feature File                 : OL_VoidBatch_PrivateBucketAwards.feature
#**  Feature Name                 : Upload Player Award via mass importer and Void Batch Bucket Awards via webapp
#**  Defect/Bug Linked(if any)    :
#**  TFS TC ID Linked             : 589242
#********************************************************************************/
#    Date:      Author:           Comments
#**  --------   --------------    --------------
#**  07/27/2022   Pooja Kashyap      Initial Version

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
		| 1000         | Standard   | SIR        | Test2      | MassName2 | JR     | 01/01/1984 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID298  |
		| 1000         | Standard   | SIR        | Test3      | MassName3 | JR     | 01/01/1984 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID299  |

Scenario: 002- Enable the Permission Related to Award Upload via Mass Importer.(TC 589242)
	#Login to webapp and check Permission for VOid Awards.
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User enters text "VOIDPRIVATEAWARDBATCHUPLOAD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.tbl_PermissionTable_EditPermissions" is present "true" on UI with parameters
		| Key            | Value                       |
		| PermissionName | VOIDPRIVATEAWARDBATCHUPLOAD |
		| Category       | Administration              |
		| Description    | VOID PRIVATE AWARD BATCH    |
	#Enable the Permission
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value                       |
		| permissionname | VOIDPRIVATEAWARDBATCHUPLOAD |
	When User waits "2" seconds
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI
	When User waits "2" seconds
	#Enable the Upload Bucket Award Permission
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
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
	#Enable the Permission check
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
	When User waits "2" seconds
	#Enable Void BAtch Permission
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "VOIDAWARDBATCH" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Verify Permission Name, Category and Description
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.tbl_PermissionTable_EditPermissions" is present "true" on UI with parameters
		| Key            | Value            |
		| PermissionName | VOIDAWARDBATCH   |
		| Category       | Administration   |
		| Description    | VOID AWARD BATCH |
	When User waits "5" seconds
	#Enable the PRIVATEAWARDUPLOAD Permission check
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value          |
		| permissionname | VOIDAWARDBATCH |
	#Verify Permission has enabled or not
	Then User verifies attribute "title" value "Checked" of element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value          |
		| permissionname | VOIDAWARDBATCH |
	# Save the Permission
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI

Scenario Outline:003- Upload Private and Non Private Player Award via Mass importer.(TC 589242)
	#Switch to Desktop Application (Mass Importer)
	# Assign Private and Non Private Award to Player from Mass Importer
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Mass Importer\ATI.Loyalty.MassImporter.exe"
	When User waits "20" seconds
	Given User types text "<#Halo_username#>" in "MI_Login.txt_UserID"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "MI_Login.Domain_DropDown" by "value"
	When User waits "4" seconds
	Given User clicks on "MI_Login.btn_SignIn"
	When User waits "20" seconds
	Given User selects option "Player Award" of element "MI_Login.SelectUpdateType_Dropdown" by "value"
	When User generates a "UniqueString" with "PlayerPrivateAward:4" for key "PlayerAward2"
	#Upload Bucket Award via Mass Importer
	When User "creates" excel file "<$PlayerAward2$>" with sheet "Player_Award" in "xls" format with data
		| UniversalPlayerId | Award Type            |
		| <$PLAYER_ID298$>  | <#PrivateAwardPromo#> |
		| <$PLAYER_ID299$>  | <#NonPrivateAward#>   |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User types text "<$testbaseLocation$>\<$PlayerAward2$>.xls" in "MASS_IMPORTER.BulUPdateCSV"
	When User waits "2" seconds
	When User switch to window object "BulkUpdate.frmBulkUpdateFrame"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User clicks on "MI_Login.btn_BeginBulkUpdate"
	When User waits "20" seconds
	When User switch to window object "default"
	Then User verifies that element "BulkUpdate.lblbulksuccess" is present "true" on UI
	Given User clicks on "BulkUpdate.btn_OK"
	When User switch to window object "BulkUpdate.frmBulkUpdateFrame"
	When User gets attribute "Value" value of "BulkUpdate.txt_BatchID" element to save with key "BatchID2"

Scenario Outline:004- Verify that both Private and Non Private Awards cannot be uploaded in the same Batch From Mass Importer.(TC 589242)
	#Switch to webapp
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Void Bulk Upload Awards" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value                   |
		| SideSubMenu | Void Bulk Upload Awards |
	Then User verifies that element "OLW_VoidBulkUploadAwards.lbl_PageTitle" is present "true" on UI
	Then User verifies that element "OLW_VoidBulkUploadAwards.tbl_BatchID" is present "false" on UI with parameters
		| Key     | Value        |
		| BatchID | <$BatchID2$> |
	When User waits "2" seconds

	Examples:
		| Inactivity_Days | Exceed_Freq | schedule_day     | schedule_time     | BucketAwardVoidScheduleJobPath                                                                                        |
		| 180             | Days        | <$Schedule_Day$> | <$Schedule_Time$> | C:\Program Files\Aristocrat\OASIS LOYALTY\TaskCoordinator\BucketAwardVoidance\OasisLoyalty.BucketAwardVoidanceJob.exe |

Scenario: 005- Verify that the error on uploading private and non private award should appear in mass importer error report in Web App.(TC 589242)
	#update Date in DB
	When User runs query "select P.PropertyName from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User generates a "getDate" with "yyyy-MM-dd hh:mm:ss" for key "currendate"
	When User performs action "subtractdays" of "1" on dateTime "<$currendate$>" with format "yyyy-MM-dd hh:mm:ss" to save the result for key "ProcessStausDate"
	When User executes query "update UC_MU_PlayerAward set ProcessStatusDate = '<$ProcessStausDate$>' where UniversalPlayerId ='<$PLAYER_ID298$>'" with connection "<#Halo_db_connectionstring#>"
	When User executes query "update UC_MU_PlayerAward set ProcessStatusDate = '<$ProcessStausDate$>' where UniversalPlayerId ='<$PLAYER_ID299$>'" with connection "<#Halo_db_connectionstring#>"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Mass Importer Error Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                      |
		| ReportName | Mass Importer Error Report |
	When User waits "2" seconds
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_Report_MassImporterError.lbl_ReportTitle" is present "true" on UI
	Then User verifies that element "OLW_Report_MassImporterError.tbl_DetailsData" is present "true" on UI with parameters
		| Key          | Value            |
		| UniversalID  | <$PLAYER_ID298$> |
		| AwardType    | <Award_Type>     |
		| BatchID      | <$BatchID2$>     |
		| Property     | <$PropertyName$> |
		| ErrorMessage | <Error_Message>  |
	When User waits "2" seconds
	Then User verifies that element "OLW_Report_MassImporterError.tbl_DetailsData" is present "true" on UI with parameters
		| Key          | Value            |
		| UniversalID  | <$PLAYER_ID299$> |
		| AwardType    | <Award_Type>     |
		| BatchID      | <$BatchID2$>     |
		| Property     | <$PropertyName$> |
		| ErrorMessage | <Error_Message>  |
	When User waits "2" seconds

	Examples:
		| Award_Type   | Error_Message                                                               |  
		| Player Award | Private and non-private award should not assigned to player for same batch. |


Scenario: 006-Close all Instance of Mass Importer desktop application.
	When User switch to window application "ATI.Loyalty.MassImporter.exe"
	Given User closes application