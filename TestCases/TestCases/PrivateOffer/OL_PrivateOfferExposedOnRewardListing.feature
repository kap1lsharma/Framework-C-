@Sequential@Release_15.0@Group_PrivateOffer@Web
Feature: OL_PrivateOfferExposedOnRewardListing

#******************************************************************************
#**  Feature File                 : OL_BonusingOffer_WebApp.feature
#**  Feature Name                 : Create and Update Bonusing offer from webapp
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 586179
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  07/04/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/
#
#/*************************************************************************
Scenario Outline: 001-Enroll Player using WebApp
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
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

	Examples:
		| BucketAmount | enrollType | prefixType | middleName | lastName  | suffix | bday       | gender | idType        | id          | expireDate | country | state   | country2 | state2  | nationality | addressType | addressLine          | city    | zip    | zipFour | fromDate   | toDate     | addressType2 | city2   | zip2   | zipFour2 | fromDate2  | toDate2    | teleType | teleNo     | teleStatus | emailType | email   | emailStatus | socialType | socialAccount  | smsType  | pin  | Permission | sms       | PLAYER_ID          | ssn       | PLAYER_ID_Key |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID042  |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID043  |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID044  |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID045  |

Scenario Outline:002- Verify that Private Offers having status as Partially redeem is exposed to Reward Listing/One Link.( TC 591052)
	#Assign offer to Player and Redeem
	
	When User runs query "select P.PropertyName from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "<$PLAYER_ID042$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "2" seconds
	Given User enters text "<#OfferName#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	Then User verifies that element "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" is present "true" on UI with parameters
		| Key       | Value                  |
		| OfferName | <#OfferName#>          |
		| OfferType | <#OfferType#>          |
		| StartDate | <#ValidFromDate#>             |
		| EndDate   | <#ValidToDate#>               |
		| Amount    | <#PrivateOfferAmount#> |
		| Property  | <$PropertyName$>       |
		| IsPrivate | Y                      |
	Given User clicks on "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" with parameters
		| Key       | Value                  |
		| OfferName | <#OfferName#>          |
		| OfferType | <#OfferType#>          |
		| StartDate | <#ValidFromDate#>             |
		| EndDate   | <#ValidToDate#>               |
		| Amount    | <#PrivateOfferAmount#> |
		| Property  | <$PropertyName$>       |
		| IsPrivate | Y                      |
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
	Given User enters text "<#OfferName#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	Then User verifies that element "OLW_PLAYER_OFFER.lnkassignedprivateoffer" is present "true" on UI with parameters
		| Key       | Value                  |
		| OfferName | <#OfferName#>          |
		| OfferType | <#OfferType#>          |
		| Status    | <Active_Status>        |
		| StartDate | <#ValidFromDate#>             |
		| EndDate   | <#ValidToDate#>               |
		| Amount    | <#PrivateOfferAmount#> |
		| Property  | <$PropertyName$>       |
		| IsPrivate | Y                      |
	Given User clicks on "OLW_PLAYER_OFFER.lnkassignedprivateoffer" with parameters
		| Key       | Value                  |
		| OfferName | <#OfferName#>          |
		| OfferType | <#OfferType#>          |
		| Status    | <Active_Status>        |
		| StartDate | <#ValidFromDate#>             |
		| EndDate   | <#ValidToDate#>               |
		| Amount    | <#PrivateOfferAmount#> |
		| Property  | <$PropertyName$>       |
		| IsPrivate | Y                      |
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
		| Key            | Value                 |
		| OfferName      | <#OfferName#>         |
		| OfferType      | <#OfferType#>         |
		| OfferStatus    | <Active_Status>       |
		| OfferStartDate | <#ValidFromDate#>            |
		| OfferEndDate   | <#ValidToDate#>              |
		| Amount         | <Partial_OfferAmount> |
		| Property       | <$PropertyName$>      |
	Given User clicks on "OLW_PLAYER_OFFER.tbl_Offer_Added" with parameters
		| Key            | Value                 |
		| OfferName      | <#OfferName#>         |
		| OfferType      | <#OfferType#>         |
		| OfferStatus    | <Active_Status>       |
		| OfferStartDate | <#ValidFromDate#>            |
		| OfferEndDate   | <#ValidToDate#>              |
		| Amount         | <Partial_OfferAmount> |
		| Property       | <$PropertyName$>      |
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
	#Verify on Reward listing Partial redeemed Amount should be displayed
	When User runs query "select P.CorpProp from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "CorpProp"
	When User generates a "getDate" with "yyyy-MM-dd'T'hh:mm:ss" for key "currenttimewithHour"
	When User generates a "getDate" with "yyyy-MM-dd" for key "currenttime"
	When User performs action "adddays" of "3" on dateTime "<$currenttimewithHour$>" with format "yyyy-MM-dd'T'hh:mm:ss" to save the result for key "GameDate"
	When User runs query "select Top(1) HC.HostEndPoint from UC_X_Property P, UC_X_Host H, UC_X_HostConnect HC where P.PropertyID = H.PropertyID and H.HostID = HC.HostID and P.CorpProp = '<$CorpProp$>' and HC.HostConnectDirection = 'O'" with connection "<#Halo_db_connectionstring#>" and save with key "FromSystem"
	When User runs query "select HC.HostEndPoint from UC_X_Host H, UC_X_HostConnect HC where H.HostID = HC.HostID and H.IsUniverse = 1 and HC.HostConnectDirection = 'I'" with connection "<#Halo_db_connectionstring#>" and save with key "ToSystem"
	Given User creates soap request to "<$ToSystem$>" with action "http://www.gamingstandards.com:8080/S2SWebsite/services/SlotSystemHost" using format "S2S" and request template "Reward_Listing"
		| IsTAg | ParentNodeName | ReplacementKey | ReplacementValue | Query |
		| false | s2sHeader      | fromSystem     | ^$FromSystem$^   |       |
		| false | s2sHeader      | toSystem       | ^$ToSystem$^     |       |
		| false | s2sHeader      | dateTimeSent   | ^$GameDate$^     |       |
		| false | offerInfo      | propertyId     | <$CorpProp$>     |       |
		| false | offerInfo      | gameDate       | ^$GameDate$^     |       |
		| false | offerInfo      | dateTime       | ^$GameDate$^     |       |
		| true  | getOfferTrans  | transType      | MKTOFFERS        |       |
		| true  | getOfferTrans  | patronId       | <$PLAYER_ID042$> |       |
		| true  | getOfferTrans  | propertyId     | <$CorpProp$>     |       |
		| true  | getOfferTrans  | transStatus    | Active           |       |
	Given User "Verifies" soap request response using format "S2S"
		| IsTag | NodeName | Attribute    | ExpectedValue   | Query |
		| false | s2sMessage      | issuedAmount | <expectedValue> |       |
	Given User "Verifies" soap request response using format "S2S"
		| IsTag | NodeName | Attribute   | ExpectedValue   | Query |
		| false | s2sMessage      | offerAmount | <expectedValue> |       |
	When User waits "10" seconds

	Examples:
		| Remaining_Amount | Redeemed_Status | Active_Status | Partial_OfferAmount | Partial_RedeemedAmount | FromDate   | ToDate     | expectedValue |
		| $0.00            | Redeemed        | Active        | $6.00               | $4.00                  | 12/12/2021 | 12/31/2098 |             |

