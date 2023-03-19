@Sequential@Release_15.0@UploadPrivateBucketAwardfromMassImporter@Desktop
Feature: Upload_BucketAward_via_MassImporter

#******************************************************************************
#**  Feature File                 : OL_Upload_BucketAward_via_MassImporter.feature
#**  Feature Name                 : upload Bucket Award via Mass Importer
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 582075,582096,582105
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  05/13/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/
#
#/*************************************************************************
Scenario:001-  To verify the user is able to add permission to the user under under Group Permissions Tab. (TC 582075)
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
	#Disable the Permission check
	Then User "Unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value              |
		| permissionname | PRIVATEAWARDUPLOAD |
	#Verify Permission has disabled or not
	Then User verifies attribute "title" value "Unchecked" of element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value              |
		| permissionname | PRIVATEAWARDUPLOAD |
	# Save the Permission
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI
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

Scenario:002   Verify the user is able to upload Award Type successfully with 'Is Private' column as 'Y' (TC 582096)
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
	Given User selects option "Award Type" of element "MI_Login.SelectUpdateType_Dropdown" by "value"
	When User generates a "UniqueString" with "AwardType:4" for key "AwardType"
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

Scenario:003- Verify the user is able to upload Award Type successfully with 'Is Private' column as 'N' (TC 582096)
	When User runs query "Select P.CorpProp from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyCorpProp"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate"
	When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "1000" on dateTime "<$startdate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	Given User switch to "desktop" application
	#Login to Mass Importer
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Mass Importer\ATI.Loyalty.MassImporter.exe"
	Given User types text "<#Halo_username#>" in "MI_Login.txt_UserID"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "MI_Login.Domain_DropDown" by "value"
	When User waits "4" seconds
	Given User clicks on "MI_Login.btn_SignIn"
	When User waits "25" seconds
	Given User selects option "Award Type" of element "MI_Login.SelectUpdateType_Dropdown" by "value"
	When User generates a "UniqueString" with "AwardType:4" for key "AwardType"
	When User generates a "UniqueString" with "Award_:5" for key "AwardName"
	#Create Bucket Award Excel File
	When User "creates" excel file "<$AwardType$>" with sheet "Award Type" in "xls" format with data
		| Name          | BucketView      | Corp Prop            | Start Date    | End Date    | Amount | IsKiosk | IsPrivate |
		| <$AwardName$> | Universal Promo | <$PropertyCorpProp$> | <$startdate$> | <$enddate$> | 10     | N       | N         |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	#Upload Above created Bucket Award Excel File
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

Scenario:004- To verify the user is not able to upload Award Type  with 'Is Private' column as 'Y' when uses doesn't have the required permission "PRIVATEAWARDUPLOAD". (TC 582105)
	#Switch to web App
	Given User switch to "Web" application
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
	#Disable the Permission check
	Then User "Unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value              |
		| permissionname | PRIVATEAWARDUPLOAD |
	#Verify Permission has disabled or not
	Then User verifies attribute "title" value "Unchecked" of element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
		| Key            | Value              |
		| permissionname | PRIVATEAWARDUPLOAD |
	# Save the Permission
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI
	#Switch to Desktop Application (Mass Importer)
	When User runs query "Select P.CorpProp from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyCorpProp"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate"
	When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "1" on dateTime "<$startdate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	Given User switch to "desktop" application
	#Login to Mass Importer
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Mass Importer\ATI.Loyalty.MassImporter.exe"
	Given User types text "<#Halo_username#>" in "MI_Login.txt_UserID"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "MI_Login.Domain_DropDown" by "value"
	When User waits "4" seconds
	Given User clicks on "MI_Login.btn_SignIn"
	When User waits "25" seconds
	Given User selects option "Award Type" of element "MI_Login.SelectUpdateType_Dropdown" by "value"
	When User generates a "UniqueString" with "AwardType:4" for key "AwardType"
	When User generates a "UniqueString" with "Award_:5" for key "AwardName"
	#Upload Private Award via Mass Importer
	When User "creates" excel file "<$AwardType$>" with sheet "Award Type" in "xls" format with data
		| Name          | BucketView      | Corp Prop            | Start Date    | End Date    | Amount | IsKiosk | IsPrivate |
		| <$AwardName$> | Universal Promo | <$PropertyCorpProp$> | <$startdate$> | <$enddate$> | 10     | N       | Y         |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User types text "<$testbaseLocation$>\<$AwardType$>.xls" in "MASS_IMPORTER.BulUPdateCSV"
	When User waits "2" seconds
	When User switch to window object "BulkUpdate.frmBulkUpdateFrame"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User clicks on "MI_Login.btn_BeginBulkUpdate"
	When User waits "10" seconds
	#Verify the error message
	Then User verifies that element "BulkUpdate.lbl_Unsuccess_Msg" is present "true" on UI
	When User switch to window object "default"
	When User waits "30" seconds
	Given User clicks on "BulkUpdate.btn_OK"
	Given User closes application

Scenario:005- To verify the user is able to upload Award Type successfully with 'Is Private' column as 'N'  when uses doesn't have the required permission "PRIVATEAWARDUPLOAD". (TC 582105)
	#Switch to Desktop Application (Mass Importer)
	When User runs query "Select P.CorpProp from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyCorpProp"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate"
	When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "1" on dateTime "<$startdate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	Given User switch to "desktop" application
	#Login to Mass Importer
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Mass Importer\ATI.Loyalty.MassImporter.exe"
	Given User types text "<#Halo_username#>" in "MI_Login.txt_UserID"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "MI_Login.Domain_DropDown" by "value"
	When User waits "4" seconds
	Given User clicks on "MI_Login.btn_SignIn"
	When User waits "25" seconds
	Given User selects option "Award Type" of element "MI_Login.SelectUpdateType_Dropdown" by "value"
	When User generates a "UniqueString" with "AwardType:4" for key "AwardType"
	When User generates a "UniqueString" with "Award_:5" for key "AwardName"
	#Upload Private Award via Mass Importer
	When User "creates" excel file "<$AwardType$>" with sheet "Award Type" in "xls" format with data
		| Name          | BucketView      | Corp Prop            | Start Date    | End Date    | Amount | IsKiosk | IsPrivate |
		| <$AwardName$> | Universal Promo | <$PropertyCorpProp$> | <$startdate$> | <$enddate$> | 10     | N       | N         |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User types text "<$testbaseLocation$>\<$AwardType$>.xls" in "MASS_IMPORTER.BulUPdateCSV"
	When User waits "2" seconds
	When User switch to window object "BulkUpdate.frmBulkUpdateFrame"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User clicks on "MI_Login.btn_BeginBulkUpdate"
	When User waits "40" seconds
	#Verify the error message
	When User switch to window object "default"
	Then User verifies that element "BulkUpdate.lblbulksuccess" is present "true" on UI
	Given User clicks on "BulkUpdate.btn_OK"
	Given User closes application
	Given User switch to "Web" application

Scenario: 006-Close all Instance of Mass Importer desktop application.
	When User switch to window application "ATI.Loyalty.MassImporter.exe"
	Given User closes application