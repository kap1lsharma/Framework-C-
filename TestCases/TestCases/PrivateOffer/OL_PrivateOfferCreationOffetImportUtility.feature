@Release_15.0@Group_PrivateOffer@OfferImportUtility@Desktop
Feature: OL_PrivateOfferCreationOffetImportUtility

#******************************************************************************
#**  Feature File                 : OL_PrivateOfferCreationOffetImportUtility.feature
#**  Feature Name                 : Private Offer Creation and assignmen to Player through Offer Import.
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 585138,585276,582172,582215
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  05/27/2022     Jogendra Singh            Initial Draft
#********************************************************************************/
#
#/*************************************************************************

Scenario: 001-Create Program Type and SubType
	# Create new Program Type
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "AutoProgram:4" for key "programType"
	When User generates a "UniqueString" with "AutoSubProgram:4" for key "programSubType"
	Given User enters text "Manage Offer Programs" in "main_nav_box.eb_menusearch"
	When User waits "2" seconds
	When User scrolls till element "lylMAIN_NAV_BOX.mnu_Manage_offer_program"
	Given User clicks on "lylMAIN_NAV_BOX.mnu_Manage_offer_program"
	Given User clicks on "lylOffer_ProgramType.btn_Add_Program_Type"
	Given User enters text "^$programType$^" in "lylOffer_ProgramType.txt_ProgramType_Name"
	Given User clicks on "lylOffer_ProgramType.btnSave"
	Then User verifies attribute "text" value "Record inserted successfully" of element "lylOffer_ProgramType.lbl_ProgramType/Subtype_SuccessMsg"
	# Search above Created Program Type
	Given User clears "lylOffer_ProgramType.txt_Search_Box"
	Given User enters text "^$programType$^" in "lylOffer_ProgramType.txt_Search_Box"
	When User pressed key "enter"
	Given User selects option "^$programType$^" of element "lylOffer_ProgramType.mnu_OfferProgramFilter" by "visibletext"
	When User waits "2" seconds
	# Create new  SubType
	Given User clicks on "lylOffer_ProgramType.btn_Add_Subtypes"
	Given User enters text "<$programSubType$>" in "lylOffer_ProgramType.Subtype_Name"
	Given User clicks on "lylOffer_ProgramType.btn_Save_Subtypes"
	Then User verifies that element "lylOffer_ProgramType.tbl_SubType_Filter" is present "true" on UI with parameters
		| Key         | Value              |
		| SubTypeName | <$programSubType$> |
	Given User clicks on "lylOffer_ProgramType.tbl_SubType_Filter" with parameters
		| Key         | Value              |
		| SubTypeName | <$programSubType$> |
	Given User clicks on "lylOffer_ProgramType.btnSave"
	Then User verifies attribute "text" value "Record updated successfully" of element "lylOffer_ProgramType.lbl_ProgramType/Subtype_SuccessMsg"

Scenario:002- Create Offer Type and SubType
	# Create Offer Type
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "Private_Food_Offer:4" for key "Offer_Type"
	When User generates a "UniqueString" with "C:1" for key "Offer_Code"
	When User generates a "UniqueString" with "Auto_Food:4" for key "OfferSubType_Type"
	When User generates a "UniqueString" with "1" for key "OfferSubType_Code"
	Given User enters text "Manage Offer Type" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.mnu_Manage_Offer_type"
	Given User clicks on "lylOffer_Types.btnAdd_Offer_Type"
	Given User enters text "^$Offer_Type$^" in "lylOffer_Types.txt_Offertype_Name"
	When User waits "2" seconds
	Given User clears "lylOffer_Types.txt_Offer_Code"
	Given User enters text "^$Offer_Code$^" in "lylOffer_Types.txt_Offer_Code"
	When User waits "2" seconds
	Given User clicks on "lylOffer_Types.btn_Save_Offer_Type"
	When User waits "2" seconds
	Then User verifies attribute "text" value "Record inserted successfully" of element "lylOffer_Types.lbl_ErrorMessage"
	#Search above Created Offer Type
	Given User clears "lylOffer_Types.txt_Search_OfferType"
	Given User enters text "^$Offer_Type$^" in "lylOffer_Types.txt_Search_OfferType"
	When User pressed key "enter"
	When User waits "2" seconds
	Then User verifies that element "lylOffer_Types.Drop_OfferTypeValue" is present "true" on UI with parameters
		| Key       | Value          |
		| OfferType | ^$Offer_Type$^ |
	Given User clicks on "lylOffer_Types.Drop_OfferTypeValue" with parameters
		| Key       | Value          |
		| OfferType | ^$Offer_Type$^ |
	#Create Offer SubType
	Given User clicks on "lylOffer_Types.btn_Add_OfferSubtypes"
	Given User enters text "^$OfferSubType_Type$^" in "lylOffer_Types.txtOfferSubtype_Name"
	Given User enters text "^$OfferSubType_Code$^" in "lylOffer_Types.txt_Subtypes_Code"
	Given User clicks on "lylOffer_Types.btnSave_Subtypes"
	When User waits "3" seconds
	Then User verifies that element "lylOffer_Types.Table_SubType_Row" is present "true" on UI with parameters
		| Key         | Value                 |
		| SubtypeName | ^$OfferSubType_Type$^ |
		| SubtypeCode | ^$OfferSubType_Code$^ |
	Given User clicks on "lylOffer_Types.Table_SubType_Row" with parameters
		| Key         | Value                 |
		| SubtypeName | ^$OfferSubType_Type$^ |
		| SubtypeCode | ^$OfferSubType_Code$^ |
	Given User clicks on "lylOffer_Types.btn_Save_Offer_Type"
	When User waits "2" seconds
	Then User verifies attribute "text" value "Record updated successfully" of element "lylOffer_Types.lbl_ErrorMessage"