Scenario Outline:003- Verify that Private Offers having status as Active is exposed to Reward Listing/One Link.( TC 591052)
	#Assign offer to Player and Redeem
	
	When User runs query "select P.PropertyName from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "<$PLAYER_ID043$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "2" seconds
	Given User enters text "<#OfferName#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	Then User verifies that element "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" is present "true" on UI with parameters
		| Key       | Value                  |
		| OfferName | <#OfferName#>          |
		| OfferType | <#OfferType#>          |
		| StartDate | <#ValidFromDate#>             |
		| EndDate   | <#ValidToDate#>               |
		| Amount    | <#PrivateOfferAmount#> |
		| Property  | <$PropertyName$>       |
		| IsPrivate | Y                      |
	Given User clicks on "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" with parameters
		| Key       | Value                  |
		| OfferName | <#OfferName#>          |
		| OfferType | <#OfferType#>          |
		| StartDate | <#ValidFromDate#>             |
		| EndDate   | <#ValidToDate#>               |
		| Amount    | <#PrivateOfferAmount#> |
		| Property  | <$PropertyName$>       |
		| IsPrivate | Y                      |
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
	#Redeem the Offer
	When User waits "4" seconds
	Given User enters text "<#OfferName#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "4" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.lnkassignedprivateoffer" is present "true" on UI with parameters
		| Key       | Value                  |
		| OfferName | <#OfferName#>          |
		| OfferType | <#OfferType#>          |
		| Status    | <Active_Status>        |
		| StartDate | <#ValidFromDate#>             |
		| EndDate   | <#ValidToDate#>               |
		| Amount    | <#PrivateOfferAmount#> |
		| Property  | <$PropertyName$>       |
		| IsPrivate | Y                      |
	Given User clicks on "OLW_PLAYER_OFFER.lnkassignedprivateoffer" with parameters
		| Key       | Value                  |
		| OfferName | <#OfferName#>          |
		| OfferType | <#OfferType#>          |
		| Status    | <Active_Status>        |
		| StartDate | <#ValidFromDate#>             |
		| EndDate   | <#ValidToDate#>               |
		| Amount    | <#PrivateOfferAmount#> |
		| Property  | <$PropertyName$>       |
		| IsPrivate | Y                      |
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
	#Verify on Reward listing Partial redeemed Amount should be displayed
	When User runs query "select P.CorpProp from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "CorpProp"
	When User generates a "getDate" with "yyyy-MM-dd'T'hh:mm:ss" for key "currenttimewithHour"
	When User generates a "getDate" with "yyyy-MM-dd" for key "currenttime"
	When User performs action "adddays" of "3" on dateTime "<$currenttimewithHour$>" with format "yyyy-MM-dd'T'hh:mm:ss" to save the result for key "GameDate"
	When User runs query "select Top(1) HC.HostEndPoint from UC_X_Property P, UC_X_Host H, UC_X_HostConnect HC where P.PropertyID = H.PropertyID and H.HostID = HC.HostID and P.CorpProp = '<$CorpProp$>' and HC.HostConnectDirection = 'O'" with connection "<#Halo_db_connectionstring#>" and save with key "FromSystem"
	When User runs query "select HC.HostEndPoint from UC_X_Host H, UC_X_HostConnect HC where H.HostID = HC.HostID and H.IsUniverse = 1 and HC.HostConnectDirection = 'I'" with connection "<#Halo_db_connectionstring#>" and save with key "ToSystem"
	Given User creates soap request to "<$ToSystem$>" with action "http://www.gamingstandards.com:8080/S2SWebsite/services/SlotSystemHost" using format "S2S" and request template "Reward_Listing"
		| IsTAg | ParentNodeName | ReplacementKey | ReplacementValue | Query |
		| false | s2sHeader      | fromSystem     | ^$FromSystem$^   |       |
		| false | s2sHeader      | toSystem       | ^$ToSystem$^     |       |
		| false | s2sHeader      | dateTimeSent   | ^$GameDate$^     |       |
		| false | offerInfo      | propertyId     | <$CorpProp$>     |       |
		| false | offerInfo      | gameDate       | ^$GameDate$^     |       |
		| false | offerInfo      | dateTime       | ^$GameDate$^     |       |
		| true  | getOfferTrans  | transType      | MKTOFFERS        |       |
		| true  | getOfferTrans  | patronId       | <$PLAYER_ID043$> |       |
		| true  | getOfferTrans  | propertyId     | <$CorpProp$>     |       |
		| true  | getOfferTrans  | transStatus    | Active           |       |
	Given User "Verifies" soap request response using format "S2S"
		| IsTag | NodeName   | Attribute    | ExpectedValue   | Query |
		| false | s2sMessage | issuedAmount | <expectedValue> |       |
	Given User "Verifies" soap request response using format "S2S"
		| IsTag | NodeName   | Attribute   | ExpectedValue   | Query |
		| false | s2sMessage | offerAmount | <expectedValue> |       |
	When User waits "10" seconds

	Examples:
		| Remaining_Amount | Redeemed_Status | Active_Status | FromDate   | ToDate     | expectedValue |
		| $0.00            | Redeemed        | Active        | 12/12/2021 | 12/31/2098 |               |

