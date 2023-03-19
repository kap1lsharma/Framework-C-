@Sequential@Release_15.0@BonusingOffer@Desktop
Feature: OL_BonusingOffer_WebApp

#******************************************************************************
#**  Feature File                 : OL_BonusingOffer_WebApp.feature
#**  Feature Name                 : Create and Update Bonusing offer from webapp
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 591052
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  07/04/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/
#
#/*************************************************************************
Scenario Outline:001- Pre-Data Creation for Bonusing Offer. (TC 591052)
	# Create Program Type
	When User generates a "UniqueString" with "BonusProgram:4" for key "programType"
	When User generates a "UniqueString" with "BonusSubProgram:4" for key "programSubType"
	When User generates a "UniqueString" with "Bonus_Offer:4" for key "Offer_Type"
	When User generates a "UniqueString" with "NPOffer:4" for key "Offer_Type2"
	When User generates a "UniqueString" with "B:1" for key "Offer_Code"
	When User generates a "UniqueString" with "Bonus_SubType:4" for key "OfferSubType_Type"
	When User generates a "UniqueString" with "NPSubType:4" for key "OfferSubType_Type2"
	When User generates a "UniqueString" with "1" for key "OfferSubType_Code"
	When User runs query "select P.PropertyName from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User generates a "UniqueString" with "Bonus_Disclaimer:2" for key "Disclaimer_Name"
	When User generates a "UniqueString" with "NPDisclaimer:2" for key "Disclaimer_Name2"
	When User generates a "UniqueString" with "BonusCampaignName:4" for key "CAMP_NAME"
	When User generates a "UniqueString" with "Bonus:4" for key "CampaignCode"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "DBcurrenttime"
	When User format date "<$DBcurrenttime$>" from "MM/dd/yyyy" to "MM-dd-yyyy" and save the result for key "currenttime"
	When User performs action "adddays" of "10" on dateTime "<$currenttime$>" with format "MM-dd-yyyy" to save the result for key "Offer_End"
	When User performs action "adddays" of "10" on dateTime "<$currenttime$>" with format "MM-dd-yyyy" to save the result for key "Camp_End"
	When User performs action "subtractdays" of "1" on dateTime "<$currenttime$>" with format "MM-dd-yyyy" to save the result for key "Camp_Start"
	When User generates a "UniqueString" with "BonusSegment:6" for key "FirstSegmentName"
	When User generates a "UniqueString" with "Bonus_Offer:4" for key "FIRST_OFFER_NAME"
	When User generates a "UniqueString" with "OfferNP:4" for key "Second_OFFER_NAME"
	When User format date "<$Camp_Start$>" from "MM-dd-yyyy" to "M/d/yyyy" and save the result for key "Verify_Offer_Start"
	When User format date "<$Offer_End$>" from "MM-dd-yyyy" to "MM/dd/yyyy" and save the result for key "Verify_Offer_End"
	When User format date "<$Camp_Start$>" from "MM-dd-yyyy" to "MM/dd/yyyy" and save the result for key "Verify_Offer_Start_OfferRow"
	When User generates a "UniqueString" with "4" for key "Bar_Code"
	#Manage Program Type
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Offer Programs" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value                 |
		| SideSubMenu | Manage Offer Programs |
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
	# Create SubType
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
	Given User clears "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User enters text "Manage Offer Type" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Manage Offer Type |
	When User waits "2" seconds
	#Search Bonusing  Offer Type
	Given User clears "lylOffer_Types.txt_Search_OfferType"
	Given User enters text "Bonusing" in "lylOffer_Types.txt_Search_OfferType"
	When User pressed key "enter"
	When User waits "2" seconds
	Then User verifies that element "lylOffer_Types.Drop_OfferTypeValue" is present "true" on UI with parameters
		| Key       | Value    |
		| OfferType | Bonusing |
	Given User clicks on "lylOffer_Types.Drop_OfferTypeValue" with parameters
		| Key       | Value    |
		| OfferType | Bonusing |
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
	Given User clears "lylMAIN_NAV_BOX.txtSearch_Box"
	#Create Offer Type2 and SubType2
	Given User enters text "Manage Offer Type" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value             |
		| SideSubMenu | Manage Offer Type |
	When User waits "2" seconds
	Given User clicks on "lylOffer_Types.btnAdd_Offer_Type"
	Given User enters text "^$Offer_Type2$^" in "lylOffer_Types.txt_Offertype_Name"
	When User waits "2" seconds
	Given User clears "lylOffer_Types.txt_Offer_Code"
	Given User enters text "^$Offer_Code$^" in "lylOffer_Types.txt_Offer_Code"
	When User waits "2" seconds
	Given User clicks on "lylOffer_Types.btn_Save_Offer_Type"
	When User waits "2" seconds
	Then User verifies attribute "text" value "Record inserted successfully" of element "lylOffer_Types.lbl_ErrorMessage"
	#Search  Offer Type
	Given User clears "lylOffer_Types.txt_Search_OfferType"
	Given User enters text "<$Offer_Type2$>" in "lylOffer_Types.txt_Search_OfferType"
	When User pressed key "enter"
	When User waits "2" seconds
	Then User verifies that element "lylOffer_Types.Drop_OfferTypeValue" is present "true" on UI with parameters
		| Key       | Value           |
		| OfferType | <$Offer_Type2$> |
	Given User clicks on "lylOffer_Types.Drop_OfferTypeValue" with parameters
		| Key       | Value           |
		| OfferType | <$Offer_Type2$> |
	#Create Offer SubType
	Given User clicks on "lylOffer_Types.btn_Add_OfferSubtypes"
	Given User enters text "^$OfferSubType_Type2$^" in "lylOffer_Types.txtOfferSubtype_Name"
	Given User enters text "^$OfferSubType_Code$^" in "lylOffer_Types.txt_Subtypes_Code"
	Given User clicks on "lylOffer_Types.btnSave_Subtypes"
	When User waits "3" seconds
	Then User verifies that element "lylOffer_Types.Table_SubType_Row" is present "true" on UI with parameters
		| Key         | Value                  |
		| SubtypeName | ^$OfferSubType_Type2$^ |
		| SubtypeCode | ^$OfferSubType_Code$^  |
	Given User clicks on "lylOffer_Types.Table_SubType_Row" with parameters
		| Key         | Value                  |
		| SubtypeName | ^$OfferSubType_Type2$^ |
		| SubtypeCode | ^$OfferSubType_Code$^  |
	Given User clicks on "lylOffer_Types.btn_Save_Offer_Type"
	When User waits "2" seconds
	Then User verifies attribute "text" value "Record updated successfully" of element "lylOffer_Types.lbl_ErrorMessage"
	Given User clears "lylMAIN_NAV_BOX.txtSearch_Box"
	# Create Offer Disclaimer
	Given User enters text "Offer Disclaimer" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value            |
		| SideSubMenu | Offer Disclaimer |
	Then User verifies text - "Offer Disclaimers" is present on page
	Given User clicks on "lylOFFERDISCLAIMERS.btnADDDISCLAIMER"
	Given User enters text "^$Disclaimer_Name$^" in "lylOFFERDISCLAIMERS.txtDIsclaimerName"
	Given User clicks on "lylOFFERDISCLAIMERS.Dropdown_OfferType"
	Given User selects option "Bonusing" of element "lylOFFERDISCLAIMERS.Dropdown_OfferType" by "visibletext"
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
	Given User clears "lylMAIN_NAV_BOX.txtSearch_Box"
	#Create Disclaimer2
	# Create Offer Disclaimer
	Given User enters text "Offer Disclaimer" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value            |
		| SideSubMenu | Offer Disclaimer |
	Then User verifies text - "Offer Disclaimers" is present on page
	Given User clicks on "lylOFFERDISCLAIMERS.btnADDDISCLAIMER"
	Given User enters text "^$Disclaimer_Name2$^" in "lylOFFERDISCLAIMERS.txtDIsclaimerName"
	Given User clicks on "lylOFFERDISCLAIMERS.Dropdown_OfferType"
	Given User selects option "<$Offer_Type2$>" of element "lylOFFERDISCLAIMERS.Dropdown_OfferType" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "lylOFFERDISCLAIMERS.Offer_Sub_type"
	When User waits "2" seconds
	Then User verifies that element "lylOFFERDISCLAIMERS.OfferSubType_DropDownList" is present "true" on UI with parameters
		| Key              | Value                  |
		| OfferSubTypeName | ^$OfferSubType_Type2$^ |
	Given User clicks on "lylOFFERDISCLAIMERS.OfferSubType_DropDownList" with parameters
		| Key              | Value                  |
		| OfferSubTypeName | ^$OfferSubType_Type2$^ |
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
	#Create Campaign
	Given User clears "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User enters text "Manage Campaign" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value           |
		| SideSubMenu | Manage Campaign |
	Then User verifies text - "Campaign Management" is present on page
	Given User clicks on "ltyCampaign_Manage.btn_Campaign_Add"
	Then User verifies text - "Campaign - New" is present on page
	Given User enters text "^$CAMP_NAME$^" in "ltyCampaign_Manage.txt_Campaign_Name"
	Given User enters text "^$CampaignCode$^" in "ltyCampaign_Manage.txt_Campaign_Code"
	Given User selects option "^$programType$^" of element "ltyCampaign_Manage.txt_Program_Type" by "visibletext"
	When User waits "2" seconds
	Given User selects option "<$programSubType$>" of element "ltyCampaign_Manage.txt_Program_SubType" by "visibletext"
	Given User selects option "New" of element "ltyCampaign_Manage.DropDown_Status" by "visibletext"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtStartDate').setAttribute('value', '<$Camp_Start$>')"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtEndDate').setAttribute('value', '<$Camp_End$>')"
	Given User clicks on "ltyCampaign_Manage.txt_Start_Time"
	Given User enters text "<CampaignTime>" in "ltyCampaign_Manage.txt_Start_Time"
	Given User clicks on "ltyCampaign_Manage.txt_Start_Time"
	Given User enters text "2" in "ltyCampaign_Manage.txt_Visible_Before_Days"
	When User waits "2" seconds
	Given User enters text "<CampaignTime>" in "ltyCampaign_Manage.txt_End_Time"
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
	#Search the Above created  Campaign on Campaign Management Page
	Given User clicks on "ltyCampaign_Manage.lbl_Campaigns_Label"
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
	Given User enters text "^$FirstSegmentName$^" in "ltyManage_Segment.txt_Segment_Name"
	Given User selects option "Active" of element "ltyManage_Segment.DropDown_Status" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.Save_Button"
	Then User verifies text - "The changes have been successfully saved." is present on page
	When User waits "2" seconds
	When User "refresh" the browser
	When User waits "2" seconds
	#Serach the above Created segment
	Given User clears "ltyManage_Segment.Filter_Segment_Name"
	Given User enters text "^$FirstSegmentName$^" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
		| Key         | Value                |
		| SegmentName | ^$FirstSegmentName$^ |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value                |
		| SegmentName | ^$FirstSegmentName$^ |

	Examples:
		| CampaignTime | OfferType | offerAmount | Value | PromoExpirationTime | OfferTime |
		| 12:00 AM     | Promo     | 30          | 10    | 5                   | 12:00 AM  |

