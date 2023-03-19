@Release_15.0@Group_PrivateOffer@Web
Feature: OL_OfferAndAwardAssignmentFromTransportManagement
#******************************************************************************
#**  Feature File                 : OL_OfferAndAwardAssignmentFromTransportManagement.feature
#**  Feature Name                 : Private Offer and award availability at Transportation Management.
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 590046,598683
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  07/11/2022     Jogendra Singh            Initial Draft
#********************************************************************************/
#
#/*************************************************************************

Scenario: 001-Provide VIEWASSIGNPRIVATEAWARD permission to user group.(TC 590046)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "VIEWASSIGNPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Verification of permission , it's category and description
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lnk_PermissionDetailAll" is present "true" on UI with parameters
	| Key            | Value                                                            |
	| PermissionName | VIEWASSIGNPRIVATEAWARD                                           |
	| Category       | Player Functions                                                 |
	| Description    | ALLOWS A USER TO VIEW AND ASSIGN PRIVATE BUCKET AWARDS TO PLAYER |
	When User waits "2" seconds
	#assign VIEWASSIGNPRIVATEAWARD permission from UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                  |
	| permissionname | VIEWASSIGNPRIVATEAWARD |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario: 002-Validate Private award availability at agreement page by giving  VIEWASSIGNPRIVATEAWARD permission to user.(TC 590046)
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "select  Top 1 P.PropertyID from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "actualPropID"
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 0 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "secondproperty"
	When User runs query "select  Top 1 P.PropertyID from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 0 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "propertyID2"
	When User runs query "select P.CorpProp from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "Prop1"
	When User runs query "select Top 1 p.CorpProp from UC_X_Property p, UC_X_Host h where PropertyName not in (select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>') and p.Active = 1 and p.PropertyID = h.PropertyID and h.IsUniverse = 0" with connection "<#Halo_db_connectionstring#>" and save with key "Prop2"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "currenttime"
	When User generates a "getDate" with "MM/dd/yyyy" for key "todayDate"
	# Pre-requisite test data for this scenario | Add Operator and Carrier
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Transportation Management" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.TRANSPORATION_MANAGEMENT_LINK"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkAdministration"
	When User waits "2" seconds
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.AGREEMENTS_FRAME"
	# Add Type which is pre-requisite data for Adding an Operator
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkType"
	When User waits "1" seconds
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.frmTransportreportframe"
	When User waits "1" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnAddtype"
	When User generates a "UniqueString" with "Type_Automation_:4" for key "typeName"
	Given User enters text "<$typeName$>" in "TRANSPORTATION_MANAGEMENT.txtTypename"
	When User waits "1" seconds
	When User generates a "UniqueString" with "This Type <$typeName$> is created using Automation_:2" for key "Typedes"
	Given User enters text "<$Typedes$> " in "TRANSPORTATION_MANAGEMENT.txtTypedescription"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.SAVE_SCHEDULE_BUTTON"
	Then User verifies text - "Record inserted successfully" is present on page
	Given User switches to frame "default"
	# Add Operator
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkOperator"
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.AGREEMENTS_FRAME"
	When User waits "1" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnAddoperator"
	Given User switches to frame "default"
	When User waits "1" seconds
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.ADD_NEW_AGREEMENT_FRAME"
	When User waits "1" seconds
	When User generates a "UniqueString" with "Operator_Automation_:4" for key "operatorName"
	Given User enters text "<$operatorName$>" in "TRANSPORTATION_MANAGEMENT.txtOperatorname"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkClickproperty"
	When User waits "2" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.chkPropertyname" with parameters
	| Key      | Value            |
	| propName | <$PropertyName$> |
	When User waits "1" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkClickproperty"
	When User generates a "randomnumeric" with "10" for key "Vendornumber"
	Given User enters text "<$Vendornumber$>" in "TRANSPORTATION_MANAGEMENT.OperatorVendorNumber"
	Given User enters text "1.20" in "TRANSPORTATION_MANAGEMENT.OperatorTax"
	Given User selects option "<$typeName$>" of element "TRANSPORTATION_MANAGEMENT.lstOperatortype" by "visibletext"
	Given User enters text "<addressLine1>" in "TRANSPORTATION_MANAGEMENT.txtMainaddressone"
	Given User enters text "<addressLine2>" in "TRANSPORTATION_MANAGEMENT.txtMainaddresstwo"
	Given User enters text "<cityName>" in "TRANSPORTATION_MANAGEMENT.txtOperatorcity"
	Given User enters text "<stateName>" in "TRANSPORTATION_MANAGEMENT.txtOperatorstate"
	Given User enters text "<zipCode>" in "TRANSPORTATION_MANAGEMENT.txtOperatorzip"
	Given User selects option "<country>" of element "TRANSPORTATION_MANAGEMENT.lstOperatorcountry" by "visibletext"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.chkAddressbox"
	When User waits "2" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.SAVE_SCHEDULE_BUTTON"
	Given User switches to frame "default"
	When User waits "1" seconds
	# Add Carrier
	When User waits "2" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkCarrier"
	When User waits "1" seconds
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.AGREEMENTS_FRAME"
	When User scrolls till element "TRANSPORTATION_MANAGEMENT.btnAddcarrier"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnAddcarrier"
	When User waits "2" seconds
	Given User switches to frame "default"
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.ADD_NEW_AGREEMENT_FRAME"
	When User generates a "UniqueString" with "Carrier_Auto_:4" for key "CarrierName"
	Given User enters text "<$CarrierName$>" in "TRANSPORTATION_MANAGEMENT.txtCarriername"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkClickproperty"
	When User waits "2" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.chkPropertyname" with parameters
	| Key      | Value            |
	| propName | <$PropertyName$> |
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkClickproperty"
	When User waits "2" seconds
	Given User enters text "Address One" in "TRANSPORTATION_MANAGEMENT.txtMainaddressone"
	Given User enters text "Address Two" in "TRANSPORTATION_MANAGEMENT.txtMainaddresstwo"
	Given User enters text "Vegas" in "TRANSPORTATION_MANAGEMENT.txtOperatorcity"
	Given User enters text "Nevada" in "TRANSPORTATION_MANAGEMENT.txtOperatorstate"
	Given User enters text "95001" in "TRANSPORTATION_MANAGEMENT.txtOperatorzip"
	Given User selects option "United States" of element "TRANSPORTATION_MANAGEMENT.lstOperatorcountry" by "visibletext"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.chkAddressbox"
	When User waits "2" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.SAVE_SCHEDULE_BUTTON"
	When User "refresh" the browser
	When User waits "2" seconds
	#Add templete
	Given User switches to frame "default"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkAdministration"
	When User waits "1" seconds
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.AGREEMENTS_FRAME"
	When User waits "1" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkLettertemplate"
	Given User switches to frame "TRANSPORTATION_MANAGEMENT.frmTransportreportframe"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnAddtype"
	When User generates a "UniqueString" with "Letter_Automation_:4" for key "letterName"
	Given User enters text "<$letterName$>" in "TRANSPORTATION_MANAGEMENT.txtTypename"
	Given User selects option "<$PropertyName$>" of element "TRANSPORTATION_MANAGEMENT.lstSelectproperty" by "visibletext"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnSave"
	When User waits "2" seconds
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
	Given User enters text "^$agreementName$^" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_NAME_TEXTBOX"
	Given User enters text "<agreementDesc>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_DESCRIPTION_TEXTBOX"
	Given User enters text "<tourCost>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_TOURCOST_TEXTBOX"
	Given User enters text "<originCity>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_ORIGINCITY_TEXTBOX"
	Given User selects option "<$PropertyName$>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_DESTINATION_DROPDOWN" by "visibletext"
	Given User selects option "<$operatorName$>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_OPERATOR_DROPDOWN" by "visibletext"
	Given User enters text "<benefitsDescription>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_BENEFITS_DESCRIPTION_TEXTBOX"
	Given User selects option "<$CarrierName$>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_CARRIER_DROPDOWN" by "visibletext"
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
	When User scrolls till element "OLW_AGREEMENTS.chk_bucketaward"
	When User waits "2" seconds
	Then User "checks" element "OLW_AGREEMENTS.chk_bucketaward"
	When User waits "2" seconds
	Given User clicks on "OLW_AGREEMENTS.mic_bucketawarddrop"
	When User waits "2" seconds
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_AGREEMENTS.txt_playerawardsearch"
	When User waits "2" seconds
	Then User verifies that element "OLW_AGREEMENTS.mic_privatebucketaward" is present "true" on UI with parameters
    | Key           | Value                 |
    | PRBucketAward | <#PrivateAwardPromo#> |
	Given User clicks on "OLW_AGREEMENTS.mic_privatebucketaward" with parameters
	 | Key           | Value                 |
	 | PRBucketAward | <#PrivateAwardPromo#> |
