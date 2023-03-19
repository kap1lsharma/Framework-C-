@Sequential@Release_15.0@Offers@Web
Feature: Infogenesis_RedeemOffer

#******************************************************************************
#**  Feature File                 : OL_Infogenesis_RedeemOffer
#**  Feature Name                 : Redeem and enquire offer via Infogensis
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 244905
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  07/25/2022     Pooja Kashyap            Initial Draft
#********************************************************************************/

#Create a player
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
		| BucketAmount | enrollType | prefixType | middleName | lastName | suffix | bday       | gender | idType        | id          | expireDate | country | state   | country2 | state2  | nationality | addressType | addressLine          | city    | zip    | zipFour | fromDate   | toDate     | addressType2 | city2   | zip2   | zipFour2 | fromDate2  | toDate2    | teleType | teleNo     | teleStatus | emailType | email   | emailStatus | socialType | socialAccount  | smsType  | pin  | Permission | sms       | PLAYER_ID          | ssn       | PLAYER_ID_Key |
		| 1000         | Standard   | SIR        | Test1      | infog1   | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID301  |
		| 1000         | Standard   | SIR        | Test1      | infog2  | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID302  |
		| 1000         | Standard   | SIR        | Test1      | infog2  | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID303  |

Scenario Outline: 002- Assign Offer to Player(TC 244905)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	#Assign Offer To Player
	Given User enters text "<$PLAYER_ID301$>" in "lylPlayer_Search.PlayerSearch_TextBox"
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

	Examples:
		| Remaining_Amount | Redeemed_Status | Active_Status | Redeemed_Amount | Total_OfferAmount |
		| $0.00            | Redeemed        | Active        | $30.00          | $30.00            |

Scenario Outline: 003  Inquiry and Redeem offer through Infogenesis(TC 244905)
	#Enquiry Offer through Infogenisis
	When User runs query "Select  ConfigValue1 from  HO_x_config where ConfigCode = 'InFOGENESIS_HOSTING_URL'" with connection "<#Open.db.connectionstring#>" and save with key "InfogenesisServiceURL"
	When User runs query "Select  ConfigValue1 from  HO_x_config where ConfigCode = 'InfogenesisRequestorId'" with connection "<#Open.db.connectionstring#>" and save with key "ProfileCenterID"
	Given User creates soap request to "<$InfogenesisServiceURL$>" with action "PMSI/AccountLookupVer1" using format "" and request template "Info_Lookup"
		| IsTAg | ParentNodeName | ReplacementKey  | ReplacementValue    | Query |
		| true  | Request        | ProfitCenterId  | <$ProfileCenterID$> |       |
		| true  | Request        | PaymentMethodId | <PaymentMethodID>   |       |
		| true  | Request        | InputData       | <$PLAYER_ID301$>    |       |
	When User waits "3" seconds
	Given User "saves" soap request response using format ""
		| IsTag | NodeName      | Attribute      | ExpectedValue    | Query |
		| true  | Response      | ErrorCode      | ErrorCode        |       |
		| true  | AccountDetail | AuthAccountNum | PlayerIdwithCode |       |
		| true  | AccountDetail | Name           | xmlofferName     |       |
		| true  | AccountDetail | BalanceAmount  | XmlAmount        |       |
	When User performs arithmetic operation "numberEquals" of provided value "<$ErrorCode$>" with "0"
	When User performs string operation "stringEquals" of provided value "<$xmlofferName$>" with "<#Reg_FIRST_OFFER_NAME#> "
	When User performs string operation "stringEquals" of provided value "<$XmlAmount$>" with "3000"
	#Redeem Offer
	#Reedem Offer  Through Infogenisis
	Given User creates soap request to "<$InfogenesisServiceURL$>" with action "PMSI/PaymentPostVer1" using format "" and request template "Info_Reedem_Void"
		| IsTAg | ParentNodeName | ReplacementKey  | ReplacementValue      | Query |
		| true  | Request        | RegisterId      | <ProfileCenterID>     |       |
		| true  | Request        | ProfitCenterId  | <$ProfileCenterID$>   |       |
		| true  | Request        | PaymentMethodId | <PaymentMethodID>     |       |
		| true  | Request        | PaymentAmount   | <XmlReedemTobeAmount> |       |
		| true  | AccountDetail  | PostAccountNum  | <$PlayerIdwithCode$>  |       |
	When User waits "3" seconds
	Given User "saves" soap request response using format ""
		| IsTag | NodeName | Attribute      | ExpectedValue | Query |
		| true  | Response | PostingStatus  | SuccessStatus |       |
		| true  | Response | PostingMessage | SuccessMsg    |       |
	When User performs string operation "stringEquals" of provided value "<$SuccessStatus$>" with "success"
	When User performs string operation "stringEquals" of provided value "<$SuccessMsg$>" with "Success"

	Examples:
		| ReedemAmount | ProfileCenterID | XmlReedemTobeAmount | offerAmount | PaymentMethodID |
		| 20           | 1234            | 3000                | 3000        | 18              |

