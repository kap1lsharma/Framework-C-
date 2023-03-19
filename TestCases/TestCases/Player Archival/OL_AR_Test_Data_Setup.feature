@Release_15.0 @Group_Player_Archival @Enviroment_Setup
Feature: OL_AR_Test_Data_Setup Setting up Test Data for Transportation Management for Archival

#******************************************************************************************************
#** Feature File                    : OL_AR_Test_Data_Setup
#** Feature Name                    : Setting up Test Data for Transportation Management for Archival
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                :
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  30/05/2022           Ajay Dahiya
#**************************************************************************************************/
Scenario Outline: SSetting up Test Data for Transportation Management for Archival
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "select  Top 1 P.PropertyID from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "actualPropID"
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 0 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "secondproperty"
	When User runs query "select  Top 1 P.PropertyID from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 0 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "propertyID2"
	When User runs query "select P.CorpProp from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "Prop1"
	When User runs query "select Top 1 p.CorpProp from UC_X_Property p, UC_X_Host h where PropertyName not in (select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>') and p.Active = 1 and p.PropertyID = h.PropertyID and h.IsUniverse = 0" with connection "<#Halo_db_connectionstring#>" and save with key "Prop2"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "currenttime"
	When User generates a "getDate" with "MM/dd/yyyy" for key "todayDate"
	# Pre-requisite test data for this scenario | Add Operator and Carrier
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
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
	Given User enters text "<#Transportation_Type#>" in "TRANSPORTATION_MANAGEMENT.txtTypename"
	When User waits "1" seconds
	When User generates a "UniqueString" with "This Type Type_Automation is created using Automation_:2" for key "Typedes"
	Given User enters text "Type_Automation " in "TRANSPORTATION_MANAGEMENT.txtTypedescription"
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
	Given User enters text "<#Transportation_Operator#>" in "TRANSPORTATION_MANAGEMENT.txtOperatorname"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkClickproperty"
	When User waits "2" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.chkPropertyname" with parameters
		| Key      | Value            |
		| propName | <$PropertyName$> |
	When User waits "1" seconds
	Given User clicks on "TRANSPORTATION_MANAGEMENT.lnkClickproperty"
	When User generates a "randomnumeric" with "10" for key "Vendornumber"
	Given User enters text "<#Transportation_Vendor#>" in "TRANSPORTATION_MANAGEMENT.OperatorVendorNumber"
	Given User enters text "1.20" in "TRANSPORTATION_MANAGEMENT.OperatorTax"
	Given User selects option "<#Transportation_Type#>" of element "TRANSPORTATION_MANAGEMENT.lstOperatortype" by "visibletext"
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
	Given User enters text "<#Transportation_Carrier#>" in "TRANSPORTATION_MANAGEMENT.txtCarriername"
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
	Given User enters text "<#Transportation_Template#>" in "TRANSPORTATION_MANAGEMENT.txtTypename"
	Given User selects option "<$PropertyName$>" of element "TRANSPORTATION_MANAGEMENT.lstSelectproperty" by "visibletext"
	Given User clicks on "TRANSPORTATION_MANAGEMENT.btnSave"
	When User waits "2" seconds
	
	Examples:
		| selectActive | Option               | EXP_DRP_DWN | addressLine1 | addressLine2 | cityName | stateName | zipCode | country       | successMessage               | newAddLine1     | newAddLine2     | newCity | newState | newCode | expired |
		| Inactive     | AutomationAutoSettle | Day(s)      | Address One  | Address Two  | Texas    | Texas     | 95001   | United States | Record inserted successfully | new Address One | new Address Two | Arizona | Arizona  | 95006   | Expired |