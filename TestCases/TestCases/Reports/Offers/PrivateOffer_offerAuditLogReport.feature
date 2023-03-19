@Sequential@Release_15.0@Report@Web
Feature: OfferAuditLogReport_PrivateOffer



#******************************************************************************
#**  Feature File                 : OL_OfferAuditLogReport_PrivateOffer
#**  Feature Name                 :  Verify Private offer data in Offer Audit Log report
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 587305
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  06/13/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/
#
#/*************************************************************************


Scenario: 001-Enroll Player using WebApp
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "PK_Audit:4" for key "FirstName"
	When User waits "2" seconds
	# User enroll player in web-app
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID872" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "Audit_PK:4" for key "FirstName"
	When User waits "2" seconds
	# User enroll player in web-app
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID873" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |

Scenario: 002-  Validate the addition of new dropdown filter with label - 'Private' in offer Audit Report. (TC 587305)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Offer Audit Log Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                  |
		| ReportName | Offer Audit Log Report |
	#Verify Private Filter exist in report
	Then User verifies that element "OLW_OffrAuditReport.lbl_Private" is present "true" on UI
	Given User clicks on "OLW_OffrAuditReport.Dropdown_PrivateFilter" with parameters
		| Key          | Value |
		| FilterOption | Yes   |
	Then User verifies that element "OLW_OffrAuditReport.Dropdown_PrivateFilter" is present "true" on UI with parameters
		| Key          | Value |
		| FilterOption | Yes   |
	Given User clicks on "OLW_OffrAuditReport.Dropdown_PrivateFilter" with parameters
		| Key          | Value |
		| FilterOption | No    |
	Then User verifies that element "OLW_OffrAuditReport.Dropdown_PrivateFilter" is present "true" on UI with parameters
		| Key          | Value |
		| FilterOption | No    |
	Given User clicks on "OLW_OffrAuditReport.Dropdown_PrivateFilter" with parameters
		| Key          | Value |
		| FilterOption | All   |
	Then User verifies that element "OLW_OffrAuditReport.Dropdown_PrivateFilter" is present "true" on UI with parameters
		| Key          | Value |
		| FilterOption | All   |
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_OffrAuditReport.lbl_ReportTitle" is present "true" on UI
	#Verify in Summary Header Private column has added
	Then User verifies that element "OLW_OffrAuditReport.tbl_SummaryColumnName" is present "true" on UI with parameters
		| Key            | Value        |
		| Property_Name  | Property     |
		| Offer_Name     | Offer Name   |
		| Player_Count   | Player Count |
		| Private_column | Private      |
	#Verify Details Header private column has added
	Then User verifies that element "OLW_OffrAuditReport.tbl_DetailsColumnName" is present "true" on UI with parameters
		| Key               | Value                |
		| OfferMasterID     | Offer Master ID      |
		| OfferName         | Offer Name           |
		| CampaignID        | Campaign ID          |
		| CampaignName      | Campaign Name        |
		| PropertyName      | Property             |
		| SegmentNameorCode | Segment Name or Code |
		| UniversalID       | Universal ID         |
		| AddRemove         | Add/Remove           |
		| ChangeDateTime    | Change Date Time     |
		| UserName          | User                 |
		| CommentsColumn    | Comments             |
		| PrivateColumn     | Private              |

