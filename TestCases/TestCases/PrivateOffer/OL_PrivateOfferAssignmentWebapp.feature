@Sequential@Release_15.0@Group_PrivateOffer@Web
Feature: OL_PrivateOfferAssignmentWebapp

#******************************************************************************
#**  Feature File                 : OL_PrivateOfferAssignmentWebapp.feature
#**  Feature Name                 : Private Offer Creation & assignment to Player via WebApp
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 584999,585000,585001,58304
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  04/20/2022     Jogendra Singh            Initial Draft
#********************************************************************************/
#
#/*************************************************************************
Scenario: 001-Create Program Type and SubType
	# Create new Program Type
	Given User switch to "Web" application
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

Scenario:002- Create Offer Type and SubType
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
Scenario:003 : Create Offer Disclaimer
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
Scenario: 004-Create Campaign and Campaign Segment for Private Offer
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
	#Serach the Created segment
	Given User clears "ltyManage_Segment.Filter_Segment_Name"
	Given User enters text "^$FirstSegmentName$^" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
		| Key         | Value                |
		| SegmentName | ^$FirstSegmentName$^ |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value                |
		| SegmentName | ^$FirstSegmentName$^ |

Scenario: 005-Create Private Offer
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

Scenario: 006-To verify Non-Private offers can not be clubbed with Private Offers in a Segment.(TC 583315)
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
	# Create non private Offers
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	Given User clicks on "ltyMaster_Offers.lnk_Add_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	When User generates a "UniqueString" with "NonPrivate_OFFER :4" for key "FIRST_OFFER_NAME"
	Given User enters text "^$FIRST_OFFER_NAME$^" in "ltyMaster_Offers.txt_Offer_Name"
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
	Given User enters text "AUTOMATION TEST DESCRIPTION" in "ltyMaster_Offers.txt_Description"
	Given User enters text "AUTOMATION TEST ALTERNATE DESCRIPTION" in "ltyMaster_Offers.txt_Alternate_Description"
	When User waits "2" seconds
	Given User selects option "<$Disclaimer_Name$>" of element "ltyMaster_Offers.Disclaimer_DropDown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.Save_Button"
	Then User verifies text - "Private offer can not be clubbed with non private offer" is present on page

Scenario: 007-Create Campaign and Campaign Segment for Non-Private Offer
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Campaign" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.Campaign_Manage"
	Then User verifies text - "Campaign Management" is present on page
	Given User clicks on "ltyCampaign_Manage.btn_Campaign_Add"
	Then User verifies text - "Campaign - New" is present on page
	When User generates a "UniqueString" with "AutoCampaignName:4" for key "CAMP_NAME1"
	Given User enters text "^$CAMP_NAME1$^" in "ltyCampaign_Manage.txt_Campaign_Name"
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
	Given User enters text "<Value>" in "ltyCampaign_Manage.txt_Budget_Allocated"
	Given User enters text "<Value>" in "ltyCampaign_Manage.txt_Estimated_Revenue"
	Given User enters text "<Value>" in "ltyCampaign_Manage.txt_OverHead_PerDay"
	Given User enters text "<Value>" in "ltyCampaign_Manage.txt_Print_PerPiece"
	Given User enters text "<Value>" in "ltyCampaign_Manage.txt_Postage_PerPiece"
	Given User enters text "<Value>" in "ltyCampaign_Manage.txt_Gaming_Text_Rate"
	Given User enters text "<Value>" in "ltyCampaign_Manage.txt_Miscellaneous_Costs"
	Given User enters text "Automation Notes" in "ltyCampaign_Manage.txt_Notes"
	When User waits "2" seconds
	Given User clicks on "ltyCampaign_Manage.btn_Save_Campaign"
	When User waits "2" seconds
	Then User verifies attribute "text" value "The changes has been successfully saved." of element "ltyCampaign_Manage.Popup_ManageCampaign_Successful"
	Given User clicks on "ltyCampaign_Manage.btn_OK_ManageCampaing_Popup"
	Given User clicks on "ltyCampaign_Manage.lbl_Campaigns_Label"
	#Search created campaign
	Given User enters text "^$CAMP_NAME1$^" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	When User waits "2" seconds
	Then User verifies that element "ltyCampaign_Manage.tbl_Campaign_List" is present "true" on UI with parameters
		| Key      | Value          |
		| Campaign | ^$CAMP_NAME1$^ |
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value          |
		| Campaign | ^$CAMP_NAME1$^ |
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
	#Serach the Created segment
	Given User clears "ltyManage_Segment.Filter_Segment_Name"
	Given User enters text "^$FirstSegmentName$^" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
		| Key         | Value                |
		| SegmentName | ^$FirstSegmentName$^ |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value                |
		| SegmentName | ^$FirstSegmentName$^ |