#Create Offer Disclaimer
Scenario:003 : Create Offer Disclaimer
	When User runs query "select P.PropertyName from UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "Auto_Disclaimer:2" for key "Disclaimer_Name"
	Given User enters text "Offer Disclaimer" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.Offer_Disclaimer"
	Then User verifies text - "Offer Disclaimers" is present on page
	Given User clicks on "lylOFFERDISCLAIMERS.btnADDDISCLAIMER"
	Given User enters text "^$Disclaimer_Name$^" in "lylOFFERDISCLAIMERS.txtDIsclaimerName"
	Given User clicks on "lylOFFERDISCLAIMERS.Dropdown_OfferType"
	Given User selects option "^$Offer_Type$^" of element "lylOFFERDISCLAIMERS.Dropdown_OfferType" by "visibletext"
	When User waits "2" seconds
	Given User clicks on "lylOFFERDISCLAIMERS.Offer_Sub_type"
	When User waits "2" seconds
	Then User verifies that element "lylOFFERDISCLAIMERS.OfferSubType_DropDownList" is present "true" on UI with parameters
		| Key              | Value                 |
		| OfferSubTypeName | ^$OfferSubType_Type$^ |
	Given User clicks on "lylOFFERDISCLAIMERS.OfferSubType_DropDownList" with parameters
		| Key              | Value                 |
		| OfferSubTypeName | ^$OfferSubType_Type$^ |
	Given User clicks on "lylOFFERDISCLAIMERS.Property_Name"
	When User waits "2" seconds
	Then User verifies that element "lylOFFERDISCLAIMERS.DropDown_PropertyList" is present "true" on UI with parameters
		| Key      | Value            |
		| Property | <$PropertyName$> |
	Given User clicks on "lylOFFERDISCLAIMERS.DropDown_PropertyList" with parameters
		| Key      | Value            |
		| Property | <$PropertyName$> |
	Given User selects option "OfferCode" of element "lylOFFERDISCLAIMERS.Offer_Disclaimer_dropdown" by "visibletext"
	Given User clicks on "lylOFFERDISCLAIMERS.btn_Disclaimer_Submit"
	When User waits "2" seconds
	Given User clicks on "lylOFFERDISCLAIMERS.btn_Save_DIsclaimer"
	Then User verifies attribute "text" value "Record inserted successfully" of element "lylOFFERDISCLAIMERS.lbl_ErrorMessage"

#Creating Player for test data
Scenario Outline: 004-Enroll Player using WebApp
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

# Creating Excel for Uploading campaign, Segment , Offer, Player Offer
Scenario: 005-Create and Update Player Offer Excel
	When User generates a "randomnumeric" with "5" for key "CampaignID"
	When User generates a "UniqueString" with "AutoCamp_:4" for key "CampaignName"
	When User generates a "randomalphanumeric" with "6" for key "CampaignCode"
	When User generates a "UniqueString" with "OfferUpload_:5" for key "OfferuploadExcel"
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate" 
    When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "120" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	When User "creates" excel file "<$OfferuploadExcel$>" with sheet "Campaigns" in "xls" format with data
	| Campaign #     | Campaign Name    | Campaign Code    | Status | Program Type    | Program Subtype    | Start Date     | Start Time  | Visible Before Days | End Date    | End Time    | Reminder Type | Distribution Channel | Budget Allocated | Estimated Revenue | Overhead Per Day | Print Per Piece | Postage Per Piece | Gaming Tax Rate | Miscellaneous Costs | Notes           |
	| <$CampaignID$> | <$CampaignName$> | <$CampaignCode$> | Active | <$programType$> | <$programSubType$> | <$currendate$> | 12:00:00 AM | 1                   | <$enddate$> | 12:00:00 AM | Email         | Email                | 200000           | 20000             | 100              | 10              | 10                | 1               | 1                   | Automation ABDT |
	When User generates a "UniqueString" with "Autoseg_:4" for key "SegmentName"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segments" in "xls" format with data
	| Segment Name    | Status | Associated Campaign # |
	| <$SegmentName$> | Active | <$CampaignID$>        |
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName"
	When User generates a "randomnumeric" with "6" for key "OfferID"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offers" in "xls" format with data
	| Offer #     | Offer Name    | Property/Property Group | Offer Type     | Sub Type              | Value | Valid From Date | Valid From Time | Visible Before Days | Valid To Date | Valid to Time | Valid Days | Printable | Reservable | Paritally Redeemable | Description | Alternate Description | Disclaimer          | Distribution Channel | Billing Department | Expiration Date | Expiration Time | Expiry Days/Hours | Expiry Type (D/H) | General Offer | Event | Max Guest | ResNet Code | Yield Rank | Entries | Mystery Prize | Sweepstakes | Require Offer Redemption | Days to Expire | Days to Qualify | Play Amount | Get Amount | Increment | Associate Players | BCO Program | Friendly Name | Friendly Date | Friendly Description | Posting Date | Final Date | BCO Disclaimer | Booking Type | Booking Phone # | Booking Phone Ext | Bar Code | Print from BCO | Display at BCO | Online Only | Revenue Center Group Mapping | Event Code | General Offer Barcode | Is Kiosk | Is Private |
	| <$OfferID$> | <$OfferName$> | <$PropertyName$>        | <$Offer_Type$> | <$OfferSubType_Type$> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <$Disclaimer_Name$> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | Y          |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segment to Offer" in "xls" format with data
	| Segment         | Associated Offers | Segment Name    |
	| <$SegmentName$> | <$OfferID$>       | <$SegmentName$> |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offer Excluded Time Period" in "xls" format with data
	| Excluded Time Period Type | Excluded Time Period Name | Start Date | Start Time | End Date | End Time | Status | Associated Offers |
	|                           |                           |            |            |          |          |        |                   |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Players" in "xls" format with data
	| Segment         | Player ID     | Segment Name    |
	| <$SegmentName$> | <$PLAYER_ID$> | <$SegmentName$> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"

