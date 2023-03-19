@Release_15.0@Report@Web
Feature: Report_AwardTransaction

#******************************************************************************
#**  Feature File                 : OL_Report_AwardTransaction.feature
#**  Feature Name                 : Private Dropdown and Private Column verification.
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 589552
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  06/21/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/



Scenario:001 -Verify the selectable report criteria will include Private  with a dropdown of All, Yes and No in Award Transaction Report.(TC 589552)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Award Transaction Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                    |
		| ReportName | Award Transaction Report |
	#Verify Private Filter exist in report
	Then User verifies that element "OLW_Report_AwardTransaction.lbl_Private" is present "true" on UI
	Then User verifies that element "OLW_Report_AwardTransaction.DropDown_Private" is present "true" on UI with parameters
		| Key                    | Value |
		| Private_DropDownOption | All   |
	Given User clicks on "OLW_Report_AwardTransaction.DropDown_Private" with parameters
		| Key                    | Value |
		| Private_DropDownOption | Yes   |
	Then User verifies that element "OLW_Report_AwardTransaction.DropDown_Private" is present "true" on UI with parameters
		| Key                    | Value |
		| Private_DropDownOption | Yes   |
	Given User clicks on "OLW_Report_AwardTransaction.DropDown_Private" with parameters
		| Key                    | Value |
		| Private_DropDownOption | No    |
	Then User verifies that element "OLW_Report_AwardTransaction.DropDown_Private" is present "true" on UI with parameters
		| Key                    | Value |
		| Private_DropDownOption | No    |
	#Verify Report Type DropDown
	Then User verifies that element "OLW_Report_AwardTransaction.DropDown_ReportType" is present "true" on UI with parameters
		| Key              | Value |
		| ReportTypeStatus | Both  |
	Given User clicks on "OLW_Report_AwardTransaction.DropDown_ReportType" with parameters
		| Key              | Value  |
		| ReportTypeStatus | Detail |
	Then User verifies that element "OLW_Report_AwardTransaction.DropDown_ReportType" is present "true" on UI with parameters
		| Key              | Value  |
		| ReportTypeStatus | Detail |
	Given User clicks on "OLW_Report_AwardTransaction.DropDown_ReportType" with parameters
		| Key              | Value   |
		| ReportTypeStatus | Summary |
	Then User verifies that element "OLW_Report_AwardTransaction.DropDown_ReportType" is present "true" on UI with parameters
		| Key              | Value   |
		| ReportTypeStatus | Summary |
	Then User verifies that element "OLW_Report_AwardTransaction.txt_AwardName" is present "true" on UI
	Then User verifies that element "OLW_Report_AwardTransaction.txt_UniversalID" is present "true" on UI

Scenario:002 Verify that the report title is displayed correctly for Award Transaction report. (TC 589552)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Award Transaction Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                    |
		| ReportName | Award Transaction Report |
	When User waits "2" seconds
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_Report_AwardTransaction.lbl_ReportTitle" is present "true" on UI

Scenario:003- Verify that the all Bucket Awards Reports will include a column indicating if a Bucket Award is Private on selecting 'Details' in Report Type filter on Select Report Criteria screen in Award Transaction Report.(TC 589552)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Award Transaction Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                    |
		| ReportName | Award Transaction Report |
	When User waits "2" seconds
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_Report_AwardTransaction.lbl_ReportTitle" is present "true" on UI
	#Verify in Summary  column 
	Then User verifies that element "OLW_Report_AwardTransaction.tbl_Summary_Column" is present "true" on UI with parameters
		| Key                 | Value                |
		| TransactionProperty | Transaction Property |
		| Bucket_Col          | Bucket               |
		| Issued_Col          | Issued               |
		| Redeemed_Col        | Redeemed             |
		| Voided_Col          | Voided               |
		| Expired_Col         | Expired              |
	#Verify Details Header private column has benn added
	Then User verifies that element "OLW_Report_AwardTransaction.tbl_Details_Col" is present "true" on UI with parameters
		| Key         | Value                 |
		| TransProp   | Transaction Property  |
		| TransaDate  | Transaction Date Time |
		| UniverID    | Universal ID          |
		| P_Name      | Player Name           |
		| A_Name      | Award Name            |
		| A_Amt       | Award Amount          |
		| Buck_Col  | Bucket                |
		| A_Date      | Award Start Date Time |
		| A_EndDate   | Award End Date Time   |
		| I_Date       | Issued on Date Time   |
		| Issue_by    | Issued by             |
		| p_User        | Issued User property  |
		| I_Amt      | Amount Issued |
		| TransAmt    | Transaction Amount          |
		| AmtRemain   | Amount Remaining     |
		| Updateby   | Updated by      |
		| ID_Col     | SlotmastID           |
		| Status_Col  | Status            |
		| SeqNo       | Sequence Number                |
		| Private_Col | Private               |