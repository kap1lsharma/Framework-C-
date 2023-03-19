@Sequential@Release_15.0@Report@Web
Feature: OfferVoidReport_PrivateOffer

#******************************************************************************
#**  Feature File                 : OL_OfferVoidReport_PrivateOffer.feature
#**  Feature Name                 :  Verify Private offer data in Offer Void report
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 587451
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  06/09/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/
Scenario Outline: 001-Enroll Player using WebApp
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Enroll Player" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "MAIN_NAV_BOX.ENROLL_PLAYER"
	Given User selects option "<enrollType>" of element "ENROLL_PLAYER.ENROLL_TYPE_DROPDOWN" by "visibletext"
	Given User selects option "<prefixType>" of element "ENROLL_PLAYER.ID_PREFIX_DROPDOWN" by "visibletext"
	When User generates a "RandomAlphabetic" with "6" for key "player_name"
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
		| 1000         | Standard   | SIR        | A          | AutoLast1 | JR     | 01/01/1988 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID894  |
		| 1000         | Standard   | SIR        | J          | Autolast2 | JR     | 01/01/1987 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID895  |

Scenario:002 -Validate the addition of new dropdown filter with label - 'Private' in Offer Void Report.(TC 587451)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Offer Void Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value             |
		| ReportName | Offer Void Report |
	#Verify Private Filter exist in report
	Then User verifies that element "OLW_OfferVoidReport.lbl_PrivateLabel" is present "true" on UI
	Given User clicks on "OLW_OfferVoidReport.Dropdown_Private" with parameters
		| Key           | Value |
		| PrivateStatus | Yes   |
	Then User verifies that element "OLW_OfferVoidReport.Dropdown_Private" is present "true" on UI with parameters
		| Key           | Value |
		| PrivateStatus | Yes   |
	Given User clicks on "OLW_OfferVoidReport.Dropdown_Private" with parameters
		| Key           | Value |
		| PrivateStatus | No    |
	Then User verifies that element "OLW_OfferVoidReport.Dropdown_Private" is present "true" on UI with parameters
		| Key           | Value |
		| PrivateStatus | No    |
	Given User clicks on "OLW_OfferVoidReport.Dropdown_Private" with parameters
		| Key           | Value |
		| PrivateStatus | All   |
	Then User verifies that element "OLW_OfferVoidReport.Dropdown_Private" is present "true" on UI with parameters
		| Key           | Value |
		| PrivateStatus | All   |
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_OfferVoidReport.lbl_ReportTitle" is present "true" on UI
	#Verify in Summary Header Private column has added
	Then User verifies that element "OLW_OfferVoidReport.tbl_Summary_Column" is present "true" on UI with parameters
		| Key            | Value          |
		| Offer_Property | Offer Property |
		| Offer_Name     | Offer Name     |
		| Player_Count   | Player Count   |
		| Private_Column | Private        |
	#Verify Details Header private column has added
	Then User verifies that element "OLW_OfferVoidReport.tbl_Details_Column" is present "true" on UI with parameters
		| Key            | Value          |
		| Offer_Property | Offer Property |
		| Universal_ID   | Universal ID   |
		| Player_Name    | Player Name    |
		| Offer_Name     | Offer Name     |
		| Offer_Code     | Offer Code     |
		| Segment_Name   | Segment Name   |
		| Campaign_Name  | Campaign Name  |
		| Offer_Type     | Offer Type     |
		| Void_DateTime  | Void Date Time |
		| Voided_By      | Voided By      |
		| Void_Amount    | Void Amount    |
		| Private_Column | Private        |