Scenario: 008-Create Non Private offer
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Campaign" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.Campaign_Manage"
	When User waits "2" seconds
	Given User enters text "^$CAMP_NAME1$^" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Then User verifies that element "ltyCampaign_Manage.tbl_Campaign_List" is present "true" on UI with parameters
		| Key      | Value          |
		| Campaign | ^$CAMP_NAME1$^ |
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value          |
		| Campaign | ^$CAMP_NAME1$^ |
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
	# Create non private Offers
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	Given User clicks on "ltyMaster_Offers.lnk_Add_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	When User generates a "UniqueString" with "NonPrivate_OFFER :4" for key "FIRST_OFFER_NAME"
	Given User enters text "^$FIRST_OFFER_NAME$^" in "ltyMaster_Offers.txt_Offer_Name"
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
	Given User enters text "AUTOMATION TEST DESCRIPTION" in "ltyMaster_Offers.txt_Description"
	Given User enters text "AUTOMATION TEST ALTERNATE DESCRIPTION" in "ltyMaster_Offers.txt_Alternate_Description"
	When User waits "2" seconds
	Given User selects option "<$Disclaimer_Name$>" of element "ltyMaster_Offers.Disclaimer_DropDown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.Save_Button"
	Then User verifies text - "The changes have been successfully saved." is present on page
	When User "refresh" the browser

Scenario: 009-To verify Private offers can not be clubbed with Non-Private Offers in a Segment.(TC 583304)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Campaign" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.Campaign_Manage"
	When User waits "2" seconds
	Given User enters text "^$CAMP_NAME1$^" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Then User verifies that element "ltyCampaign_Manage.tbl_Campaign_List" is present "true" on UI with parameters
		| Key      | Value          |
		| Campaign | ^$CAMP_NAME1$^ |
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value          |
		| Campaign | ^$CAMP_NAME1$^ |
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
	When User generates a "UniqueString" with "Private_OFFER :4" for key "FIRST_OFFER_NAME"
	Given User enters text "^$FIRST_OFFER_NAME$^" in "ltyMaster_Offers.txt_Offer_Name"
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
	Then User verifies text - "Private offer can not be clubbed with non private offer" is present on page

Scenario Outline: 010-Enroll Player using WebApp
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
	Given User clicks on "ENROLL_PLAYER.ID_DOB_TEXTBOX"
	When User waits "2" seconds
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
	When User waits "2" seconds
	Given User enters text "<pin>" in "ENROLL_PLAYER.PIN_TEXTBOX"
	Given User enters text "<pin>" in "ENROLL_PLAYER.PIN_AGAIN_TEXTBOX"
	When User scrolls till element "ENROLL_PLAYER.ENROLL_BUTTON"
	When User waits "2" seconds
	Given User clicks on "ENROLL_PLAYER.ENROLL_BUTTON"
	When User waits "4" seconds
	When User gets attribute "getText" value of "PLAYER_INFO.PLAYER_ID_SPAN" element to save with key "<PLAYER_ID_Key>"
	Examples:
		| BucketAmount | enrollType | prefixType | middleName | lastName  | suffix | bday       | gender | idType        | id          | expireDate | country | state   | country2 | state2  | nationality | addressType | addressLine          | city    | zip    | zipFour | fromDate   | toDate     | addressType2 | city2   | zip2   | zipFour2 | fromDate2  | toDate2    | teleType | teleNo     | teleStatus | emailType | email   | emailStatus | socialType | socialAccount  | smsType  | pin  | Permission | sms       | PLAYER_ID          | ssn       | PLAYER_ID_Key |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID     |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID_1   |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID_2   |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID_3   | 

	
