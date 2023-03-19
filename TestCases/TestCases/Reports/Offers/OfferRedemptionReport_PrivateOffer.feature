@Sequential@Release_15.0@Report@Web
Feature: OfferRedemptionReport_PrivateOffer

#******************************************************************************
#**  Feature File                 : OL_OfferRedemptionReport_PrivateOffer.feature
#**  Feature Name                 :  Verify Private offer data in Offer Redemption report
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 587314
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  06/10/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/
Scenario: 001-Enroll Player using WebApp
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "PK_Test:4" for key "FirstName"
	When User waits "2" seconds
	# User enroll player in web-app
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID892" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "Test_PK:4" for key "FirstName"
	When User waits "2" seconds
	# User enroll player in web-app
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID893" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |

Scenario: 002 - Add and Redeemed Private Offer and Non Private Offer .(TC 587314)
	#Add Private Offer to player
	When User runs query "select P.PropertyName from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID892$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
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
		| Key       | Value             |
		| OfferName | <#OfferName#>     |
		| OfferType | <#OfferType#>     |
		| StartDate | 12/12/2021        |
		| EndDate   | 12/31/2098        |
		| Amount    | $10.00            |
		| Property  | <#OfferProperty#> |
		| IsPrivate | Y                 |
	Given User clicks on "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" with parameters
		| Key       | Value             |
		| OfferName | <#OfferName#>     |
		| OfferType | <#OfferType#>     |
		| StartDate | 12/12/2021        |
		| EndDate   | 12/31/2098        |
		| Amount    | $10.00            |
		| Property  | <#OfferProperty#> |
		| IsPrivate | Y                 |
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"
	#When User waits "4" seconds
	# Provide Authorization.
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Guest Satisfaction" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	Given User clicks on "OLW_PLAYER_OFFER.btn_CancelAndReturn_PlayerOffer"
	Given User enters text "<#OfferName#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	#Verify that Private Offer added to Player Account and Private Column value displayed as 'Y'
	Then User verifies that element "OLW_PLAYER_OFFER.lnkassignedprivateoffer" is present "true" on UI with parameters
		| Key       | Value             |
		| OfferName | <#OfferName#>     |
		| OfferType | <#OfferType#>     |
		| Status    | Active            |
		| StartDate | 12/12/2021        |
		| EndDate   | 12/31/2098        |
		| Amount    | $10.00            |
		| Property  | <#OfferProperty#> |
		| IsPrivate | Y                 |
	Given User clicks on "OLW_PLAYER_OFFER.lnkassignedprivateoffer" with parameters
		| Key       | Value             |
		| OfferName | <#OfferName#>     |
		| OfferType | <#OfferType#>     |
		| Status    | Active            |
		| StartDate | 12/12/2021        |
		| EndDate   | 12/31/2098        |
		| Amount    | $10.00            |
		| Property  | <#OfferProperty#> |
		| IsPrivate | Y                 |
	#REdeem Private Offer
	When User waits "3" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Redeem_Offer"
	When User waits "2" seconds
	Given User switches to frame "default"
	Given User switches to frame "OLW_PLAYER_OFFER.frm_Redeem_Offer_Popup"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Popup_Redeem_Offer"
	When User waits "4" seconds
	Given User switches to frame "default"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_No_Offer_Exist" is present "true" on UI
	#Add Non Private Offer to player
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID893$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
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
		| Property  | <#OfferProperty#>        |
	Given User clicks on "OLW_PLAYER_OFFER.tbl_Unassigned_Offers" with parameters
		| Key       | Value                    |
		| OfferName | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType | <#Reg_Offer_Type#>       |
		| StartDate | <#ValidFromDate#>        |
		| EndDate   | <#ValidToDate#>          |
		| Amount    | $30.00                   |
		| Property  | <#OfferProperty#>        |
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"
	#When User waits "6" seconds
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
		| Property       | <#OfferProperty#>        |
	Given User clicks on "OLW_PLAYER_OFFER.tbl_Offer_Added" with parameters
		| Key            | Value                    |
		| OfferName      | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType      | <#Reg_Offer_Type#>       |
		| OfferStatus    | Active                   |
		| OfferStartDate | <#ValidFromDate#>        |
		| OfferEndDate   | <#ValidToDate#>          |
		| Amount         | $30.00                   |
		| Property       | <#OfferProperty#>        |
	#REdeem Non Private Offer
	When User waits "3" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Redeem_Offer"
	When User waits "2" seconds
	Given User switches to frame "default"
	Given User switches to frame "OLW_PLAYER_OFFER.frm_Redeem_Offer_Popup"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Popup_Redeem_Offer"
	When User waits "4" seconds
	Given User switches to frame "default"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_No_Offer_Exist" is present "true" on UI