Scenario:003  - Add Private and Non Private Offer to Player for Offer Audit Report. (TC 587305)
	#Add Private Offer to player
	When User runs query "select P.PropertyName from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID872$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "2" seconds
	Given User enters text "<#OfferName#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	Then User verifies that element "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" is present "true" on UI with parameters
		| Key       | Value            |
		| OfferName | <#OfferName#>    |
		| OfferType | <#OfferType#>    |
		| StartDate | 12/12/2021       |
		| EndDate   | 12/31/2098       |
		| Amount    | $10.00           |
		| Property  | <$PropertyName$> |
		| IsPrivate | Y                |
	Given User clicks on "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" with parameters
		| Key       | Value            |
		| OfferName | <#OfferName#>    |
		| OfferType | <#OfferType#>    |
		| StartDate | 12/12/2021       |
		| EndDate   | 12/31/2098       |
		| Amount    | $10.00           |
		| Property  | <$PropertyName$> |
		| IsPrivate | Y                |
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"

	# Provide Authorization.
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Guest Satisfaction" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	Given User clicks on "OLW_PLAYER_OFFER.btn_CancelAndReturn_PlayerOffer"
	When User waits "2" seconds
	Given User enters text "<#OfferName#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	#Verify that Private Offer added to Player Account and Private Column value displayed as 'Y'
	Then User verifies that element "OLW_PLAYER_OFFER.lnkassignedprivateoffer" is present "true" on UI with parameters
		| Key       | Value            |
		| OfferName | <#OfferName#>    |
		| OfferType | <#OfferType#>    |
		| Status    | Active           |
		| StartDate | 12/12/2021       |
		| EndDate   | 12/31/2098       |
		| Amount    | $10.00           |
		| Property  | <$PropertyName$> |
		| IsPrivate | Y                |
	#Add Non Private Offer to player
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID873$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "2" seconds
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_Unassigned_Offers" is present "true" on UI with parameters
		| Key       | Value                    |
		| OfferName | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType | <#Reg_Offer_Type#>       |
		| StartDate | <#ValidFromDate#>        |
		| EndDate   | <#ValidToDate#>          |
		| Amount    | $30.00                   |
		| Property  | <$PropertyName$>         |
	Given User clicks on "OLW_PLAYER_OFFER.tbl_Unassigned_Offers" with parameters
		| Key       | Value                    |
		| OfferName | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType | <#Reg_Offer_Type#>       |
		| StartDate | <#ValidFromDate#>        |
		| EndDate   | <#ValidToDate#>          |
		| Amount    | $30.00                   |
		| Property  | <$PropertyName$>         |
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"
	
	# fill the Authorization
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Guest Satisfaction" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "6" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	Given User clicks on "OLW_PLAYER_OFFER.btn_CancelAndReturn_PlayerOffer"
	#Verify offer has been added or not.
	When User waits "2" seconds
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_Offer_Added" is present "true" on UI with parameters
		| Key            | Value                    |
		| OfferName      | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType      | <#Reg_Offer_Type#>       |
		| OfferStatus    | Active                   |
		| OfferStartDate | <#ValidFromDate#>        |
		| OfferEndDate   | <#ValidToDate#>          |
		| Amount         | $30.00                   |
		| Property       | <$PropertyName$>         |