Scenario:002- Verify that User is not allowed to create bonusing offer as Private From WebApp. (TC 591052)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Campaign" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value           |
		| SideSubMenu | Manage Campaign |
	#Search Above created Campaign
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
	#Search Above created Segment
	Given User enters text "^$FirstSegmentName$^" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
		| Key         | Value                |
		| SegmentName | ^$FirstSegmentName$^ |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value                |
		| SegmentName | ^$FirstSegmentName$^ |
	# Create First Offer
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	Given User clicks on "ltyMaster_Offers.lnk_Add_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	Given User enters text "^$FIRST_OFFER_NAME$^" in "ltyMaster_Offers.txt_Offer_Name"
	Given User selects option "Active" of element "ltyMaster_Offers.Status_DropDown" by "visibletext"
	Given User selects option "<$PropertyName$>" of element "ltyMaster_Offers.DropDown_Property" by "visibletext"
	Given User selects option "Bonusing" of element "ltyMaster_Offers.OfferType_DropDown" by "visibletext"
	Given User selects option "^$OfferSubType_Type$^" of element "ltyMaster_Offers.OfferSubType_DropDown" by "visibletext"
	#After Selecting Bonusing offer type, Private is disabled
	Then User verifies attribute "disabled" value "true" of element "ltyMaster_Offers.chk_Private"