Scenario:003  - Validate the addition of new dropdown filter with label - 'Private' in Offer Redemption Report.(TC 587314)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Offer Redemption Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                   |
		| ReportName | Offer Redemption Report |
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
	Then User verifies that element "OLW_OfrRedemptonRprt.lbl_Title_OfferRedemptionReport" is present "true" on UI
	#Verify in Summary Header Private column has added
	Then User verifies that element "OLW_OfrRedemptonRprt.tbl_Summary_Column" is present "true" on UI with parameters
		| Key                 | Value                 |
		| RedemptionProperty  | Redemption Property   |
		| OfferName           | Offer Name            |
		| UserSlotmastID      | User/SlotmastID       |
		| TotalPlayers        | Total Players         |
		| TotalAmountRedeemed | Total Amount Redeemed |
		| PrivateColumn       | Private               |
	#Verify Details Header private column has added
	Then User verifies that element "OLW_OfrRedemptonRprt.tbl_Details_Column" is present "true" on UI with parameters
		| Key                     | Value                   |
		| Redemption_Property     | Redemption Property     |
		| Sequenceno              | ID #                    |
		| OfferName               | Offer Name              |
		| OfferID                 | Offer ID                |
		| Bar_Code                | Bar Code                |
		| UniversalID             | Universal ID            |
		| Player_Name             | Player Name             |
		| Redeemed_Date_Time      | Redeemed Date Time      |
		| Offer_Amount            | Offer Amount            |
		| Amount_Redeemed         | Amount Redeemed         |
		| Remaining_Balance       | Remaining Balance       |
		| SlotmastID              | SlotmastID              |
		| Play_on_Redemption_Date | Play on Redemption Date |
		| Redeemed_Outlet_Name    | Redeemed Outlet Name    |
		| Private_Column          | Private                 |

