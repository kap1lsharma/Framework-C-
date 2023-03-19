@Sequential@Release_15.0@Group_PrivateAward@Desktop
Feature: OL_PrivateAwardAssignmentLL

#******************************************************************************
#**  Feature File                 : OL_PrivateAwardAssignmentLL.feature
#**  Feature Name                 : Private Award assignment to Player via LL
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 587497,583185
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  05/16/2022     Jogendra Singh            Initial Draft
#********************************************************************************/
#
#/*************************************************************************
Scenario: 001-Data Creation 
	When User runs query "Select P.CorpProp from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyCorpProp"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate" 
    When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "120" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "enddate"

Scenario Outline: 002-Enroll Player using WebApp
	Given User switch to "Web" application
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
	Given User clicks on "ENROLL_PLAYER.ID_DOB_TEXTBOX"
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
	When User waits "4" seconds
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


Scenario: 003-Private Award creation.
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Mass Importer\ATI.Loyalty.MassImporter.exe"
	Given User types text "<#Halo_username#>" in "MI_Login.txt_UserID"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "MI_Login.Domain_DropDown" by "value"
	When User waits "4" seconds
	Given User clicks on "MI_Login.btn_SignIn"
	When User waits "20" seconds
	Given User selects option "Award Type" of element "MI_Login.SelectUpdateType_Dropdown" by "value"
	When User generates a "UniqueString" with "AwardType:4" for key "AwardType"
	When User generates a "UniqueString" with "Award_:5" for key "AwardName"
	When User "creates" excel file "<$AwardType$>" with sheet "Award Type" in "xls" format with data
	| Name          | BucketView      | Corp Prop            | Start Date    | End Date    | Amount | IsKiosk | IsPrivate |
	| <$AwardName$> | Universal Promo | <$PropertyCorpProp$> | <$startdate$> | <$enddate$> | 10     | N       | Y         |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	Given User types text "<$testbaseLocation$>\<$AwardType$>.xls" in "MASS_IMPORTER.BulUPdateCSV"
	When User waits "2" seconds
	When User switch to window object "BulkUpdate.frmBulkUpdateFrame"
	Given User types text "<#Halo_password#>" in "MI_Login.txt_Password"
	Given User clicks on "MI_Login.btn_BeginBulkUpdate"
	When User waits "35" seconds
	When User switch to window object "default"
	Then User verifies that element "BulkUpdate.lblbulksuccess" is present "true" on UI
	Given User clicks on "BulkUpdate.btn_OK"
	Given User closes application

Scenario: 004-Verify User is able to Assign a Private Bucket Award from Loyalty Lite.(TC 587497)
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "2" seconds
	Given User types text "<$PLAYER_ID$>" in "OLL_MAIN_NAV.txt_PlayerID_Search"	
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	When User waits "2" seconds
	Given User clicks on "LLSideNavigation.lbl_PlayerHistory"
	Given User clicks on "LLPlayerAward.lnkBucketAwards"
	Given User clicks on "LLPlayerAward.btnShowBucketAwards"
	Given User types text "<#PrivateAwardPromo#>" in "LLPlayerAward.txtshowPlayerAwardSearchBox"
	Then User verifies that element "LLPlayerAward.lstPrivateDropdown" is present "true" on UI
	Given User selects option "Yes" of element "LLPlayerAward.lstPrivateDropdown" by "value"
	Given User clicks on "LLPlayerAward.btnSearchnotassignedawrd"
	When User waits "4" seconds
	#Given User clicks on cell of grid "PlayerAward.micshowawardgrid" using row "1" and column "1"
	Given User clicks on "LLPlayerAward.lblNotAssignedAward"
	Given User clicks on "LLPlayerAward.btnAddAwardtoPlayer"
	Given User clicks on "LLPlayerAward.btnConfirmationOK"
	Given User clicks on "LLPlayerAward.btnSuccessOK"
	Given User clicks on "LLPlayerAward.btnReturntoplayeraward"
	Given User types text "<#PrivateAwardPromo#>" in "LLPlayerAward.txtplayerbucketawardsearch"
	Given User clicks on "LLPlayerAward.btnassignedawardsearch"
	#Then User gets a cell value of table "PlayerAward.micplayerawardGrid" with row "1" and column "1" and save into key "gridawardname"
	Given User clicks on "LLPlayerAward.lblNotAssignedAward"
	Given User clicks on "LLPlayerAward.btnviewbucketawarddetail"
	#Validate added award details.
	When User gets attribute "Value" value of "LLBucketAwardDetails.txtBucketAwardName" element to save with key "DetailAwardName"
	When User performs string operation "stringEquals" of provided value "<$DetailAwardName$>" with "<#PrivateAwardPromo#>"
	When User gets attribute "Value" value of "LLBucketAwardDetails.lblStartDate" element to save with key "DetailStartdate"
	When User performs string operation "stringEquals" of provided value "<$DetailStartdate$>" with "<#PrivateAwardStartDate#>"
	When User gets attribute "Value" value of "LLBucketAwardDetails.lblEndDate" element to save with key "DetailEnddate"
	When User performs string operation "stringEquals" of provided value "<$DetailEnddate$>" with "<#PrivateAwardEndDate#>"
	When User gets attribute "Value" value of "LLBucketAwardDetails.lblStatus" element to save with key "DetailStatus"
	When User performs string operation "stringEquals" of provided value "<$DetailStatus$>" with "Active"
	When User gets attribute "Value" value of "LLBucketAwardDetails.lblUserID" element to save with key "DetailUserID"
	When User performs string operation "stringEquals" of provided value "<$DetailUserID$>" with "<#Halo_username#>"
	When User gets attribute "Value" value of "LLBucketAwardDetails.lblIssuedAmount" element to save with key "DetailIssuedAmount"
	When User performs string operation "stringEquals" of provided value "<$DetailIssuedAmount$>" with "$100.00"
	When User gets attribute "Value" value of "LLBucketAwardDetails.lblRedeemedAmount" element to save with key "DetailRedeemedAmount"
	When User performs string operation "stringEquals" of provided value "<$DetailRedeemedAmount$>" with "$0.00"
	When User gets attribute "Value" value of "LLBucketAwardDetails.lblAvailableamount" element to save with key "DetailAvailableAmount"
	When User performs string operation "stringEquals" of provided value "<$DetailAvailableAmount$>" with "$100.00"
	Given User closes application

