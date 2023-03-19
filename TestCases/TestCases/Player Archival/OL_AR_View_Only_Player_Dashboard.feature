@Release15.0@Player_Archival@View_Only_Player_Dashboard@Desktop
Feature: OL_AR_View_Only_Player_Dashboard

#***************************************************************************************************************
#**  Feature File                 : OL_AR_View_Only_Player_Dashboard.feature
#**  Feature Name                 : View Only Player Dashboard
#**  Defect/Bug Linked(if any)    : 597294
#**  TFS TC ID Linked             : 476896,461342,461345
#**************************************************************************************************************/
#**  Created Date:         Author:                  #Comments
#**  13/06/2022            Vijay Pratap Singh       Initial Draft
#**  26/06/2022            Ajay Dahiya              Added actions for Web-APP
#*************************************************************************************************************/
Scenario: 001 Verify that no actions can be performed on an archived account on Loyalty Lite (TC 476896)
	#Login to Loyalty Lite
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	Given User clicks on "LLSideNavigation.chkIncludeArchivedAccount"
	Given User clears "OLL_MAIN_NAV.txt_PlayerID_Search"
	Given User types text "<#ArchivePlayer#>" in "OLL_MAIN_NAV.txt_PlayerID_Search"
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	#User click on Issue Comp
	Given User clicks on "LLSideNavigation.lblPlayerAction"
	Given User clicks on "OLL_ISSUECOMP.lnk_IssueComp"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on Adjust Player Tier
	Given User clicks on "OLL_ADJUSTPLAYERTIER.lnk_AdjustPlayerTier"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on Edit Patron Data
	Given User clicks on "OLL_EDITPATRONDATA.lnk_Edit_Patron_Data"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on Print Card
	Given User clicks on "OLL_PRINTCARD.lnk_PrintCard"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on Adjust Bucket Value
	Given User clicks on "OLL_ADJUSTBUCKETVALUE.lnk_AdjustBucketValue"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on Link Player
	Given User clicks on "OLL_LINKPLAYER.lnk_LinkPlayer"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on UnLink Player
	Given User clicks on "OLL_UNLINKPLAYER.lnk_UnlinkPlayer"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on Reset PIN
	Given User clicks on "LLSideNavigation.btn_pagedown"
	Given User clicks on "OLL_RESETPIN.lnk_ResetPin"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on Pending Earning
	Given User clicks on "OLL_VIEWPENDINGEARNINGS.lnk_ViewPendingEarnings"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on Player Interest
	Given User clicks on "LLSideNavigation.btn_PageUp"
	Given User clicks on "OLL_MANAGEPLAYERINTEREST.lnk_PlayerInterest"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on View Comment
	Given User clicks on "OLL_VIEWCOMMENTS.lnk_ViewComment"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on Push Player Enrollment
	Given User clicks on "OLL_PUSHPLAYERENROLLMENT.lnk_PushPlayerEnrollment"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on Player Information Sync
	Given User clicks on "OLL_PLAYERINFORMATIONSYNC.lnk_PlayerInformationSync"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on Manage Contact Information
	Given User clicks on "OLL_MANAGECONTATCINFORMATION.lnk_ManageContactInformation"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on Player Offer
	Given User clicks on "OLL_PLAYEROFFERS.lnk_ViewPlayerOffers"
	Given User clicks on "OLL_PLAYEROFFERS.lbl_AddActiveOffer"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	When User waits "4" seconds
	Given User clicks on "OLL_BUCKETAWARDS.btn_Close"
	#User click on Add Bucket Award
	Given User clicks on "LLSideNavigation.lbl_PlayerHistory"
	Given User clicks on "OLL_BUCKETAWARDS.lnk_BucketAward"
	Given User clicks on "OLL_BUCKETAWARDS.btn_ShowBucketAward"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_BUCKETAWARDS.btn_Close"
	#User click on Overflow Earning
	Given User clicks on "OLL_MANAGEOVERFLOWEARNINGS.lnk_ManageOverflowEarnings"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on Bucket Balance Popup
	Given User clicks on "OLL_BUCKETBALANCEPOPUP.lnk_BucketBalancePopup"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"
	#User click on Player Earnings
	Given User clicks on "OLL_PLAYEREARNINGS.lnk_PlayerEarnings"
	Then User verifies that element "OLL_ISSUECOMP.lbl_FunctionNotAllowed" is present "true" on UI
	Given User clicks on "OLL_ISSUECOMP.btn_FunctionNotAllowedOK"