Scenario: 011- Create Campaign,Campaign Segment offer and Active Campaign
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Campaign" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.Campaign_Manage"
	Then User verifies text - "Campaign Management" is present on page
	Given User clicks on "ltyCampaign_Manage.btn_Campaign_Add"
	Then User verifies text - "Campaign - New" is present on page
	When User generates a "UniqueString" with "AutoCampaignName:4" for key "Private_CAMP_NAME"
	Given User enters text "^$Private_CAMP_NAME$^" in "ltyCampaign_Manage.txt_Campaign_Name"
	When User generates a "UniqueString" with "Code:4" for key "CampaignCode"
	Given User enters text "^$CampaignCode$^" in "ltyCampaign_Manage.txt_Campaign_Code"
	Given User selects option "<$programType$>" of element "ltyCampaign_Manage.txt_Program_Type" by "visibletext"
	When User waits "2" seconds
	Given User selects option "<$programSubType$>" of element "ltyCampaign_Manage.txt_Program_SubType" by "visibletext"
	Given User selects option "New" of element "ltyCampaign_Manage.DropDown_Status" by "visibletext"
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
	Given User enters text "10000" in "ltyCampaign_Manage.txt_Budget_Allocated"
	Given User enters text "10000" in "ltyCampaign_Manage.txt_Estimated_Revenue"
	Given User enters text "100" in "ltyCampaign_Manage.txt_OverHead_PerDay"
	Given User enters text "1" in "ltyCampaign_Manage.txt_Print_PerPiece"
	Given User enters text "1" in "ltyCampaign_Manage.txt_Postage_PerPiece"
	Given User enters text "10" in "ltyCampaign_Manage.txt_Gaming_Text_Rate"
	Given User enters text "1" in "ltyCampaign_Manage.txt_Miscellaneous_Costs"
	Given User enters text "Automation Notes" in "ltyCampaign_Manage.txt_Notes"
	When User waits "2" seconds
	Given User clicks on "ltyCampaign_Manage.btn_Save_Campaign"
	When User waits "2" seconds
	Then User verifies attribute "text" value "The changes has been successfully saved." of element "ltyCampaign_Manage.Popup_ManageCampaign_Successful"
	Given User clicks on "ltyCampaign_Manage.btn_OK_ManageCampaing_Popup"
	Given User clicks on "ltyCampaign_Manage.lbl_Campaigns_Label"
	Given User enters text "^$Private_CAMP_NAME$^" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Then User verifies that element "ltyCampaign_Manage.tbl_Campaign_List" is present "true" on UI with parameters
		| Key      | Value                 |
		| Campaign | ^$Private_CAMP_NAME$^ |
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value                 |
		| Campaign | ^$Private_CAMP_NAME$^ |
	When User waits "2" seconds
	When User scrolls till element "ltyCampaign_Manage.btn_View_Segment"
	Given User clicks on "ltyCampaign_Manage.btn_View_Segment"
	When User waits "2" seconds
	#Create Campaign Segment
	Then User verifies that element "ltyManage_Segment.lbl_Manage_Segment_PageTitle" is present "true" on UI
	Given User clicks on "ltyManage_Segment.btn_Add_Segment"
	When User generates a "UniqueString" with "AutoSegment:6" for key "PrivateSegment"
	Given User enters text "^$PrivateSegment$^" in "ltyManage_Segment.txt_Segment_Name"
	Given User selects option "Active" of element "ltyManage_Segment.DropDown_Status" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.Save_Button"
	Then User verifies text - "The changes have been successfully saved." is present on page
	When User waits "2" seconds
	When User "refresh" the browser
	When User waits "2" seconds
	#Serach the Created segment
	Given User clears "ltyManage_Segment.Filter_Segment_Name"
	Given User enters text "^$PrivateSegment$^" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
		| Key         | Value              |
		| SegmentName | ^$PrivateSegment$^ |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value              |
		| SegmentName | ^$PrivateSegment$^ |
	# Create Offers
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	Given User clicks on "ltyMaster_Offers.lnk_Add_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	When User generates a "UniqueString" with "OFFER_:4" for key "PrivateOffer"
	Given User enters text "^$PrivateOffer$^" in "ltyMaster_Offers.txt_Offer_Name"
	Given User selects option "Active" of element "ltyMaster_Offers.Status_DropDown" by "visibletext"
	Given User selects option "<$PropertyName$>" of element "ltyMaster_Offers.DropDown_Property" by "visibletext"
	Given User selects option "^$Offer_Type$^" of element "ltyMaster_Offers.OfferType_DropDown" by "visibletext"
	Given User selects option "^$OfferSubType_Type$^" of element "ltyMaster_Offers.OfferSubType_DropDown" by "visibletext"
	Given User enters text "44" in "ltyMaster_Offers.txt_Offer_Amount"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtStartDate').setAttribute('value', '<$Camp_Start$>')"
	Given User enters text "12:00 AM" in "ltyMaster_Offers.txt_Start_Time"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtEndDate').setAttribute('value', '<$Camp_End$>')"
	Given User enters text "12:00 AM" in "ltyMaster_Offers.txt_End_Time"
	Then User "selects" element "MANAGE_MASTER_OFFERS.PRINTABLE_CHECKBOX"
	Then User "selects" element "ltyMaster_Offers.chk_Printable"
	Then User "selects" element "ltyMaster_Offers.chk_Reservable"
	Then User "selects" element "ltyMaster_Offers.chk_Partial_Redemption"
	Then User "selects" element "ltyMaster_Offers.chk_Private"
	When User waits "2" seconds
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
		| Key                    | Value              |
		| SegmentName_Breadcrumb | ^$PrivateSegment$^ |
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.tbl_Master_Offers_List" is present "true" on UI with parameters
		| Key   | Value            |
		| offer | ^$PrivateOffer$^ |
	Given User clicks on "ltyMaster_Offers.tbl_Master_Offers_List" with parameters
		| Key   | Value            |
		| offer | ^$PrivateOffer$^ |
	#Mark the campaign as Active
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.lnk_CampaignName_Breadcrumb" with parameters
		| Key                 | Value                 |
		| Campaign_Breadcrumb | ^$Private_CAMP_NAME$^ |
	Given User selects option "Active" of element "ltyCampaign_Manage.DropDown_Status" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyCampaign_Manage.btn_Save_Campaign"
	When User waits "2" seconds
	Given User "accepts" the alert
	Given User enters text "<#Halo_password#>" in "ltyCampaign_Manage.Authorization_Password"
	Given User selects option "Activate" of element "ltyCampaign_Manage.Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "ltyCampaign_Manage.Authorization_Comment"
	Given User clicks on "ltyCampaign_Manage.Authorization_Submit_Button"
	When User waits "4" seconds
	When User "refresh" the browser
	When User waits "2" seconds

