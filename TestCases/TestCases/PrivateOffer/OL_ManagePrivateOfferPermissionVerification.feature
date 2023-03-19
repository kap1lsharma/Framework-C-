@Release_15.0 @Group_Permission@Private_offers@MANAGEPRIVETAOFFERS@Web

Feature:OL_ManagePrivateOfferPermissionImpact 

#******************************************************************************************************
#** Feature File                    : OL_ManagePrivateOfferPermissionVerification 
#** Feature Name                    : Verifing the MANAGEPRIVATEOFFER permission and validating UI based on this permission
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 583302
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  17/06/2022           Manisha Mehta				Initial Draft
#**************************************************************************************************/

Scenario: 001- Validate Permission MANAGEPRIVATEOFFER added under 'Offer Management' category of Group permission.(TC 583302)

Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
Given User enters text "Group Permission" in "lylMAIN_NAV_BOX.menu_Search_Box"
When User waits "1" seconds
Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
When User waits "2" seconds
Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
Given User enters text "MANAGEPRIVATEOFFER " in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
When User waits "2" seconds

#assign ASSIGNMANAGEPRIVATEOFFER permission from UC_TechServices user group.
Then User "unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
| Key | Value |
| permissionname | MANAGEPRIVATEOFFER |
When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
Then User verifies text - "Permissions Saved" is present on page

Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
| Key | Value |
| permissionname | MANAGEPRIVATEOFFER |
When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
Then User verifies text - "Permissions Saved" is present on page

#Verification of permission , it's category and description
Then User verifies that element "OLW_USER_GROUP_PERMISSION.lnk_PermissionDetailAll" is present "true" on UI with parameters
| Key | Value |
| PermissionName | MANAGEPRIVATEOFFER |
| Category | Offer Management |
| Description | ALLOW A USER TO MANUALLY CREATE, EDIT, ACTIVATE, INACTIVATE, SEARCH/VIEW PRIVATE OFFERS |
When User waits "2" seconds

When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
Then User verifies text - "Permissions Saved" is present on page

