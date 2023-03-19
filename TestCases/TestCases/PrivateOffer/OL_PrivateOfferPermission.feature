@Release_15.0@Group_PrivateOffer@Desktop
Feature: OL_PrivateOfferPermission
#******************************************************************************
#**  Feature File                 : OL_PrivateOfferPermission.feature
#**  Feature Name                 : Private Offer Permission and different validation.
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 582157,582165,582166,582171
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  06/13/2022     Jogendra Singh            Initial Draft
#********************************************************************************/
#
#/*************************************************************************

Scenario: 001-Validate Permission PRIVATEOFFERUPLOAD added under 'Offer Import' category of Group permission.(TC 582157)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "PRIVATEOFFERUPLOAD " in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Verification of permission , it's category and description
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lnk_PermissionDetailAll" is present "true" on UI with parameters
	| Key            | Value                                                                 |
	| PermissionName | PRIVATEOFFERUPLOAD                                                    |
	| Category       | Offer import                                                          |
	| Description    | ALLOW A USER TO UPLOAD PRIVATE OFFERS USING THE OFFER IMPORT UTILITY. |
	When User waits "2" seconds
	#assign ASSIGNBULKPRIVATEOFFER permission from UC_TechServices user group.
	Then User "unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value              |
	| permissionname | PRIVATEOFFERUPLOAD |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario Outline: 002-Verify that error is received when user tries to upload the sheet and does not have the PRIVATEOFFERUPLOAD Permission.
	When User generates a "randomnumeric" with "5" for key "CampaignID"
	When User generates a "UniqueString" with "AutoCamp_:4" for key "CampaignName"
	When User generates a "randomalphanumeric" with "6" for key "CampaignCode"
	When User generates a "UniqueString" with "OfferUpload_:5" for key "OfferuploadExcel"
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate" 
    When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "120" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	When User "creates" excel file "<$OfferuploadExcel$>" with sheet "Campaigns" in "xls" format with data
	| Campaign #     | Campaign Name    | Campaign Code    | Status | Program Type         | Program Subtype         | Start Date     | Start Time  | Visible Before Days | End Date    | End Time    | Reminder Type | Distribution Channel | Budget Allocated | Estimated Revenue | Overhead Per Day | Print Per Piece | Postage Per Piece | Gaming Tax Rate | Miscellaneous Costs | Notes           |
	| <$CampaignID$> | <$CampaignName$> | <$CampaignCode$> | Active | <#Reg_Program_Type#> | <#Reg_ProgramSub_Type#> | <$currendate$> | 12:00:00 AM | 1                   | <$enddate$> | 12:00:00 AM | Email         | Email                | 200000           | 20000             | 100              | 10              | 10                | 1               | 1                   | Automation ABDT |
	When User generates a "UniqueString" with "Autoseg_:4" for key "SegmentName"
	When User generates a "UniqueString" with "Autoseg_:4" for key "SegmentName1"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segments" in "xls" format with data
	| Segment Name     | Status | Associated Campaign # |
	| <$SegmentName$>  | Active | <$CampaignID$>        |
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName"
	When User generates a "randomnumeric" with "6" for key "OfferID"
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName1"
	When User generates a "randomnumeric" with "6" for key "OfferID1"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offers" in "xls" format with data
	| Offer #     | Offer Name    | Property/Property Group | Offer Type         | Sub Type             | Value | Valid From Date | Valid From Time | Visible Before Days | Valid To Date | Valid to Time | Valid Days | Printable | Reservable | Paritally Redeemable | Description | Alternate Description | Disclaimer               | Distribution Channel | Billing Department | Expiration Date | Expiration Time | Expiry Days/Hours | Expiry Type (D/H) | General Offer | Event | Max Guest | ResNet Code | Yield Rank | Entries | Mystery Prize | Sweepstakes | Require Offer Redemption | Days to Expire | Days to Qualify | Play Amount | Get Amount | Increment | Associate Players | BCO Program | Friendly Name | Friendly Date | Friendly Description | Posting Date | Final Date | BCO Disclaimer | Booking Type | Booking Phone # | Booking Phone Ext | Bar Code | Print from BCO | Display at BCO | Online Only | Revenue Center Group Mapping | Event Code | General Offer Barcode | Is Kiosk | Is Private |
	| <$OfferID$> | <$OfferName$> | <$PropertyName$>        | <#Reg_Offer_Type#> | <#Reg_OfferSubType#> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <#Reg_OfferDisclaimers#> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | Y          |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segment to Offer" in "xls" format with data
	| Segment          | Associated Offers | Segment Name     |
	| <$SegmentName$>  | <$OfferID$>       | <$SegmentName$>  |
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
	When User gets attribute "Name" value of "OLIU_UploadSrc.lbl_preuploaderror" element to save with key "ErrorHeader"
	When User performs string operation "stringEquals" of provided value "<$ErrorHeader$>" with "Pre Upload Errors"
	When User gets attribute "Name" value of "OLIU_UploadSrc.lbl_uploadErrorMessage" element to save with key "ErrorMessage"
	When User performs string operation "stringcontains" of provided value "<$ErrorMessage$>" with "<Message>"
	Given User closes application
