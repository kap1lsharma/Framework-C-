@Sequential@Release_15.0@DcompConfiguration@sanity@TestDataSetup@Web 
Feature: DComp_Configuration

#**  Feature File                 : OL_EB_DComp_Configuration.feature
#**  Feature Name                 : Dcomp Configuration(ADT Range Group, Dcomp Bucket Configuration, Manage Matrix, Manage Configuration
#**  Defect/Bug Linked(if any)    :
#**  TFS TC ID Linked             : 590557,590562,590564,590565
#********************************************************************************/
#    Date:      Author:           Comments
#**  --------   --------------    --------------
#**  05/02/2022   Pooja Kashyap      Initial Version

Scenario: 001- Pre-Data Creation for Dcomp Configuration
	When User runs query "select P.PropertyName from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When  User generates a "UniqueString" with "AutoADTGroup:4" for key "ADTRangeGroup"
	When  User generates a "UniqueString" with "ADTRange:2" for key "ADTRangeName"
	When  User generates a "UniqueString" with "MatrixDesc:4" for key "MatrixDesc"
	When User generates a "randomnumeric" with "1" for key "AutoADTValue"
	When User saves arithmetic operation "numberadd" of provided value "1" with "<$AutoADTValue$>" to key "AutoMinimumADT"
	When User saves arithmetic operation "numberadd" of provided value "10" with "<$AutoADTValue$>" to key "AutoMaxADT"
	#Create Dcomp Bucket
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Configure Buckets" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Configure Buckets |
	When User waits "2" seconds
	Given User clicks on "OLW_Configure_Bucket.btn_ADD_ExtendedBucket"
	When User waits "4" seconds
	When  User generates a "UniqueString" with "Auto_DComp:4" for key "AutoDcomp_Bucket"
	Given User enters text "<$AutoDcomp_Bucket$>" in "OLW_Configure_Bucket.txt_BucketName"
	When  User generates a "randomalphabetic" with "14" for key "BucketDes"
	Given User enters text "<$BucketDes$>" in "OLW_Configure_Bucket.txt_BucketDescription"
	When User waits "2" seconds
	Given User enters text "4" in "OLW_Configure_Bucket.txt_BucketPrecision"
	When User waits "2" seconds
	Given User clicks on "OLW_Configure_Bucket.chk_AllowCompItems"
	When User waits "3" seconds
	Given User clicks on "OLW_Configure_Bucket.chk_AllowNegative"
	When User waits "3" seconds
	Given User clicks on "OLW_Configure_Bucket.chk_Discretionary Comp"
	When User waits "3" seconds
	Given User clicks on "OLW_Configure_Bucket.chk_VisibletoPlayer"
	When User waits "5" seconds
	Given User clicks on "OLW_Configure_Bucket.rdb_OnGoing_RedemptionTimePeriod"
	When User waits "5" seconds
	Given User enters text "1" in "OLW_Configure_Bucket.txt_ConversionRate"
	Given User selects option "US Dollar" of element "OLW_Configure_Bucket.mic_Currency_DropDown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "OLW_Configure_Bucket.btn_Save&Continue_BucketDefinition"
	Then User verifies attribute "innerText" value "Universal Limits" of element "OLW_Configure_Bucket.mic_UniversalLimit_Text"
	When User waits "2" seconds
	When User runs query "select BucketViewID from dbo.BucketViews where BucketViewName='<$AutoDcomp_Bucket$>'" with connection "<#Halo_db_connectionstring#>" and save with key "DcompBucket_ViewID"
	#Apply Bucket Limit
	Given User clears "OLW_Configure_Bucket.txt_MaxBalance_BucketLimit"
	Given User enters text "1000" in "OLW_Configure_Bucket.txt_MaxBalance_BucketLimit"
	Given User clears "OLW_Configure_Bucket.txt_MaxEarnPerDay"
	Given User enters text "1000" in "OLW_Configure_Bucket.txt_MaxEarnPerDay"
	Given User clears "OLW_Configure_Bucket.txt_MaxNegativeBalance"
	Given User enters text "1000" in "OLW_Configure_Bucket.txt_MaxNegativeBalance"
	Given User clicks on "OLW_Configure_Bucket.btn_SaveandContinue_BucketLimit"
	#Grant Edit Bucket Association
	Given User enters text "Group Permissions" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Group Permissions |
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup#>" of element "USER_GROUP_PERMISSIONS.USER_GROUP_DROPDOWN" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.tab_EditBucketAssociation"
	Given User enters text "<$AutoDcomp_Bucket$>" in "OLW_USER_GROUP_PERMISSION.txt_BucketSearch_Filter"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btn_BucketSearch_EditBucketAssociation"
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.tbl_BucketTable_EditBucketAssociation" is present "true" on UI with parameters
		| Key        | Value                |
		| BucketName | <$AutoDcomp_Bucket$> |
	Given User clicks on "OLW_USER_GROUP_PERMISSION.chk_BucketChecbox_EditBucketAssociation"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btn_Save_EditBucketAssociation"
	When User waits "3" seconds
	Then User verifies text - "Permission saved successfully." is present on page

