@Sequential@Release_15.0@Offers@sanity@Web
Feature: Promo and NonPromo Offers_via WebApp

#**  Feature File                 : Promo and NonPromo Offers_via WebApp.feature
#**  Feature Name                 : Create/Assign/Redeem/Void NonPromo and Promo Offer
#**  Defect/Bug Linked(if any)    :
#**  TFS TC ID Linked             : 588021,589922,589926,589219
#********************************************************************************/
#    Date:      Author:           Comments
#**  --------   --------------    --------------
#**  04/20/2022   Pooja Kashyap      Initial Version
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
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID77   |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID78   |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID79   |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID80   |

Scenario Outline: 002- Verify User is able to Assign Non Promo Offer to Player's Account and Redeem the same. (TC 588021)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	#Assign Offer To Player
	Given User enters text "<$PLAYER_ID77$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "4" seconds
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	When User waits "4" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_Unassigned_Offers" is present "true" on UI with parameters
		| Key       | Value                    |
		| OfferName | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType | <#Reg_Offer_Type#>       |
		| StartDate | <#ValidFromDate#>        |
		| EndDate   | <#ValidToDate#>          |
		| Amount    | <Total_OfferAmount>      |
		| Property  | <$PropertyName$>         |
	Given User clicks on "OLW_PLAYER_OFFER.tbl_Unassigned_Offers" with parameters
		| Key       | Value                    |
		| OfferName | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType | <#Reg_Offer_Type#>       |
		| StartDate | <#ValidFromDate#>        |
		| EndDate   | <#ValidToDate#>          |
		| Amount    | <Total_OfferAmount>      |
		| Property  | <$PropertyName$>         |
	When User waits "6" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"
	When User waits "6" seconds
	# fill the Authorization
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Guest Satisfaction" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "6" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	Given User clicks on "OLW_PLAYER_OFFER.btn_CancelAndReturn_PlayerOffer"
	#Redeem Offer
	When User waits "4" seconds
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "4" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_Offer_Added" is present "true" on UI with parameters
		| Key            | Value                    |
		| OfferName      | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType      | <#Reg_Offer_Type#>       |
		| OfferStatus    | <Active_Status>          |
		| OfferStartDate | <#ValidFromDate#>        |
		| OfferEndDate   | <#ValidToDate#>          |
		| Amount         | <Total_OfferAmount>      |
		| Property       | <$PropertyName$>         |
	Given User clicks on "OLW_PLAYER_OFFER.tbl_Offer_Added" with parameters
		| Key            | Value                    |
		| OfferName      | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType      | <#Reg_Offer_Type#>       |
		| OfferStatus    | <Active_Status>          |
		| OfferStartDate | <#ValidFromDate#>        |
		| OfferEndDate   | <#ValidToDate#>          |
		| Amount         | <Total_OfferAmount>      |
		| Property       | <$PropertyName$>         |
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
	# Check Offers got redeemed and status got changed from Active to Redeemed.
	Given User clicks on "OLW_PLAYER_OFFER.chk_Redeemed"
	When User waits "4" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_Redeemed_Offer" is present "true" on UI with parameters
		| Key                 | Value                    |
		| OfferName           | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType           | <#Reg_Offer_Type#>       |
		| OfferRedeemedStatus | <Redeemed_Status>        |
		| RemainingAmount     | <Remaining_Amount>       |
		| Property            | <$PropertyName$>         |
	Given User clicks on "OLW_PLAYER_OFFER.tbl_Redeemed_Offer" with parameters
		| Key                 | Value                    |
		| OfferName           | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType           | <#Reg_Offer_Type#>       |
		| OfferRedeemedStatus | <Redeemed_Status>        |
		| RemainingAmount     | <Remaining_Amount>       |
		| Property            | <$PropertyName$>         |
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.Redeemed_Offer_Expand_Arrow"
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_Redeemed_Offer_Data" is present "true" on UI with parameters
		| Key            | Value             |
		| RedeemedAmount | <Redeemed_Amount> |
		| Property       | <$PropertyName$>  |
		| VoidStatus     | N                 |

	Examples:
		| Remaining_Amount | Redeemed_Status | Active_Status | Redeemed_Amount | Total_OfferAmount |
		| $0.00            | Redeemed        | Active        | $30.00          | $30.00            |