#Validating Offer Import When User group Have Permission.
Scenario: 006-Validate Adding player to Segment having Private Offers when ASSIGNBULKPRIVATEOFFER permission is assigned to LoggedIn user.(TC 585276)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "ASSIGNBULKPRIVATEOFFER " in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Assign ASSIGNBULKPRIVATEOFFER permission from UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                  |
	| permissionname | ASSIGNBULKPRIVATEOFFER |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

# Uploading Excel using offer import Utility. User having the Permission ASSIGNBULKPRIVATEOFFER  Must be able to Upload bulk Offer.
Scenario Outline: 007-Upload Offer excel using Offer Import Utility. (TC 585138)
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Offer Import\ATI.Loyalty.OfferImport.exe"
	Given User enters text "<#Halo_username#>" in "OLIU_LOGIN.txt_user_id"
	Given User enters text "<#Halo_password#>" in "OLIU_LOGIN.txt_Password"
	Given User clicks on "OLIU_LOGIN.mic_DomainName"
	Given User clicks on "OLIU_LOGIN.btn_drp_dwn_select"
	Given User clicks on "OLIU_LOGIN.btn_Submit"
	When User waits "20" seconds
	Given User clicks on "OLIU_UploadSrc.btn_ButtonNext"
	Given User selects option "<UploadType>" of element "OLIU_UploadSrc.mic_UploadType" by "value"
	When User switch to window object "OLIU_UploadSrc.frm_Offer_Import"
	Given User clicks on "OLIU_UploadSrc.btn_Next_Step"
	When User switch to window object "default"
	#Clicking on Browse button.
	When User switch to window object "OLIU_UploadSrc.frm_UploadFile"
	Given User clicks on "OLIU_UploadSrc.btn_BrowseCSVButton"
	When User switch to window object "default"	
	When User waits "2" seconds
	Given User clicks on "OLIU_UploadSrc.txt_FileName_Desktop"
	When User waits "2" seconds
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
	Given User clicks on "OLIU_UploadSrc.btn_finished"
	Given User closes application
	Examples:
	| UploadType   |
	| Offer Upload |

# Validating the Uploaded Campaign,Segment,Offer and Player.
Scenario: 008-Verify Created campaign on WebApp. (TC 585138)
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Campaign" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.Campaign_Manage"
	Then User verifies text - "Campaign Management" is present on page
	#Search uploaded campaign
	Given User enters text "^$CampaignName$^" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Then User verifies that element "ltyCampaign_Manage.tbl_Campaign_List" is present "true" on UI with parameters
		| Key      | Value            |
		| Campaign | <$CampaignName$> |
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
		| Key      | Value            |
		| Campaign | <$CampaignName$> |
	When User waits "2" seconds
		When User scrolls till element "ltyCampaign_Manage.btn_View_Segment"
	Given User clicks on "ltyCampaign_Manage.btn_View_Segment"
	When User waits "2" seconds
	#Serach Uploaded segment
	Given User clears "ltyManage_Segment.Filter_Segment_Name"
	Given User enters text "^$SegmentName$^" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
	| Key         | Value           |
	| SegmentName | <$SegmentName$> |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
	| Key         | Value           |
	| SegmentName | <$SegmentName$> |
	#Verify Uploaded Offer 
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.tbl_Master_Offers_List" is present "true" on UI with parameters
	| Key   | Value         |
	| offer | <$OfferName$> |
	Given User clicks on "ltyMaster_Offers.tbl_Master_Offers_List" with parameters
	| Key   | Value         |
	| offer | <$OfferName$> |
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.btn_view"
	When User gets attribute "Value" value of "ltyMaster_Offers.txt_Offer_Name" element to save with key "Offernamevalueattr"
	When User performs string operation "stringEquals" of provided value "<$Offernamevalueattr$>" with "<$OfferName$>"
	Given User clicks on "ltyMaster_Offers.SegmentName_Breadcrumb_Link" with parameters
	| Key                    | Value           |
	| SegmentName_Breadcrumb | <$SegmentName$> |
	When User waits "2" seconds
	# Verify Assigned Player to Segment.
	Given User clicks on "ltyManage_Segment.btn_View_Players"
	Given User enters text "<$PLAYER_ID$>" in "ltyManage_Segment.txt_PlayerID_SearchFilter"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.lbl_SegmentPlayer" is present "true" on UI with parameters
    | Key         | Value         |
    | segPlayerid | <$PLAYER_ID$> |

