@Sequential@Release_15.0@Report@Web
Feature: OfferRedemptionReportwithPlay_PrivateOffer

#******************************************************************************
#**  Feature File                 : OL_OfferRedemptionReportwithPlay_PrivateOffer.feature
#**  Feature Name                 :  Verify Private offer data in Offer Redemption report with play
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 587372
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  06/15/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/
Scenario Outline: 001-Enroll Player using WebApp
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
	When User runs query "select P.PropertyName from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"

	Examples:
		| BucketAmount | enrollType | prefixType | middleName | lastName  | suffix | bday       | gender | idType        | id          | expireDate | country | state   | country2 | state2  | nationality | addressType | addressLine          | city    | zip    | zipFour | fromDate   | toDate     | addressType2 | city2   | zip2   | zipFour2 | fromDate2  | toDate2    | teleType | teleNo     | teleStatus | emailType | email   | emailStatus | socialType | socialAccount  | smsType  | pin  | Permission | sms       | PLAYER_ID          | ssn       | PLAYER_ID_Key |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID896  |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID897  |

Scenario:002  - Add Private and Non Private Offer to Player for Redemption Report with play.(TC 587372)
	#Add Private Offer to player
	When User runs query "select P.PropertyName from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID896$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
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
	Given User enters text "<$PLAYER_ID897$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
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

Scenario:003  - Validate the addition of new dropdown filter with label - 'Private' in Offer Redemption Report with Play.(Tc 587372)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Offer Redemption Report with Play" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                             |
		| ReportName | Offer Redemption Report with Play |
	#Verify Private Filter exist in report
	Then User verifies that element "OLW_Report_OffrRedmptnwithPlay.lbl_PrivateLabel" is present "true" on UI
	Given User clicks on "OLW_Report_OffrRedmptnwithPlay.Dropdown_PrivateStatus" with parameters
		| Key          | Value |
		| StatusOption | Yes   |
	Then User verifies that element "OLW_Report_OffrRedmptnwithPlay.Dropdown_PrivateStatus" is present "true" on UI with parameters
		| Key          | Value |
		| StatusOption | Yes   |
	Given User clicks on "OLW_Report_OffrRedmptnwithPlay.Dropdown_PrivateStatus" with parameters
		| Key          | Value |
		| StatusOption | No    |
	Then User verifies that element "OLW_Report_OffrRedmptnwithPlay.Dropdown_PrivateStatus" is present "true" on UI with parameters
		| Key          | Value |
		| StatusOption | No    |
	Given User clicks on "OLW_Report_OffrRedmptnwithPlay.Dropdown_PrivateStatus" with parameters
		| Key          | Value |
		| StatusOption | All   |
	Then User verifies that element "OLW_Report_OffrRedmptnwithPlay.Dropdown_PrivateStatus" is present "true" on UI with parameters
		| Key          | Value |
		| StatusOption | All   |
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_Report_OffrRedmptnwithPlay.lbl_ReportTitle" is present "true" on UI
	#Verify in Summary Header Private column has added
	Then User verifies that element "OLW_Report_OffrRedmptnwithPlay.tbl_Summary_Column" is present "true" on UI with parameters
		| Key                   | Value                 |
		| Redemption_Property   | Redemption Property   |
		| Offer_Name            | Offer Name            |
		| User_SlotmastID       | User/SlotmastID       |
		| Total_Players         | Total Players         |
		| Total_Amount_Redeemed | Total Amount Redeemed |
		| Private_Column        | Private               |
	#Verify Details Header private column has added
	Then User verifies that element "OLW_Report_OffrRedmptnwithPlay.tbl_DetailsColumn" is present "true" on UI with parameters
		| Key         | Value                   |
		| Prop        | Redemption Property     |
		| Seqno       | ID #                    |
		| Offer       | Offer Name              |
		| OID         | Offer ID                |
		| BarCode     | Bar Code                |
		| P_ID        | Universal ID            |
		| Player      | Player Name             |
		| RDate       | Redeemed Date Time      |
		| Trips       | Trips Per Player        |
		| ADTheo      | Average Daily Theo      |
		| ADLoss      | Average Daily Loss      |
		| OfrAmt      | Offer Amount            |
		| AmtRedmd    | Amount Redeemed         |
		| Rmngbal     | Remaining Balance       |
		| user        | User/                   |
		| Slot_mastID | SlotmastID              |
		| ReonDate    | Play on Redemption Date |
		| Outlet      | Redeemed Outlet Name    |
		| PrivateCol  | Private                 |