Scenario: 012-Verify that user is able to Add Private Offer to Player's Account Via Webapp (TC 585001)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User format date "<$Camp_Start$>" from "MM-dd-yyyy" to "MM/dd/yyyy" and save the result for key "Verify_Offer_Start"
	When User format date "<$Camp_End$>" from "MM-dd-yyyy" to "MM/dd/yyyy" and save the result for key "Verify_Offer_End"
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "4" seconds
	Given User enters text "<$PrivateOffer$>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	When User waits "4" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" is present "true" on UI with parameters
		| Key       | Value                  |
		| OfferName | <$PrivateOffer$>       |
		| OfferType | <$Offer_Type$>         |
		| StartDate | <$Verify_Offer_Start$> |
		| EndDate   | <$Verify_Offer_End$>   |
		| Amount    | 44                     |
		| Property  | <$PropertyName$>       |
		| IsPrivate | Y                      |
	Given User clicks on "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" with parameters
		| Key       | Value                  |
		| OfferName | <$PrivateOffer$>       |
		| OfferType | <$Offer_Type$>         |
		| StartDate | <$Verify_Offer_Start$> |
		| EndDate   | <$Verify_Offer_End$>   |
		| Amount    | 44                     |
		| Property  | <$PropertyName$>       |
		| IsPrivate | Y                      |
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"
	When User waits "4" seconds
	# Provide Authorization.
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Guest Satisfaction" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	Given User clicks on "OLW_PLAYER_OFFER.btn_CancelAndReturn_PlayerOffer"
	When User waits "4" seconds
	Given User enters text "<$PrivateOffer$>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "4" seconds
	#Verify that Private Offer added to Player Account and Private Column value displayed as 'Y'
	Then User verifies that element "OLW_PLAYER_OFFER.lnkassignedprivateoffer" is present "true" on UI with parameters
		| Key       | Value                  |
		| OfferName | <$PrivateOffer$>       |
		| OfferType | <$Offer_Type$>         |
		| Status    | Active                 |
		| StartDate | <$Verify_Offer_Start$> |
		| EndDate   | <$Verify_Offer_End$>   |
		| Amount    | 44                     |
		| Property  | <$PropertyName$>       |
		| IsPrivate | Y                      |