Scenario Outline:004-Verify that Non Private Awards having status as Active  is exposed to Reward Listing
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	#Assign Offer To Player
	Given User enters text "<$PLAYER_ID044$>" in "lylPlayer_Search.PlayerSearch_TextBox"
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
	#Verify Offer has been added to player
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
	#Verify on Reward listing Partial redeemed Amount should be displayed
	When User runs query "select P.CorpProp from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "CorpProp"
	When User generates a "getDate" with "yyyy-MM-dd'T'hh:mm:ss" for key "currenttimewithHour"
	When User generates a "getDate" with "yyyy-MM-dd" for key "currenttime"
	When User performs action "adddays" of "3" on dateTime "<$currenttimewithHour$>" with format "yyyy-MM-dd'T'hh:mm:ss" to save the result for key "GameDate"
	When User runs query "select Top(1) HC.HostEndPoint from UC_X_Property P, UC_X_Host H, UC_X_HostConnect HC where P.PropertyID = H.PropertyID and H.HostID = HC.HostID and P.CorpProp = '<$CorpProp$>' and HC.HostConnectDirection = 'O'" with connection "<#Halo_db_connectionstring#>" and save with key "FromSystem"
	When User runs query "select HC.HostEndPoint from UC_X_Host H, UC_X_HostConnect HC where H.HostID = HC.HostID and H.IsUniverse = 1 and HC.HostConnectDirection = 'I'" with connection "<#Halo_db_connectionstring#>" and save with key "ToSystem"
	Given User creates soap request to "<$ToSystem$>" with action "http://www.gamingstandards.com:8080/S2SWebsite/services/SlotSystemHost" using format "S2S" and request template "Reward_Listing"
		| IsTAg | ParentNodeName | ReplacementKey | ReplacementValue | Query |
		| false | s2sHeader      | fromSystem     | ^$FromSystem$^   |       |
		| false | s2sHeader      | toSystem       | ^$ToSystem$^     |       |
		| false | s2sHeader      | dateTimeSent   | ^$GameDate$^     |       |
		| false | offerInfo      | propertyId     | <$CorpProp$>     |       |
		| false | offerInfo      | gameDate       | ^$GameDate$^     |       |
		| false | offerInfo      | dateTime       | ^$GameDate$^     |       |
		| true  | getOfferTrans  | transType      | MKTOFFERS        |       |
		| true  | getOfferTrans  | patronId       | <$PLAYER_ID044$> |       |
		| true  | getOfferTrans  | propertyId     | <$CorpProp$>     |       |
		| true  | getOfferTrans  | transStatus    | Active           |       |
	Given User "Verifies" soap request response using format "S2S"
		| IsTag | NodeName   | Attribute    | ExpectedValue   | Query |
		| false | s2sMessage | issuedAmount | <expectedValue> |       |
	Given User "Verifies" soap request response using format "S2S"
		| IsTag | NodeName   | Attribute   | ExpectedValue   | Query |
		| false | s2sMessage | offerAmount | <expectedValue> |       |
	When User waits "10" seconds

	Examples:
		| Remaining_Amount | Redeemed_Status | Active_Status | Redeemed_Amount | Total_OfferAmount | expectedValue |
		| $0.00            | Redeemed        | Active        | $30.00          | $30.00            |               |