Scenario: 002 Verify that no actions can be performed on an archived account on Web-APP (TC 461342,461345) (Bug ID -597294)
	# User login web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#User include Archived account using checkbox in search list
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Search.btn_search_dropdown"
	Given User clicks on "lylPlayer_Search.btn_chck_arch_accnt"
	When User waits "1" seconds
	#User search player archival status under player function
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<#ArchivePlayer#>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	#User verifies Indicator on Player's Dashboard
	Then User verifies that element "lylPage_Archival_Sts.btn_ar_indicator" is present "true" on UI
	#User verifies Issue Comp button should not present on Web-APP on Archived
	Then User verifies that element "OLW_ISSUECOMP.btn_IssueComp" is present "false" on UI
	#User click on Adjust Player Tier
	Given User clears "MAIN_NAV_BOX.EB_MenuSearch"
	Given User enters text "Adjust Player Tier" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_Adjust_Player_Tier"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"
	#User click on Edit Patron Data
	Given User clears "MAIN_NAV_BOX.EB_MenuSearch"
	Given User enters text "Edit Patron Data" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_Edit_Patron_Data"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"
	#User click on Print Card
	Given User clears "MAIN_NAV_BOX.EB_MenuSearch"
	Given User enters text "Print Card" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_Print_Card"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage1>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"
	#User click on Adjust Bucket Value
	Given User clears "MAIN_NAV_BOX.EB_MenuSearch"
	Given User enters text "Adjust Bucket Value" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_Adjust_Bucket_Value"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"
	#User click on Link Player
	Given User clears "MAIN_NAV_BOX.EB_MenuSearch"
	Given User enters text "Link Player" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_Link_Player"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"
	#User click on UnLink Player
	Given User clears "MAIN_NAV_BOX.EB_MenuSearch"
	Given User enters text "Unlink Player" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_Unlink_Player"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"
	#User click on Reset PIN
	Given User clears "MAIN_NAV_BOX.EB_MenuSearch"
	Given User enters text "Reset PIN" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_Reset_PIN"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"
	#User click on View Comment
	Given User clears "MAIN_NAV_BOX.EB_MenuSearch"
	Given User enters text "View Comment" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_View_Comment"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"
	#User click on Push Player Enrollment
	Given User clears "MAIN_NAV_BOX.EB_MenuSearch"
	Given User enters text "Push Player Enrollment" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_Push_Player_Enrollment"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"
	#User click on Manage Contact Information
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value               |
		| Dashboard_Tab | Contact Information |
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage1>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"
	#User click on Player Offer
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "4" seconds
	Given User enters text "<#Reg_FIRST_OFFER_NAME#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"
	#User click on Overflow Earning
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value             |
		| Dashboard_Tab | Overflow Earnings |
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage1>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"
	#User click on Bucket Balance Popup
	Given User clears "MAIN_NAV_BOX.EB_MenuSearch"
	Given User enters text "Bucket Balances Popup" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_Bucket_Balances_Popup"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"
	#User click on Pending Earnings
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value            |
		| Dashboard_Tab | Pending Earnings |
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage1>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"
	#User click on Player Information Sync
	Given User clears "MAIN_NAV_BOX.EB_MenuSearch"
	Given User enters text "Player Information Sync" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_Player_Information_Sync"
	When User waits "2" seconds
	Then User verifies that element "lylPlayer_Archival.mic_Alert" is present "true" on UI
	When User gets attribute "getText" value of "lylPlayer_Archival.mic_Alert" element to save with key "ArchiveWarningMessage"
	When User performs string operation "stringEquals" of provided value "<givenErrorMessage>" with "<$ArchiveWarningMessage$>"
	When User waits "2" seconds
	Given User clicks on "lylPlayer_Archival.btn_Close"

	Examples:
		| givenErrorMessage                           | givenErrorMessage1                         |
		| Function not allowed due to account status. | Function not allowed due to account status |

Scenario: 003-Close all instance of Loyalty Lite Desktop application.
	When User switch to window application "ATI.Loyalty.Lite.Client.exe"
	Given User closes application