Scenario: 002-Create Program Type and SubType
	# Create new Program Type
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "AutoProgram:4" for key "programType"
	When User generates a "UniqueString" with "AutoSubProgram:4" for key "programSubType"
	Given User enters text "Manage Offer Programs" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	When User scrolls till element "lylMAIN_NAV_BOX.mnu_Manage_offer_program"
	Given User clicks on "lylMAIN_NAV_BOX.mnu_Manage_offer_program"
	Given User clicks on "lylOffer_ProgramType.btn_Add_Program_Type"
	Given User enters text "^$programType$^" in "lylOffer_ProgramType.txt_ProgramType_Name"
	Given User clicks on "lylOffer_ProgramType.btnSave"
	Then User verifies attribute "text" value "Record inserted successfully" of element "lylOffer_ProgramType.lbl_ProgramType/Subtype_SuccessMsg"
	# Search above Created Program Type
	Given User clears "lylOffer_ProgramType.txt_Search_Box"
	Given User enters text "^$programType$^" in "lylOffer_ProgramType.txt_Search_Box"
	When User pressed key "enter"
	Given User selects option "^$programType$^" of element "lylOffer_ProgramType.mnu_OfferProgramFilter" by "visibletext"
	When User waits "2" seconds
	# Create new  SubType
	Given User clicks on "lylOffer_ProgramType.btn_Add_Subtypes"
	Given User enters text "<$programSubType$>" in "lylOffer_ProgramType.Subtype_Name"
	Given User clicks on "lylOffer_ProgramType.btn_Save_Subtypes"
	Then User verifies that element "lylOffer_ProgramType.tbl_SubType_Filter" is present "true" on UI with parameters
		| Key         | Value              |
		| SubTypeName | <$programSubType$> |
	Given User clicks on "lylOffer_ProgramType.tbl_SubType_Filter" with parameters
		| Key         | Value              |
		| SubTypeName | <$programSubType$> |
	Given User clicks on "lylOffer_ProgramType.btnSave"
	Then User verifies attribute "text" value "Record updated successfully" of element "lylOffer_ProgramType.lbl_ProgramType/Subtype_SuccessMsg"
	
	Scenario:003- Create Offer Type and SubType
	# Create Offer Type
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "Private_Food_Offer:4" for key "Offer_Type"
	When User generates a "UniqueString" with "C:1" for key "Offer_Code"
	When User generates a "UniqueString" with "Auto_Food:4" for key "OfferSubType_Type"
	When User generates a "UniqueString" with "1" for key "OfferSubType_Code"
	Given User enters text "Manage Offer Type" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.mnu_Manage_Offer_type"
	Given User clicks on "lylOffer_Types.btnAdd_Offer_Type"
	Given User enters text "^$Offer_Type$^" in "lylOffer_Types.txt_Offertype_Name"
	When User waits "2" seconds
	Given User clears "lylOffer_Types.txt_Offer_Code"
	Given User enters text "^$Offer_Code$^" in "lylOffer_Types.txt_Offer_Code"
	When User waits "2" seconds
	Given User clicks on "lylOffer_Types.btn_Save_Offer_Type"
	When User waits "2" seconds
	Then User verifies attribute "text" value "Record inserted successfully" of element "lylOffer_Types.lbl_ErrorMessage"
	#Search above Created Offer Type
	Given User clears "lylOffer_Types.txt_Search_OfferType"
	Given User enters text "^$Offer_Type$^" in "lylOffer_Types.txt_Search_OfferType"
	When User pressed key "enter"
	When User waits "2" seconds
	Then User verifies that element "lylOffer_Types.Drop_OfferTypeValue" is present "true" on UI with parameters
		| Key       | Value          |
		| OfferType | ^$Offer_Type$^ |
	Given User clicks on "lylOffer_Types.Drop_OfferTypeValue" with parameters
		| Key       | Value          |
		| OfferType | ^$Offer_Type$^ |
	#Create Offer SubType
	Given User clicks on "lylOffer_Types.btn_Add_OfferSubtypes"
	Given User enters text "^$OfferSubType_Type$^" in "lylOffer_Types.txtOfferSubtype_Name"
	Given User enters text "^$OfferSubType_Code$^" in "lylOffer_Types.txt_Subtypes_Code"
	Given User clicks on "lylOffer_Types.btnSave_Subtypes"
	When User waits "3" seconds
	Then User verifies that element "lylOffer_Types.Table_SubType_Row" is present "true" on UI with parameters
		| Key         | Value                 |
		| SubtypeName | ^$OfferSubType_Type$^ |
		| SubtypeCode | ^$OfferSubType_Code$^ |
	Given User clicks on "lylOffer_Types.Table_SubType_Row" with parameters
		| Key         | Value                 |
		| SubtypeName | ^$OfferSubType_Type$^ |
		| SubtypeCode | ^$OfferSubType_Code$^ |
	Given User clicks on "lylOffer_Types.btn_Save_Offer_Type"
	When User waits "2" seconds
	Then User verifies attribute "text" value "Record updated successfully" of element "lylOffer_Types.lbl_ErrorMessage"