Scenario:004  - Validate Summary and details section is displaying Private column with correct values populated in Offer Redemption with play.(Tc 587372)
	#Get Offer Code
	When User runs query "select OfferCode from  OFR.UC_X_OfferMaster where OfferName = '<#OfferName#>'" with connection "<#Halo_db_connectionstring#>" and save with key "Offer_Code_96"
	When User runs query "select OfferCode from OFR.UC_X_OfferMaster where OfferName = '<#Reg_FIRST_OFFER_NAME#>'" with connection "<#Halo_db_connectionstring#>" and save with key "Offer_Code97"
	# Get the Player int id
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID896$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PlayerIntID_96"
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID897$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PlayerIntID_97"
	#Get Player Offer ID
	When User runs query "select ID from OFR.UC_PL_Offer where PlayerID = '<$PlayerIntID_96$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PlayerOfferID_96"
	When User runs query "select ID from OFR.UC_PL_Offer where PlayerID = '<$PlayerIntID_97$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PlayerOfferID_97"
	#Get Current Date
	When User generates a "getDate" with "yyyy-MM-dd hh:mm:ss" for key "currendate"
	#Update Date in DB
	When User performs action "subtractdays" of "1" on dateTime "<$currendate$>" with format "yyyy-MM-dd hh:mm:ss" to save the result for key "RedeemedDateTIme"
	When User executes query "update OFR.UC_PL_OfferRedeem set RedemptionDateTime = '<$RedeemedDateTIme$>' where PlayerOfferID ='<$PlayerOfferID_96$>'" with connection "<#Halo_db_connectionstring#>"
	When User executes query "update OFR.UC_PL_OfferRedeem set RedemptionDateTime = '<$RedeemedDateTIme$>' where PlayerOfferID ='<$PlayerOfferID_97$>'" with connection "<#Halo_db_connectionstring#>"
	##get firstname and last name
	When User runs query "select lastname from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID896$>'" with connection "<#Halo_db_connectionstring#>" and save with key "Lastname96"
	When User runs query "select FirstName from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID896$>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName96"
	When User saves string operation "append" of provided value "<$Lastname96$>" with ", " to key "Lastnameupdated96"
	When User saves string operation "append" of provided value "<$Lastnameupdated96$>" with " <$FirstName96$>" to key "PlayerName96"
	##get firstname and last name
	When User runs query "select lastname from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID897$>'" with connection "<#Halo_db_connectionstring#>" and save with key "Lastname97"
	When User runs query "select FirstName from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID897$>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName97"
	When User saves string operation "append" of provided value "<$Lastname97$>" with ", " to key "Lastnameupdated97"
	When User saves string operation "append" of provided value "<$Lastnameupdated97$>" with " <$FirstName97$>" to key "PlayerName97"
	When User runs query "select OfferCode from OFR.UC_X_OfferMaster where OfferName = '<#Reg_FIRST_OFFER_NAME#>'" with connection "<#Halo_db_connectionstring#>" and save with key "Offer_Code97"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Offer Redemption Report with Play" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                             |
		| ReportName | Offer Redemption Report with Play |
	Given User enters text "<$PLAYER_ID896$>" in "OLW_Report_OffrRedmptnwithPlay.txt_UniversalID"
	Given User clicks on "OLW_Report_OffrRedmptnwithPlay.Dropdown_PrivateStatus" with parameters
		| Key          | Value |
		| StatusOption | Yes   |
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_Report_OffrRedmptnwithPlay.lbl_ReportTitle" is present "true" on UI
	#Verify in Summary Header Private column has added
	Then User verifies that element "OLW_Report_OffrRedmptnwithPlay.tbl_Summary_Data" is present "true" on UI with parameters
		| Key            | Value             |
		| Prop           | <#OfferProperty#> |
		| OfferName      | <#OfferName#>     |
		| UserId         | <#Halo_username#> |
		| PlayerCount    | 1                 |
		| RedeemedAmount | $10               |
		| IsPrivate      | Yes               |
	#Verify Details Header private column has added
	Then User verifies that element "OLW_Report_OffrRedmptnwithPlay.tbl_Details_Data" is present "true" on UI with parameters
		| Key        | Value                |
		| Prop       | <#OfferProperty#>    |
		| PlrOffrID  | <$PlayerOfferID_96$> |
		| OfferName  | <#OfferName#>        |
		| OfrID      | <$Offer_Code_96$>    |
		| BCode      | NA                   |
		| PlrID      | <$PLAYER_ID896$>     |
		| PlrName    | <$PlayerName96$>     |
		| TTheo      | $0                   |
		| TActual    | $0                   |
		| PTheo      | $0                   |
		| PActual    | $0                   |
		| OffrAmnt   | $10                  |
		| RdmdAmnt   | $10                  |
		| UserID     | oladmin              |
		| PlayRDDate | N                    |
		| Outlet     | NA                   |
		| IsPrivate  | Yes                  |
	#Verify Data fof Non Private Offer
	#Switch to another window tab
	When User switches to browser tab "0"
	#Enter Universal ID
	Given User clears "OLW_OffrAuditReport.txt_UniversalID"
	Given User enters text "<$PLAYER_ID897$>" in "OLW_OffrAuditReport.txt_UniversalID"
	#Select Private Yes
	Given User clicks on "OLW_Report_OffrRedmptnwithPlay.Dropdown_PrivateStatus" with parameters
		| Key          | Value |
		| StatusOption | No    |
	When User waits "2" seconds
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	#Verify the report Title
	Then User verifies that element "OLW_Report_OffrRedmptnwithPlay.lbl_ReportTitle" is present "true" on UI
	#Verify in Summary Header Private column has added
	Then User verifies that element "OLW_Report_OffrRedmptnwithPlay.tbl_Summary_Data" is present "true" on UI with parameters
		| Key            | Value                    |
		| Prop           | <#OfferProperty#>        |
		| OfferName      | <#Reg_FIRST_OFFER_NAME#> |
		| UserId         | <#Halo_username#>        |
		| PlayerCount    | 1                        |
		| RedeemedAmount | $30                      |
		| IsPrivate      | No                       |
	#Verify Details Header private column has added
	Then User verifies that element "OLW_Report_OffrRedmptnwithPlay.tbl_Details_Data" is present "true" on UI with parameters
		| Key        | Value                    |
		| Prop       | <#OfferProperty#>        |
		| PlrOffrID  | <$PlayerOfferID_97$>     |
		| OfferName  | <#Reg_FIRST_OFFER_NAME#> |
		| OfrID      | <$Offer_Code97$>         |
		| BCode      | NA                       |
		| PlrID      | <$PLAYER_ID897$>         |
		| PlrName    | <$PlayerName97$>         |
		| TTheo      | $0                       |
		| TActual    | $0                       |
		| PTheo      | $0                       |
		| PActual    | $0                       |
		| OffrAmnt   | $30                      |
		| RdmdAmnt   | $30                      |
		| UserID     | oladmin                  |
		| PlayRDDate | N                        |
		| Outlet     | NA                       |
		| IsPrivate  | No                       |