#Validating Offer Import When User group does not have Permission.
Scenario: 009-Validate Permission ASSIGNBULKPRIVATEOFFER added under 'Offer Import' category of Group permission.(585276)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "ASSIGNBULKPRIVATEOFFER " in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Verification of permission , it's category and description
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lnk_PermissionDetailAll" is present "true" on UI with parameters
	| Key            | Value                                                          |
	| PermissionName | ASSIGNBULKPRIVATEOFFER                                         |
	| Category       | Offer import                                                   |
	| Description    | ALLOW A USER TO ASSIGN BULK PRIVATE OFFERS TO PLAYER ACCOUNTS. |
	When User waits "2" seconds
	#assign ASSIGNBULKPRIVATEOFFER permission from UC_TechServices user group.
	Then User "unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                  |
	| permissionname | ASSIGNBULKPRIVATEOFFER |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario: 010-Creating Excel for the User group UC_TechService.
	When User generates a "randomnumeric" with "5" for key "CampaignID"
	When User generates a "UniqueString" with "AutoCamp_:4" for key "CampaignName"
	When User generates a "randomalphanumeric" with "6" for key "CampaignCode"
	When User generates a "UniqueString" with "OfferUpload_:5" for key "OfferuploadExcel"
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate" 
    When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "120" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	When User "creates" excel file "<$OfferuploadExcel$>" with sheet "Campaigns" in "xls" format with data
	| Campaign #     | Campaign Name    | Campaign Code    | Status | Program Type    | Program Subtype    | Start Date     | Start Time  | Visible Before Days | End Date    | End Time    | Reminder Type | Distribution Channel | Budget Allocated | Estimated Revenue | Overhead Per Day | Print Per Piece | Postage Per Piece | Gaming Tax Rate | Miscellaneous Costs | Notes           |
	| <$CampaignID$> | <$CampaignName$> | <$CampaignCode$> | Active | <$programType$> | <$programSubType$> | <$currendate$> | 12:00:00 AM | 1                   | <$enddate$> | 12:00:00 AM | Email         | Email                | 200000           | 20000             | 100              | 10              | 10                | 1               | 1                   | Automation ABDT |
	When User generates a "UniqueString" with "Autoseg_:4" for key "SegmentName"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segments" in "xls" format with data
	| Segment Name    | Status | Associated Campaign # |
	| <$SegmentName$> | Active | <$CampaignID$>        |
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName"
	When User generates a "randomnumeric" with "6" for key "OfferID"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offers" in "xls" format with data
	| Offer #     | Offer Name    | Property/Property Group | Offer Type     | Sub Type              | Value | Valid From Date | Valid From Time | Visible Before Days | Valid To Date | Valid to Time | Valid Days | Printable | Reservable | Paritally Redeemable | Description | Alternate Description | Disclaimer          | Distribution Channel | Billing Department | Expiration Date | Expiration Time | Expiry Days/Hours | Expiry Type (D/H) | General Offer | Event | Max Guest | ResNet Code | Yield Rank | Entries | Mystery Prize | Sweepstakes | Require Offer Redemption | Days to Expire | Days to Qualify | Play Amount | Get Amount | Increment | Associate Players | BCO Program | Friendly Name | Friendly Date | Friendly Description | Posting Date | Final Date | BCO Disclaimer | Booking Type | Booking Phone # | Booking Phone Ext | Bar Code | Print from BCO | Display at BCO | Online Only | Revenue Center Group Mapping | Event Code | General Offer Barcode | Is Kiosk | Is Private |
	| <$OfferID$> | <$OfferName$> | <$PropertyName$>        | <$Offer_Type$> | <$OfferSubType_Type$> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <$Disclaimer_Name$> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | Y          |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segment to Offer" in "xls" format with data
	| Segment         | Associated Offers | Segment Name    |
	| <$SegmentName$> | <$OfferID$>       | <$SegmentName$> |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offer Excluded Time Period" in "xls" format with data
	| Excluded Time Period Type | Excluded Time Period Name | Start Date | Start Time | End Date | End Time | Status | Associated Offers |
	|                           |                           |            |            |          |          |        |                   |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Players" in "xls" format with data
	| Segment         | Player ID     | Segment Name    |
	| <$SegmentName$> | <$PLAYER_ID$> | <$SegmentName$> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation1"

# Upload Offer when user group does not have Permission. 
Scenario Outline: 011-Upload Offer excel using Offer Import Utility. (TC 585276)
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Offer Import\ATI.Loyalty.OfferImport.exe"
	Given User enters text "<#Halo_username_3#>" in "OLIU_LOGIN.txt_user_id"
	Given User enters text "<#Halo_password#>" in "OLIU_LOGIN.txt_Password"
	Given User clicks on "OLIU_LOGIN.mic_DomainName"
	Given User clicks on "OLIU_LOGIN.btn_drp_dwn_select"
	Given User clicks on "OLIU_LOGIN.btn_Submit"
	When User waits "20" seconds
	Given User clicks on "OLIU_UploadSrc.btn_ButtonNext"
	Given User selects option "<UploadType>" of element "OLIU_UploadSrc.mic_UploadType" by "value"
	When User switch to window object "OLIU_UploadSrc.frm_Offer_Import"
	Given User clicks on "OLIU_UploadSrc.btn_Next_Step"
	When User switch to window object "default"
	#Clicking on Browse button.
	When User switch to window object "OLIU_UploadSrc.frm_UploadFile"
	Given User clicks on "OLIU_UploadSrc.btn_BrowseCSVButton"
	When User switch to window object "default"	
	When User waits "2" seconds
	Given User clicks on "OLIU_UploadSrc.txt_FileName_Desktop"
	When User waits "2" seconds
	Given User types text "<$testbaseLocation1$><$OfferuploadExcel$>.xls" in "OLIU_UploadSrc.txt_FileName_Desktop"
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
	| UploadType   | ErrorMessage |
	| Offer Upload | Error Report |