Scenario:003  - Add Private and Non Private Offer to Player and Void the offer.(TC 587451)
	#Add Private Offer to player
	When User runs query "select P.PropertyName from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID894$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
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
	# Void  Private Offer
	#Add Barcode
	When User generates a "UniqueString" with "4" for key "Bar_Code"
	Given User enters text "Manage Campaign" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value           |
		| SideSubMenu | Manage Campaign |
	When User waits "2" seconds
	Given User enters text "<#CampaignName#>" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Then User verifies that element "ltyCampaign_Manage.tbl_Campaign_List" is present "true" on UI with parameters
		| Key      | Value            |
		| Campaign | <#CampaignName#> |
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value            |
		| Campaign | <#CampaignName#> |
	When User waits "2" seconds
	When User scrolls till element "ltyCampaign_Manage.btn_View_Segment"
	Given User clicks on "ltyCampaign_Manage.btn_View_Segment"
	When User waits "2" seconds
	Then User verifies that element "ltyManage_Segment.lbl_Manage_Segment_PageTitle" is present "true" on UI
	Then User verifies that element "ltyManage_Segment.tbl_Segment _List" is present "true" on UI with parameters
		| Key         | Value           |
		| SegmentName | <#SegmentName#> |
	Given User clicks on "ltyManage_Segment.tbl_Segment _List" with parameters
		| Key         | Value           |
		| SegmentName | <#SegmentName#> |
	Given User clicks on "ltyManage_Segment.btn_View_Players"
	Given User enters text "<$PLAYER_ID894$>" in "ltyManage_Segment.txt_PlayerID_SearchFilter"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_Players_List" is present "true" on UI with parameters
		| Key         | Value            |
		| player_name | <$PLAYER_ID894$> |
	Given User clicks on "ltyManage_Segment.tbl_Segment_Players_List" with parameters
		| Key         | Value            |
		| player_name | <$PLAYER_ID894$> |
	Given User clicks on "ltyManage_Segment.Associated_Offers_DropDown"
	Given User clicks on "ltyManage_Segment.txt_Associated_Offers_Searchbox"
	Given User enters text "<#OfferName#>" in "ltyManage_Segment.txt_Associated_Offers_Searchbox"
	When User pressed key "enter"
	Given User enters text "<$Bar_Code$>" in "ltyManage_Segment.txt_BarCode"
	Given User clicks on "ltyManage_Segment.Save_Button"
	When User waits "2" seconds
	When User "refresh" the browser
	#Update Offer Status From Active to Void
	Given User enters text "Update Offer Status" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value               |
		| SideSubMenu | Update Offer Status |
	Given User selects option "Voided" of element "OLW_UPDATE_OFFER_Sts.Update_Status_DropDown" by "visibletext"
	Given User clicks on "OLW_UPDATE_OFFER_Sts.btn_Start"
	When User waits "4" seconds
	Given User enters text "<$Bar_Code$>" in "OLW_UPDATE_OFFER_Sts.txt_Enter_Barcode"
	When User waits "4" seconds
	When User pressed key "enter"
	When User waits "4" seconds
	Then User verifies that element "OLW_UPDATE_OFFER_Sts.Updated _Status_Message" is present "true" on UI
	#Add Non Private Offer to player
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID895$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
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
	# Void  Non Private Offer
	#Add Barcode
	When User generates a "UniqueString" with "4" for key "Bar_Code2"
	Given User enters text "Manage Campaign" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value           |
		| SideSubMenu | Manage Campaign |
	When User waits "2" seconds
	Given User enters text "<#Reg_CampaignName#>" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Then User verifies that element "ltyCampaign_Manage.tbl_Campaign_List" is present "true" on UI with parameters
		| Key      | Value                |
		| Campaign | <#Reg_CampaignName#> |
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value                |
		| Campaign | <#Reg_CampaignName#> |
	When User waits "2" seconds
	When User scrolls till element "ltyCampaign_Manage.btn_View_Segment"
	Given User clicks on "ltyCampaign_Manage.btn_View_Segment"
	When User waits "2" seconds
	Then User verifies that element "ltyManage_Segment.lbl_Manage_Segment_PageTitle" is present "true" on UI
	Then User verifies that element "ltyManage_Segment.tbl_Segment _List" is present "true" on UI with parameters
		| Key         | Value               |
		| SegmentName | <#Reg_SegmentName#> |
	Given User clicks on "ltyManage_Segment.tbl_Segment _List" with parameters
		| Key         | Value               |
		| SegmentName | <#Reg_SegmentName#> |
	Given User clicks on "ltyManage_Segment.btn_View_Players"
	Given User enters text "<$PLAYER_ID895$>" in "ltyManage_Segment.txt_PlayerID_SearchFilter"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_Players_List" is present "true" on UI with parameters
		| Key         | Value            |
		| player_name | <$PLAYER_ID895$> |
	Given User clicks on "ltyManage_Segment.tbl_Segment_Players_List" with parameters
		| Key         | Value            |
		| player_name | <$PLAYER_ID895$> |
	Given User clicks on "ltyManage_Segment.Associated_Offers_DropDown"
	Given User clicks on "ltyManage_Segment.txt_Associated_Offers_Searchbox"
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "ltyManage_Segment.txt_Associated_Offers_Searchbox"
	When User pressed key "enter"
	Given User enters text "<$Bar_Code2$>" in "ltyManage_Segment.txt_BarCode"
	Given User clicks on "ltyManage_Segment.Save_Button"
	When User waits "2" seconds
	When User "refresh" the browser
	#Update Offer Status From Active to Void
	Given User enters text "Update Offer Status" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value               |
		| SideSubMenu | Update Offer Status |
	Given User selects option "Voided" of element "OLW_UPDATE_OFFER_Sts.Update_Status_DropDown" by "visibletext"
	Given User clicks on "OLW_UPDATE_OFFER_Sts.btn_Start"
	When User waits "4" seconds
	Given User enters text "<$Bar_Code2$>" in "OLW_UPDATE_OFFER_Sts.txt_Enter_Barcode"
	When User waits "4" seconds
	When User pressed key "enter"
	When User waits "4" seconds
	Then User verifies that element "OLW_UPDATE_OFFER_Sts.Updated _Status_Message" is present "true" on UI