Scenario Outline:003- Verify that user is not allowed to modify/update any existing bonusing offer as private From WebApp.(TC 591052)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Campaign" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value           |
		| SideSubMenu | Manage Campaign |
	#Search Above created Campaign
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
	#Search Above created Segment
	Given User enters text "^$FirstSegmentName$^" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
		| Key         | Value                |
		| SegmentName | ^$FirstSegmentName$^ |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value                |
		| SegmentName | ^$FirstSegmentName$^ |
	# Create Bonusing  Offer
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	Given User clicks on "ltyMaster_Offers.lnk_Add_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	Given User enters text "^$FIRST_OFFER_NAME$^" in "ltyMaster_Offers.txt_Offer_Name"
	Given User selects option "Active" of element "ltyMaster_Offers.Status_DropDown" by "visibletext"
	Given User selects option "<$PropertyName$>" of element "ltyMaster_Offers.DropDown_Property" by "visibletext"
	Given User selects option "Bonusing" of element "ltyMaster_Offers.OfferType_DropDown" by "visibletext"
	Given User selects option "^$OfferSubType_Type$^" of element "ltyMaster_Offers.OfferSubType_DropDown" by "visibletext"
	Given User enters text "<offerAmount>" in "ltyMaster_Offers.txt_Offer_Amount"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtStartDate').setAttribute('value', '<$Camp_Start$>')"
	Given User enters text "<OfferTime>" in "ltyMaster_Offers.txt_Start_Time"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtEndDate').setAttribute('value', '<$Camp_End$>')"
	Given User enters text "<OfferTime>" in "ltyMaster_Offers.txt_End_Time"
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
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.SegmentName_Breadcrumb_Link" with parameters
		| Key                    | Value                |
		| SegmentName_Breadcrumb | ^$FirstSegmentName$^ |
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.tbl_Master_Offers_List" is present "true" on UI with parameters
		| Key   | Value                |
		| offer | ^$FIRST_OFFER_NAME$^ |
	Given User clicks on "ltyMaster_Offers.tbl_Master_Offers_List" with parameters
		| Key   | Value                |
		| offer | ^$FIRST_OFFER_NAME$^ |
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.btn_view"
	When User scrolls till element "ltyMaster_Offers.chk_Private"
	Then User verifies attribute "disabled" value "true" of element "ltyMaster_Offers.chk_Private"

	Examples:
		| CampaignTime | OfferType | offerAmount | Value | PromoExpirationTime | OfferTime |
		| 12:00 AM     | Promo     | 30          | 10    | 5                   | 12:00 AM  |