Scenario: 005-Verify Users without permission "SC_VIEWASSIGNPRIVATEAWARD" will not be able to assign Private Awards to a player.(TC 587497)
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	Given User types text "<$PLAYER_ID1$>" in "OLL_MAIN_NAV.txt_PlayerID_Search"	
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	When User waits "2" seconds
	Given User clicks on "LLSideNavigation.lbl_PlayerHistory"
	Given User clicks on "LLPlayerAward.lnkBucketAwards"
	Given User clicks on "LLPlayerAward.btnShowBucketAwards"
	#Validating Private Filter availability IsOffscreen true
	Then User verifies that element "LLPlayerAward.lstPrivateDropdown" is present "true" on UI
	Given User types text "<#PrivateAwardPromo#>" in "LLPlayerAward.txtshowPlayerAwardSearchBox"
	Given User selects option "No" of element "LLPlayerAward.lstPrivateDropdown" by "value"
	Given User clicks on "LLPlayerAward.btnSearchnotassignedawrd"
	When User waits "4" seconds
	#Validating that after selecting NO option from Private dropdown No award available message is displaying.
	Then User verifies that element "LLPlayerAward.lblNoAwardfound" is present "true" on UI
	#Validating that after selecting YESOption from Private dropdown  award is displaying.
	Given User selects option "Yes" of element "LLPlayerAward.lstPrivateDropdown" by "value"
	Given User clicks on "LLPlayerAward.btnSearchnotassignedawrd"
	Then User verifies that element "LLPlayerAward.btnSearchnotassignedawrd" is present "true" on UI
	Given User closes application


Scenario: 006-Verify the Category and Description of the Permission: SC_VIEWASSIGNPRIVATEAWARD & Uncheck.(TC 587497)
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "SC_VIEWASSIGNPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Verification of permission , it's category and description
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lnk_PermissionDetailAll" is present "true" on UI with parameters
	| Key            | Value                                                               |
	| PermissionName | SC_VIEWASSIGNPRIVATEAWARD                                           |
	| Category       | Loyalty Lite                                                        |
	| Description    | IN LOYALTY LITE, VIEW AND ASSIGN A PRIVATE BUCKET AWARD TO A PLAYER |
	When User waits "2" seconds
	#Remove DELETEPLAYERPRIVATEOFFER permission from UC_TechServices user group.
	Then User "Uncheck" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                     |
	| permissionname | SC_VIEWASSIGNPRIVATEAWARD |	
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario: 007-Verify Users without permission "SC_VIEWASSIGNPRIVATEAWARD" will not be able to assign Private Awards to a player.(TC 587497)
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
	Given User clicks on "LLSideNavigation.lbl_PlayerHistory"
	Given User clicks on "LLPlayerAward.lnkBucketAwards"
	Given User clicks on "LLPlayerAward.btnShowBucketAwards"
	#Validating Private Filter availability IsOffscreen true
	When User gets attribute "visible" value of "LLPlayerAward.lstPrivateDropdown" element to save with key "drodpwnstate"
	When User performs string operation "stringEquals" of provided value "<$drodpwnstate$>" with "false"
	Given User types text "<#PrivateAwardPromo#>" in "LLPlayerAward.txtshowPlayerAwardSearchBox"
	Given User clicks on "LLPlayerAward.btnSearchnotassignedawrd"
	#Validating that No award available message is displaying.
	Then User verifies that element "LLPlayerAward.lblNoAwardfound" is present "true" on UI
	Given User closes application