Scenario:004  - Validate Summary and details section is displaying Private column with correct values populated in Offer Void Report.((TC 587451)
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID894$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PlayerIntID_94"
	When User runs query "select PlayerID from UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID895$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PlayerIntID_95"
	#Get Current Date
	When User generates a "getDate" with "yyyy-MM-dd hh:mm:ss" for key "currendate"
	#Update Reserved Date Time
	When User performs action "subtractdays" of "1" on dateTime "<$currendate$>" with format "yyyy-MM-dd hh:mm:ss" to save the result for key "VoidDateTime"
	When User executes query "update OFR.UC_PL_Offer set VoidedDate = '<$VoidDateTime$>' where PlayerID ='<$PlayerIntID_94$>'" with connection "<#Halo_db_connectionstring#>"
	When User executes query "update OFR.UC_PL_Offer set VoidedDate = '<$VoidDateTime$>' where PlayerID ='<$PlayerIntID_95$>'" with connection "<#Halo_db_connectionstring#>"
	#Get Offer ID
	When User runs query "select ID from OFR.UC_PL_Offer where PlayerID = '<$PlayerIntID_94$>'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferID_94"
	When User runs query "select ID from OFR.UC_PL_Offer where PlayerID = '<$PlayerIntID_95$>'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferID_95"
	#Get player name for Private Offer
	When User runs query "select lastname from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID894$>'" with connection "<#Halo_db_connectionstring#>" and save with key "Lastname94"
	When User runs query "select FirstName from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID894$>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName94"
	When User saves string operation "append" of provided value "<$Lastname94$>" with ", " to key "Lastnameupdated94"
	When User saves string operation "append" of provided value "<$Lastnameupdated94$>" with " <$FirstName94$>" to key "PlayerName94"
	#Get player name for non Private Offer
	When User runs query "select lastname from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID895$>'" with connection "<#Halo_db_connectionstring#>" and save with key "Lastname95"
	When User runs query "select FirstName from  UC_PL_Player where UniversalPlayerID = '<$PLAYER_ID895$>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName95"
	When User saves string operation "append" of provided value "<$Lastname95$>" with ", " to key "Lastnameupdated95"
	When User saves string operation "append" of provided value "<$Lastnameupdated95$>" with " <$FirstName95$>" to key "PlayerName95"
	#Get Offer Code
		When User runs query "select OfferCode from  OFR.UC_X_OfferMaster where OfferName = '<#OfferName#>'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferCode94"
	When User runs query "select OfferCode from  OFR.UC_X_OfferMaster where OfferName = '<#Reg_FIRST_OFFER_NAME#>'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferCode95"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Offer Void Report" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value             |
		| ReportName | Offer Void Report |
	#Verify Private Filter exist in report
	Given User enters text "<$PLAYER_ID894$>" in "OLW_OfferVoidReport.txt_UniversalID"
	Then User verifies that element "OLW_OfferVoidReport.lbl_PrivateLabel" is present "true" on UI
	Given User clicks on "OLW_OfferVoidReport.Dropdown_Private" with parameters
		| Key           | Value |
		| PrivateStatus | Yes   |
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_OfferVoidReport.lbl_ReportTitle" is present "true" on UI
	#Verify data of Summary and Details
	Then User verifies that element "OLW_OfferVoidReport.tbl_SummaryData" is present "true" on UI with parameters
		| Key           | Value             |
		| Property_Name | <#OfferProperty#> |
		| Offer_Name    | <#OfferName#>     |
		| Player_Count  | 2                 |
		| IsPrivate     | Yes               |
	When User waits "2" seconds
	#Verify Details of Private Offer
	Then User verifies that element "OLW_OfferVoidReport.tbl_Details_Data" is present "true" on UI with parameters
		| Key           | Value             |
		| Property_Name | <#OfferProperty#> |
		| UniversalID   | <$PLAYER_ID894$>  |
		| PlayerName    | <$PlayerName94$>  |
		| Offer_Name    | <#OfferName#>     |
		| Offer_Code    | <$OfferCode94$>     |
		| Segment_Name  | <#SegmentName#>   |
		| Campaign_Name | <#CampaignName#>  |
		| Offer_Type    | <#OfferType#>     |
		| UserID        | <#Halo_username#> |
		| VoidAmount    | $10               |
		| IsPrivate     | Yes               |
	When User waits "2" seconds
	#Verify summary and details for Non Private Offer
	#Switch to another window tab
	When User switches to browser tab "0"
	#Enter Universal ID
	Given User clears "OLW_OfferVoidReport.txt_UniversalID"
	Given User enters text "<$PLAYER_ID895$>" in "OLW_OfferVoidReport.txt_UniversalID"
	#Select Private Yes
	Given User clicks on "OLW_OfferVoidReport.Dropdown_Private" with parameters
		| Key           | Value |
		| PrivateStatus | No    |
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_OfferVoidReport.lbl_ReportTitle" is present "true" on UI
	Then User verifies that element "OLW_OfferVoidReport.tbl_SummaryData" is present "true" on UI with parameters
		| Key           | Value                    |
		| Property_Name | <#OfferProperty#>        |
		| Offer_Name    | <#Reg_FIRST_OFFER_NAME#> |
		| Player_Count  | 2                        |
		| IsPrivate     | No                       |
	When User waits "2" seconds
	#Verify Details of Private Offer
	Then User verifies that element "OLW_OfferVoidReport.tbl_Details_Data" is present "true" on UI with parameters
		| Key           | Value                    |
		| Property_Name | <#OfferProperty#>        |
		| UniversalID   | <$PLAYER_ID895$>         |
		| PlayerName    | <$PlayerName95$>         |
		| Offer_Name    | <#Reg_FIRST_OFFER_NAME#> |
		| Offer_Code    | <$OfferCode95$>          |
		| Segment_Name  | <#Reg_SegmentName#>      |
		| Campaign_Name | <#Reg_CampaignName#>     |
		| Offer_Type    | <#Reg_Offer_Type#>       |
		| UserID        | <#Halo_username#>        |
		| VoidAmount    | $30                      |
		| IsPrivate     | No                       |