# Creating Excel for the Segment does not have any Offer.
Scenario: 012- Creating Excel for the Segment does not have any Offer.
	When User generates a "randomnumeric" with "5" for key "CampaignID"
	When User generates a "UniqueString" with "AutoCamp_:4" for key "CampaignName"
	When User generates a "randomalphanumeric" with "6" for key "CampaignCode"
	When User generates a "UniqueString" with "OfferUpload_:5" for key "OfferuploadExcel"
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate" 
    When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "120" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	When User "creates" excel file "<$OfferuploadExcel$>" with sheet "Campaigns" in "xls" format with data
	| Campaign #     | Campaign Name    | Campaign Code    | Status | Program Type    | Program Subtype    | Start Date     | Start Time  | Visible Before Days | End Date    | End Time    | Reminder Type | Distribution Channel | Budget Allocated | Estimated Revenue | Overhead Per Day | Print Per Piece | Postage Per Piece | Gaming Tax Rate | Miscellaneous Costs | Notes           |
	| <$CampaignID$> | <$CampaignName$> | <$CampaignCode$> | Active | <$programType$> | <$programSubType$> | <$currendate$> | 12:00:00 AM | 1                   | <$enddate$> | 12:00:00 AM | Email         | Email                | 200000           | 20000             | 100              | 10              | 10                | 1               | 1                   | Automation ABDT |
	When User generates a "UniqueString" with "Autoseg_:4" for key "SegmentName"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segments" in "xls" format with data
	| Segment Name    | Status | Associated Campaign # |
	| <$SegmentName$> | Active | <$CampaignID$>        |
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName"
	When User generates a "randomnumeric" with "6" for key "OfferID"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offers" in "xls" format with data
	| Offer #     | Offer Name    | Property/Property Group | Offer Type     | Sub Type              | Value | Valid From Date | Valid From Time | Visible Before Days | Valid To Date | Valid to Time | Valid Days | Printable | Reservable | Paritally Redeemable | Description | Alternate Description | Disclaimer          | Distribution Channel | Billing Department | Expiration Date | Expiration Time | Expiry Days/Hours | Expiry Type (D/H) | General Offer | Event | Max Guest | ResNet Code | Yield Rank | Entries | Mystery Prize | Sweepstakes | Require Offer Redemption | Days to Expire | Days to Qualify | Play Amount | Get Amount | Increment | Associate Players | BCO Program | Friendly Name | Friendly Date | Friendly Description | Posting Date | Final Date | BCO Disclaimer | Booking Type | Booking Phone # | Booking Phone Ext | Bar Code | Print from BCO | Display at BCO | Online Only | Revenue Center Group Mapping | Event Code | General Offer Barcode | Is Kiosk | Is Private |
	| <$OfferID$> | <$OfferName$> | <$PropertyName$>        | <$Offer_Type$> | <$OfferSubType_Type$> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <$Disclaimer_Name$> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | Y          |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segment to Offer" in "xls" format with data
	| Segment | Associated Offers | Segment Name |
	|         |                   |              |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offer Excluded Time Period" in "xls" format with data
	| Excluded Time Period Type | Excluded Time Period Name | Start Date | Start Time | End Date | End Time | Status | Associated Offers |
	|                           |                           |            |            |          |          |        |                   |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Players" in "xls" format with data
	| Segment         | Player ID      | Segment Name    |
	| <$SegmentName$> | <$PLAYER_ID1$> | <$SegmentName$> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation2"

Scenario Outline: 013-Validate by adding Player in a segment having no existing offers. (TC 585138)
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Offer Import\ATI.Loyalty.OfferImport.exe"
	Given User enters text "<#Halo_username#>" in "OLIU_LOGIN.txt_user_id"
	Given User enters text "<#Halo_password#>" in "OLIU_LOGIN.txt_Password"
	Given User clicks on "OLIU_LOGIN.mic_DomainName"
	Given User clicks on "OLIU_LOGIN.btn_drp_dwn_select"
	Given User clicks on "OLIU_LOGIN.btn_Submit"
	When User waits "20" seconds
	Given User clicks on "OLIU_UploadSrc.btn_ButtonNext"
	Given User selects option "<UploadType>" of element "OLIU_UploadSrc.mic_UploadType" by "value"
	When User switch to window object "OLIU_UploadSrc.frm_Offer_Import"
	Given User clicks on "OLIU_UploadSrc.btn_Next_Step"
	When User switch to window object "default"
	#Clicking on Browse button.
	When User switch to window object "OLIU_UploadSrc.frm_UploadFile"
	Given User clicks on "OLIU_UploadSrc.btn_BrowseCSVButton"
	When User switch to window object "default"	
	When User waits "2" seconds
	Given User clicks on "OLIU_UploadSrc.txt_FileName_Desktop"
	When User waits "2" seconds
	Given User types text "<$testbaseLocation2$><$OfferuploadExcel$>.xls" in "OLIU_UploadSrc.txt_FileName_Desktop"
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
	When User gets attribute "Name" value of "OLIU_UploadSrc.lbl_preuploaderror" element to save with key "ErrorHeader"
	When User performs string operation "stringEquals" of provided value "<$ErrorHeader$>" with "Pre Upload Errors"
	When User gets attribute "Name" value of "OLIU_UploadSrc.lbl_uploadErrorMessage" element to save with key "ErrorMessage"
	When User performs string operation "stringcontains" of provided value "<$ErrorMessage$>" with "Offer Id <$OfferID$> does not belong to any segment"
	Given User closes application
	Examples:
	| UploadType   |
	| Offer Upload |

Scenario: 014-Creating Excel for the Segment having regular Offer.
	When User generates a "randomnumeric" with "5" for key "CampaignID"
	When User generates a "UniqueString" with "AutoCamp_:4" for key "CampaignName"
	When User generates a "randomalphanumeric" with "6" for key "CampaignCode"
	When User generates a "UniqueString" with "OfferUpload_:5" for key "OfferuploadExcel"
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate" 
    When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "120" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	When User "creates" excel file "<$OfferuploadExcel$>" with sheet "Campaigns" in "xls" format with data
	| Campaign #     | Campaign Name    | Campaign Code    | Status | Program Type    | Program Subtype    | Start Date     | Start Time  | Visible Before Days | End Date    | End Time    | Reminder Type | Distribution Channel | Budget Allocated | Estimated Revenue | Overhead Per Day | Print Per Piece | Postage Per Piece | Gaming Tax Rate | Miscellaneous Costs | Notes           |
	| <$CampaignID$> | <$CampaignName$> | <$CampaignCode$> | Active | <$programType$> | <$programSubType$> | <$currendate$> | 12:00:00 AM | 1                   | <$enddate$> | 12:00:00 AM | Email         | Email                | 200000           | 20000             | 100              | 10              | 10                | 1               | 1                   | Automation ABDT |
	When User generates a "UniqueString" with "Autoseg_:4" for key "SegmentName"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segments" in "xls" format with data
	| Segment Name    | Status | Associated Campaign # |
	| <$SegmentName$> | Active | <$CampaignID$>        |
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName"
	When User generates a "randomnumeric" with "6" for key "OfferID"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offers" in "xls" format with data
	| Offer #     | Offer Name    | Property/Property Group | Offer Type     | Sub Type              | Value | Valid From Date | Valid From Time | Visible Before Days | Valid To Date | Valid to Time | Valid Days | Printable | Reservable | Paritally Redeemable | Description | Alternate Description | Disclaimer          | Distribution Channel | Billing Department | Expiration Date | Expiration Time | Expiry Days/Hours | Expiry Type (D/H) | General Offer | Event | Max Guest | ResNet Code | Yield Rank | Entries | Mystery Prize | Sweepstakes | Require Offer Redemption | Days to Expire | Days to Qualify | Play Amount | Get Amount | Increment | Associate Players | BCO Program | Friendly Name | Friendly Date | Friendly Description | Posting Date | Final Date | BCO Disclaimer | Booking Type | Booking Phone # | Booking Phone Ext | Bar Code | Print from BCO | Display at BCO | Online Only | Revenue Center Group Mapping | Event Code | General Offer Barcode | Is Kiosk | Is Private |
	| <$OfferID$> | <$OfferName$> | <$PropertyName$>        | <$Offer_Type$> | <$OfferSubType_Type$> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <$Disclaimer_Name$> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | N          |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segment to Offer" in "xls" format with data
	| Segment         | Associated Offers | Segment Name    |
	| <$SegmentName$> | <$OfferID$>       | <$SegmentName$> |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offer Excluded Time Period" in "xls" format with data
	| Excluded Time Period Type | Excluded Time Period Name | Start Date | Start Time | End Date | End Time | Status | Associated Offers |
	|                           |                           |            |            |          |          |        |                   |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Players" in "xls" format with data
	| Segment         | Player ID      | Segment Name    |
	| <$SegmentName$> | <$PLAYER_ID1$> | <$SegmentName$> |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation3"