Scenario Outline:004- Verify that user is able to update any Non Private Offer (Food/Hotel/Electronics) to Bonusing Offer. (TC 591052)
	#Create Non Private Offer
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Campaign" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value           |
		| SideSubMenu | Manage Campaign |
	#Search Above created Campaign
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
	#Search Above created Segment
	Given User enters text "^$FirstSegmentName$^" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
		| Key         | Value                |
		| SegmentName | ^$FirstSegmentName$^ |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value                |
		| SegmentName | ^$FirstSegmentName$^ |
	# Create Bonusing  Offer
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	Given User clicks on "ltyMaster_Offers.lnk_Add_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	Given User enters text "^$Second_OFFER_NAME$^" in "ltyMaster_Offers.txt_Offer_Name"
	Given User selects option "Active" of element "ltyMaster_Offers.Status_DropDown" by "visibletext"
	Given User selects option "<$PropertyName$>" of element "ltyMaster_Offers.DropDown_Property" by "visibletext"
	Given User selects option "<$Offer_Type2$>" of element "ltyMaster_Offers.OfferType_DropDown" by "visibletext"
	Given User selects option "^$OfferSubType_Type2$^" of element "ltyMaster_Offers.OfferSubType_DropDown" by "visibletext"
	Given User enters text "<offerAmount>" in "ltyMaster_Offers.txt_Offer_Amount"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtStartDate').setAttribute('value', '<$Camp_Start$>')"
	Given User enters text "<OfferTime>" in "ltyMaster_Offers.txt_Start_Time"
	When User executes javascript "document.getElementById('ctl00_ContentPlaceHolder1_txtEndDate').setAttribute('value', '<$Camp_End$>')"
	Given User enters text "<OfferTime>" in "ltyMaster_Offers.txt_End_Time"
	Then User "selects" element "MANAGE_MASTER_OFFERS.PRINTABLE_CHECKBOX"
	Then User "selects" element "ltyMaster_Offers.chk_Printable"
	Then User "selects" element "ltyMaster_Offers.chk_Reservable"
	Then User "selects" element "ltyMaster_Offers.chk_Partial_Redemption"
	Given User enters text "AUTOMATION TEST DESCRIPTION" in "ltyMaster_Offers.txt_Description"
	Given User enters text "AUTOMATION TEST ALTERNATE DESCRIPTION" in "ltyMaster_Offers.txt_Alternate_Description"
	When User waits "2" seconds
	Given User selects option "<$Disclaimer_Name2$>" of element "ltyMaster_Offers.Disclaimer_DropDown" by "visibletext"
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
		| Key   | Value                 |
		| offer | ^$Second_OFFER_NAME$^ |
	Given User clicks on "ltyMaster_Offers.tbl_Master_Offers_List" with parameters
		| Key   | Value                 |
		| offer | ^$Second_OFFER_NAME$^ |
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.btn_view"
	#Update Non PRivate Offer to Bonusing Offer
	Given User selects option "Bonusing" of element "ltyMaster_Offers.OfferType_DropDown" by "visibletext"
	Given User selects option "^$OfferSubType_Type$^" of element "ltyMaster_Offers.OfferSubType_DropDown" by "visibletext"
	When User waits "2" seconds
	Given User selects option "<$Disclaimer_Name$>" of element "ltyMaster_Offers.Disclaimer_DropDown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.Save_Button"
	Then User verifies text - "The changes have been successfully updated." is present on page
	When User "refresh" the browser
	When User waits "2" seconds

	Examples:
		| CampaignTime | OfferType | offerAmount | Value | PromoExpirationTime | OfferTime |
		| 12:00 AM     | Promo     | 30          | 10    | 5                   | 12:00 AM  |