Scenario Outline: 003- Verify user is able to Void the assigned offer.(TC 589922)
	#Assign Offer to player
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "4" for key "Bar_Code"
	Given User enters text "<$PLAYER_ID78$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "4" seconds
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	When User waits "4" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_Unassigned_Offers" is present "true" on UI with parameters
		| Key       | Value                    |
		| OfferName | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType | <#Reg_Offer_Type#>       |
		| StartDate | <#ValidFromDate#>        |
		| EndDate   | <#ValidToDate#>          |
		| Amount    | <Total_OfferAmount>      |
		| Property  | <$PropertyName$>         |
	Given User clicks on "OLW_PLAYER_OFFER.tbl_Unassigned_Offers" with parameters
		| Key       | Value                    |
		| OfferName | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType | <#Reg_Offer_Type#>       |
		| StartDate | <#ValidFromDate#>        |
		| EndDate   | <#ValidToDate#>          |
		| Amount    | <Total_OfferAmount>      |
		| Property  | <$PropertyName$>         |
	When User waits "6" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"
	When User waits "6" seconds
	# fill the Authorization
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Guest Satisfaction" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "6" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	Given User clicks on "OLW_PLAYER_OFFER.btn_CancelAndReturn_PlayerOffer"
	#Add Barcode
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
	Given User enters text "<$PLAYER_ID78$>" in "ltyManage_Segment.txt_PlayerID_SearchFilter"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_Players_List" is present "true" on UI with parameters
		| Key         | Value           |
		| player_name | <$PLAYER_ID78$> |
	Given User clicks on "ltyManage_Segment.tbl_Segment_Players_List" with parameters
		| Key         | Value           |
		| player_name | <$PLAYER_ID78$> |
	Given User clicks on "ltyManage_Segment.Associated_Offers_DropDown"
	Given User clicks on "ltyManage_Segment.txt_Associated_Offers_Searchbox"
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "ltyManage_Segment.txt_Associated_Offers_Searchbox"
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

	Examples:
		| Remaining_Amount | Redeemed_Status | Active_Status | Redeemed_Amount | Total_OfferAmount |
		| $0.00            | Redeemed        | Active        | $30.00          | $30.00            |

Scenario Outline: 004-Verify user is able to do Partial Redemption.(TC 589926)
	#Assign Offer
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "<$PLAYER_ID79$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "4" seconds
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	When User waits "4" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_Unassigned_Offers" is present "true" on UI with parameters
		| Key       | Value                    |
		| OfferName | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType | <#Reg_Offer_Type#>       |
		| StartDate | <#ValidFromDate#>        |
		| EndDate   | <#ValidToDate#>          |
		| Amount    | <Total_OfferAmount>      |
		| Property  | <$PropertyName$>         |
	Given User clicks on "OLW_PLAYER_OFFER.tbl_Unassigned_Offers" with parameters
		| Key       | Value                    |
		| OfferName | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType | <#Reg_Offer_Type#>       |
		| StartDate | <#ValidFromDate#>        |
		| EndDate   | <#ValidToDate#>          |
		| Amount    | <Total_OfferAmount>      |
		| Property  | <$PropertyName$>         |
	When User waits "6" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"
	When User waits "6" seconds
	# fill the  Authorization
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Guest Satisfaction" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "6" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	Given User clicks on "OLW_PLAYER_OFFER.btn_CancelAndReturn_PlayerOffer"
	#Redeem the Offer Partially
	When User waits "4" seconds
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "4" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_Offer_Added" is present "true" on UI with parameters
		| Key            | Value                    |
		| OfferName      | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType      | <#Reg_Offer_Type#>       |
		| OfferStatus    | <Active_Status>          |
		| OfferStartDate | <#ValidFromDate#>        |
		| OfferEndDate   | <#ValidToDate#>          |
		| Amount         | <Total_OfferAmount>      |
		| Property       | <$PropertyName$>         |
	Given User clicks on "OLW_PLAYER_OFFER.tbl_Offer_Added" with parameters
		| Key            | Value                    |
		| OfferName      | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType      | <#Reg_Offer_Type#>       |
		| OfferStatus    | <Active_Status>          |
		| OfferStartDate | <#ValidFromDate#>        |
		| OfferEndDate   | <#ValidToDate#>          |
		| Amount         | <Total_OfferAmount>      |
		| Property       | <$PropertyName$>         |
	When User waits "3" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Redeem_Offer"
	When User waits "2" seconds
	Given User switches to frame "default"
	Given User switches to frame "OLW_PLAYER_OFFER.frm_Redeem_Offer_Popup"
	When User waits "4" seconds
	Given User clears "OLW_PLAYER_OFFER.txt_Amount_To_Redeem"
	Given User enters text "4" in "OLW_PLAYER_OFFER.txt_Amount_To_Redeem"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Popup_Redeem_Offer"
	When User waits "4" seconds
	Given User switches to frame "default"
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_Offer_Added" is present "true" on UI with parameters
		| Key            | Value                    |
		| OfferName      | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType      | <#Reg_Offer_Type#>       |
		| OfferStatus    | <Active_Status>          |
		| OfferStartDate | <#ValidFromDate#>        |
		| OfferEndDate   | <#ValidToDate#>          |
		| Amount         | <Partial_OfferAmount>    |
		| Property       | <$PropertyName$>         |
	Given User clicks on "OLW_PLAYER_OFFER.tbl_Offer_Added" with parameters
		| Key            | Value                    |
		| OfferName      | <#Reg_FIRST_OFFER_NAME#> |
		| OfferType      | <#Reg_Offer_Type#>       |
		| OfferStatus    | <Active_Status>          |
		| OfferStartDate | <#ValidFromDate#>        |
		| OfferEndDate   | <#ValidToDate#>          |
		| Amount         | <Partial_OfferAmount>    |
		| Property       | <$PropertyName$>         |
	#Expand the Partial Redeemed Offer and verify the Redeemed Amount
	Given User clicks on "OLW_PLAYER_OFFER.Added_Offer_Expand_Arrow"
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_Expand_Partially_Redeemed" is present "true" on UI with parameters
		| Key                       | Value                    |
		| Partially_Redeemed_Amount | <Partial_RedeemedAmount> |
		| Property                  | <$PropertyName$>         |
	Given User clicks on "OLW_PLAYER_OFFER.tbl_Expand_Partially_Redeemed" with parameters
		| Key                       | Value                    |
		| Partially_Redeemed_Amount | <Partial_RedeemedAmount> |
		| Property                  | <$PropertyName$>         |
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.chk_Active"
	Given User clicks on "OLW_PLAYER_OFFER.chk_Redeemed"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_No_Offer_Exist" is present "true" on UI

	Examples:
		| Remaining_Amount | Redeemed_Status | Active_Status | Redeemed_Amount | Total_OfferAmount | Partial_OfferAmount | Partial_RedeemedAmount |
		| $0.00            | Redeemed        | Active        | $30.00          | $30.00            | $26.00              | $4.00                  |

