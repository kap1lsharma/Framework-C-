@Sequential@Release_15.0@Report@Web
Feature: OfferReservationReport_PrivateOffer

#******************************************************************************
#**  Feature File                 : OL_OfferReservationReport_PrivateOffer
#**  Feature Name                 :  Verify Private offer data in Offer reservation report
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 587449
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  06/06/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/

Scenario: 001-Enroll Player using WebApp
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "PK_Reserve:4" for key "FirstName"
	When User waits "2" seconds
	# User enroll player in web-app
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID870" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "Test_Reserve:4" for key "FirstName"
	When User waits "2" seconds
	# User enroll player in web-app
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID871" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |

Scenario:002- Reserve Private and Non Private Offer.(Tc 587449)
	#Get Offer Start and End Date
	When User runs query "select OfferCode from  OFR.UC_X_OfferMaster where OfferName = '<#OfferName#>'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferCode194"
	When User runs query "select AvailableStartDate from OFR.UC_X_OfferMaster where OfferName ='<#OfferName#>'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferStartDate1"
	When User runs query "select AvailableEndDate from OFR.UC_X_OfferMaster where OfferName ='<#OfferName#>'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferEndDate1"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID870$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
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
	#When User waits "4" seconds
	# Provide Authorization.
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Guest Satisfaction" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	Given User clicks on "OLW_PLAYER_OFFER.btn_CancelAndReturn_PlayerOffer"
	When User waits "2" seconds
	#Verify the OFfer Exist in player Account
	Given User enters text "<#OfferName#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
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
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Reserve_Offer"
	#Fill the Authorization
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Guest Satisfaction" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "6" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_No_Offer_Exist" is present "true" on UI
	#Check the Reserve Checkbox
	Then User "unchecks" element "OLW_PLAYER_OFFER.chk_Active"
	Then User "checks" element "OLW_PLAYER_OFFER.chk_Reserved"
	#Verify the Reserved Offer
	When User waits "4" seconds
	Given User clears "OLW_PLAYER_OFFER.txt_OfferName_Search"
	Given User enters text "<#OfferName#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_ReservedOffer" is present "true" on UI with parameters
		| Key            | Value             |
		| OFFER_Name     | <#OfferName#>     |
		| OfferCode      | <$OfferCode194$>     |
		| OfferType      | <#OfferType#>     |
		| Redeem_Partial | Y                 |
		| OfferStatus    | Reserved          |
		| OfferStartDate | 12/12/2021        |
		| OfferEndDate   | 12/31/2098        |
		| OfferAmount    | $10.00            |
		| PropertyName   | <#OfferProperty#> |
		| IsKiosk        | N                 |
		| IsPrivate      | Y                 |
	#Reserve Non Private Offer
	When User runs query "select OfferCode from OFR.UC_X_OfferMaster where OfferName ='<#Reg_FIRST_OFFER_NAME#>'" with connection "<#Halo_db_connectionstring#>" and save with key "Reg_OfferCode"
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID871$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
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
	#When User waits "6" seconds
	# fill the Authorization
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Guest Satisfaction" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "6" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	Given User clicks on "OLW_PLAYER_OFFER.btn_CancelAndReturn_PlayerOffer"
	When User waits "2" seconds
	#Verify the OFfer Exist in player Account
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	#Verify that Private Offer added to Player Account and Private Column value displayed as 'Y'
	Then User verifies that element "OLW_PLAYER_OFFER.lnkassignedprivateoffer" is present "true" on UI with parameters
		| Key       | Value                    |
		| OfferName | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType | <#Reg_Offer_Type#>       |
		| Status    | Active                   |
		| StartDate | <#ValidFromDate#>        |
		| EndDate   | <#ValidToDate#>          |
		| Amount    | $30.00                   |
		| Property  | <#OfferProperty#>        |
		| IsPrivate | N                        |
	Given User clicks on "OLW_PLAYER_OFFER.lnkassignedprivateoffer" with parameters
		| Key       | Value                    |
		| OfferName | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType | <#Reg_Offer_Type#>       |
		| Status    | Active                   |
		| StartDate | <#ValidFromDate#>        |
		| EndDate   | <#ValidToDate#>          |
		| Amount    | $30.00                   |
		| Property  | <#OfferProperty#>        |
		| IsPrivate | N                        |
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Reserve_Offer"
	#Fill the Authorization
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Guest Satisfaction" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "6" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_No_Offer_Exist" is present "true" on UI
	#Check the Reserve Checkbox
	Then User "unchecks" element "OLW_PLAYER_OFFER.chk_Active"
	When User waits "2" seconds
	Then User "checks" element "OLW_PLAYER_OFFER.chk_Reserved"
	#Verify the Reserved Offer
	When User waits "4" seconds
	Given User clears "OLW_PLAYER_OFFER.txt_OfferName_Search"
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_ReservedOffer" is present "true" on UI with parameters
		| Key            | Value                    |
		| OFFER_Name     | <#Reg_FIRST_OFFER_NAME#> |
		| OfferCode      | <$Reg_OfferCode$>        |
		| OfferType      | <#Reg_Offer_Type#>       |
		| Redeem_Partial | Y                        |
		| OfferStatus    | Reserved                 |
		| OfferStartDate | 05/04/2022               |
		| OfferEndDate   | 12/31/2046               |
		| OfferAmount    | $30.00                   |
		| PropertyName   | <#OfferProperty#>        |
		| IsKiosk        | N                        |
		| IsPrivate      | N                        |