Scenario: 004 - Verify on Webapp, offer has redeemed(TC 244905)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	#Assign Offer To Player
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<$PLAYER_ID301$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_No_Offer_Exist" is present "true" on UI
	#Checkin Redeem offer
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




Scenario Outline: 005- Assign Offer to Player for partial Redemption(TC 244905)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	#Assign Offer To Player
	Given User enters text "<$PLAYER_ID302$>" in "lylPlayer_Search.PlayerSearch_TextBox"
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

	Examples:
		| Remaining_Amount | Redeemed_Status | Active_Status | Redeemed_Amount | Total_OfferAmount |
		| $0.00            | Redeemed        | Active        | $30.00          | $30.00            |



Scenario Outline: 006  Inquiry and Redeem offer through Infogenesis Partially(TC 244905)
	#Enquiry Offer through Infogenisis
	Given User creates soap request to "<$InfogenesisServiceURL$>" with action "PMSI/AccountLookupVer1" using format "" and request template "Info_Lookup"
		| IsTAg | ParentNodeName | ReplacementKey  | ReplacementValue    | Query |
		| true  | Request        | ProfitCenterId  | <$ProfileCenterID$> |       |
		| true  | Request        | PaymentMethodId | <PaymentMethodID>   |       |
		| true  | Request        | InputData       | <$PLAYER_ID302$>    |       |
	When User waits "3" seconds
	Given User "saves" soap request response using format ""
		| IsTag | NodeName      | Attribute      | ExpectedValue    | Query |
		| true  | Response      | ErrorCode      | ErrorCode1        |       |
		| true  | AccountDetail | AuthAccountNum | PlayerIdwithCode1 |       |
		| true  | AccountDetail | Name           | xmlofferName1     |       |
		| true  | AccountDetail | BalanceAmount  | XmlAmount1        |       |
	When User performs arithmetic operation "numberEquals" of provided value "<$ErrorCode1$>" with "0"
	When User performs string operation "stringEquals" of provided value "<$xmlofferName1$>" with "<#Reg_FIRST_OFFER_NAME#> "
	When User performs string operation "stringEquals" of provided value "<$XmlAmount1$>" with "3000"
	#Redeem Offer
	#Reedem Offer partially Through Infogenisis
	Given User creates soap request to "<$InfogenesisServiceURL$>" with action "PMSI/PaymentPostVer1" using format "" and request template "Info_Reedem_Void"
		| IsTAg | ParentNodeName | ReplacementKey  | ReplacementValue      | Query |
		| true  | Request        | RegisterId      | <ProfileCenterID>     |       |
		| true  | Request        | ProfitCenterId  | <$ProfileCenterID$>   |       |
		| true  | Request        | PaymentMethodId | <PaymentMethodID>     |       |
		| true  | Request        | PaymentAmount   | <XmlReedemTobeAmount1> |       |
		| true  | AccountDetail  | PostAccountNum  | <$PlayerIdwithCode1$>  |       |
	When User waits "3" seconds
	Given User "saves" soap request response using format ""
		| IsTag | NodeName | Attribute      | ExpectedValue | Query |
		| true  | Response | PostingStatus  | SuccessStatus1 |       |
		| true  | Response | PostingMessage | SuccessMsg1    |       |
	When User performs string operation "stringEquals" of provided value "<$SuccessStatus1$>" with "success"
	When User performs string operation "stringEquals" of provided value "<$SuccessMsg1$>" with "Success"

	Examples:
		| ReedemAmount | ProfileCenterID | XmlReedemTobeAmount1 | offerAmount | PaymentMethodID |
		| 20           | 1234            | 2000                | 3000        | 18              |