# Create Offer Disclaimer
Scenario:004 - Create Offer Disclaimer
	When User runs query "select P.PropertyName from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "Auto_Disclaimer:2" for key "Disclaimer_Name"
	Given User enters text "Offer Disclaimer" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.Offer_Disclaimer"
	Then User verifies text - "Offer Disclaimers" is present on page
	Given User clicks on "lylOFFERDISCLAIMERS.btnADDDISCLAIMER"
	Given User enters text "^$Disclaimer_Name$^" in "lylOFFERDISCLAIMERS.txtDIsclaimerName"
	Given User clicks on "lylOFFERDISCLAIMERS.Dropdown_OfferType"
	Given User selects option "^$Offer_Type$^" of element "lylOFFERDISCLAIMERS.Dropdown_OfferType" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "lylOFFERDISCLAIMERS.Offer_Sub_type"
	When User waits "2" seconds
	Then User verifies that element "lylOFFERDISCLAIMERS.OfferSubType_DropDownList" is present "true" on UI with parameters
		| Key              | Value                 |
		| OfferSubTypeName | ^$OfferSubType_Type$^ |
	Given User clicks on "lylOFFERDISCLAIMERS.OfferSubType_DropDownList" with parameters
		| Key              | Value                 |
		| OfferSubTypeName | ^$OfferSubType_Type$^ |
	Given User clicks on "lylOFFERDISCLAIMERS.Property_Name"
	When User waits "2" seconds
	Then User verifies that element "lylOFFERDISCLAIMERS.DropDown_PropertyList" is present "true" on UI with parameters
		| Key      | Value            |
		| Property | <$PropertyName$> |
	Given User clicks on "lylOFFERDISCLAIMERS.DropDown_PropertyList" with parameters
		| Key      | Value            |
		| Property | <$PropertyName$> |
	Given User selects option "OfferCode" of element "lylOFFERDISCLAIMERS.Offer_Disclaimer_dropdown" by "visibletext"
	Given User clicks on "lylOFFERDISCLAIMERS.btn_Disclaimer_Submit"
	When User waits "2" seconds
	Given User clicks on "lylOFFERDISCLAIMERS.btn_Save_DIsclaimer"
	Then User verifies attribute "text" value "Record inserted successfully" of element "lylOFFERDISCLAIMERS.lbl_ErrorMessage"