Scenario:004  - Validate Summary and details section is displaying Private column with correct values populated in Offer Redemption Report. (TC 587314)
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID892$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PlayerIntID_3"
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID893$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PlayerIntID_4"
	When User runs query "select ID from OFR.UC_PL_Offer where PlayerID = '<$PlayerIntID_3$>'" with connection "<#Halo_db_connectionstring#>" and save with key "Sequenceno"
	When User runs query "select ID from OFR.UC_PL_Offer where PlayerID = '<$PlayerIntID_4$>'" with connection "<#Halo_db_connectionstring#>" and save with key "Sequenceno1"
	When User runs query "select OfferCode from OFR.UC_X_OfferMaster where OfferName = '<#OfferName#>'" with connection "<#Halo_db_connectionstring#>" and save with key "Offer_ID"
	When User runs query "select OfferCode from OFR.UC_X_OfferMaster where OfferName = '<#Reg_FIRST_OFFER_NAME#>'" with connection "<#Halo_db_connectionstring#>" and save with key "Offer_ID2"
	When User generates a "getDate" with "yyyy-MM-dd hh:mm:ss" for key "currendate"
	When User performs action "subtractdays" of "1" on dateTime "<$currendate$>" with format "yyyy-MM-dd hh:mm:ss" to save the result for key "RedeemedDateTime"
	When User executes query "update OFR.UC_PL_OfferRedeem set RedemptionDateTime = '<$RedeemedDateTime$>' where PlayerOfferID ='<$Sequenceno$>'" with connection "<#Halo_db_connectionstring#>"
	When User performs action "subtractdays" of "1" on dateTime "<$currendate$>" with format "yyyy-MM-dd hh:mm:ss" to save the result for key "RedeemedDateTime1"
	When User executes query "update OFR.UC_PL_OfferRedeem set RedemptionDateTime = '<$RedeemedDateTime1$>' where PlayerOfferID ='<$Sequenceno1$>'" with connection "<#Halo_db_connectionstring#>"
	##get firstname and last name
	When User runs query "select lastname from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID892$>'" with connection "<#Halo_db_connectionstring#>" and save with key "Lastname1"
	When User runs query "select FirstName from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID892$>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName1"
	When User saves string operation "append" of provided value "<$Lastname1$>" with ", " to key "Lastnameupdated"
	When User saves string operation "append" of provided value "<$Lastnameupdated$>" with " <$FirstName1$>" to key "PlayerName"
	#Get Fristname and lastname
	When User runs query "select lastname from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID893$>'" with connection "<#Halo_db_connectionstring#>" and save with key "Lastname2"
	When User runs query "select FirstName from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID893$>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName2"
	When User saves string operation "append" of provided value "<$Lastname2$>" with ", " to key "Lastnameupdated2"
	When User saves string operation "append" of provided value "<$Lastnameupdated2$>" with " <$FirstName2$>" to key "PlayerName2"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Offer Redemption Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                   |
		| ReportName | Offer Redemption Report |
	#Enter Universal ID
	#Given User enters text "<$PLAYER_ID890$>" in "OLW_OffrAuditReport.txt_UniversalID"
	Given User enters text "<$PLAYER_ID892$>" in "OLW_OffrAuditReport.txt_UniversalID"
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
	Then User verifies that element "OLW_OfrRedemptonRprt.lbl_Title_OfferRedemptionReport" is present "true" on UI
	#Verify Summary of Private Offer
	Then User verifies that element "OLW_OfrRedemptonRprt.tbl_SummaryData" is present "true" on UI with parameters
		| Key                 | Value             |
		| PropertyName        | <#OfferProperty#> |
		| OfferName           | <#OfferName#>     |
		| UserID              | <#Halo_username#> |
		| PlayerCount         | 1                 |
		| TotalRedeemedAmount | $10               |
		| IsPrivate           | Yes               |
	#Verify Details of Private Offer
	Then User verifies that element "OLW_OfrRedemptonRprt.tbl_Details_Data" is present "true" on UI with parameters
		| Key          | Value             |
		| PropertyName | <#OfferProperty#> |
		| Sequenceno   | <$Sequenceno$>    |
		| OfferName    | <#OfferName#>     |
		| OfferID      | <$Offer_ID$>      |
		| BarCode      | NA                |
		| UniversalID  | <$PLAYER_ID892$>  |
		| PlayerName   | <$PlayerName$>    |
		#| RedeemedDateTime     | <$UpdatedRedeemedDateTime$>                 |
		| OfferAmount          | $10               |
		| RedeemedAmount       | $10               |
		| RemainingBalance     | $0                |
		| UserID               | <#Halo_username#> |
		| PlayonRedemptionDate | N                 |
		| RedeemedOutletName   | NA                |
		| IsPrivate            | Yes               |
	#Switch to another window tab
	When User switches to browser tab "0"
	#Enter Universal ID
	Given User clears "OLW_OffrAuditReport.txt_UniversalID"
	Given User enters text "<$PLAYER_ID893$>" in "OLW_OffrAuditReport.txt_UniversalID"
	#Select Private Yes
	Given User clicks on "OLW_OffrAuditReport.Dropdown_PrivateFilter" with parameters
		| Key          | Value |
		| FilterOption | No    |
	When User waits "2" seconds
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	#Verify Summary of  Non Private Offer
	Then User verifies that element "OLW_OfrRedemptonRprt.tbl_SummaryData" is present "true" on UI with parameters
		| Key                 | Value                    |
		| PropertyName        | <#OfferProperty#>        |
		| OfferName           | <#Reg_FIRST_OFFER_NAME#> |
		| UserID              | <#Halo_username#>        |
		| PlayerCount         | 1                        |
		| TotalRedeemedAmount | $30                      |
		| IsPrivate           | No                       |
	#Verify Details of Private Offer
	Then User verifies that element "OLW_OfrRedemptonRprt.tbl_Details_Data" is present "true" on UI with parameters
		| Key          | Value                    |
		| PropertyName | <#OfferProperty#>        |
		| Sequenceno   | <$Sequenceno1$>          |
		| OfferName    | <#Reg_FIRST_OFFER_NAME#> |
		| OfferID      | <$Offer_ID2$>            |
		| BarCode      | NA                       |
		| UniversalID  | <$PLAYER_ID893$>         |
		| PlayerName   | <$PlayerName2$>          |
		#| RedeemedDateTime     | <$UpdatedRedeemedDateTime1$>                 |
		| OfferAmount          | $30               |
		| RedeemedAmount       | $30               |
		| RemainingBalance     | $0                |
		| UserID               | <#Halo_username#> |
		| PlayonRedemptionDate | N                 |
		| RedeemedOutletName   | NA                |
		| IsPrivate            | No                |