Scenario Outline: 005-Enroll Player using WebApp
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

	Examples:
		| BucketAmount | enrollType | prefixType | middleName | lastName  | suffix | bday       | gender | idType        | id          | expireDate | country | state   | country2 | state2  | nationality | addressType | addressLine          | city    | zip    | zipFour | fromDate   | toDate     | addressType2 | city2   | zip2   | zipFour2 | fromDate2  | toDate2    | teleType | teleNo     | teleStatus | emailType | email   | emailStatus | socialType | socialAccount  | smsType  | pin  | Permission | sms       | PLAYER_ID          | ssn       | PLAYER_ID_Key |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID675  |

Scenario:006- Create Excel for Offer Import Utility. (TC 591052)
	# Create new Program Type
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "randomnumeric" with "5" for key "CampaignID"
	When User generates a "UniqueString" with "BonCamp_:4" for key "CampaignName"
	When User generates a "randomalphanumeric" with "6" for key "CampaignCode"
	When User generates a "UniqueString" with "OfferUpload_:5" for key "OfferuploadExcel"
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate"
	When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "120" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	When User "creates" excel file "<$OfferuploadExcel$>" with sheet "Campaigns" in "xls" format with data
		| Campaign #     | Campaign Name    | Campaign Code    | Status | Program Type    | Program Subtype    | Start Date     | Start Time  | Visible Before Days | End Date    | End Time    | Reminder Type | Distribution Channel | Budget Allocated | Estimated Revenue | Overhead Per Day | Print Per Piece | Postage Per Piece | Gaming Tax Rate | Miscellaneous Costs | Notes           |
		| <$CampaignID$> | <$CampaignName$> | <$CampaignCode$> | Active | <$programType$> | <$programSubType$> | <$currendate$> | 12:00:00 AM | 1                   | <$enddate$> | 12:00:00 AM | Email         | Email                | 200000           | 20000             | 100              | 10              | 10                | 1               | 1                   | Automation ABDT |
	When User generates a "UniqueString" with "Bonseg_:4" for key "SegmentName"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segments" in "xls" format with data
		| Segment Name    | Status | Associated Campaign # |
		| <$SegmentName$> | Active | <$CampaignID$>        |
	When User generates a "UniqueString" with "BonOffer_:4" for key "OfferName"
	When User generates a "randomnumeric" with "6" for key "OfferID"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offers" in "xls" format with data
		| Offer #     | Offer Name    | Property/Property Group | Offer Type | Sub Type              | Value | Valid From Date | Valid From Time | Visible Before Days | Valid To Date | Valid to Time | Valid Days | Printable | Reservable | Paritally Redeemable | Description | Alternate Description | Disclaimer          | Distribution Channel | Billing Department | Expiration Date | Expiration Time | Expiry Days/Hours | Expiry Type (D/H) | General Offer | Event | Max Guest | ResNet Code | Yield Rank | Entries | Mystery Prize | Sweepstakes | Require Offer Redemption | Days to Expire | Days to Qualify | Play Amount | Get Amount | Increment | Associate Players | BCO Program | Friendly Name | Friendly Date | Friendly Description | Posting Date | Final Date | BCO Disclaimer | Booking Type | Booking Phone # | Booking Phone Ext | Bar Code | Print from BCO | Display at BCO | Online Only | Revenue Center Group Mapping | Event Code | General Offer Barcode | Is Kiosk | Is Private |
		| <$OfferID$> | <$OfferName$> | <$PropertyName$>        | Bonusing   | <$OfferSubType_Type$> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <$Disclaimer_Name$> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | Y          |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segment to Offer" in "xls" format with data
		| Segment | Associated Offers | Segment Name |
		|         |                   |              |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offer Excluded Time Period" in "xls" format with data
		| Excluded Time Period Type | Excluded Time Period Name | Start Date | Start Time | End Date | End Time | Status | Associated Offers |
		|                           |                           |            |            |          |          |        |                   |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Players" in "xls" format with data
		| Segment         | Player ID        | Segment Name    |
		| <$SegmentName$> | <$PLAYER_ID675$> | <$SegmentName$> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation2"