Scenario: 007 - Verify on Webapp, offer has redeemed Partially(TC 244905)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	#Assign Offer To Player
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<$PLAYER_ID302$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
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
		| $0.00            | Redeemed        | Active        | $30.00          | $30.00            | $10.00              | $20.00                  |



Scenario Outline: 008- Assign Offer to Player to check Invalid Case(TC 244905)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	#Assign Offer To Player
	Given User enters text "<$PLAYER_ID303$>" in "lylPlayer_Search.PlayerSearch_TextBox"
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

	Examples:
		| Remaining_Amount | Redeemed_Status | Active_Status | Redeemed_Amount | Total_OfferAmount |
		| $0.00            | Redeemed        | Active        | $30.00          | $30.00            |



		Scenario Outline: 009 Inquiry and try to Redeem offer through Infogenesis by passing invalid offer id (TC 244905)
	#Enquiry Offer through Infogenisis
	When User runs query "Select  ConfigValue1 from  HO_x_config where ConfigCode = 'InFOGENESIS_HOSTING_URL'" with connection "<#Open.db.connectionstring#>" and save with key "InfogenesisServiceURL"
	When User runs query "Select  ConfigValue1 from  HO_x_config where ConfigCode = 'InfogenesisRequestorId'" with connection "<#Open.db.connectionstring#>" and save with key "ProfileCenterID"
	Given User creates soap request to "<$InfogenesisServiceURL$>" with action "PMSI/AccountLookupVer1" using format "" and request template "Info_Lookup"
		| IsTAg | ParentNodeName | ReplacementKey  | ReplacementValue    | Query |
		| true  | Request        | ProfitCenterId  | <$ProfileCenterID$> |       |
		| true  | Request        | PaymentMethodId | <PaymentMethodID>   |       |
		| true  | Request        | InputData       | <$PLAYER_ID303$>    |       |
	When User waits "3" seconds
	Given User "saves" soap request response using format ""
		| IsTag | NodeName      | Attribute      | ExpectedValue    | Query |
		| true  | Response      | ErrorCode      | ErrorCode2        |       |
		| true  | AccountDetail | AuthAccountNum | PlayerIdwithCode2 |       |
		| true  | AccountDetail | Name           | xmlofferName2    |       |
		| true  | AccountDetail | BalanceAmount  | XmlAmount2        |       |
	When User performs arithmetic operation "numberEquals" of provided value "<$ErrorCode2$>" with "0"
	When User performs string operation "stringEquals" of provided value "<$xmlofferName2$>" with "<#Reg_FIRST_OFFER_NAME#> "
	When User performs string operation "stringEquals" of provided value "<$XmlAmount2$>" with "3000"
	#Redeem Offer
	#Reedem Offer  Through Infogenisis
	Given User creates soap request to "<$InfogenesisServiceURL$>" with action "PMSI/PaymentPostVer1" using format "" and request template "Info_Reedem_Void"
		| IsTAg | ParentNodeName | ReplacementKey  | ReplacementValue      | Query |
		| true  | Request        | RegisterId      | <ProfileCenterID>     |       |
		| true  | Request        | ProfitCenterId  | <$ProfileCenterID$>   |       |
		| true  | Request        | PaymentMethodId | <PaymentMethodID>     |       |
		| true  | Request        | PaymentAmount   | <XmlReedemTobeAmount2> |       |
		| true  | AccountDetail  | PostAccountNum  | <$PlayerIdwithCode2$>6  |       |
	When User waits "3" seconds
	Given User "saves" soap request response using format ""
		| IsTag | NodeName | Attribute      | ExpectedValue | Query |
		| true  | Response | PostingStatus  | SuccessStatus2 |       |
		| true  | Response | PostingMessage | SuccessMsg2    |       |
	When User performs string operation "stringEquals" of provided value "<$SuccessStatus2$>" with "failure"
	When User performs string operation "stringEquals" of provided value "<$SuccessMsg2$>" with "Unknown Offer ID"

	Examples:
		| ReedemAmount | ProfileCenterID | XmlReedemTobeAmount2 | offerAmount | PaymentMethodID |
		| 20           | 1234            | 3000                | 3000        | 18              |