# Creating Campaign and Segment.
 Scenario: 005- Create Campaign and Campaign Segment for Private Offer
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Campaign" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.Campaign_Manage"
	Then User verifies text - "Campaign Management" is present on page
	Given User clicks on "ltyCampaign_Manage.btn_Campaign_Add"
	Then User verifies text - "Campaign - New" is present on page
	When User generates a "UniqueString" with "AutoCampaignName:4" for key "CAMP_NAME"
	Given User enters text "^$CAMP_NAME$^" in "ltyCampaign_Manage.txt_Campaign_Name"
	When User generates a "UniqueString" with "Code:4" for key "CampaignCode"
	Given User enters text "^$CampaignCode$^" in "ltyCampaign_Manage.txt_Campaign_Code"
	Given User selects option "<$programType$>" of element "ltyCampaign_Manage.txt_Program_Type" by "visibletext"
	When User waits "2" seconds
	Given User selects option "<$programSubType$>" of element "ltyCampaign_Manage.txt_Program_SubType" by "visibletext"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "DBcurrenttime"
	When User format date "<$DBcurrenttime$>" from "MM/dd/yyyy" to "MM-dd-yyyy" and save the result for key "currenttime"
	When User performs action "adddays" of "10" on dateTime "<$currenttime$>" with format "MM-dd-yyyy" to save the result for key "Camp_End"
	When User performs action "subtractdays" of "1" on dateTime "<$currenttime$>" with format "MM-dd-yyyy" to save the result for key "Camp_Start"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtStartDate').setAttribute('value', '<$Camp_Start$>')"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtEndDate').setAttribute('value', '<$Camp_End$>')"
	Given User clicks on "ltyCampaign_Manage.txt_Start_Time"
	Given User enters text "12:00 AM" in "ltyCampaign_Manage.txt_Start_Time"
	Given User clicks on "ltyCampaign_Manage.txt_Start_Time"
	Given User enters text "2" in "ltyCampaign_Manage.txt_Visible_Before_Days"
	When User waits "2" seconds
	Given User enters text "06:30 PM" in "ltyCampaign_Manage.txt_End_Time"
	Given User selects option "Email" of element "ltyCampaign_Manage.DropDown_Reminder_Type" by "visibletext"
	Then User "selects" element "ltyCampaign_Manage.chk_Text_DistributionChannel"
	Given User enters text "1000000" in "ltyCampaign_Manage.txt_Budget_Allocated"
	Given User enters text "10001" in "ltyCampaign_Manage.txt_Estimated_Revenue"
	Given User enters text "1" in "ltyCampaign_Manage.txt_OverHead_PerDay"
	Given User enters text "1" in "ltyCampaign_Manage.txt_Print_PerPiece"
	Given User enters text "1" in "ltyCampaign_Manage.txt_Postage_PerPiece"
	Given User enters text "1" in "ltyCampaign_Manage.txt_Gaming_Text_Rate"
	Given User enters text "1" in "ltyCampaign_Manage.txt_Miscellaneous_Costs"
	Given User enters text "Automation Notes" in "ltyCampaign_Manage.txt_Notes"
	When User waits "2" seconds
	Given User clicks on "ltyCampaign_Manage.btn_Save_Campaign"
	When User waits "2" seconds
	Then User verifies attribute "text" value "The changes has been successfully saved." of element "ltyCampaign_Manage.Popup_ManageCampaign_Successful"
	Given User clicks on "ltyCampaign_Manage.btn_OK_ManageCampaing_Popup"
	Given User clicks on "ltyCampaign_Manage.lbl_Campaigns_Label"
	#Search created campaign
	Given User enters text "^$CAMP_NAME$^" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Then User verifies that element "ltyCampaign_Manage.tbl_Campaign_List" is present "true" on UI with parameters
		| Key      | Value         |
		| Campaign | ^$CAMP_NAME$^ |
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value         |
		| Campaign | ^$CAMP_NAME$^ |
	When User waits "2" seconds
	When User scrolls till element "ltyCampaign_Manage.btn_View_Segment"
	Given User clicks on "ltyCampaign_Manage.btn_View_Segment"
	When User waits "2" seconds
	
	#Create Campaign Segment
	Then User verifies that element "ltyManage_Segment.lbl_Manage_Segment_PageTitle" is present "true" on UI
	Given User clicks on "ltyManage_Segment.btn_Add_Segment"
	When User generates a "UniqueString" with "AutoSegment:6" for key "FirstSegmentName"
	Given User enters text "^$FirstSegmentName$^" in "ltyManage_Segment.txt_Segment_Name"
	Given User selects option "Active" of element "ltyManage_Segment.DropDown_Status" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.Save_Button"
	Then User verifies text - "The changes have been successfully saved." is present on page
	When User waits "2" seconds
	When User "refresh" the browser
	When User waits "2" seconds
	
	Scenario:006 - Create private Offers
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Campaign" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.Campaign_Manage"
	When User waits "2" seconds
	Given User enters text "^$CAMP_NAME$^" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Then User verifies that element "ltyCampaign_Manage.tbl_Campaign_List" is present "true" on UI with parameters
		| Key      | Value         |
		| Campaign | ^$CAMP_NAME$^ |
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value         |
		| Campaign | ^$CAMP_NAME$^ |
	When User waits "2" seconds
	When User scrolls till element "ltyCampaign_Manage.btn_View_Segment"
	Given User clicks on "ltyCampaign_Manage.btn_View_Segment"
	When User waits "2" seconds
	Given User clears "ltyManage_Segment.Filter_Segment_Name"
	Given User enters text "^$FirstSegmentName$^" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
		| Key         | Value                |
		| SegmentName | ^$FirstSegmentName$^ |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value                |
		| SegmentName | ^$FirstSegmentName$^ |
	# Create private Offers
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	Given User clicks on "ltyMaster_Offers.lnk_Add_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	When User generates a "UniqueString" with "Private_OFFER :4" for key "PrivateOffer"
	Given User enters text "^$PrivateOffer$^" in "ltyMaster_Offers.txt_Offer_Name"
	Given User selects option "Active" of element "ltyMaster_Offers.Status_DropDown" by "visibletext"
	Given User selects option "<$PropertyName$>" of element "ltyMaster_Offers.DropDown_Property" by "visibletext"
	Given User selects option "^$Offer_Type$^" of element "ltyMaster_Offers.OfferType_DropDown" by "visibletext"
	Given User selects option "^$OfferSubType_Type$^" of element "ltyMaster_Offers.OfferSubType_DropDown" by "visibletext"
	Given User enters text "10" in "ltyMaster_Offers.txt_Offer_Amount"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtStartDate').setAttribute('value', '<$Camp_Start$>')"
	Given User enters text "12:00 AM" in "ltyMaster_Offers.txt_Start_Time"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtEndDate').setAttribute('value', '<$Camp_End$>')"
	Given User enters text "12:00 AM" in "ltyMaster_Offers.txt_End_Time"
	Then User "selects" element "MANAGE_MASTER_OFFERS.PRINTABLE_CHECKBOX"
	Then User "selects" element "ltyMaster_Offers.chk_Printable"
	Then User "selects" element "ltyMaster_Offers.chk_Reservable"
	Then User "selects" element "ltyMaster_Offers.chk_Partial_Redemption"
	Then User "selects" element "ltyMaster_Offers.chk_Private"
	Given User enters text "AUTOMATION TEST DESCRIPTION" in "ltyMaster_Offers.txt_Description"
	Given User enters text "AUTOMATION TEST ALTERNATE DESCRIPTION" in "ltyMaster_Offers.txt_Alternate_Description"
	When User waits "2" seconds
	Given User selects option "<$Disclaimer_Name$>" of element "ltyMaster_Offers.Disclaimer_DropDown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.Save_Button"
	Then User verifies text - "The changes have been successfully saved." is present on page
	When User "refresh" the browser
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.SegmentName_Breadcrumb_Link" with parameters
		| Key                    | Value                |
		| SegmentName_Breadcrumb | ^$FirstSegmentName$^ |
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.tbl_Master_Offers_List" is present "true" on UI with parameters
		| Key   | Value            |
		| offer | ^$PrivateOffer$^ |
	Given User clicks on "ltyMaster_Offers.tbl_Master_Offers_List" with parameters
		| Key   | Value            |
		| offer | ^$PrivateOffer$^ |

	Scenario:007 - verify private field when Manage Private Offer Permission is assigned to player
Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
When User waits "1" seconds
Given User enters text "manage campaign" in "lylMAIN_NAV_BOX.menu_Search_Box"
When User waits "1" seconds
Given User clicks on "lylMAIN_NAV_BOX.Campaign_Manage"
When User waits "2" seconds
#verify dropdown list of private field
Then User verifies text - "Private" is present on page
Then User verify list "ltyCampaign_Manage.mic_private_dropdown" options "All"
Then User verify list "ltyCampaign_Manage.mic_private_dropdown" options "Yes"
Then User verify list "ltyCampaign_Manage.mic_private_dropdown" options "No"
		