Scenario Outline: 005- Verify User is able to Assign Promo Offer to Player's Account  and also Redeem and Reserve Button is disabled for Promo Offers. (TC 589219)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "<$PLAYER_ID80$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	#Assign Offer to player
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "4" seconds
	Given User enters text "<#PromoOffer#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	When User waits "4" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_Unassigned_Offers" is present "true" on UI with parameters
		| Key       | Value               |
		| OfferName | <#PromoOffer#>      |
		| OfferType | <Offer_Type>        |
		| StartDate | <#ValidFromDate#>   |
		| EndDate   | <#ValidToDate#>     |
		| Amount    | <Total_OfferAmount> |
		| Property  | <$PropertyName$>    |
	Given User clicks on "OLW_PLAYER_OFFER.tbl_Unassigned_Offers" with parameters
		| Key       | Value               |
		| OfferName | <#PromoOffer#>      |
		| OfferType | <Offer_Type>        |
		| StartDate | <#ValidFromDate#>   |
		| EndDate   | <#ValidToDate#>     |
		| Amount    | <Total_OfferAmount> |
		| Property  | <$PropertyName$>    |
	When User waits "6" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"
	When User waits "6" seconds
	# fill the  Authorization
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Guest Satisfaction" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "6" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	Given User clicks on "OLW_PLAYER_OFFER.btn_CancelAndReturn_PlayerOffer"
	#Verify Promo Offer has been added
	When User waits "4" seconds
	Given User enters text "<#PromoOffer#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "4" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.tbl_Offer_Added" is present "true" on UI with parameters
		| Key            | Value               |
		| OfferName      | <#PromoOffer#>      |
		| OfferType      | <Offer_Type>        |
		| OfferStatus    | <Active_Status>     |
		| OfferStartDate | <#ValidFromDate#>   |
		| OfferEndDate   | <#ValidToDate#>     |
		| Amount         | <Total_OfferAmount> |
		| Property       | <$PropertyName$>    |
	Given User clicks on "OLW_PLAYER_OFFER.tbl_Offer_Added" with parameters
		| Key            | Value               |
		| OfferName      | <#PromoOffer#>      |
		| OfferType      | <Offer_Type>        |
		| OfferStatus    | <Active_Status>     |
		| OfferStartDate | <#ValidFromDate#>   |
		| OfferEndDate   | <#ValidToDate#>     |
		| Amount         | <Total_OfferAmount> |
		| Property       | <$PropertyName$>    |
	When User waits "3" seconds
	#Verify Redeemed and Reserve Buttons are disabled
	Then User verifies attribute "disabled" value "true" of element "OLW_PLAYER_OFFER.btn_Reserve_Offer"
	Then User verifies attribute "disabled" value "true" of element "OLW_PLAYER_OFFER.btn_Redeem_Offer"

	Examples:
		| Active_Status | Total_OfferAmount | Offer_Type |
		| Active        | $30.00            | Promo      |