Scenario: 008-check SC_VIEWASSIGNPRIVATEAWARD Permssion for UC_techServices user group.
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "SC_VIEWASSIGNPRIVATEAWARD" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Remove DELETEPLAYERPRIVATEOFFER permission from UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                     |
	| permissionname | SC_VIEWASSIGNPRIVATEAWARD |	
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario: 009-Uncheck SC_DAPOVERRIDE Permission.
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "SC_DAPOVERRIDE" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Remove DELETEPLAYERPRIVATEOFFER permission from UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value          |
	| permissionname | SC_DAPOVERRIDE |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario Outline: 010-Verify Private Bucket Awards cannot be added to <AccountStatus> accounts.(TC 587497) 
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	Given User types text "<PlayerID>" in "OLL_MAIN_NAV.txt_PlayerID_Search"	
	When User waits "2" seconds
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"	
	Given User clicks on "LLSideNavigation.lbl_PlayerHistory"
	Given User clicks on "LLPlayerAward.lnkBucketAwards"
	Given User clicks on "LLPlayerAward.btnShowBucketAwards"
	#Verify the availability of Alert Message 'Function Not Allowed'.
	When User gets attribute "visible" value of "LLPlayerAward.lblFunctionNotAllowed" element to save with key "Alertmessagevisibility"
	When User performs string operation "stringEquals" of provided value "<$Alertmessagevisibility$>" with "true"
	When User gets attribute "Name" value of "LLPlayerAward.lblFunctionNotAllowed" element to save with key "AlertMessage"
	When User performs string operation "stringEquals" of provided value "<$AlertMessage$>" with "<Message>"
	Given User closes application
Examples: 
	| AccountStatus    | PlayerID           | Message                                     |
	| Deceased  Player | <#DeceasedPlayer#> | Function not allowed due to account status. |
	| MergePlayer      | <#MergePlayer#>    | Function not allowed due to account status. |

Scenario Outline: 011-Verify Private Bucket Awards cannot be added to Archive Player accounts.(TC 587497)
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	Given User clicks on "LLSideNavigation.chkIncludeArchivedAccount"
	Given User types text "<PlayerID>" in "OLL_MAIN_NAV.txt_PlayerID_Search"	
	Given User clicks on "OLL_MAIN_NAV.btn_PlayerSearch"
	When User waits "2" seconds
	Given User clicks on "LLSideNavigation.lbl_PlayerHistory"
	Given User clicks on "LLPlayerAward.lnkBucketAwards"
	Given User clicks on "LLPlayerAward.btnShowBucketAwards"
	#Verify the availability of Alert Message 'Function Not Allowed'.
	When User gets attribute "visible" value of "LLPlayerAward.lblFunctionNotAllowed" element to save with key "Alertmessagevisibility"
	When User performs string operation "stringEquals" of provided value "<$Alertmessagevisibility$>" with "true"
	When User gets attribute "Name" value of "LLPlayerAward.lblFunctionNotAllowed" element to save with key "AlertMessage"
	When User performs string operation "stringEquals" of provided value "<$AlertMessage$>" with "<Message>"
	Given User closes application
	Examples: 
	| AccountStatus    | PlayerID           | Message                                     |
	| Archive Player   | <#ArchivePlayer#>  | Function not allowed due to account status. |

Scenario Outline: 012-Verify Private Bucket Awards cannot be added to Excluded Player accounts.(TC 587497)
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
	Given User clicks on "LLSideNavigation.lbl_PlayerHistory"
	Given User clicks on "LLPlayerAward.lnkBucketAwards"
	Given User clicks on "LLPlayerAward.btnShowBucketAwards"
	Given User types text "<#PrivateAwardPromo#>" in "LLPlayerAward.txtshowPlayerAwardSearchBox"
	Given User clicks on "LLPlayerAward.btnSearchnotassignedawrd"
	Given User clicks on "LLPlayerAward.lblNotAssignedAward"
	Given User clicks on "LLPlayerAward.btnAddAwardtoPlayer"
	#Verify the availability of Alert Message 'Function Not Allowed'.
	When User gets attribute "visible" value of "LLPlayerAward.lblFunctionNotAllowed" element to save with key "Alertmessagevisibility"
	When User performs string operation "stringEquals" of provided value "<$Alertmessagevisibility$>" with "true"
	When User gets attribute "Name" value of "LLPlayerAward.lblFunctionNotAllowed" element to save with key "AlertMessage"
	When User performs string operation "stringEquals" of provided value "<$AlertMessage$>" with "<Message>"
	Given User closes application
	Examples: 
	| AccountStatus   | PlayerID           | Message                                                                |
	| Excluded Player | <#ExcludedPlayer#> | Action restricted for patron. Exclusion Plan 'DAP' assigned to patron. |

Scenario: 013-Close all Instance of Mass Importer desktop application.
	When User switch to window application "ATI.Loyalty.MassImporter.exe"
	Given User closes application	

Scenario: 014-Close all instance of Loyalty Lite Desktop application.
	When User switch to window application "ATI.Loyalty.Lite.Client.exe"
	Given User closes application
	
	

	
	
	