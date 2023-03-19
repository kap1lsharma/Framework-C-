@Sequential@Release_15.0@Group_PrivateOffer@Desktopa
Feature: OL_PrivateOfferAssignmentLL

#******************************************************************************
#**  Feature File                 : OL_PrivateOfferAssignmentLL.feature
#**  Feature Name                 : Private Offer Creation & assignment to Player via LL
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 585401,585399
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  04/29/2022     Jogendra Singh            Initial Draft
#********************************************************************************/
#
#/*************************************************************************

Scenario Outline: 001-Enroll Player using WebApp
	Given User switch to "Web" application
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
	Examples:
		| BucketAmount | enrollType | prefixType | middleName | lastName  | suffix | bday       | gender | idType        | id          | expireDate | country | state   | country2 | state2  | nationality | addressType | addressLine          | city    | zip    | zipFour | fromDate   | toDate     | addressType2 | city2   | zip2   | zipFour2 | fromDate2  | toDate2    | teleType | teleNo     | teleStatus | emailType | email   | emailStatus | socialType | socialAccount  | smsType  | pin  | Permission | sms       | PLAYER_ID          | ssn       | PLAYER_ID_Key |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID     |
		| 1000         | Standard   | SIR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID1    |

Scenario: 002-Verify that user is able to Add Private Offer to Player's Account Via Loyalty lite.(TC 585401)
	When User runs query "Select top 1 Reason from [OFR].[UC_X_OfferReason]  order by NEWID()" with connection "<#Halo_db_connectionstring#>" and save with key "Reason"
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	Given User types text "<$PLAYER_ID$>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.tab_PlayerActions"
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerOffers"
	When User waits "2" seconds
	Given User clicks on "OLL_PlayerOffer.btn_AddActive_Offer"
	#Given User Entering Active Offer for Search.
	Given User types text "<#OfferName#>" in "OLL_PlayerOffer.txt_OfferName"
	Then User verifies that element "OLL_PlayerOffer.micPrivateDropdown" is present "true" on UI
	Given User selects option "Yes" of element "OLL_PlayerOffer.micPrivateDropdown" by "value"
	Given User clicks on "OLL_PlayerOffer.btn_Search"
	Given User clicks on cell of grid "OLL_PlayerOffer.tbl_ActiveOfferGrid" using row "1" and column "1"
	Given User clicks on "OLL_PlayerOffer.btn_ViewOfferDetails"
	When User waits "1" seconds
	Given User clicks on "OLL_PlayerOffer.btn_ViewOfferDet_Close"
	When User waits "1" seconds
	Given User clicks on "OLL_PlayerOffer.btn_AddPlayerToActiveOffer"
	Given User clicks on "OLL_PlayerOffer.btn_AddConfirmationOk"
	When User waits "2" seconds
	Given User types text "<#Halo_password#>" in "OLL_PlayerOffer.txt_Auth_Password"
	Given User selects option "<$Reason$>" of element "OLL_PlayerOffer.mic_Auth_Reason" by "value"
	Given User types text "Automation Testing" in "OLL_PlayerOffer.txt_Auth_Comment"
	When User waits "2" seconds
	#Clicking on OK button on Auth Popup.
	When User switch to window object "OLL_PlayerOffer.micAuthorizationbox"
	Given User clicks on "OLL_PlayerOffer.btn_Auth_OK"
	When User waits "4" seconds
	When User switch to window object "default"
	When User waits "6" seconds
	Given User clicks on "OLL_PlayerOffer.btn_Cancel_Return_Offer"
	When User waits "6" seconds
	#Validating on Player Offer Screen.
	Given User types text "<#OfferName#>" in "OLL_PlayerOffer.txt_OfferName"
	Given User clicks on "OLL_PlayerOffer.btn_Search"
	When User waits "2" seconds
	Given User clicks on cell of grid "OLL_PlayerOffer.micPlayerOfferGrid" using row "1" and column "1"
	Given User clicks on "OLL_PlayerOffer.ViewPlayerOfferDetails"
	When User waits "2" seconds
	When User gets attribute "Value" value of "OLL_PlayerOffer.lblOfferNameOfferDetails" element to save with key "Ofrname"
	When User performs string operation "stringEquals" of provided value "<$Ofrname$>" with "<#OfferName#>"
	Given User closes application
	