Scenario Outline:005-Verify that Non Private Awards having status as Partially Redeem is exposed to Reward Listing.(TC 591052)
	When User runs query "select P.PropertyName from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	#Assign Offer To Player
	Given User enters text "<$PLAYER_ID045$>" in "lylPlayer_Search.PlayerSearch_TextBox"
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
	#Redeem Offer Partially
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
	#Verify on Reward listing Partial redeemed Amount should be displayed
	When User runs query "select P.CorpProp from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "CorpProp"
	When User generates a "getDate" with "yyyy-MM-dd'T'hh:mm:ss" for key "currenttimewithHour"
	When User generates a "getDate" with "yyyy-MM-dd" for key "currenttime"
	When User performs action "adddays" of "3" on dateTime "<$currenttimewithHour$>" with format "yyyy-MM-dd'T'hh:mm:ss" to save the result for key "GameDate"
	When User runs query "select Top(1) HC.HostEndPoint from UC_X_Property P, UC_X_Host H, UC_X_HostConnect HC where P.PropertyID = H.PropertyID and H.HostID = HC.HostID and P.CorpProp = '<$CorpProp$>' and HC.HostConnectDirection = 'O'" with connection "<#Halo_db_connectionstring#>" and save with key "FromSystem"
	When User runs query "select HC.HostEndPoint from UC_X_Host H, UC_X_HostConnect HC where H.HostID = HC.HostID and H.IsUniverse = 1 and HC.HostConnectDirection = 'I'" with connection "<#Halo_db_connectionstring#>" and save with key "ToSystem"
	Given User creates soap request to "<$ToSystem$>" with action "http://www.gamingstandards.com:8080/S2SWebsite/services/SlotSystemHost" using format "S2S" and request template "Reward_Listing"
		| IsTAg | ParentNodeName | ReplacementKey | ReplacementValue | Query |
		| false | s2sHeader      | fromSystem     | ^$FromSystem$^   |       |
		| false | s2sHeader      | toSystem       | ^$ToSystem$^     |       |
		| false | s2sHeader      | dateTimeSent   | ^$GameDate$^     |       |
		| false | offerInfo      | propertyId     | <$CorpProp$>     |       |
		| false | offerInfo      | gameDate       | ^$GameDate$^     |       |
		| false | offerInfo      | dateTime       | ^$GameDate$^     |       |
		| true  | getOfferTrans  | transType      | MKTOFFERS        |       |
		| true  | getOfferTrans  | patronId       | <$PLAYER_ID045$> |       |
		| true  | getOfferTrans  | propertyId     | <$CorpProp$>     |       |
		| true  | getOfferTrans  | transStatus    | Active           |       |
	Given User "Verifies" soap request response using format "S2S"
		| IsTag | NodeName   | Attribute    | ExpectedValue   | Query |
		| false | s2sMessage | issuedAmount | <expectedValue> |       |
	Given User "Verifies" soap request response using format "S2S"
		| IsTag | NodeName   | Attribute   | ExpectedValue   | Query |
		| false | s2sMessage | offerAmount | <expectedValue> |       |
	When User waits "10" seconds

	Examples:
		| Remaining_Amount | Redeemed_Status | Active_Status | Redeemed_Amount | Total_OfferAmount | expectedValue | Partial_OfferAmount | Partial_RedeemedAmount |
		| $0.00            | Redeemed        | Active        | $30.00          | $30.00            |               | $26.00              | $4.00                  |