Examples: 
 | startTime | endTime   | Option               | benefitsDescription | EXP_DRP_DWN | charterNumber | maxPassengers | originCity | tourCost | agreementDesc  | addressLine1 | addressLine2 | cityName | stateName | zipCode | country       | successMessage               | newAddLine1     | newAddLine2     |
 | 12:01  AM | 10:00  PM | AutomationAutoSettle | Benefit Description | Day(s)      | 9             | 5             | Dallas     | 20       | Agreement Desc | Address One  | Address Two  | Texas    | Texas     | 95001   | United States | Record inserted successfully | new Address One | new Address Two |

 Scenario: 003-Removing VIEWASSIGNPRIVATEAWARD permission to user group.(TC 590046)	
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "VIEWASSIGNPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Removing VIEWASSIGNPRIVATEAWARD permission from UC_TechServices user group.
	Then User "unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                  |
	| permissionname | VIEWASSIGNPRIVATEAWARD |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario: 004-To Validate Private award availability at agreement page by removing VIEWASSIGNPRIVATEAWARD permission to user.(TC 590046)
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "select  Top 1 P.PropertyID from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "actualPropID"
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 0 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "secondproperty"
	When User runs query "select  Top 1 P.PropertyID from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 0 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "propertyID2"
	When User runs query "select P.CorpProp from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "Prop1"
	When User runs query "select Top 1 p.CorpProp from UC_X_Property p, UC_X_Host h where PropertyName not in (select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>') and p.Active = 1 and p.PropertyID = h.PropertyID and h.IsUniverse = 0" with connection "<#Halo_db_connectionstring#>" and save with key "Prop2"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "currenttime"
	When User generates a "getDate" with "MM/dd/yyyy" for key "todayDate"
	# Launch WebApp
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Transportation Management" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.TRANSPORATION_MANAGEMENT_LINK"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkAdministration"
	When User waits "2" seconds
	#Add Agreement.	
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
	Given User enters text "^$agreementName$^" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_NAME_TEXTBOX"
	Given User enters text "<agreementDesc>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_DESCRIPTION_TEXTBOX"
	Given User enters text "<tourCost>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_TOURCOST_TEXTBOX"
	Given User enters text "<originCity>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_ORIGINCITY_TEXTBOX"
	Given User selects option "<$PropertyName$>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_DESTINATION_DROPDOWN" by "visibletext"
	Given User selects option "<$operatorName$>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_OPERATOR_DROPDOWN" by "visibletext"
	Given User enters text "<benefitsDescription>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_BENEFITS_DESCRIPTION_TEXTBOX"
	Given User selects option "<$CarrierName$>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_CARRIER_DROPDOWN" by "visibletext"
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
	When User scrolls till element "OLW_AGREEMENTS.chk_bucketaward"
	When User waits "2" seconds
	Then User "checks" element "OLW_AGREEMENTS.chk_bucketaward"
	When User waits "2" seconds
	Given User clicks on "OLW_AGREEMENTS.mic_bucketawarddrop"
	When User waits "2" seconds
	Given User enters text "<#PrivateAwardPromo#>" in "OLW_AGREEMENTS.txt_playerawardsearch"
	When User waits "2" seconds
	Then User verifies that element "OLW_AGREEMENTS.mic_privatebucketaward" is present "false" on UI with parameters
    | Key           | Value                 |
    | PRBucketAward | <#PrivateAwardPromo#> |