Scenario: 002- Create ADT Range Group (TC 590557)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Discretionary Comp" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value                     |
		| SideSubMenu | Manage Discretionary Comp |
	When User waits "2" seconds
	Given User clicks on "OLW_Manage_DComp.btn_Add_ADTRangeGroup"
	When User waits "2" seconds
	Given User enters text "<$ADTRangeGroup$>" in "OLW_Manage_DComp.txt_ADTRangeGroup"
	When User waits "3" seconds
	Given User clicks on "OLW_Manage_DComp.chk_Active_ADTRangeGroup"
	Given User enters text "<$ADTRangeName$>" in "OLW_Manage_DComp.txt_ADTRangeName"
	Given User enters text "<$MatrixDesc$>" in "OLW_Manage_DComp.txt_ADTRangeDescription"
	Given User enters text "<$AutoMinimumADT$>" in "OLW_Manage_DComp.txt_MinimumADTRange"
	Given User enters text "<$AutoMaxADT$>" in "OLW_Manage_DComp.txt_MaximumADTRange"
	Given User clicks on "OLW_Manage_DComp.btn_Add/Update_ADTRange"
	Then User verifies text - "Please save the changes." is present on page
	Given User clicks on "OLW_Manage_DComp.btn_Save"
	When User waits "2" seconds
	Then User verifies text - "ADT Level Created/Updated successfully." is present on page

Scenario Outline: 003-  Verify user is able to Link DComp Bucket with ADT Range Group (Tc 590562)
	# Link DComp Bucket with ADT Range Group
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Discretionary Comp" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value                     |
		| SideSubMenu | Manage Discretionary Comp |
	When User waits "2" seconds
	Given User clicks on "OLW_Manage_DComp.tab_DCompBucket_Configuration"
	Given User clicks on "OLW_Manage_DComp.txt_DCompBucketConfig_SearchFilter"
	Given User selects option "<$AutoDcomp_Bucket$>" of element "OLW_Manage_DComp.mic_DropDown_DcompBucket" by "visibletext"
	When User waits "4" seconds
	Given User selects option "<$ADTRangeGroup$>" of element "OLW_Manage_DComp.mic_DropDown_ADTRangeGroup" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "OLW_Manage_DComp.rdb_CalculationBasis" with parameters
		| Key               | Value              |
		| Calculation_Basis | <CalculationBasis> |
	Given User clicks on "OLW_Manage_DComp.rdb_CalculationType" with parameters
		| Key              | Value             |
		| Calculation_Type | <CalculationType> |
	When User waits "5" seconds
	Given User clicks on "OLW_Manage_DComp.btn_Save"
	Then User verifies that element "OLW_Manage_DComp.lbl_SuccessMsg_DcompBucketConfiuration" is present "true" on UI

	Examples:
		| CalculationBasis | CalculationType |
		| Local            | Standard        |

