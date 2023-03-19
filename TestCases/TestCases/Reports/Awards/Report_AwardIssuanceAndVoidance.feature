@Release_15.0@Report@Web
Feature: Report_AwardIssuanceAndVoidance

#******************************************************************************
#**  Feature File                 : OL_Report_AwardIssuanceAndVoidance.feature
#**  Feature Name                 : Private Dropdown and Private Column verification.
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 589552
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  06/21/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/

Scenario:001 -Verify the selectable report criteria will include Private  with a dropdown of All, Yes and No in Award Issuance and Voidance.(TC 589552)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Award Issuance and Voidance Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                              |
		| ReportName | Award Issuance and Voidance Report |
	#Verify Private Filter exist in report
	Then User verifies that element "OLW_Report_AwardIssuanceAndVoidance.lbl_PrivateLabel" is present "true" on UI
	Then User verifies that element "OLW_Report_AwardIssuanceAndVoidance.DropDown_Private" is present "true" on UI with parameters
		| Key             | Value |
		| PrivateDropDown | All   |
	Given User clicks on "OLW_Report_AwardIssuanceAndVoidance.DropDown_Private" with parameters
		| Key             | Value |
		| PrivateDropDown | Yes   |
	Then User verifies that element "OLW_Report_AwardIssuanceAndVoidance.DropDown_Private" is present "true" on UI with parameters
		| Key             | Value |
		| PrivateDropDown | Yes   |
	Given User clicks on "OLW_Report_AwardIssuanceAndVoidance.DropDown_Private" with parameters
		| Key             | Value |
		| PrivateDropDown | No    |
	Then User verifies that element "OLW_Report_AwardIssuanceAndVoidance.DropDown_Private" is present "true" on UI with parameters
		| Key             | Value |
		| PrivateDropDown | No    |
	#Verify Report Type DropDown
	Then User verifies that element "OLW_Report_AwardIssuanceAndVoidance.DropDown_ReportType" is present "true" on UI with parameters
		| Key         | Value |
		| Report_Type | Both  |
	Given User clicks on "OLW_Report_AwardIssuanceAndVoidance.DropDown_ReportType" with parameters
		| Key         | Value  |
		| Report_Type | Detail |
	Then User verifies that element "OLW_Report_AwardIssuanceAndVoidance.DropDown_ReportType" is present "true" on UI with parameters
		| Key         | Value  |
		| Report_Type | Detail |
	Given User clicks on "OLW_Report_AwardIssuanceAndVoidance.DropDown_ReportType" with parameters
		| Key         | Value   |
		| Report_Type | Summary |
	Then User verifies that element "OLW_Report_AwardIssuanceAndVoidance.DropDown_ReportType" is present "true" on UI with parameters
		| Key         | Value   |
		| Report_Type | Summary |
	Then User verifies that element "OLW_Report_AwardIssuanceAndVoidance.txt_AwardName" is present "true" on UI
	Then User verifies that element "OLW_Report_AwardIssuanceAndVoidance.txt_UniversalID" is present "true" on UI

Scenario:002 Verify that the report title is displayed correctly for Award Issuance and Voidance report. (TC 589552)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Award Issuance and Voidance Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                              |
		| ReportName | Award Issuance and Voidance Report |
	When User waits "2" seconds
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_Report_AwardIssuanceAndVoidance.lbl_Report_Title" is present "true" on UI

Scenario:003- Verify that the all Bucket Awards Reports will include a column indicating if a Bucket Award is Private on selecting 'Details' in Report Type filter on Select Report Criteria screen in Award Issuance and Voidance report.(TC 589552)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Award Issuance and Voidance Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                              |
		| ReportName | Award Issuance and Voidance Report |
	When User waits "2" seconds
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_Report_AwardIssuanceAndVoidance.lbl_Report_Title" is present "true" on UI
	#Verify in Summary column
	Then User verifies that element "OLW_Report_AwardIssuanceAndVoidance.tbl_Summary_Column" is present "true" on UI with parameters
		| Key                  | Value                |
		| Transaction_Property | Transaction Property |
		| Bucket_Col           | Bucket               |
		| Issued_Col           | Issued               |
		| Voided_Col           | Voided               |
	#Verify Details Header private column has been added
	Then User verifies that element "OLW_Report_AwardIssuanceAndVoidance.tbl_Details_Column" is present "true" on UI with parameters
		| Key                 | Value                 |
		| TransactionProperty | Transaction Property  |
		| UniversalID         | Universal ID          |
		| PlayerName          | Player Name           |
		| Status_Col          | Status                |
		| Property_Col        | Property              |
		| TransactionDateTime | Transaction Date Time |
		| User_Col            | User                  |
		| AwardName           | Award Name            |
		| AwardAmount         | Award Amount          |
		| Bucket_Col          | Bucket                |
		| StartDateTime       | Start Date Time       |
		| EndDateTime         | End Date Time         |
		| BatchID             | Batch ID              |
		| SequenceNumber      | Sequence Number       |
		| UpdatedDate         | Updated Date          |
		| Private_Col         | Private               |