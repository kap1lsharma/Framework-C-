@Sequential@Release_15.0@Group_PrivateOffer@Web
Feature: OL_PrivateOfferConversion

#******************************************************************************
#**  Feature File                 : OL_PrivateOfferConversion.feature
#**  Feature Name                 : Private Offer Creation & Converson to Regula and Regular Offer to private.
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 583315
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  04/27/2022     Jogendra Singh            Initial Draft
#********************************************************************************/
#
#/*************************************************************************

Scenario: 001-Create Campaign and Campaign Segment for Private Offer
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
	Given User selects option "<#Reg_Program_Type#>" of element "ltyCampaign_Manage.txt_Program_Type" by "visibletext"
	When User waits "2" seconds
	Given User selects option "<#Reg_ProgramSub_Type#>" of element "ltyCampaign_Manage.txt_Program_SubType" by "visibletext"
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
	Given User clicks on "ltyManage_Segment.btn_Add_Segment"
	When User generates a "UniqueString" with "AutoSegment:6" for key "SecondSegmentName"
	Given User enters text "<$SecondSegmentName$>" in "ltyManage_Segment.txt_Segment_Name"
	Given User selects option "Active" of element "ltyManage_Segment.DropDown_Status" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.Save_Button"
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
	Given User clears "ltyManage_Segment.Filter_Segment_Name"
	Given User enters text "<$SecondSegmentName$>" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
		| Key         | Value                 |
		| SegmentName | <$SecondSegmentName$> |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value                 |
		| SegmentName | <$SecondSegmentName$> |


Scenario: 002-Validate by adding single Non-Private Offers in a segment and then converting the same offer to Private offer. (TC 583315)
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
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
	Given User selects option "<#Reg_Offer_Type#>" of element "ltyMaster_Offers.OfferType_DropDown" by "visibletext"
	Given User selects option "<#Reg_OfferSubType#>" of element "ltyMaster_Offers.OfferSubType_DropDown" by "visibletext"
	Given User enters text "100" in "ltyMaster_Offers.txt_Offer_Amount"
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
	Given User selects option "<#Reg_OfferDisclaimers#>" of element "ltyMaster_Offers.Disclaimer_DropDown" by "visibletext"
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
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.btn_view"
	When User waits "2" seconds
	Then User verifies attribute "<Rattribute>" value "<RPrivateCheckbox>" of element "ltyMaster_Offers.chk_Private"
	Then User "selects" element "ltyMaster_Offers.chk_Private"
	Given User clicks on "ltyMaster_Offers.Save_Button"
	Then User verifies text - "The changes have been successfully updated." is present on page
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
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.btn_view"
	When User waits "2" seconds
	Then User verifies attribute "<attribute>" value "<PrivateCheckbox>" of element "ltyMaster_Offers.chk_Private"
Examples: 
    | PrivateCheckbox | attribute | Rattribute | RPrivateCheckbox |
    | true            | checked   | selected   | false            |

Scenario: 003-Validate by adding 2 Private Offers in a segment and then converting one to Non-Private offer. (TC 583315)
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
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
	When User generates a "UniqueString" with "Private_OFFER :4" for key "PrivateOffer1"
	Given User enters text "^$PrivateOffer1$^" in "ltyMaster_Offers.txt_Offer_Name"
	Given User selects option "Active" of element "ltyMaster_Offers.Status_DropDown" by "visibletext"
	Given User selects option "<$PropertyName$>" of element "ltyMaster_Offers.DropDown_Property" by "visibletext"
	Given User selects option "<#Reg_Offer_Type#>" of element "ltyMaster_Offers.OfferType_DropDown" by "visibletext"
	Given User selects option "<#Reg_OfferSubType#>" of element "ltyMaster_Offers.OfferSubType_DropDown" by "visibletext"
	Given User enters text "100" in "ltyMaster_Offers.txt_Offer_Amount"
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
	Given User selects option "<#Reg_OfferDisclaimers#>" of element "ltyMaster_Offers.Disclaimer_DropDown" by "visibletext"
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
		| Key   | Value             |
		| offer | ^$PrivateOffer1$^ |
	Given User clicks on "ltyMaster_Offers.tbl_Master_Offers_List" with parameters
		| Key   | Value             |
		| offer | ^$PrivateOffer1$^ |
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.btn_view"
	When User waits "2" seconds
	Then User "uncheck" element "ltyMaster_Offers.chk_Private"
	Given User clicks on "ltyMaster_Offers.Save_Button"
	Then User verifies text - "Private offer can not be clubbed with non private offer" is present on page