Scenario: 015-Validate by adding Player in a segment having Regular offer. (TC 585138)
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Offer Import\ATI.Loyalty.OfferImport.exe"
	Given User enters text "<#Halo_username#>" in "OLIU_LOGIN.txt_user_id"
	Given User enters text "<#Halo_password#>" in "OLIU_LOGIN.txt_Password"
	Given User clicks on "OLIU_LOGIN.mic_DomainName"
	Given User clicks on "OLIU_LOGIN.btn_drp_dwn_select"
	Given User clicks on "OLIU_LOGIN.btn_Submit"
	When User waits "20" seconds
	Given User clicks on "OLIU_UploadSrc.btn_ButtonNext"
	Given User selects option "<UploadType>" of element "OLIU_UploadSrc.mic_UploadType" by "value"
	When User switch to window object "OLIU_UploadSrc.frm_Offer_Import"
	Given User clicks on "OLIU_UploadSrc.btn_Next_Step"
	When User switch to window object "default"
	#Clicking on Browse button.
	When User switch to window object "OLIU_UploadSrc.frm_UploadFile"
	Given User clicks on "OLIU_UploadSrc.btn_BrowseCSVButton"
	When User switch to window object "default"	
	When User waits "2" seconds
	Given User clicks on "OLIU_UploadSrc.txt_FileName_Desktop"
	When User waits "2" seconds
	Given User types text "<$testbaseLocation2$><$OfferuploadExcel$>.xls" in "OLIU_UploadSrc.txt_FileName_Desktop"
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
	Given User clicks on "OLIU_UploadSrc.btn_finished"
	Given User closes application
	Examples:
	| UploadType   |
	| Offer Upload |

#Validate with Different Type of Player Status.
Scenario Outline: 016-Verify that if an archived player is on an Offer Import file, then it is showing an error stating the player is archived. (TC-585138)
	#User Logging in Import Utility Application
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Offer Import\ATI.Loyalty.OfferImport.exe"
	Given User enters text "<#Halo_username#>" in "OLIU_LOGIN.txt_user_id"
	Given User enters text "<#Halo_password#>" in "OLIU_LOGIN.txt_Password"
	Given User clicks on "OLIU_LOGIN.mic_DomainName"
	Given User clicks on "OLIU_LOGIN.btn_drp_dwn_select"
	Given User clicks on "OLIU_LOGIN.btn_Submit"
	When User waits "20" seconds
	Given User clicks on "OLIU_UploadSrc.btn_ButtonNext"
	Given User selects option "<UploadType>" of element "OLIU_UploadSrc.mic_UploadType" by "value"
	When User switch to window object "OLIU_UploadSrc.frm_Offer_Import"
	Given User clicks on "OLIU_UploadSrc.btn_Next_Step"
	When User switch to window object "default"
	#Clicking on Browse button.
	When User switch to window object "OLIU_UploadSrc.frm_UploadFile"
	Given User clicks on "OLIU_UploadSrc.btn_BrowseCSVButton"
	When User switch to window object "default"
	When User generates a "UniqueString" with "OfferUpload_:5" for key "OfferuploadExcel"
	#Creating File Player UPload.
	When User "creates" excel file "<$OfferuploadExcel$>" with sheet "Player Upload" in "xls" format with data
	| Campaign ID    | Segment Name    | Player ID  |
	| <$CampaignID$> | <$SegmentName$> | <PlayerID> |
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
	| Player Status  | PlayerID    | UploadType    | ErrorMessage |
	| DeceasedPlayer | SA000001001 | Player Upload | Error Report |
	| ArchivePlayer  | SA000001008 | Player Upload | Error Report |
	| ExcludedPlayer | SA000001009 | Player Upload | Error Report |
	| MergePlayer    | SA000001010 | Player Upload | Error Report |

# resetting the Permission for UC_TechService user group.
Scenario: 017-Validate Permission ASSIGNBULKPRIVATEOFFER added under 'Offer Import' category of Group permission.(585276)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "ASSIGNBULKPRIVATEOFFER " in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Verification of permission , it's category and description
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lnk_PermissionDetailAll" is present "true" on UI with parameters
	| Key            | Value                                                          |
	| PermissionName | ASSIGNBULKPRIVATEOFFER                                         |
	| Category       | Offer import                                                   |
	| Description    | ALLOW A USER TO ASSIGN BULK PRIVATE OFFERS TO PLAYER ACCOUNTS. |
	When User waits "2" seconds
	#assign ASSIGNBULKPRIVATEOFFER permission from UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                  |
	| permissionname | ASSIGNBULKPRIVATEOFFER |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

