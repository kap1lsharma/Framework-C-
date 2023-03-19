@Release_15.0@Report@Web
Feature: AwardUploadReport_PrivateAward

#******************************************************************************
#**  Feature File                 : OL_Report_AwardUpload.feature
#**  Feature Name                 : Private Dropdown and Private Column verification.
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 589552
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  06/21/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/
Scenario:001 -Verify the selectable report criteria will include Private  with a dropdown of All, Yes and No in Award Upload Report.(TC 589552)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Award Upload Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value               |
		| ReportName | Award Upload Report |
	#Verify Private Filter exist in report
	Then User verifies that element "OLW_AwardUploadReprt.lbl_PrivateLabel" is present "true" on UI
	Then User verifies that element "OLW_AwardUploadReprt.Dropdown_Private" is present "true" on UI with parameters
		| Key           | Value |
		| PrivateOption | All   |
	Given User clicks on "OLW_AwardUploadReprt.DropDown_Private" with parameters
		| Key           | Value |
		| PrivateOption | Yes   |
	Then User verifies that element "OLW_AwardUploadReprt.DropDown_Private" is present "true" on UI with parameters
		| Key           | Value |
		| PrivateOption | Yes   |
	Given User clicks on "OLW_AwardUploadReprt.Dropdown_Private" with parameters
		| Key           | Value |
		| PrivateOption | No    |
	Then User verifies that element "OLW_AwardUploadReprt.Dropdown_Private" is present "true" on UI with parameters
		| Key           | Value |
		| PrivateOption | No    |
	#Verify Report Type DropDown
	Then User verifies that element "OLW_AwardUploadReprt.DropDown_ReportType" is present "true" on UI with parameters
		| Key        | Value |
		| ReportType | Both  |
	Given User clicks on "OLW_AwardUploadReprt.DropDown_ReportType" with parameters
		| Key        | Value  |
		| ReportType | Detail |
	Then User verifies that element "OLW_AwardUploadReprt.DropDown_ReportType" is present "true" on UI with parameters
		| Key        | Value  |
		| ReportType | Detail |
	Given User clicks on "OLW_AwardUploadReprt.DropDown_ReportType" with parameters
		| Key        | Value   |
		| ReportType | Summary |
	Then User verifies that element "OLW_AwardUploadReprt.DropDown_ReportType" is present "true" on UI with parameters
		| Key        | Value   |
		| ReportType | Summary |
	Then User verifies that element "OLW_AwardUploadReprt.txt_AwardName" is present "true" on UI

Scenario:002 Verify that the report title is displayed correctly in Award Upload report. (TC 589552)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Award Upload Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value               |
		| ReportName | Award Upload Report |
	When User waits "2" seconds
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_AwardUploadReprt.lbl_Title_AwardUploadReport" is present "true" on UI

Scenario:003- Verify that the all Bucket Awards Reports will include a column indicating if a Bucket Award is Private on selecting 'Details' in Report Type filter on Select Report Criteria screen in Award Upload Report.(TC 589552)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Award Upload Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value               |
		| ReportName | Award Upload Report |
	When User waits "2" seconds
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_AwardUploadReprt.lbl_Title_AwardUploadReport" is present "true" on UI
	#Verify in Summary column 
	Then User verifies that element "OLW_AwardUploadReprt.tbl_Summary_Column" is present "true" on UI with parameters
		| Key               | Value       |
		| Property_Column   | Property    |
		| User_Column       | User        |
		| Bucket_Column     | Bucket      |
		| AwardCount_Column | Award Count |
	#Verify in Details Header private column has been added
	Then User verifies that element "OLW_AwardUploadReprt.tbl_Details_Column" is present "true" on UI with parameters
		| Key                | Value               |
		| AwardID            | Award ID            |
		| BatchID            | Batch ID            |
		| AwardName          | Award Name          |
		| Bucket_Col         | Bucket              |
		| Property_Col       | Property            |
		| AwardStartDate     | Award Start Date    |
		| AwardEndDate       | Award End Date      |
		| Amount_Col         | Amount              |
		| ProcessStatus      | Process Status      |
		| Process_StatusDate | Process Status Date |
		| Details_Col        | Details             |
		| TransactionID      | Transaction ID      |
		| User_Col           | User                |
		| CreatedDate        | Created Date        |
		| UpdatedDate        | Updated Date        |
		| Private_Col        | Private             |