Examples:
	| UploadType   | Message                                                |
	| Offer Upload | User does not have permission to upload private offer. |

Scenario: 003-Check PRIVATEAWARDUPLOAD Permission.(TC 582157)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "PRIVATEOFFERUPLOAD " in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#assign ASSIGNBULKPRIVATEOFFER permission from UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value              |
	| permissionname | PRIVATEOFFERUPLOAD |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario Outline: 004-Verify that error is received when user tries to upload the existing sheet without renaming.(TC 582165)
	When User generates a "randomnumeric" with "5" for key "CampaignID"
	When User generates a "UniqueString" with "AutoCamp_:4" for key "CampaignName"
	When User generates a "randomalphanumeric" with "6" for key "CampaignCode"
	When User generates a "UniqueString" with "OfferUpload_:5" for key "OfferuploadExcel"
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate" 
    When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "120" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	When User "creates" excel file "<$OfferuploadExcel$>" with sheet "Campaigns" in "xls" format with data
	| Campaign #     | Campaign Name    | Campaign Code    | Status | Program Type         | Program Subtype         | Start Date     | Start Time  | Visible Before Days | End Date    | End Time    | Reminder Type | Distribution Channel | Budget Allocated | Estimated Revenue | Overhead Per Day | Print Per Piece | Postage Per Piece | Gaming Tax Rate | Miscellaneous Costs | Notes           |
	| <$CampaignID$> | <$CampaignName$> | <$CampaignCode$> | Active | <#Reg_Program_Type#> | <#Reg_ProgramSub_Type#> | <$currendate$> | 12:00:00 AM | 1                   | <$enddate$> | 12:00:00 AM | Email         | Email                | 200000           | 20000             | 100              | 10              | 10                | 1               | 1                   | Automation ABDT |
	When User generates a "UniqueString" with "Autoseg_:4" for key "SegmentName"
	When User generates a "UniqueString" with "Autoseg_:4" for key "SegmentName1"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segments" in "xls" format with data
	| Segment Name     | Status | Associated Campaign # |
	| <$SegmentName$>  | Active | <$CampaignID$>        |
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName"
	When User generates a "randomnumeric" with "6" for key "OfferID"
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName1"
	When User generates a "randomnumeric" with "6" for key "OfferID1"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offers" in "xls" format with data
	| Offer #     | Offer Name    | Property/Property Group | Offer Type         | Sub Type             | Value | Valid From Date | Valid From Time | Visible Before Days | Valid To Date | Valid to Time | Valid Days | Printable | Reservable | Paritally Redeemable | Description | Alternate Description | Disclaimer               | Distribution Channel | Billing Department | Expiration Date | Expiration Time | Expiry Days/Hours | Expiry Type (D/H) | General Offer | Event | Max Guest | ResNet Code | Yield Rank | Entries | Mystery Prize | Sweepstakes | Require Offer Redemption | Days to Expire | Days to Qualify | Play Amount | Get Amount | Increment | Associate Players | BCO Program | Friendly Name | Friendly Date | Friendly Description | Posting Date | Final Date | BCO Disclaimer | Booking Type | Booking Phone # | Booking Phone Ext | Bar Code | Print from BCO | Display at BCO | Online Only | Revenue Center Group Mapping | Event Code | General Offer Barcode | Is Kiosk | Is Private |
	| <$OfferID$> | <$OfferName$> | <$PropertyName$>        | <#Reg_Offer_Type#> | <#Reg_OfferSubType#> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <#Reg_OfferDisclaimers#> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | Y          |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segment to Offer" in "xls" format with data
	| Segment          | Associated Offers | Segment Name     |
	| <$SegmentName$>  | <$OfferID$>       | <$SegmentName$>  |
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
	When User waits "4" seconds
	Given User closes application
	#Uploading same file again.
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
	When User waits "2" seconds
	Given User clicks on "OLIU_UploadSrc.btn_uploadButtonNext"
	When User waits "2" seconds
	#Validating the Error Message Presense.
	When User gets attribute "Name" value of "OLIU_UploadSrc.lbl_txtmessage_fileused" element to save with key "ErrorMessage"
	When User performs string operation "stringEquals" of provided value "<$ErrorMessage$>" with "<Message>"
	Given User closes application
	Examples:
	| UploadType   | Message                                                                                            |  
	| Offer Upload | Please select another file, <$testbaseLocation4$><$OfferuploadExcel$>.xls has been used previously |