Scenario: 013-Create private and Non-Private Offer with same name for validating Private filter.
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Campaign" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.Campaign_Manage"
	Then User verifies text - "Campaign Management" is present on page
	Given User clicks on "ltyCampaign_Manage.btn_Campaign_Add"
	Then User verifies text - "Campaign - New" is present on page
	When User generates a "UniqueString" with "AutoCampaignName:4" for key "Private_CAMP_NAME"
	Given User enters text "^$Private_CAMP_NAME$^" in "ltyCampaign_Manage.txt_Campaign_Name"
	When User generates a "UniqueString" with "Code:4" for key "CampaignCode"
	Given User enters text "^$CampaignCode$^" in "ltyCampaign_Manage.txt_Campaign_Code"
	Given User selects option "test" of element "ltyCampaign_Manage.txt_Program_Type" by "visibletext"
	When User waits "2" seconds
	Given User selects option "sutest" of element "ltyCampaign_Manage.txt_Program_SubType" by "visibletext"
	Given User selects option "New" of element "ltyCampaign_Manage.DropDown_Status" by "visibletext"
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
	Given User enters text "10000" in "ltyCampaign_Manage.txt_Budget_Allocated"
	Given User enters text "10000" in "ltyCampaign_Manage.txt_Estimated_Revenue"
	Given User enters text "100" in "ltyCampaign_Manage.txt_OverHead_PerDay"
	Given User enters text "1" in "ltyCampaign_Manage.txt_Print_PerPiece"
	Given User enters text "1" in "ltyCampaign_Manage.txt_Postage_PerPiece"
	Given User enters text "10" in "ltyCampaign_Manage.txt_Gaming_Text_Rate"
	Given User enters text "1" in "ltyCampaign_Manage.txt_Miscellaneous_Costs"
	Given User enters text "Automation Notes" in "ltyCampaign_Manage.txt_Notes"
	When User waits "2" seconds
	Given User clicks on "ltyCampaign_Manage.btn_Save_Campaign"
	When User waits "2" seconds
	Then User verifies attribute "text" value "The changes has been successfully saved." of element "ltyCampaign_Manage.Popup_ManageCampaign_Successful"
	Given User clicks on "ltyCampaign_Manage.btn_OK_ManageCampaing_Popup"
	Given User clicks on "ltyCampaign_Manage.lbl_Campaigns_Label"
	Given User enters text "^$Private_CAMP_NAME$^" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Then User verifies that element "ltyCampaign_Manage.tbl_Campaign_List" is present "true" on UI with parameters
		| Key      | Value                 |
		| Campaign | ^$Private_CAMP_NAME$^ |
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value                 |
		| Campaign | ^$Private_CAMP_NAME$^ |
	When User waits "2" seconds
	When User scrolls till element "ltyCampaign_Manage.btn_View_Segment"
	Given User clicks on "ltyCampaign_Manage.btn_View_Segment"
	When User waits "2" seconds
	#Create Campaign Segment
	Then User verifies that element "ltyManage_Segment.lbl_Manage_Segment_PageTitle" is present "true" on UI
	Given User clicks on "ltyManage_Segment.btn_Add_Segment"
	When User generates a "UniqueString" with "AutoSegment:6" for key "PrivateSegment"
	Given User enters text "^$PrivateSegment$^" in "ltyManage_Segment.txt_Segment_Name"
	Given User selects option "Active" of element "ltyManage_Segment.DropDown_Status" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.Save_Button"
	Then User verifies text - "The changes have been successfully saved." is present on page
	When User waits "2" seconds
	When User "refresh" the browser
	When User waits "2" seconds
	#Serach the Created segment
	Given User clears "ltyManage_Segment.Filter_Segment_Name"
	Given User enters text "^$PrivateSegment$^" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
		| Key         | Value              |
		| SegmentName | ^$PrivateSegment$^ |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value              |
		| SegmentName | ^$PrivateSegment$^ |
	# Create Offers
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	Given User clicks on "ltyMaster_Offers.lnk_Add_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	When User generates a "UniqueString" with "OFFER_:4" for key "PrivateOffer"
	Given User enters text "^$PrivateOffer$^" in "ltyMaster_Offers.txt_Offer_Name"
	Given User selects option "Active" of element "ltyMaster_Offers.Status_DropDown" by "visibletext"
	Given User selects option "<$PropertyName$>" of element "ltyMaster_Offers.DropDown_Property" by "visibletext"
	Given User selects option "^$Offer_Type$^" of element "ltyMaster_Offers.OfferType_DropDown" by "visibletext"
	Given User selects option "^$OfferSubType_Type$^" of element "ltyMaster_Offers.OfferSubType_DropDown" by "visibletext"
	Given User enters text "44" in "ltyMaster_Offers.txt_Offer_Amount"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtStartDate').setAttribute('value', '<$Camp_Start$>')"
	Given User enters text "12:00 AM" in "ltyMaster_Offers.txt_Start_Time"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtEndDate').setAttribute('value', '<$Camp_End$>')"
	Given User enters text "12:00 AM" in "ltyMaster_Offers.txt_End_Time"
	Then User "selects" element "MANAGE_MASTER_OFFERS.PRINTABLE_CHECKBOX"
	Then User "selects" element "ltyMaster_Offers.chk_Printable"
	Then User "selects" element "ltyMaster_Offers.chk_Reservable"
	Then User "selects" element "ltyMaster_Offers.chk_Partial_Redemption"
	Then User "selects" element "ltyMaster_Offers.chk_Private"
	When User waits "2" seconds
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
		| Key                    | Value              |
		| SegmentName_Breadcrumb | ^$PrivateSegment$^ |
	When User waits "2" seconds
	#Creating another segment for Non-Private offer
	Given User clicks on "ltyManage_Segment.btn_Add_Segment"
	When User generates a "UniqueString" with "AutoSegment:6" for key "PrivateSegment"
	Given User enters text "^$PrivateSegment$^" in "ltyManage_Segment.txt_Segment_Name"
	Given User selects option "Active" of element "ltyManage_Segment.DropDown_Status" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.Save_Button"
	Then User verifies text - "The changes have been successfully saved." is present on page
	When User waits "2" seconds
	When User "refresh" the browser
	When User waits "2" seconds
	#Serach the Created segment
	Given User clears "ltyManage_Segment.Filter_Segment_Name"
	Given User enters text "^$PrivateSegment$^" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
		| Key         | Value              |
		| SegmentName | ^$PrivateSegment$^ |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value              |
		| SegmentName | ^$PrivateSegment$^ |
	# Create Non Private offer with same offer name
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	Given User clicks on "ltyMaster_Offers.lnk_Add_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	Given User enters text "^$PrivateOffer$^" in "ltyMaster_Offers.txt_Offer_Name"
	Given User selects option "Active" of element "ltyMaster_Offers.Status_DropDown" by "visibletext"
	Given User selects option "<$PropertyName$>" of element "ltyMaster_Offers.DropDown_Property" by "visibletext"
	Given User selects option "^$Offer_Type$^" of element "ltyMaster_Offers.OfferType_DropDown" by "visibletext"
	Given User selects option "^$OfferSubType_Type$^" of element "ltyMaster_Offers.OfferSubType_DropDown" by "visibletext"
	Given User enters text "44" in "ltyMaster_Offers.txt_Offer_Amount"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtStartDate').setAttribute('value', '<$Camp_Start$>')"
	Given User enters text "12:00 AM" in "ltyMaster_Offers.txt_Start_Time"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtEndDate').setAttribute('value', '<$Camp_End$>')"
	Given User enters text "12:00 AM" in "ltyMaster_Offers.txt_End_Time"
	Then User "selects" element "MANAGE_MASTER_OFFERS.PRINTABLE_CHECKBOX"
	Then User "selects" element "ltyMaster_Offers.chk_Printable"
	Then User "selects" element "ltyMaster_Offers.chk_Reservable"
	Then User "selects" element "ltyMaster_Offers.chk_Partial_Redemption"
	When User waits "2" seconds
	Given User enters text "AUTOMATION TEST DESCRIPTION" in "ltyMaster_Offers.txt_Description"
	Given User enters text "AUTOMATION TEST ALTERNATE DESCRIPTION" in "ltyMaster_Offers.txt_Alternate_Description"
	When User waits "2" seconds
	Given User selects option "<$Disclaimer_Name$>" of element "ltyMaster_Offers.Disclaimer_DropDown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.Save_Button"
	Then User verifies text - "The changes have been successfully saved." is present on page
	When User "refresh" the browser
	When User waits "2" seconds
	#Mark the campaign as Active
	Given User clicks on "ltyMaster_Offers.lnk_CampaignName_Breadcrumb" with parameters
		| Key                 | Value                 |
		| Campaign_Breadcrumb | ^$Private_CAMP_NAME$^ |
	Given User selects option "Active" of element "ltyCampaign_Manage.DropDown_Status" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyCampaign_Manage.btn_Save_Campaign"
	When User waits "2" seconds
	Given User "accepts" the alert
	Given User enters text "<#Halo_password#>" in "ltyCampaign_Manage.Authorization_Password"
	Given User selects option "Activate" of element "ltyCampaign_Manage.Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "ltyCampaign_Manage.Authorization_Comment"
	Given User clicks on "ltyCampaign_Manage.Authorization_Submit_Button"
	When User waits "2" seconds