Scenario Outline: 007-Verify that User is not allowed to create  bonusing offer as Private From Offer Import. (TC 591052)
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Offer Import\ATI.Loyalty.OfferImport.exe"
	Given User enters text "<#Halo_username#>" in "OLIU_LOGIN.txt_user_id"
	Given User enters text "<#Halo_password#>" in "OLIU_LOGIN.txt_Password"
	Given User clicks on "OLIU_LOGIN.mic_DomainName"
	Given User clicks on "OLIU_LOGIN.btn_drp_dwn_select"
	Given User clicks on "OLIU_LOGIN.btn_Submit"
	When User waits "20" seconds
	Given User clicks on "OLIU_UploadSrc.btn_ButtonNext"
	Given User selects option "<UploadType>" of element "OLIU_UploadSrc.mic_UploadType" by "value"
	When User switch to window object "OLIU_UploadSrc.frm_Offer_Import"
	Given User clicks on "OLIU_UploadSrc.btn_Next_Step"
	When User switch to window object "default"
	#Clicking on Browse button.
	When User switch to window object "OLIU_UploadSrc.frm_UploadFile"
	Given User clicks on "OLIU_UploadSrc.btn_BrowseCSVButton"
	When User switch to window object "default"
	When User waits "2" seconds
	Given User clicks on "OLIU_UploadSrc.txt_FileName_Desktop"
	When User waits "2" seconds
	Given User types text "<$testbaseLocation2$><$OfferuploadExcel$>.xls" in "OLIU_UploadSrc.txt_FileName_Desktop"
	When User waits "2" seconds
	Given User clicks on "OLIU_UploadSrc.btn_OpenDesktop"
	When User waits "6" seconds
	Given User clicks on "OLIU_UploadSrc.btn_uploadButtonNext"
	When User waits "6" seconds
	Given User clicks on "OLIU_UploadSrc.txt_EnterPassword"
	When User waits "2" seconds
	Given User types text "<#Halo_password#>" in "OLIU_UploadSrc.txt_EnterPassword"
	When User waits "2" seconds
	Given User clicks on "OLIU_UploadSrc.btn_beginUpload"
	When User waits "6" seconds
	When User gets attribute "Name" value of "OLIU_UploadSrc.lbl_uploadErrorMessage" element to save with key "ErrorMessage"
	When User performs string operation "stringcontains" of provided value "<$ErrorMessage$>" with "Bonusing type offer can't be private"

	Examples:
		| UploadType   |
		| Offer Upload |