Scenario:003 - Validate the addition of new dropdown filter with label - 'Private' in Offer reservation Report.(TC 587449)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Offer Reservation Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                    |
		| ReportName | Offer Reservation Report |
	#Verify Private Filter exist in report
	Then User verifies that element "OLW_OfrRsrrvtionRprt.lbl_Private" is present "true" on UI
	Given User clicks on "OLW_OfrRsrrvtionRprt.Dropdown_PrivateStatus" with parameters
		| Key          | Value |
		| StatusOption | Yes   |
	Then User verifies that element "OLW_OfrRsrrvtionRprt.Dropdown_PrivateStatus" is present "true" on UI with parameters
		| Key          | Value |
		| StatusOption | Yes   |
	Given User clicks on "OLW_OfrRsrrvtionRprt.Dropdown_PrivateStatus" with parameters
		| Key          | Value |
		| StatusOption | No    |
	Then User verifies that element "OLW_OfrRsrrvtionRprt.Dropdown_PrivateStatus" is present "true" on UI with parameters
		| Key          | Value |
		| StatusOption | No    |
	Given User clicks on "OLW_OfrRsrrvtionRprt.Dropdown_PrivateStatus" with parameters
		| Key          | Value |
		| StatusOption | All   |
	Then User verifies that element "OLW_OfrRsrrvtionRprt.Dropdown_PrivateStatus" is present "true" on UI with parameters
		| Key          | Value |
		| StatusOption | All   |
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_OfrRsrrvtionRprt.lbl_ReportTitle" is present "true" on UI
	#Verify the Column name in Summary and Details section
	Then User verifies that element "OLW_OfrRsrrvtionRprt.tbl_Summary_Column" is present "true" on UI with parameters
		| Key           | Value        |
		| Offer_Name    | Offer Name   |
		| Player_Count  | Player Count |
		| Privatecolumn | Private      |
	#Verify Details Header private column has added
	Then User verifies that element "OLW_OfrRsrrvtionRprt.tbl_Details_Column" is present "true" on UI with parameters
		| Key                     | Value                    |
		| Offer_Name              | Offer Name               |
		| Offer_ID                | Offer ID                 |
		| Universal_ID            | Universal ID             |
		| Player_Name             | Player Name              |
		| UserID                  | User                     |
		| Offer_Reserved_DateTime | Offer Reserved Date Time |
		| Offer_Amount            | Offer Amount             |
		| PrivateColumn           | Private                  |