Scenario: 014-Verify UI changes done on Offer Screens to Support Private Offers in WebApp. (TC 584999)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User format date "<$Camp_Start$>" from "MM-dd-yyyy" to "MM/dd/yyyy" and save the result for key "Verify_Offer_Start"
	When User format date "<$Camp_End$>" from "MM-dd-yyyy" to "MM/dd/yyyy" and save the result for key "Verify_Offer_End"
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User enters text "<$PLAYER_ID_1$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
	| Key           | Value  |
	| Dashboard_Tab | Offers |
	When User waits "2" seconds
	# Verify Private column added on Screen.
	Then User verifies that element "OLW_PLAYER_OFFER.lblPrivateColumn" is present "true" on UI
	# Verify Availability of Private filter at Add Active offer screen.
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "2" seconds
	Given User enters text "<$PrivateOffer$>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.micPrivatefilter" is present "true" on UI
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	When User waits "2" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" is present "true" on UI with parameters
	| Key       | Value                  |
	| OfferName | <$PrivateOffer$>       |
	| OfferType | <$Offer_Type$>         |
	| StartDate | <$Verify_Offer_Start$> |
	| EndDate   | <$Verify_Offer_End$>   |
	| Amount    | 44                     |
	| Property  | <$PropertyName$>       |
	| IsPrivate | Y                      |
	Then User verifies that element "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" is present "true" on UI with parameters
	| Key       | Value                  |
	| OfferName | <$PrivateOffer$>       |
	| OfferType | <$Offer_Type$>         |
	| StartDate | <$Verify_Offer_Start$> |
	| EndDate   | <$Verify_Offer_End$>   |
	| Amount    | 44                     |
	| Property  | <$PropertyName$>       |
	| IsPrivate | N                      |
	When User waits "2" seconds
	Given User selects option "Yes" of element "OLW_PLAYER_OFFER.micPrivatefilter" by "visibletext"
	Given User clicks on "OLW_PLAYER_OFFER.btnPrivateOfferSearch"
	When User waits "2" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" is present "true" on UI with parameters
	| Key       | Value                  |
	| OfferName | <$PrivateOffer$>       |
	| OfferType | <$Offer_Type$>         |
	| StartDate | <$Verify_Offer_Start$> |
	| EndDate   | <$Verify_Offer_End$>   |
	| Amount    | 44                     |
	| Property  | <$PropertyName$>       |
	| IsPrivate | Y                      |
	Then User verifies that element "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" is present "false" on UI with parameters
	| Key       | Value                  |
	| OfferName | <$PrivateOffer$>       |
	| OfferType | <$Offer_Type$>         |
	| StartDate | <$Verify_Offer_Start$> |
	| EndDate   | <$Verify_Offer_End$>   |
	| Amount    | 44                     |
	| Property  | <$PropertyName$>       |
	| IsPrivate | N                      |
	When User waits "2" seconds
	Given User selects option "No" of element "OLW_PLAYER_OFFER.micPrivatefilter" by "visibletext"
	Given User clicks on "OLW_PLAYER_OFFER.btnPrivateOfferSearch"
	When User waits "2" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" is present "false" on UI with parameters
	| Key       | Value                  |
	| OfferName | <$PrivateOffer$>       |
	| OfferType | <$Offer_Type$>         |
	| StartDate | <$Verify_Offer_Start$> |
	| EndDate   | <$Verify_Offer_End$>   |
	| Amount    | 44                     |
	| Property  | <$PropertyName$>       |
	| IsPrivate | Y                      |
	Then User verifies that element "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" is present "true" on UI with parameters
	| Key       | Value                  |
	| OfferName | <$PrivateOffer$>       |
	| OfferType | <$Offer_Type$>         |
	| StartDate | <$Verify_Offer_Start$> |
	| EndDate   | <$Verify_Offer_End$>   |
	| Amount    | 44                     |
	| Property  | <$PropertyName$>       |
	| IsPrivate | N                      |

