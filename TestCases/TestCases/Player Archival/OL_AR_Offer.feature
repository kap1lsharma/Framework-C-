@Release15.0@Player_Archival@Offer@Desktop
Feature: OL_AR_Offer Verify that archived players are not included in offer

#***************************************************************************************************************
#**  Feature File                 : OL_AR_Offer.feature
#**  Feature Name                 : Offer can not be added to Player
#**  Defect/Bug Linked(if any)    : 596083
#**  TFS TC ID Linked             : 477834,468960,468974,468979
#**************************************************************************************************************/
#**  Created Date:         Author:                  #Comments
#**  13/06/2022            Vijay Pratap Singh        Initial Draft
#**  27/06/2022            Ajay Dahiya               Added desktop closing scenerio at end of script
#*************************************************************************************************************/
Scenario Outline: 001-Verify that players that are archived cannot have an offer added to their account in Loyalty Lite.(TC 477834)
	#User login into Web-APP
	When User runs query "Select top 1 Reason from [OFR].[UC_X_OfferReason]  order by NEWID()" with connection "<#Halo_db_connectionstring#>" and save with key "Reason"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "RandomAlphabetic" with "5" for key "player_name"
	When Loyalty User Enroll Player via Webapp with "<$player_name$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	When User waits "2" seconds
	#User switches to Loyality Lite Application
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	Given User types text "<$PLAYER_ID$>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	Given User clicks on "OLL_MAIN_NAV.tab_PlayerActions"
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerOffers"
	Given User clicks on "OLL_PLAYEROFFERS.lbl_AddActiveOffer"
	#User Entering Active Offer for Search.
	Given User types text "<#OfferName#>" in "OLL_PlayerOffer.txt_OfferName"
	Then User verifies that element "OLL_PlayerOffer.micPrivateDropdown" is present "true" on UI
	Given User selects option "Yes" of element "OLL_PlayerOffer.micPrivateDropdown" by "value"
	Given User clicks on "OLL_PlayerOffer.btn_Search"
	Given User clicks on cell of grid "OLL_PlayerOffer.tbl_ActiveOfferGrid" using row "1" and column "1"
	Given User clicks on "OLL_PlayerOffer.btn_AddPlayerToActiveOffer"
	Given User clicks on "OLL_PlayerOffer.btn_AddConfirmationOk"
	Given User types text "<#Halo_password#>" in "OLL_PlayerOffer.txt_Auth_Password"
	Given User selects option "<$Reason$>" of element "OLL_PlayerOffer.mic_Auth_Reason" by "value"
	Given User types text "Automation Testing" in "OLL_PlayerOffer.txt_Auth_Comment"
	When User waits "2" seconds
	#Clicking on OK button on Auth Popup.
	When User switch to window object "OLL_PlayerOffer.micAuthorizationbox"
	Given User clicks on "OLL_PlayerOffer.btn_Auth_OK"
	When User switch to window object "default"
	Given User clicks on "OLL_PlayerOffer.btn_Cancel_Return_Offer"
	When User waits "6" seconds
	Given User clicks on "OLL_PLAYEROFFERS.btn_Close"
	#User navigate to Player Archival
	Given User clicks on "LLSideNavigation.btn_pagedown"
	Given User clicks on "LLPlayerArchival.btn_Player_Archival_Status"
	Given User types text "<#Halo_password#>" in "LLPlayerArchival.txt_PasswordTextBox"
	Given User selects option "<archive_reason>" of element "LLPlayerArchival.mic_ReasonBox_Dropdown" by "value"
	Given User types text "<Comment_For_Archival>" in "LLPlayerArchival.txt_CommentBox"
	Given User clicks on "LLPlayerArchival.btn_Archive_Player"
	#User verifes successful message on archival
	When User gets attribute "Name" value of "LLPlayerArchival.lbl_Archive_Message" element to save with key "Message"
	When User performs string operation "stringEquals" of provided value "<ArchivalMessage>" with "<$Message$>"
	Given User clicks on "LLPlayerArchival.btn_Close"
	#User verifes AR button on player
	When User gets attribute "Name" value of "LLPlayerArchival.btn_AR_indicator" element to save with key "AR_Button_Text"
	When User performs string operation "stringEquals" of provided value "<AR_Button>" with "<$AR_Button_Text$>"
	#User check message on add active offer button
	Given User clicks on "OLL_MAIN_NAV.tab_PlayerActions"
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerOffers"
	Given User clicks on "OLL_PLAYEROFFERS.lbl_AddActiveOffer"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "LLPlayerArchival.btn_Close"
	When User waits "2" seconds
	#User clicks on Redeem Offer
	When User switch to window object "OLL_PLAYEROFFERS.mic_HomeCtrl"
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerOffers"
	Given User clicks on cell of grid "OLL_PLAYEROFFERS.tbl_PlayerOffersGrid" using row "1" and column "1"
	Given User clicks on "OLL_PLAYEROFFERS.btn_RedeemOffer"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "LLPlayerArchival.btn_Close"
	When User waits "2" seconds
	#User clicks on Scan Barcode
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerOffers"
	Given User clicks on cell of grid "OLL_PLAYEROFFERS.tbl_PlayerOffersGrid" using row "1" and column "1"
	Given User clicks on "OLL_PLAYEROFFERS.btn_ScanBarcode"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "LLPlayerArchival.btn_Close"
	When User waits "2" seconds
	#User clicks on Delete Player Offer
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerOffers"
	Given User clicks on cell of grid "OLL_PLAYEROFFERS.tbl_PlayerOffersGrid" using row "1" and column "1"
	Given User clicks on "OLL_PLAYEROFFERS.btn_DeleteOffer"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "LLPlayerArchival.btn_Close"
	When User waits "2" seconds
	#User clicks on Reverse Offer
	When User switch to window object "default"
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerOffers"
	Given User clicks on cell of grid "OLL_PLAYEROFFERS.tbl_PlayerOffersGrid" using row "1" and column "1"
	Given User clicks on "OLL_PLAYEROFFERS.btn_ReserveOffer"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI

	Examples:
		| archive_reason           | Comment_For_Archival      | ArchivalMessage             | AR_Button |
		| Instructed by Management | Comment Line For Archival | Player Archival Successful. | AR        |