Examples: 
 | startTime | endTime   | Option               | benefitsDescription | EXP_DRP_DWN | charterNumber | maxPassengers | originCity | tourCost | agreementDesc  | addressLine1 | addressLine2 | cityName | stateName | zipCode | country       | successMessage               | newAddLine1     | newAddLine2     |
 | 12:01  AM | 10:00  PM | AutomationAutoSettle | Benefit Description | Day(s)      | 9             | 5             | Dallas     | 20       | Agreement Desc | Address One  | Address Two  | Texas    | Texas     | 95001   | United States | Record inserted successfully | new Address One | new Address Two |


 Scenario: 005-Providing VIEWASSIGNPRIVATEAWARD permission to user group.(TC 590046)	
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "VIEWASSIGNPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#assign VIEWASSIGNPRIVATEAWARD permission from UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                  |
	| permissionname | VIEWASSIGNPRIVATEAWARD |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario: 006- Providing MANAGEPRIVATEOFFER permission to user group.
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "MANAGEPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#assign VIEWASSIGNPRIVATEAWARD permission from UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value              |
	| permissionname | MANAGEPRIVATEOFFER |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario: 007-Validate availability of private offer at Agrrement page when user group have MANAGEPRIVATEOFFER.(TC 598683)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Transportation Management" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.TRANSPORATION_MANAGEMENT_LINK"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkAdministration"
	When User waits "2" seconds
	#Add Agreement.	
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
	Given User enters text "^$agreementName$^" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_NAME_TEXTBOX"
	Given User enters text "<agreementDesc>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_DESCRIPTION_TEXTBOX"
	Given User enters text "<tourCost>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_TOURCOST_TEXTBOX"
	Given User enters text "<originCity>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_ORIGINCITY_TEXTBOX"
	Given User selects option "<$PropertyName$>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_DESTINATION_DROPDOWN" by "visibletext"
	Given User selects option "<$operatorName$>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_OPERATOR_DROPDOWN" by "visibletext"
	Given User enters text "<benefitsDescription>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_BENEFITS_DESCRIPTION_TEXTBOX"
	Given User selects option "<$CarrierName$>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_CARRIER_DROPDOWN" by "visibletext"
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
	When User scrolls till element "OLW_AGREEMENTS.chk_offer"
	When User waits "2" seconds
	Then User "checks" element "OLW_AGREEMENTS.chk_offer"
	When User waits "2" seconds
	Given User clicks on "OLW_AGREEMENTS.mic_offerdropdown"
	When User waits "2" seconds
	Then User verifies that element "OLW_AGREEMENTS.mic_offer" is present "true" on UI with parameters
    | Key     | Value         |
    | PROffer | <#OfferName#> |
	Given User clicks on "OLW_AGREEMENTS.mic_offer" with parameters
   | Key     | Value         |
   | PROffer | <#OfferName#> |