Scenario:004  - Validate Summary and details section is displaying Private column with correct values populated in Offer Audit Report. (TC 587305)
	#Get Data from DB
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID872$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PlayerIntID_72"
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID873$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PlayerIntID_73"
	When User generates a "getDate" with "yyyy-MM-dd hh:mm:ss" for key "currendate"
	When User performs action "subtractdays" of "1" on dateTime "<$currendate$>" with format "yyyy-MM-dd hh:mm:ss" to save the result for key "UpdatedDate"
	When User executes query "update OFR.UC_PL_Offer set UpdatedDate = '<$UpdatedDate$>' where PlayerID ='<$PlayerIntID_72$>'" with connection "<#Halo_db_connectionstring#>"
	When User executes query "update OFR.UC_PL_Offer set UpdatedDate = '<$UpdatedDate$>' where PlayerID ='<$PlayerIntID_73$>'" with connection "<#Halo_db_connectionstring#>"
	When User runs query "select OfferMasterID from OFR.UC_PL_Offer where PlayerID = '<$PlayerIntID_72$>'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferMasterID1"
	When User runs query "select OfferMasterID from OFR.UC_PL_Offer where PlayerID = '<$PlayerIntID_73$>'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferMasterID2"
	When User runs query "select CampaignID from OFR.UC_X_Campaign where CampaignName = '<#CampaignName#>'" with connection "<#Halo_db_connectionstring#>" and save with key "CampaignID1"
	When User runs query "select CampaignID from OFR.UC_X_Campaign where CampaignName = '<#Reg_CampaignName#>'" with connection "<#Halo_db_connectionstring#>" and save with key "CampaignID2"
	When User runs query "select UpdatedDate from OFR.UC_PL_Offer where PlayerID ='<$PlayerIntID_72$>'" with connection "<#Halo_db_connectionstring#>" and save with key "ChangeDateTime1"
	When User runs query "select UpdatedDate from OFR.UC_PL_Offer where PlayerID ='<$PlayerIntID_73$>'" with connection "<#Halo_db_connectionstring#>" and save with key "ChangeDateTime2"
	#Login to webapp
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Offer Audit Log Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                  |
		| ReportName | Offer Audit Log Report |
	#Enter Universal ID
	Given User enters text "<$PLAYER_ID872$>" in "OLW_OffrAuditReport.txt_UniversalID"
	#Select Private Yes
	Given User clicks on "OLW_OffrAuditReport.Dropdown_PrivateFilter" with parameters
		| Key          | Value |
		| FilterOption | Yes   |
	When User waits "6" seconds
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_OffrAuditReport.lbl_ReportTitle" is present "true" on UI
	#Verify Summary of  Private Offer
	Then User verifies that element "OLW_OffrAuditReport.tbl_Summary_Data" is present "true" on UI with parameters
		| Key         | Value             |
		| Property    | <#OfferProperty#> |
		| OfferName   | <#OfferName#>     |
		| PlayerCount | 1                 |
		| IsPrivate   | Yes               |
	#Verify Details of  Private Offer
	Then User verifies that element "OLW_OffrAuditReport.tbl_Details_Data" is present "true" on UI with parameters
		| Key            | Value               |
		| OfferMasterID  | <$OfferMasterID1$>  |
		| OfferName      | <#OfferName#>       |
		| CampaignID     | <$CampaignID1$>     |
		| CampaignName   | <#CampaignName#>    |
		| Property       | <#OfferProperty#>   |
		| SegmentName    | <#SegmentName#>     |
		| UniversalID    | <$PLAYER_ID872$>    |
		| AddRemove      | Add                 |
		| changedatetime | <$ChangeDateTime1$> |
		| user           | oladmin             |
		| comments       | Test Comments       |
		| IsPrivate      | Yes                 |
	#Switch to another window tab
	When User switches to browser tab "0"
	#Enter Universal ID
	Given User clears "OLW_OffrAuditReport.txt_UniversalID"
	Given User enters text "<$PLAYER_ID873$>" in "OLW_OffrAuditReport.txt_UniversalID"
	#Select Private No
	Given User clicks on "OLW_OffrAuditReport.Dropdown_PrivateFilter" with parameters
		| Key          | Value |
		| FilterOption | No    |
	When User waits "6" seconds
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	#Verify Summary of Non Private Offer
	Then User verifies that element "OLW_OffrAuditReport.tbl_Summary_Data" is present "true" on UI with parameters
		| Key         | Value                    |
		| Property    | <#OfferProperty#>        |
		| OfferName   | <#Reg_FIRST_OFFER_NAME#> |
		| PlayerCount | 1                        |
		| IsPrivate   | No                       |
	#Verify Details of Non Private Offer
	Then User verifies that element "OLW_OffrAuditReport.tbl_Details_Data" is present "true" on UI with parameters
		| Key            | Value                    |
		| OfferMasterID  | <$OfferMasterID2$>       |
		| OfferName      | <#Reg_FIRST_OFFER_NAME#> |
		| CampaignID     | <$CampaignID2$>          |
		| CampaignName   | <#Reg_CampaignName#>     |
		| Property       | <#OfferProperty#>        |
		| SegmentName    | <#Reg_SegmentName#>      |
		| UniversalID    | <$PLAYER_ID873$>         |
		| AddRemove      | Add                      |
		| changedatetime | <$ChangeDateTime2$>      |
		| user           | oladmin                  |
		| comments       | Test Comments            |
		| IsPrivate      | No                       |