Scenario Outline: 002 Making Test Data For Offer provided on Archived Player
	#User login to web-app
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User enroll a player in web-app
	When User generates a "UniqueString" with "AjayPlayer_:4" for key "FirstName"
	When User waits "2" seconds
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	When User waits "2" seconds
	#User search player archival status under player function
	Given User enters text "Player Archival Status" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "lylPlayer_Function.lnk_player_archivalstatus"
	When User waits "2" seconds
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	#User process Archival on the player
	Given User enters text "<#Halo_password#>" in "lylPage_Archival_Sts.txt_Password"
	Given User selects option "<archive_reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Archival>" in "lylPage_Archival_Sts.txt_comment"
	Given User clicks on "lylPage_Archival_Sts.btn_archive"
	When User waits "3" seconds
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI

	Examples:
		| archive_reason           | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |

Scenario Outline:003 Verify User is not able to Assign Non Promo Offer to Archived Player's Account ( TC ID-468960)
	#User login to web-app
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User clicks on "lylPlayer_Search.btn_search_dropdown"
	Given User clicks on "lylPlayer_Search.btn_chck_arch_accnt"
	When User waits "1" seconds
	#User search player archival status under player function
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	#Assign Offer To Player
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "4" seconds
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Then User verifies that element "OLL_PlayerOffer.mic_FunctionNotAllowed_Alert" is present "true" on UI
	When User gets attribute "getText" value of "OLL_PlayerOffer.mic_FunctionNotAllowed_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds

	Examples:
		| givenErrorMessage                           |
		| Function not allowed due to account status. |

Scenario Outline: 004 Verify that if an archived player is on an Offer Import file, then it is showing an error stating the player is archived. ( TC ID-468979)
	When User runs query "Select P.CorpProp from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyCorpProp"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate"
	When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "1" on dateTime "<$startdate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	When User runs query "select * from ofr.UC_X_Campaign where CampaignName = '<#Reg_CampaignName#>'" with connection "<#Halo_db_connectionstring#>" and save with key "CampaignID"
	#User Logging in Import Utility Application
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Offer Import\ATI.Loyalty.OfferImport.exe"
	Given User enters text "<#Halo_username#>" in "OLIU_LOGIN.txt_user_id"
	Given User enters text "<#Halo_password#>" in "OLIU_LOGIN.txt_Password"
	Given User clicks on "OLIU_LOGIN.mic_DomainName"
	Given User clicks on "OLIU_LOGIN.btn_drp_dwn_select"
	Given User clicks on "OLIU_LOGIN.btn_Submit"
	When User waits "2" seconds
	Given User clicks on "OLIU_UploadSrc.btn_ButtonNext"
	When User waits "2" seconds
	Given User selects option "<UploadType>" of element "OLIU_UploadSrc.mic_UploadType" by "value"
	When User switch to window object "OLIU_UploadSrc.frm_Offer_Import"
	Given User clicks on "OLIU_UploadSrc.btn_Next_Step"
	When User switch to window object "default"
	#Clicking on Browse button.
	When User switch to window object "OLIU_UploadSrc.frm_UploadFile"
	Given User clicks on "OLIU_UploadSrc.btn_BrowseCSVButton"
	When User switch to window object "default"
	When User generates a "UniqueString" with "OfferUpload_:5" for key "OfferuploadExcel"
	When User "creates" excel file "<$OfferuploadExcel$>" with sheet "Player Upload" in "xls" format with data
		| Campaign ID    | Segment Name        | Player ID         |
		| <$CampaignID$> | <#Reg_SegmentName#> | <#ArchivePlayer#> |
	When User waits "2" seconds
	Given User clicks on "OLIU_UploadSrc.txt_FileName_Desktop"
	When User waits "2" seconds
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User types text "<$testbaseLocation$><$OfferuploadExcel$>.xls" in "OLIU_UploadSrc.txt_FileName_Desktop"
	When User waits "2" seconds
	Given User clicks on "OLIU_UploadSrc.btn_OpenDesktop"
	When User waits "6" seconds
	Given User clicks on "OLIU_UploadSrc.btn_uploadButtonNext"
	When User waits "6" seconds
	Given User clicks on "OLIU_UploadSrc.txt_EnterPassword"
	When User waits "2" seconds
	Given User types text "<#Halo_password#>" in "OLIU_UploadSrc.txt_EnterPassword"
	When User waits "2" seconds
	Given User clicks on "OLIU_UploadSrc.btn_beginUpload"
	When User waits "6" seconds
	When User gets attribute "Name" value of "OLIU_UploadSrc.btn_ErrorReport" element to save with key "Error_Report"
	When User performs string operation "stringEquals" of provided value "<ErrorMessage>" with "<$Error_Report$>"
	Given User closes application

	Examples:
		| UploadType    | ErrorMessage |
		| Player Upload | Error Report |