Scenario Outline: 005-Verify Template for offers uploaded through Offer Import Utility, will have an additional column as 'Is Private'.
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
	When User waits "4" seconds
	Given User clicks on "OLIU_UploadSrc.btn_DownloadSample"
	When User waits "4" seconds
	Given User clicks on "OLIU_UploadSrc.btn_save_browsewindow"
	When User waits "2" seconds
	Given User closes application
	When User saves value of "GetTestDatalocation" with key "testbaseLocation"
	When User reads cell value on "0" row and "57" column of file "offerupload.xlsx" and save into key "ColumnHeader"
	When User performs string operation "stringEquals" of provided value "<$ColumnHeader$>" with "<Column>"	
	Examples:
	| UploadType   | Column     |
	| Offer Upload | Is Private |

Scenario Outline: 006-Verify multiple Input type for new Column 'Is Private' during Upload of file into Offer Import Utility.(TC 582171)
	When User generates a "randomnumeric" with "5" for key "CampaignID"
	When User generates a "UniqueString" with "AutoCamp_:4" for key "CampaignName"
	When User generates a "randomalphanumeric" with "6" for key "CampaignCode"
	When User generates a "UniqueString" with "OfferUpload_:5" for key "OfferuploadExcel"
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User generates a "getDate" with "MM/dd/yyyy" for key "currendate" 
    When User performs action "adddays" of "1" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "startdate"
	When User performs action "adddays" of "120" on dateTime "<$currendate$>" with format "MM/dd/yyyy" to save the result for key "enddate"
	When User "creates" excel file "<$OfferuploadExcel$>" with sheet "Campaigns" in "xls" format with data
	| Campaign #     | Campaign Name    | Campaign Code    | Status | Program Type         | Program Subtype         | Start Date     | Start Time  | Visible Before Days | End Date    | End Time    | Reminder Type | Distribution Channel | Budget Allocated | Estimated Revenue | Overhead Per Day | Print Per Piece | Postage Per Piece | Gaming Tax Rate | Miscellaneous Costs | Notes           |
	| <$CampaignID$> | <$CampaignName$> | <$CampaignCode$> | Active | <#Reg_Program_Type#> | <#Reg_ProgramSub_Type#> | <$currendate$> | 12:00:00 AM | 1                   | <$enddate$> | 12:00:00 AM | Email         | Email                | 200000           | 20000             | 100              | 10              | 10                | 1               | 1                   | Automation ABDT |
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
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName2"
	When User generates a "randomnumeric" with "6" for key "OfferID2"
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName3"
	When User generates a "randomnumeric" with "6" for key "OfferID3"
	When User generates a "UniqueString" with "AutoOffer_:4" for key "OfferName4"
	When User generates a "randomnumeric" with "6" for key "OfferID4"
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Offers" in "xls" format with data
	| Offer #      | Offer Name     | Property/Property Group | Offer Type         | Sub Type             | Value | Valid From Date | Valid From Time | Visible Before Days | Valid To Date | Valid to Time | Valid Days | Printable | Reservable | Paritally Redeemable | Description | Alternate Description | Disclaimer               | Distribution Channel | Billing Department | Expiration Date | Expiration Time | Expiry Days/Hours | Expiry Type (D/H) | General Offer | Event | Max Guest | ResNet Code | Yield Rank | Entries | Mystery Prize | Sweepstakes | Require Offer Redemption | Days to Expire | Days to Qualify | Play Amount | Get Amount | Increment | Associate Players | BCO Program | Friendly Name | Friendly Date | Friendly Description | Posting Date | Final Date | BCO Disclaimer | Booking Type | Booking Phone # | Booking Phone Ext | Bar Code | Print from BCO | Display at BCO | Online Only | Revenue Center Group Mapping | Event Code | General Offer Barcode | Is Kiosk | Is Private |
	| <$OfferID$>  | <$OfferName$>  | <$PropertyName$>        | <#Reg_Offer_Type#> | <#Reg_OfferSubType#> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <#Reg_OfferDisclaimers#> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | Y          |
	| <$OfferID1$> | <$OfferName1$> | <$PropertyName$>        | <#Reg_Offer_Type#> | <#Reg_OfferSubType#> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <#Reg_OfferDisclaimers#> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | N          |
	| <$OfferID2$> | <$OfferName2$> | <$PropertyName$>        | <#Reg_Offer_Type#> | <#Reg_OfferSubType#> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <#Reg_OfferDisclaimers#> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | NA         |
	| <$OfferID3$> | <$OfferName3$> | <$PropertyName$>        | <#Reg_Offer_Type#> | <#Reg_OfferSubType#> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <#Reg_OfferDisclaimers#> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | ABC        |
	| <$OfferID4$> | <$OfferName4$> | <$PropertyName$>        | <#Reg_Offer_Type#> | <#Reg_OfferSubType#> | 10    | <$startdate$>   | 12:00:00 AM     | 1                   | <$enddate$>   | 12:00:00 AM   | 55         | Y         | Y          | Y                    |             |                       | <#Reg_OfferDisclaimers#> | Email                | MSD                |                 |                 |                   |                   |               |       |           |             |            |         |               |             |                          |                |                 | 10          |            |           |                   |             |               |               |                      |              |            |                |              |                 |                   |          |                |                |             |                              |            |                       | N        | NA/ABC     |
	When User "updates" excel file "<$OfferuploadExcel$>" with sheet "Segment to Offer" in "xls" format with data
	| Segment          | Associated Offers | Segment Name     |
	| <$SegmentName$>  | <$OfferID$>       | <$SegmentName$>  |
	| <$SegmentName1$> | <$OfferID1$>      | <$SegmentName1$> |
	| <$SegmentName1$> | <$OfferID2$>      | <$SegmentName1$> |
	| <$SegmentName1$> | <$OfferID3$>      | <$SegmentName1$> |
	| <$SegmentName1$> | <$OfferID4$>      | <$SegmentName1$> |
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
	When User waits "2" seconds
	Given User closes application
	Examples:
	| UploadType   |
	| Offer Upload |