#Private and regular offer can be in same campaign in different segment.
Scenario: 018-To Verify Offer upload functionality having Multiple Segments where one segment having Private offers and other segment having Non Private Offers. (TC 582215)
	When User generates a "randomnumeric" with "5" for key "CampaignID"
	When User generates a "UniqueString" with "AutoCamp_:4" for key "CampaignName"
	When User generates a "randomalphanumeric" with "6" for key "CampaignCode"
	When User generates a "UniqueString" with "OfferUpload_:5" for key "OfferuploadExcel"
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate" 
    When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "120" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	When User "creates" excel file "<$OfferuploadExcel$>" with sheet "Campaigns" in "xls" format with data
	| Campaign #     | Campaign Name    | Campaign Code    | Status | Program Type    | Program Subtype    | Start Date     | Start Time  | Visible Before Days | End Date    | End Time    | Reminder Type | Distribution Channel | Budget Allocated | Estimated Revenue | Overhead Per Day | Print Per Piece | Postage Per Piece | Gaming Tax Rate | Miscellaneous Costs | Notes           |
	| <$CampaignID$> | <$CampaignName$> | <$CampaignCode$> | Active | <$programType$> | <$programSubType$> | <$currendate$> | 12:00:00 AM | 1                   | <$enddate$> | 12:00:00 AM | Email         | Email                | 200000           | 20000             | 100              | 10              | 10                | 1               | 1                   | Automation ABDT |
	When User generates a "UniqueString" with "Autoseg_:4" for key "SegmentName"
	When User generates a "UniqueString" with "Autoseg_:4" for key "SegmentName1"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segments" in "xls" format with data
	| Segment Name     | Status | Associated Campaign # |
	| <$SegmentName$>  | Active | <$CampaignID$>        |
	| <$SegmentName1$> | Active | <$CampaignID$>        |
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName"
	When User generates a "randomnumeric" with "6" for key "OfferID"
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName1"
	When User generates a "randomnumeric" with "6" for key "OfferID1"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offers" in "xls" format with data
	| Offer #      | Offer Name     | Property/Property Group | Offer Type     | Sub Type              | Value | Valid From Date | Valid From Time | Visible Before Days | Valid To Date | Valid to Time | Valid Days | Printable | Reservable | Paritally Redeemable | Description | Alternate Description | Disclaimer          | Distribution Channel | Billing Department | Expiration Date | Expiration Time | Expiry Days/Hours | Expiry Type (D/H) | General Offer | Event | Max Guest | ResNet Code | Yield Rank | Entries | Mystery Prize | Sweepstakes | Require Offer Redemption | Days to Expire | Days to Qualify | Play Amount | Get Amount | Increment | Associate Players | BCO Program | Friendly Name | Friendly Date | Friendly Description | Posting Date | Final Date | BCO Disclaimer | Booking Type | Booking Phone # | Booking Phone Ext | Bar Code | Print from BCO | Display at BCO | Online Only | Revenue Center Group Mapping | Event Code | General Offer Barcode | Is Kiosk | Is Private |
	| <$OfferID$>  | <$OfferName$>  | <$PropertyName$>        | <$Offer_Type$> | <$OfferSubType_Type$> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <$Disclaimer_Name$> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | N          |
	| <$OfferID1$> | <$OfferName1$> | <$PropertyName$>        | <$Offer_Type$> | <$OfferSubType_Type$> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <$Disclaimer_Name$> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | Y          |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segment to Offer" in "xls" format with data
	| Segment          | Associated Offers | Segment Name     |
	| <$SegmentName$>  | <$OfferID$>       | <$SegmentName$>  |
	| <$SegmentName1$> | <$OfferID1$>      | <$SegmentName1$> |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offer Excluded Time Period" in "xls" format with data
	| Excluded Time Period Type | Excluded Time Period Name | Start Date | Start Time | End Date | End Time | Status | Associated Offers |
	|                           |                           |            |            |          |          |        |                   |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Players" in "xls" format with data
	| Segment | Player ID | Segment Name |
	|         |           |              |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation4"
	#UPloading Excel file having Regular and Private Offer in different segment.
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Offer Import\ATI.Loyalty.OfferImport.exe"
	Given User enters text "<#Halo_username#>" in "OLIU_LOGIN.txt_user_id"
	Given User enters text "<#Halo_password#>" in "OLIU_LOGIN.txt_Password"
	Given User clicks on "OLIU_LOGIN.mic_DomainName"
	Given User clicks on "OLIU_LOGIN.btn_drp_dwn_select"
	Given User clicks on "OLIU_LOGIN.btn_Submit"
	When User waits "20" seconds
	Given User clicks on "OLIU_UploadSrc.btn_ButtonNext"
	Given User selects option "<UploadType>" of element "OLIU_UploadSrc.mic_UploadType" by "value"
	When User switch to window object "OLIU_UploadSrc.frm_Offer_Import"
	Given User clicks on "OLIU_UploadSrc.btn_Next_Step"
	When User switch to window object "default"
	#Clicking on Browse button.
	When User switch to window object "OLIU_UploadSrc.frm_UploadFile"
	Given User clicks on "OLIU_UploadSrc.btn_BrowseCSVButton"
	When User switch to window object "default"	
	When User waits "2" seconds
	Given User clicks on "OLIU_UploadSrc.txt_FileName_Desktop"
	When User waits "2" seconds
	Given User types text "<$testbaseLocation4$><$OfferuploadExcel$>.xls" in "OLIU_UploadSrc.txt_FileName_Desktop"
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
	Given User clicks on "OLIU_UploadSrc.btn_finished"
	Given User closes application
	Examples:
	| UploadType   |
	| Offer Upload |