Scenario: 015-Uncheck VIEWASSIGNPLAYERPRIVATEOFFER Permssion for UC_techServices user group.
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "VIEWASSIGNPLAYERPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Unchecked VIEWASSIGNPLAYERPRIVATEOFFER permission for saservice user of UC_TechServices user group.	
	Then User "Unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                        |
	| permissionname | VIEWASSIGNPLAYERPRIVATEOFFER |	
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"

Scenario: 016-Verify permission 'VIEWASSIGNPLAYERPRIVATEOFFER' usage via Webapp. (TC 585000)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "<$PLAYER_ID_1$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
	| Key           | Value  |
	| Dashboard_Tab | Offers |
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "2" seconds
	#Verify that Private filter is not available 
	Then User verifies that element "OLW_PLAYER_OFFER.micPrivatefilter" is present "false" on UI
	#Verify Private column is also not available 
	Then User verifies that element "OLW_PLAYER_OFFER.lblunassignedofferlabelprivate" is present "false" on UI
	When User waits "2" seconds
	Given User enters text "<$PrivateOffer$>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	When User waits "2" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" is present "false" on UI with parameters
	| Key       | Value                  |
	| OfferName | <$PrivateOffer$>       |
	| OfferType | <$Offer_Type$>         |
	| StartDate | <$Verify_Offer_Start$> |
	| EndDate   | <$Verify_Offer_End$>   |
	| Amount    | 44                     |
	| Property  | <$PropertyName$>       |
	| IsPrivate | Y                      |

Scenario: 017-check VIEWASSIGNPLAYERPRIVATEOFFER Permssion for UC_techServices user group.
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "VIEWASSIGNPLAYERPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Unchecked VIEWASSIGNPLAYERPRIVATEOFFER permission for saservice user of UC_TechServices user group.	
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                        |
	| permissionname | VIEWASSIGNPLAYERPRIVATEOFFER |	
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"	