Scenario: 004-Validate by adding single Private Offers in a segment and then converting the same offer to Non-Private offer. (TC 583315)
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
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
	Given User enters text "<$SecondSegmentName$>" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
		| Key         | Value                 |
		| SegmentName | <$SecondSegmentName$> |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value                 |
		| SegmentName | <$SecondSegmentName$> |
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
	Given User selects option "<#Reg_Offer_Type#>" of element "ltyMaster_Offers.OfferType_DropDown" by "visibletext"
	Given User selects option "<#Reg_OfferSubType#>" of element "ltyMaster_Offers.OfferSubType_DropDown" by "visibletext"
	Given User enters text "100" in "ltyMaster_Offers.txt_Offer_Amount"
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
	Given User selects option "<#Reg_OfferDisclaimers#>" of element "ltyMaster_Offers.Disclaimer_DropDown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.Save_Button"
	Then User verifies text - "The changes have been successfully saved." is present on page
	When User "refresh" the browser
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.SegmentName_Breadcrumb_Link" with parameters
		| Key                    | Value                 |
		| SegmentName_Breadcrumb | <$SecondSegmentName$> |
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.tbl_Master_Offers_List" is present "true" on UI with parameters
		| Key   | Value            |
		| offer | ^$PrivateOffer$^ |
	Given User clicks on "ltyMaster_Offers.tbl_Master_Offers_List" with parameters
		| Key   | Value            |
		| offer | ^$PrivateOffer$^ |
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.btn_view"
	When User waits "2" seconds
	Then User verifies attribute "<attribute>" value "<PrivateCheckbox>" of element "ltyMaster_Offers.chk_Private"
	Then User "uncheck" element "ltyMaster_Offers.chk_Private"
	Given User clicks on "ltyMaster_Offers.Save_Button"
	Then User verifies text - "The changes have been successfully updated." is present on page
	When User "refresh" the browser
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.SegmentName_Breadcrumb_Link" with parameters
		| Key                    | Value                 |
		| SegmentName_Breadcrumb | <$SecondSegmentName$> |
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.tbl_Master_Offers_List" is present "true" on UI with parameters
		| Key   | Value            |
		| offer | ^$PrivateOffer$^ |
	Given User clicks on "ltyMaster_Offers.tbl_Master_Offers_List" with parameters
		| Key   | Value            |
		| offer | ^$PrivateOffer$^ |
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.btn_view"
	When User waits "2" seconds
	Then User verifies attribute "<Rattribute>" value "<RPrivateCheckbox>" of element "ltyMaster_Offers.chk_Private"
Examples: 
    | PrivateCheckbox | attribute | Rattribute | RPrivateCheckbox |
    | true            | checked   | selected   | false            |

Scenario: 005-Validate by adding 2 Non-Private Offers in a segment and then converting one to Private offer.
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
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
	Given User enters text "<$SecondSegmentName$>" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
		| Key         | Value                 |
		| SegmentName | <$SecondSegmentName$> |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value                 |
		| SegmentName | <$SecondSegmentName$> |
	# Create private Offers
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	Given User clicks on "ltyMaster_Offers.lnk_Add_Offers"
	Then User verifies that element "ltyMaster_Offers.lbl_Title_MasterOffers" is present "true" on UI
	When User generates a "UniqueString" with "Private_OFFER :4" for key "PrivateOffer2"
	Given User enters text "^$PrivateOffer2$^" in "ltyMaster_Offers.txt_Offer_Name"
	Given User selects option "Active" of element "ltyMaster_Offers.Status_DropDown" by "visibletext"
	Given User selects option "<$PropertyName$>" of element "ltyMaster_Offers.DropDown_Property" by "visibletext"
	Given User selects option "<#Reg_Offer_Type#>" of element "ltyMaster_Offers.OfferType_DropDown" by "visibletext"
	Given User selects option "<#Reg_OfferSubType#>" of element "ltyMaster_Offers.OfferSubType_DropDown" by "visibletext"
	Given User enters text "100" in "ltyMaster_Offers.txt_Offer_Amount"
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
	Given User selects option "<#Reg_OfferDisclaimers#>" of element "ltyMaster_Offers.Disclaimer_DropDown" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.Save_Button"
	Then User verifies text - "The changes have been successfully saved." is present on page
	When User "refresh" the browser
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.SegmentName_Breadcrumb_Link" with parameters
		| Key                    | Value                 |
		| SegmentName_Breadcrumb | <$SecondSegmentName$> |
	When User waits "2" seconds
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.tbl_Master_Offers_List" is present "true" on UI with parameters
		| Key   | Value             |
		| offer | ^$PrivateOffer2$^ |
	Given User clicks on "ltyMaster_Offers.tbl_Master_Offers_List" with parameters
		| Key   | Value             |
		| offer | ^$PrivateOffer2$^ |
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.btn_view"
	When User waits "2" seconds
	Then User "checks" element "ltyMaster_Offers.chk_Private"
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.Save_Button"
	Then User verifies text - "Private offer can not be clubbed with non private offer" is present on page