#Regular and Private Offer can't be clubbed together.
Scenario: 019-Offer Import Utility - Verify segment cannot contain both Private and regular offers clubbed together. (TC 582172)
	When User generates a "randomnumeric" with "5" for key "CampaignID"
	When User generates a "UniqueString" with "AutoCamp_:4" for key "CampaignName"
	When User generates a "randomalphanumeric" with "6" for key "CampaignCode"
	When User generates a "UniqueString" with "OfferUpload_:5" for key "OfferuploadExcel"
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate" 
    When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "120" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	When User "creates" excel file "<$OfferuploadExcel$>" with sheet "Campaigns" in "xls" format with data
	| Campaign #     | Campaign Name    | Campaign Code    | Status | Program Type    | Program Subtype    | Start Date     | Start Time  | Visible Before Days | End Date    | End Time    | Reminder Type | Distribution Channel | Budget Allocated | Estimated Revenue | Overhead Per Day | Print Per Piece | Postage Per Piece | Gaming Tax Rate | Miscellaneous Costs | Notes           |
	| <$CampaignID$> | <$CampaignName$> | <$CampaignCode$> | Active | <$programType$> | <$programSubType$> | <$currendate$> | 12:00:00 AM | 1                   | <$enddate$> | 12:00:00 AM | Email         | Email                | 200000           | 20000             | 100              | 10              | 10                | 1               | 1                   | Automation ABDT |
	When User generates a "UniqueString" with "Autoseg_:4" for key "SegmentName"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segments" in "xls" format with data
	| Segment Name     | Status | Associated Campaign # |
	| <$SegmentName$>  | Active | <$CampaignID$>        |
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName"
	When User generates a "randomnumeric" with "6" for key "OfferID"
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName1"
	When User generates a "randomnumeric" with "6" for key "OfferID1"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offers" in "xls" format with data
	| Offer #      | Offer Name     | Property/Property Group | Offer Type     | Sub Type              | Value | Valid From Date | Valid From Time | Visible Before Days | Valid To Date | Valid to Time | Valid Days | Printable | Reservable | Paritally Redeemable | Description | Alternate Description | Disclaimer          | Distribution Channel | Billing Department | Expiration Date | Expiration Time | Expiry Days/Hours | Expiry Type (D/H) | General Offer | Event | Max Guest | ResNet Code | Yield Rank | Entries | Mystery Prize | Sweepstakes | Require Offer Redemption | Days to Expire | Days to Qualify | Play Amount | Get Amount | Increment | Associate Players | BCO Program | Friendly Name | Friendly Date | Friendly Description | Posting Date | Final Date | BCO Disclaimer | Booking Type | Booking Phone # | Booking Phone Ext | Bar Code | Print from BCO | Display at BCO | Online Only | Revenue Center Group Mapping | Event Code | General Offer Barcode | Is Kiosk | Is Private |
	| <$OfferID$>  | <$OfferName$>  | <$PropertyName$>        | <$Offer_Type$> | <$OfferSubType_Type$> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <$Disclaimer_Name$> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | N          |
	| <$OfferID1$> | <$OfferName1$> | <$PropertyName$>        | <$Offer_Type$> | <$OfferSubType_Type$> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <$Disclaimer_Name$> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | Y          |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segment to Offer" in "xls" format with data
	| Segment         | Associated Offers | Segment Name    |
	| <$SegmentName$> | <$OfferID$>       | <$SegmentName$> |
	| <$SegmentName$> | <$OfferID1$>      | <$SegmentName$> |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offer Excluded Time Period" in "xls" format with data
	| Excluded Time Period Type | Excluded Time Period Name | Start Date | Start Time | End Date | End Time | Status | Associated Offers |
	|                           |                           |            |            |          |          |        |                   |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Players" in "xls" format with data
	| Segment | Player ID | Segment Name |
	|         |           |              |
	When User saves value of "GetTestDatalocation" with key "testbaseLocation5"
	#UPloading Excel file having Regular and Private Offer in different segment.
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Offer Import\ATI.Loyalty.OfferImport.exe"
	Given User enters text "<#Halo_username#>" in "OLIU_LOGIN.txt_user_id"
	Given User enters text "<#Halo_password#>" in "OLIU_LOGIN.txt_Password"
	Given User clicks on "OLIU_LOGIN.mic_DomainName"
	Given User clicks on "OLIU_LOGIN.btn_drp_dwn_select"
	Given User clicks on "OLIU_LOGIN.btn_Submit"
	When User waits "20" seconds
	Given User clicks on "OLIU_UploadSrc.btn_ButtonNext"
	Given User selects option "<UploadType>" of element "OLIU_UploadSrc.mic_UploadType" by "value"
	When User switch to window object "OLIU_UploadSrc.frm_Offer_Import"
	Given User clicks on "OLIU_UploadSrc.btn_Next_Step"
	When User switch to window object "default"
	#Clicking on Browse button.
	When User switch to window object "OLIU_UploadSrc.frm_UploadFile"
	Given User clicks on "OLIU_UploadSrc.btn_BrowseCSVButton"
	When User switch to window object "default"	
	When User waits "2" seconds
	Given User clicks on "OLIU_UploadSrc.txt_FileName_Desktop"
	When User waits "2" seconds
	Given User types text "<$testbaseLocation5$><$OfferuploadExcel$>.xls" in "OLIU_UploadSrc.txt_FileName_Desktop"
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
	When User gets attribute "Name" value of "OLIU_UploadSrc.lbl_preuploaderror" element to save with key "ErrorHeader"
	When User performs string operation "stringEquals" of provided value "<$ErrorHeader$>" with "Pre Upload Errors"
	When User gets attribute "Name" value of "OLIU_UploadSrc.lbl_uploadErrorMessage" element to save with key "ErrorMessage"
	When User performs string operation "stringcontains" of provided value "<$ErrorMessage$>" with "Private offers can not be clubbed with Non-Private offers in a segment."
	Examples:
	| UploadType   |
	| Offer Upload |

Scenario: 020-Sclose all instance of desktop application
	When User switch to window application "ATI.Loyalty.Lite.Client.exe"
	Given User closes application