Examples: 
 | startTime | endTime   | Option               | benefitsDescription | EXP_DRP_DWN | charterNumber | maxPassengers | originCity | tourCost | agreementDesc  | addressLine1 | addressLine2 | cityName | stateName | zipCode | country       | successMessage               | newAddLine1     | newAddLine2     |
 | 12:01  AM | 10:00  PM | AutomationAutoSettle | Benefit Description | Day(s)      | 9             | 5             | Dallas     | 20       | Agreement Desc | Address One  | Address Two  | Texas    | Texas     | 95001   | United States | Record inserted successfully | new Address One | new Address Two |


Scenario: 008- Removing MANAGEPRIVATEOFFER permission to user group.
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "MANAGEPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Removing VIEWASSIGNPRIVATEAWARD permission from UC_TechServices user group.
	Then User "unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value              |
	| permissionname | MANAGEPRIVATEOFFER |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario: 009-Validate availability of private offer at Agrrement page when user group don't have MANAGEPRIVATEOFFER.(TC 598683)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Transportation Management" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.TRANSPORATION_MANAGEMENT_LINK"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkAdministration"
	When User waits "2" seconds
	#Add Agreement.	
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
	Given User enters text "^$agreementName$^" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_NAME_TEXTBOX"
	Given User enters text "<agreementDesc>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_DESCRIPTION_TEXTBOX"
	Given User enters text "<tourCost>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_TOURCOST_TEXTBOX"
	Given User enters text "<originCity>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_ORIGINCITY_TEXTBOX"
	Given User selects option "<$PropertyName$>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_DESTINATION_DROPDOWN" by "visibletext"
	Given User selects option "<$operatorName$>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_OPERATOR_DROPDOWN" by "visibletext"
	Given User enters text "<benefitsDescription>" in "TRANSPORTATION_MANAGEMENT.AGREEMENT_BENEFITS_DESCRIPTION_TEXTBOX"
	Given User selects option "<$CarrierName$>" of element "TRANSPORTATION_MANAGEMENT.AGREEMENT_CARRIER_DROPDOWN" by "visibletext"
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
	When User scrolls till element "OLW_AGREEMENTS.chk_offer"
	When User waits "2" seconds
	Then User "checks" element "OLW_AGREEMENTS.chk_offer"
	When User waits "2" seconds
	Given User clicks on "OLW_AGREEMENTS.mic_offerdropdown"
	When User waits "2" seconds
	Then User verifies that element "OLW_AGREEMENTS.mic_offer" is present "false" on UI with parameters
    | Key     | Value         |
    | PROffer | <#OfferName#> |
Examples: 
 | startTime | endTime   | Option               | benefitsDescription | EXP_DRP_DWN | charterNumber | maxPassengers | originCity | tourCost | agreementDesc  | addressLine1 | addressLine2 | cityName | stateName | zipCode | country       | successMessage               | newAddLine1     | newAddLine2     |
 | 12:01  AM | 10:00  PM | AutomationAutoSettle | Benefit Description | Day(s)      | 9             | 5             | Dallas     | 20       | Agreement Desc | Address One  | Address Two  | Texas    | Texas     | 95001   | United States | Record inserted successfully | new Address One | new Address Two |

 Scenario: 010-Providing MANAGEPRIVATEOFFER permission to user group.
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "MANAGEPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#assign VIEWASSIGNPRIVATEAWARD permission from UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value              |
	| permissionname | MANAGEPRIVATEOFFER |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page