Scenario: 003-Uncheck SC_VIEWASSIGNPLAYERPRIVATEOFFER Permssion for UC_techServices user group.
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "VIEWASSIGNPLAYERPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Unchecked SC_VIEWASSIGNPLAYERPRIVATEOFFER permission for saservice user of UC_TechServices user group.	
	Then User "Unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                           |
	| permissionname | SC_VIEWASSIGNPLAYERPRIVATEOFFER |	
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"

Scenario: 004-Verify permission 'SC_VIEWASSIGNPLAYERPRIVATEOFFER' usage via Loyalty Lite. (TC 585399)
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username_3#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	Given User types text "<$PLAYER_ID1$>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.tab_PlayerActions"
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerOffers"
	When User waits "2" seconds
	Given User clicks on "OLL_PlayerOffer.btn_AddActive_Offer"
	When User waits "2" seconds
	#Validating Private Filter availability IsOffscreen true
	When User gets attribute "visible" value of "OLL_PlayerOffer.micPrivateDropdown" element to save with key "drodpwnstate"
	When User performs string operation "stringEquals" of provided value "<$drodpwnstate$>" with "false"
	Given User types text "<#OfferName#>" in "OLL_PlayerOffer.txt_OfferName"
	Given User clicks on "OLL_PlayerOffer.btn_Search"
	#Validating that No Offer available message is displaying.
	Then User verifies that element "OLL_PlayerOffer.lblNOActiveOffer" is present "true" on UI
	Given User closes application


Scenario: 005-check SC_VIEWASSIGNPLAYERPRIVATEOFFER Permssion for UC_techServices user group.
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "VIEWASSIGNPLAYERPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Unchecked SC_VIEWASSIGNPLAYERPRIVATEOFFER permission for saservice user of UC_TechServices user group.	
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                        |
	| permissionname | SC_VIEWASSIGNPLAYERPRIVATEOFFER |	
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"

Scenario Outline: 006-Verify Private Offer cannot be added to Deceased Player accounts.(TC 587497) 
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	Given User types text "<PlayerID>" in "OLL_MAIN_NAV.txt_PlayerID_Search"	
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.tab_PlayerActions"
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerOffers"
	Given User clicks on "OLL_PlayerOffer.btn_AddActive_Offer"
	#Verify the availability of Alert Message 'Function Not Allowed'.
	When User gets attribute "visible" value of "LLPlayerAward.lblFunctionNotAllowed" element to save with key "Alertmessagevisibility"
	When User performs string operation "stringEquals" of provided value "<$Alertmessagevisibility$>" with "true"
	When User gets attribute "Name" value of "LLPlayerAward.lblFunctionNotAllowed" element to save with key "AlertMessage"
	When User performs string operation "stringEquals" of provided value "<$AlertMessage$>" with "<Message>"
	
Examples: 
	| AccountStatus    | PlayerID           | Message                                                                |
	| Deceased  Player | <#DeceasedPlayer#> | Function not allowed due to account status                             |
	| Excluded Player  | <#ExcludedPlayer#> | Action restricted for patron. Exclusion Plan 'DAP' assigned to patron. |

Scenario Outline: 007-Verify Private Offer cannot be added to Archive Player accounts.(TC 587497) 
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	Given User clicks on "LLSideNavigation.chkIncludeArchivedAccount"
	Given User types text "<PlayerID>" in "OLL_MAIN_NAV.txt_PlayerID_Search"	
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.tab_PlayerActions"
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerOffers"
	Given User clicks on "OLL_PlayerOffer.btn_AddActive_Offer"
	#Verify the availability of Alert Message 'Function Not Allowed'.
	When User gets attribute "visible" value of "LLPlayerAward.lblFunctionNotAllowed" element to save with key "Alertmessagevisibility"
	When User performs string operation "stringEquals" of provided value "<$Alertmessagevisibility$>" with "true"
	When User gets attribute "Name" value of "LLPlayerAward.lblFunctionNotAllowed" element to save with key "AlertMessage"
	When User performs string operation "stringEquals" of provided value "<$AlertMessage$>" with "<Message>"
	
Examples: 
	| AccountStatus  | PlayerID          | Message                                    |
	| Archive Player | <#ArchivePlayer#> | Function not allowed due to account status |

Scenario: 008-Close all Instance of desktop application.
	When User switch to window application "ATI.Loyalty.Lite.Client.exe"
	Given User closes application

	

	
	
	
		