# search campaign and check private checkbox on modify offers page
#Search created campaign
	Given User enters text "^$CAMP_NAME$^" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Then User verifies that element "ltyCampaign_Manage.tbl_Campaign_List" is present "true" on UI with parameters
		| Key      | Value         |
		| Campaign | ^$CAMP_NAME$^ |
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value         |
		| Campaign | ^$CAMP_NAME$^ |
	When User waits "2" seconds
	When User scrolls till element "ltyCampaign_Manage.btn_View_Segment"
	Given User clicks on "ltyCampaign_Manage.btn_ModifyOffer"
When User waits "2" seconds
#verify checkbox of private field on campaign offer screen

Given User clicks on "ltyCampaign_Manage.chkbox_privateoffer" 
Then User verifies text - "Private" is present on page

#Save offer with private checkbox as true
Given User clicks on "ltyCampaign_Manage.private_checkbox"
When User scrolls till element "ltyCampaign_Manage.modifyoffers_campaignoffers"
When User waits "2" seconds
Given User clicks on "ltyCampaign_Manage.modifyoffers_campaignoffers"
Given User "accepts" the alert
When User waits "2" seconds
Given User clicks on "OLW_MODIFY_OFFER.offer_confirm" 
When User waits "4" seconds

Scenario:008 - search campaign and verify private field in segment

Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
When User waits "1" seconds
Given User enters text "manage campaign" in "lylMAIN_NAV_BOX.menu_Search_Box"
When User waits "1" seconds
Given User clicks on "lylMAIN_NAV_BOX.Campaign_Manage"
When User waits "2" seconds
	#Search created campaign
	Given User enters text "^$CAMP_NAME$^" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Then User verifies that element "ltyCampaign_Manage.tbl_Campaign_List" is present "true" on UI with parameters
		| Key      | Value         |
		| Campaign | ^$CAMP_NAME$^ |
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value         |
		| Campaign | ^$CAMP_NAME$^ |
	When User waits "2" seconds
	When User scrolls till element "ltyCampaign_Manage.btn_View_Segment"
	Given User clicks on "ltyCampaign_Manage.btn_View_Segment"
	When User waits "2" seconds
	#user select segment radio button and verify offer in segment list