Scenario Outline: 004 - Verify user is able to Create Matrix for ADT Range (TC 590564)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Discretionary Comp" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value                     |
		| SideSubMenu | Manage Discretionary Comp |
	When User waits "2" seconds
	Given User clicks on "OLW_Manage_DComp.tab_ManageMatrix"
	Given User selects option "<$AutoDcomp_Bucket$>" of element "OLW_Manage_DComp.mic_DropDown_DcompBucket" by "visibletext"
	When User waits "3" seconds
	#Select Configure by Tier
	Given User clicks on "OLW_Manage_DComp.chk_ConfigureByTier"
	When User waits "3" seconds
	#Select Property
	Given User selects option "<$PropertyName$>" of element "OLW_Manage_DComp.mic_DropDown_Property" by "visibletext"
	When User waits "3" seconds
	#Select Tier
	Given User selects option "<Tier>" of element "OLW_Manage_DComp.mic_Tier_DropDown" by "visibletext"
	When User waits "3" seconds
	#Select ADT Range
	Given User selects option "<$ADTRangeName$>" of element "OLW_Manage_DComp.mic_SelectADTRange_ManageMatrix_Drpdown" by "visibletext"
	When User waits "3" seconds
	#Enter Slot Actual
	Given User enters text "<SlotActual>" in "OLW_Manage_DComp.txt_SlotActual"
	#Enter Slot Theo
	Given User enters text "<SlotTheo>" in "OLW_Manage_DComp.txt_SlotTheo"
	#Enter Table Actual
	Given User enters text "<TableActual>" in "OLW_Manage_DComp.txt_TableActual"
	#Enter Table Theo
	Given User enters text "<TableTheo>" in "OLW_Manage_DComp.txt_TableTheo"
	#Enter Other Actual
	Given User enters text "<OtherActual>" in "OLW_Manage_DComp.txt_OtherActual"
	#Enter Other Theo
	Given User enters text "<OtherTheo>" in "OLW_Manage_DComp.txt_OtherTheo"
	Given User clicks on "OLW_Manage_DComp.btn_Add/Update_ManageMatrix"
	When User waits "2" seconds
	Then User verifies text - "Please save the changes." is present on page
	Given User clicks on "OLW_Manage_DComp.btn_Save"
	When User waits "2" seconds
	Then User verifies text - "ADT Matrix saved successfully." is present on page

	Examples:
		| SlotActual | SlotTheo | TableActual | TableTheo | OtherActual | OtherTheo | Tier   |
		| 20         | 20       | 20          | 20        | 20          | 20        | Copper |

Scenario Outline: 005 - Manage Configuration (TC 590565)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Discretionary Comp" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value                     |
		| SideSubMenu | Manage Discretionary Comp |
	When User waits "2" seconds
	Given User clicks on "OLW_Manage_DComp.tab_ManageConfiguration"
	Given User selects option "<$AutoDcomp_Bucket$>" of element "OLW_Manage_DComp.mic_DropDown_DcompBucket" by "visibletext"
	When User waits "3" seconds
	#Select Property
	Given User selects option "<$PropertyName$>" of element "OLW_Manage_DComp.mic_DropDown_Property" by "visibletext"
	When User waits "3" seconds
	#Select Comp Basis
	Given User selects option "<CompBasis>" of element "OLW_Manage_DComp.mic_DropDown_CompBasis" by "visibletext"
	When User waits "3" seconds
	#Select Comp Method
	Given User selects option "<CompMethod>" of element "OLW_Manage_DComp.DropDown_CompMethod" by "visibletext"
	When User waits "3" seconds
	#enter Consider Quantity
	Given User enters text "1" in "OLW_Manage_DComp.txt_ConsiderQuantity"
	When User waits "3" seconds
	#enter Basis Quantity
	Given User enters text "1" in "OLW_Manage_DComp.txt_BasisQuantity"
	When User waits "3" seconds
	Given User clicks on "OLW_Manage_DComp.btn_Save"

	#Inactive ADT Range Group
      Given User clicks on "OLW_Manage_DComp.tab_ADTRangeGroup"
	  	Given User selects option "<$ADTRangeGroup$>" of element "OLW_Manage_DComp.ADTRangeGroup_SearchFilter" by "visibletext"
		When User waits "3" seconds
		Given User clicks on "OLW_Manage_DComp.chk_Active_ADTRangeGroup"
		Given User clicks on "OLW_Manage_DComp.btn_Save"

	Examples:
		| CompBasis   | CompMethod |
		| Days Played | Actual Win |


Scenario: 006 - Delete Test data
	When User executes query "update dbo.Buckets set IsActive = 0 where BucketName = '<$AutoDcomp_Bucket$>'" with connection "<#Halo_db_connectionstring#>"
	When User executes query "update UC_X_ADTRangeGroup set IsActive = 0 where ADTRangeGroupName = '<$ADTRangeGroup$>'" with connection "<#Halo_db_connectionstring#>"
#