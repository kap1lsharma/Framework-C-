@Sequential@Release_15.0@Group_PrivateOffer@ModifyOffer@Web
Feature: OL_ModifyOffer_PrivateOffer
#******************************************************************************
#**  Feature File                 : OL_ModifyOffer_PrivateOffer
#**  Feature Name                 : Modify Offer > Private Offer - MANAGEPRIVATEOFFER permission impact on Modify offer page with respect to private offer.
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 587352


#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  04/22/2022     Sahil Thakur               Initial Draft
#********************************************************************************/

Scenario: 001-Remove MANAGEPRIVATEOFFER Permission from UC_TechServices user group.
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "MANAGEPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Validating the Permission Category and Description.
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lnk_PermissionDetailAll" is present "true" on UI with parameters
	| Key             | Value                                                                                          |
	| PermissionName  | MANAGEPRIVATEOFFER                                                                             |
	| Category        | Offer Management                                                                               |
	| Description     | ALLOW A USER TO MANUALLY CREATE, EDIT, ACTIVATE, INACTIVATE, SEARCH/VIEW PRIVATE OFFERS        |
	#Removing permission from UC_TechServices user group.
	When User waits "2" seconds
	Then User "unchecks" element "OLW_USER_GROUP_PERMISSION.lnk_PermissionDetails" with parameters
	| Key            | Value                        |
	| permissionname | MANAGEPRIVATEOFFER			|	
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	When User waits "1" seconds
	#Validating the permission removed successfully.
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI

Scenario: 002- After removing MANAGEPRIVATEOFFER permission from UC_TechServices user group, check Private offer and Private Checkbox unavailability on Modify Offer page. (TC 587352)
    When User runs query "Select OfferCode from OFR.UC_X_OfferMaster where OfferName='<#OfferName#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PrivateOfferCode"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Manage Campaign" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.Campaign_Manage"
	When User waits "2" seconds
	#Searching for campaign having regular as well as private offer.
	Given User enters text "<#CampaignName#>" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
	| Key      | Value		      |
	| Campaign | <#CampaignName#> |
	Given User clicks on "ltyCampaign_Manage.btn_ModifyOffer"
	When User waits "2" seconds
	#Validating Private Offer is not displayed on modify Offer page.
	Then User verifies that element "OLW_MODIFY_OFFER.lnk_ModifyOffer" is present "false" on UI with parameters
	| Key           | Value                |
	| OfferCode     | <$PrivateOfferCode$> |
	| OfferName     | <#OfferName#>        |
	| OfferType     | <#OfferType#>        |
	| OfferSubType  | <#OfferSubType#>     |
	| ValidFromDate | <#ValidFromDate#>    |
	| ValidToDate   | <#ValidToDate#>      |
	| SegmentName   | <#SegmentName#>      |
	When User waits "2" seconds
	Then User verifies that element "OLW_MODIFY_OFFER.chk_Private" is present "false" on UI
	When User waits "2" seconds

Scenario: 003-Add MANAGEPRIVATEOFFER Permission to UC_TechServices user group.
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "MANAGEPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Adding MANAGEPRIVATEOFFER permission to UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                        |
	| permissionname | MANAGEPRIVATEOFFER			|	
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	When User waits "1" seconds
	#Validating the permission is added successfully.
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI

Scenario: 004- After adding MANAGEPRIVATEOFFER permission to UC_TechServices user group, check Private offer and Private Checkbox availability on Modify Offer page.(TC 587352)
    When User runs query "Select OfferCode from OFR.UC_X_OfferMaster where OfferName='<#OfferName#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PrivateOfferCode"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Manage Campaign" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "lylMAIN_NAV_BOX.Campaign_Manage"
	When User waits "2" seconds
	#Searching for campaign having regular as well as private offer.
	Given User enters text "<#CampaignName#>" in "ltyCampaign_Manage.SearchFilter_CampaignName"
	Given User clicks on "ltyCampaign_Manage.btn_Search_Campaign"
	Given User clicks on "ltyCampaign_Manage.tbl_Campaign_List" with parameters
	| Key      | Value			      |
	| Campaign | <#CampaignName#>     |
	Given User clicks on "ltyCampaign_Manage.btn_ModifyOffer"
	When User waits "2" seconds
	#Validating Private Offer is displayed on modify Offer page.
	Then User verifies that element "OLW_MODIFY_OFFER.lnk_ModifyOffer" is present "true" on UI with parameters
	| Key           | Value                |
	| OfferCode     | <$PrivateOfferCode$> |
	| OfferName     | <#OfferName#>        |
	| OfferType     | <#OfferType#>        |
	| OfferSubType  | <#OfferSubType#>     |
	| ValidFromDate | <#ValidFromDate#>    |
	| ValidToDate   | <#ValidToDate#>      |
	| SegmentName   | <#SegmentName#>      |
	When User waits "2" seconds
	#Validating the Private checkbox displaying on Modify Offer Page.
	Then User verifies that element "OLW_MODIFY_OFFER.chk_Private" is present "true" on UI
	When User waits "2" seconds