Given User clicks on "ltyCampaign_Manage.rdb_privateoffersegment" 
Given User clicks on "ltyManage_Segment.btn_View_Offers"
Given User clicks on "ltyMaster_Offers.select_offer" 
Given User clicks on "ltyMaster_Offers.btn_view"
Given User clicks on "ltyMaster_Offers.chk_Private"
Then User verifies that element "ltyMaster_Offers.chk_Private" is present "true" on UI
Given User clicks on "ltyMaster_Offers.Save_Button"
Given User clicks on "OLW_MODIFY_OFFER.offer_confirm" 

#verify private field on manage offers screen
Given User enters text "Manage Offers" in "lylMAIN_NAV_BOX.menu_Search_Box"
When User waits "1" seconds
Given User clicks on "OLW_MAIN_NAV_BOX.manage_offers"
When User waits "2" seconds
Then User verifies that element "OLW_MANAGEOFFER.private_column" is present "true" on UI


Scenario:009 - verify private field when Manage Private Offer Permission is not assigned to player
Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
Given User enters text "Group Permission" in "lylMAIN_NAV_BOX.menu_Search_Box"
When User waits "1" seconds
Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
When User waits "2" seconds
Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
Given User enters text "MANAGEPRIVATEOFFER " in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
When User waits "2" seconds
#unassign ASSIGNMANAGEPRIVATEOFFER permission from UC_TechServices user group.
Then User "unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
| Key | Value |
| permissionname | MANAGEPRIVATEOFFER |
When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
Then User verifies text - "Permissions Saved" is present on page


When User waits "2" seconds
Given User enters text "manage campaign" in "lylMAIN_NAV_BOX.menu_Search_Box"
When User waits "1" seconds
Given User clicks on "lylMAIN_NAV_BOX.Campaign_Manage"
When User waits "2" seconds
#verify private field is not present on UI
Then User verifies that element "ltyCampaign_Manage.private_field" is present "false" on UI
When User waits "1" seconds
#Search created campaign
Given User enters text "^$CAMP_NAME$^" in "ltyCampaign_Manage.SearchFilter_CampaignName"
Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
Then User verifies that element "ltyCampaign_Manage.tbl_Campaign_List" is present "true" on UI with parameters
	| Key      | Value         |
	| Campaign | ^$CAMP_NAME$^ |
Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value         |
		| Campaign | ^$CAMP_NAME$^ |
When User waits "2" seconds
When User scrolls till element "ltyCampaign_Manage.btn_View_Segment"
Given User clicks on "ltyCampaign_Manage.btn_View_Segment"
When User waits "2" seconds
	#user select segment radio button and verify offer in segment list
Given User clicks on "ltyCampaign_Manage.rdb_privateoffersegment" 
Given User clicks on "ltyManage_Segment.btn_View_Offers"
Given User clicks on "ltyMaster_Offers.select_offer" 
Given User clicks on "ltyMaster_Offers.btn_view"

Then User verifies that element "ltyMaster_Offers.chk_Private" is present "false" on UI
Given User clicks on "ltyMaster_Offers.Save_Button"
Given User clicks on "OLW_MODIFY_OFFER.offer_confirm" 

#verify private field on manage offers screen
Given User enters text "Manage Offers" in "lylMAIN_NAV_BOX.menu_Search_Box"
When User waits "1" seconds
Given User clicks on "OLW_MAIN_NAV_BOX.manage_offers"
When User waits "2" seconds
Then User verifies that element "OLW_MANAGEOFFER.private_column" is present "false" on UI