Scenario Outline:005 Verify that Active players added in segment ( TC ID-468974)
	#User login to web-app
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User enroll a player in web-app
	When User generates a "UniqueString" with "AjayPlayer_:4" for key "FirstName"
	When User waits "2" seconds
	When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "PLAYER_ID_1" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |
	When User waits "2" seconds
	#Opening The Campaign & Segment
	Given User clears "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User enters text "Manage Campaign" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value           |
		| SideSubMenu | Manage Campaign |
	Given User enters text "<#Reg_CampaignName#>" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value                |
		| Campaign | <#Reg_CampaignName#> |
	When User waits "2" seconds
	When User scrolls till element "ltyCampaign_Manage.btn_View_Segment"
	Given User clicks on "ltyCampaign_Manage.btn_View_Segment"
	When User waits "2" seconds
	Given User clears "ltyManage_Segment.Filter_Segment_Name"
	Given User enters text "<#Reg_SegmentName#>" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value               |
		| SegmentName | <#Reg_SegmentName#> |
	#Adding Player to Segment
	Given User clicks on "ltyManage_Segment.btn_View_Players"
	Given User clicks on "ltyPlayerDetail.btn_Addnew_Player_Segment"
	Given User enters text "<$PLAYER_ID_1$>" in "ltyPlayerDetail.txt_NewPlayer_Addbox"
	Given User clicks on "ltyPlayerDetail.btn_searchplayer"
	Given User clicks on "ltyPlayerDetail.btn_save"
	Then User verifies text - "The offers have been assigned successfully." is present on page
	When User waits "3" seconds
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID_1$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	#User search player archival status under player function
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User enters text "Player Archival Status" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylPlayer_Function.lnk_player_archivalstatus"
	When User waits "4" seconds
	Given User switches to frame "lylPage_Archival_Sts.frm_Player_Archival_Status"
	When User waits "2" seconds
	#User process Archival on the player
	Given User enters text "<#Halo_password#>" in "lylPage_Archival_Sts.txt_Password"
	Given User selects option "<archive_reason>" of element "lylPage_Archival_Sts.mic_reason_dropdown" by "visibletext"
	Given User enters text "<Comment_For_Archival>" in "lylPage_Archival_Sts.txt_comment"
	Given User clicks on "lylPage_Archival_Sts.btn_archive"
	When User waits "3" seconds
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI

	Examples:
		| archive_reason           | Comment_For_Archival      |
		| Instructed by Management | Comment Line For Archival |

Scenario Outline:006 Verify that archived players above is auot excluded in offer counts in Manage Campaign. ( TC ID-468974)
	#User login to web-app
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#Opening The Campaign & Segment
	Given User clears "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User enters text "Manage Campaign" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value           |
		| SideSubMenu | Manage Campaign |
	Given User enters text "<#Reg_CampaignName#>" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value                |
		| Campaign | <#Reg_CampaignName#> |
	When User waits "2" seconds
	When User scrolls till element "ltyCampaign_Manage.btn_View_Segment"
	Given User clicks on "ltyCampaign_Manage.btn_View_Segment"
	When User waits "2" seconds
	Given User clears "ltyManage_Segment.Filter_Segment_Name"
	Given User enters text "<#Reg_SegmentName#>" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
		| Key         | Value               |
		| SegmentName | <#Reg_SegmentName#> |
	#Adding Player to Segment
	Given User clicks on "ltyManage_Segment.btn_View_Players"
	Given User clicks on "ltyPlayerDetail.btn_Addnew_Player_Segment"
	Given User enters text "<$PLAYER_ID_1$>" in "ltyPlayerDetail.txt_NewPlayer_Addbox"
	Given User clicks on "ltyPlayerDetail.btn_searchplayer"
	Then User verifies that element "ltyPlayerDetail.txt_ErrorText" is present "true" on UI
	When User gets attribute "getText" value of "ltyPlayerDetail.txt_ErrorText" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds

	Examples:
		| givenErrorMessage |
		| Player Not Found  |

Scenario: 007-Close all Instance of Loyalty Lite desktop application.
	When User switch to window application "ATI.Loyalty.Lite.Client.exe"
	Given User closes application

Scenario: 008-Close all Instance of Import Utility desktop application.
	When User switch to window application "ATI.Loyalty.OfferImport.exe"
	Given User closes application