Scenario Template: 007-Verify created Offer on to WebApp.(TC 582171)
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Manage Campaign" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.Campaign_Manage"
	Then User verifies text - "Campaign Management" is present on page
	#Search uploaded campaign
	Given User enters text "<$CampaignName$>" in "ltyCampaign_Manage.SearchFilter_CampaignName"
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
	Given User enters text "<SegmentName>" in "ltyManage_Segment.Filter_Segment_Name"
	Given User clicks on "ltyManage_Segment.btn_Search"
	Then User verifies that element "ltyManage_Segment.tbl_Segment_List" is present "true" on UI with parameters
	| Key         | Value         |
	| SegmentName | <SegmentName> |
	Given User clicks on "ltyManage_Segment.tbl_Segment_List" with parameters
	| Key         | Value         |
	| SegmentName | <SegmentName> |
	#Verify Uploaded Offer 
	Given User clicks on "ltyManage_Segment.btn_View_Offers"
	Then User verifies that element "ltyMaster_Offers.tbl_Master_Offers_List" is present "true" on UI with parameters
	| Key   | Value       |
	| offer | <offerName> |
	Given User clicks on "ltyMaster_Offers.tbl_Master_Offers_List" with parameters
	| Key   | Value       |
	| offer | <offerName> |
	When User waits "2" seconds
	Given User clicks on "ltyMaster_Offers.btn_view"
	When User waits "2" seconds
	Then User verifies attribute "<attribute>" value "<PrivateCheckbox>" of element "ltyMaster_Offers.chk_Private"
Examples: 
| SegmentName      | offerName      | PrivateCheckbox | attribute |
| <$SegmentName$>  | <$OfferName$>  | true            | checked   |
| <$SegmentName1$> | <$OfferName1$> | false           | selected  |
| <$SegmentName1$> | <$OfferName2$> | false           | selected  |
| <$SegmentName1$> | <$OfferName3$> | false           | selected  |
| <$SegmentName1$> | <$OfferName4$> | false           | selected  |

Scenario: 008-Close all instance of Desktop Application
	When User switch to window application "ATI.Loyalty.OfferImport.exe"
	Given User closes application