Scenario:004  - Validate Summary and details section is displaying Private column with correct values populated in Offer reservation Report.(TC 587449)
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID870$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PlayerIntID_70"
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID871$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PlayerIntID_71"
	#Get Current Date
	When User generates a "getDate" with "yyyy-MM-dd hh:mm:ss" for key "currendateRes"
	#Update Reserved Date Time
	When User performs action "subtractdays" of "1" on dateTime "<$currendateRes$>" with format "yyyy-MM-dd hh:mm:ss" to save the result for key "ReserveDateTime"
	When User executes query "update OFR.UC_PL_Offer set UpdatedDate = '<$ReserveDateTime$>' where PlayerID ='<$PlayerIntID_70$>'" with connection "<#Halo_db_connectionstring#>"
	When User executes query "update OFR.UC_PL_Offer set UpdatedDate = '<$ReserveDateTime$>' where PlayerID ='<$PlayerIntID_71$>'" with connection "<#Halo_db_connectionstring#>"
	#Get Offer ID
	When User runs query "select ID from OFR.UC_PL_Offer where PlayerID = '<$PlayerIntID_70$>'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferID_70"
	When User runs query "select ID from OFR.UC_PL_Offer where PlayerID = '<$PlayerIntID_71$>'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferID_71"
	#Get player name for Private Offer
	When User runs query "select lastname from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID870$>'" with connection "<#Halo_db_connectionstring#>" and save with key "Lastname70"
	When User runs query "select FirstName from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID870$>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName70"
	When User saves string operation "append" of provided value "<$Lastname70$>" with ", " to key "Lastnameupdated70"
	When User saves string operation "append" of provided value "<$Lastnameupdated70$>" with " <$FirstName70$>" to key "PlayerName70"
	#Get player name for non Private Offer
	When User runs query "select lastname from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID871$>'" with connection "<#Halo_db_connectionstring#>" and save with key "Lastname71"
	When User runs query "select FirstName from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID871$>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName71"
	When User saves string operation "append" of provided value "<$Lastname71$>" with ", " to key "Lastnameupdated71"
	When User saves string operation "append" of provided value "<$Lastnameupdated71$>" with " <$FirstName71$>" to key "PlayerName71"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Offer Reservation Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                    |
		| ReportName | Offer Reservation Report |
	#Verify Private Filter exist in report
	Given User enters text "<$PLAYER_ID870$>" in "OLW_OfrRsrrvtionRprt.txt_UniversalID"
	Then User verifies that element "OLW_OfrRsrrvtionRprt.lbl_Private" is present "true" on UI
	Given User clicks on "OLW_OfrRsrrvtionRprt.Dropdown_PrivateStatus" with parameters
		| Key          | Value |
		| StatusOption | Yes   |
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_OfrRsrrvtionRprt.lbl_ReportTitle" is present "true" on UI
	#Verify data of Summary and Details
	Then User verifies that element "OLW_OfrRsrrvtionRprt.tbl_SummaryData" is present "true" on UI with parameters
		| Key         | Value         |
		| OfferName   | <#OfferName#> |
		| PlayerCount | 1             |
		| IsPrivate   | Yes           |
	When User waits "2" seconds
	#Verify Details of Private Offer
	Then User verifies that element "OLW_OfrRsrrvtionRprt.tbl_DetailsData" is present "true" on UI with parameters
		| Key         | Value             |
		| OfferName   | <#OfferName#>     |
		| OfferID     | <$OfferID_70$>    |
		| UniversalID | <$PLAYER_ID870$>  |
		| PlayerName  | <$PlayerName70$>  |
		| UserID      | <#Halo_username#> |
		| OfferAmount | $10               |
		| Is_Private  | Yes               |
	When User waits "2" seconds
	#Verify summary and details for Non Private Offer
	#Switch to another window tab
	When User switches to browser tab "0"
	#Enter Universal ID
	Given User clears "OLW_OfrRsrrvtionRprt.txt_UniversalID"
	Given User enters text "<$PLAYER_ID871$>" in "OLW_OfrRsrrvtionRprt.txt_UniversalID"
	#Select Private Yes
	Given User clicks on "OLW_OfrRsrrvtionRprt.Dropdown_PrivateStatus" with parameters
		| Key          | Value |
		| StatusOption | No    |
	When User waits "2" seconds
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	#Verify Summary of  Non Private Offer
	Then User verifies that element "OLW_OfrRsrrvtionRprt.tbl_SummaryData" is present "true" on UI with parameters
		| Key         | Value                    |
		| OfferName   | <#Reg_FIRST_OFFER_NAME#> |
		| PlayerCount | 1                        |
		| IsPrivate   | No                       |
	When User waits "2" seconds
	#Verify Details of Private Offer
	Then User verifies that element "OLW_OfrRsrrvtionRprt.tbl_DetailsData" is present "true" on UI with parameters
		| Key         | Value                    |
		| OfferName   | <#Reg_FIRST_OFFER_NAME#> |
		| OfferID     | <$OfferID_71$>           |
		| UniversalID | <$PLAYER_ID871$>         |
		| PlayerName  | <$PlayerName71$>         |
		| UserID      | <#Halo_username#>        |
		| OfferAmount | $30                      |
		| Is_Private  | No                       |