@Sequential@Release_15.0@Report@Web
Feature: OfferChangeReport_PrivateOffer


#******************************************************************************
#**  Feature File                 : OL_OfferChangeReport_PrivateOffer.feature
#**  Feature Name                 :  Verify Private offer data in Offer Change report 
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 587447
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  06/15/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/


Scenario:001  - Validate the addition of new dropdown filter with label - 'Private' in Offer Change Report.(TC- 587447)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Offer Change Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value               |
		| ReportName | Offer Change Report |
	#Verify Private Filter exist in report
	Then User verifies that element "OLW_OfferChangeReprt.lbl_PrivateLabel" is present "true" on UI
	Given User clicks on "OLW_OfferChangeReprt.DropDown_PrivateFilter" with parameters
		| Key                 | Value |
		| PrivateFilterOption | Yes   |
	Then User verifies that element "OLW_OfferChangeReprt.DropDown_PrivateFilter" is present "true" on UI with parameters
		| Key                 | Value |
		| PrivateFilterOption | Yes   |
	Given User clicks on "OLW_OfferChangeReprt.DropDown_PrivateFilter" with parameters
		| Key                 | Value |
		| PrivateFilterOption | No    |
	Then User verifies that element "OLW_OfferChangeReprt.DropDown_PrivateFilter" is present "true" on UI with parameters
		| Key                 | Value |
		| PrivateFilterOption | No    |
	Given User clicks on "OLW_OfferChangeReprt.DropDown_PrivateFilter" with parameters
		| Key                 | Value |
		| PrivateFilterOption | All   |
	Then User verifies that element "OLW_OfferChangeReprt.DropDown_PrivateFilter" is present "true" on UI with parameters
		| Key                 | Value |
		| PrivateFilterOption | All   |
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_OfferChangeReprt.lbl_ReportTitle" is present "true" on UI
	#Verify in Summary Header Private column has added
	Then User verifies that element "OLW_OfferChangeReprt.tbl_Summary_Column" is present "true" on UI with parameters
		| Key         | Value       |
		| Prop        | Property    |
		| UserID      | User        |
		| Offer_Count | Offer Count |
	#Verify Details Header private column has added
	Then User verifies that element "OLW_OfferChangeReprt.tbl_Details_Column" is present "true" on UI with parameters
		| Key            | Value            |
		| Campaign_ID    | Campaign ID      |
		| Campaign_Name  | Campaign Name    |
		| Prop           | Property         |
		| Segment_Name   | Segment Name     |
		| Offer_Name     | Offer Name       |
		| Field_Change   | Field Change     |
		| Original_Value | Original Value   |
		| Changed_To     | Changed To       |
		| ChangeDateTime | Change Date Time |
		| UserID         | User             |
		| Private_Column | Private          |