Scenario:008- Delete the Data
	#Delete Program Type and SubType
	When User executes query "delete from OFR.UC_X_ProgramSubType where ProgramTypeID in (select ID from OFR.UC_X_ProgramType where name='<$programType$>')" with connection "<#Halo_db_connectionstring#>"
	When User executes query "delete from OFR.UC_X_ProgramType where name='<$programType$>'" with connection "<#Halo_db_connectionstring#>"
	#Delete Offer Type and  Offer SubType
	When User executes query "delete from OFR.UC_X_OfferSubType where OfferTypeID in (select OfferTypeID from OFR.UC_X_OfferType  where OfferTypeName='Bonusing')" with connection "<#Halo_db_connectionstring#>"
	When User executes query "delete from OFR.UC_X_OfferSubType where OfferTypeID in (select OfferTypeID from OFR.UC_X_OfferType  where OfferTypeName='<$Offer_Type2$>')" with connection "<#Halo_db_connectionstring#>"
	When User executes query "delete from OFR.UC_X_OfferType where OfferTypeName='<$Offer_Type2$>'" with connection "<#Halo_db_connectionstring#>"
	# Delete campaign
	When User executes query "delete from OFR.UC_X_CampaignDistributionChannel where CampaignID in (select CampaignID from OFR.UC_X_Campaign where CampaignName='<$CAMP_NAME$>')" with connection "<#Halo_db_connectionstring#>"
	When User executes query "delete from OFR.UC_X_Segment where CampaignID in (select CampaignID from OFR.UC_X_Campaign where CampaignName='<$CAMP_NAME$>')" with connection "<#Halo_db_connectionstring#>"
	When User executes query "delete from OFR.UC_X_Campaign where CampaignName='<$CAMP_NAME$>'" with connection "<#Halo_db_connectionstring#>"
	# Delete campaign2
	When User executes query "delete from OFR.UC_X_CampaignDistributionChannel where CampaignID in (select CampaignID from OFR.UC_X_Campaign where CampaignName='<$CampaignName$>')" with connection "<#Halo_db_connectionstring#>"
	When User executes query "delete from OFR.UC_X_Segment where CampaignID in (select CampaignID from OFR.UC_X_Campaign where CampaignName='<$CampaignName$>')" with connection "<#Halo_db_connectionstring#>"
	When User executes query "delete from OFR.UC_X_Campaign where CampaignName='<$CampaignName$>'" with connection "<#Halo_db_connectionstring#>"

Scenario:009-Close all instance of desktop application
	When User switch to window application "ATI.Loyalty.OfferImport.exe"
	Given User closes application