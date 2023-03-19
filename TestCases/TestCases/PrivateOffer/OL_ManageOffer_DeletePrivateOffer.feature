@Sequential@Release_15.0@Group_PrivateOffer@ManageOffer_DeletePrivateOffer@Web
Feature: OL_ManageOffer_DeletePrivateOffer
#******************************************************************************
#**  Feature File                 : OL_ManageOffer_DeletePrivateOffer.feature
#**  Feature Name                 : ManageOffer - To check functionality of Delete Offer button for Private Offers based on DELETEPRIVATEOFFER permission.
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 590976

#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  04/22/2022     Sahil Thakur               Initial Draft
#********************************************************************************/
 
Scenario: 001-Removing DELETEPRIVATEOFFER Permission from UC_TechServices user group.
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "DELETEPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Validating the Permission Category and Description.
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lnk_PermissionDetailAll" is present "true" on UI with parameters
	| Key             | Value                                                                      |
	| PermissionName  | DELETEPRIVATEOFFER                                                         |
	| Category        | Offer Management                                                           |
	| Description     | ALLOW THE USER TO DELETE PRIVATE OFFERS FROM FROM MANAGE OFFERS SCREEN     |
	Then User "Unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                 |
	| permissionname | DELETEPRIVATEOFFER	 |	
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	When User waits "1" seconds
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI

Scenario: 002-After Removing DELETEPRIVATEOFFER Permission from UC_TechServices user group, check user won't be able to delete Private offer from Manage Offer Page. (TC 590976)
    When User runs query "Select OfferCode from OFR.UC_X_OfferMaster where OfferName='<#OfferName#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PrivateOfferCode"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
	When User waits "1" seconds
	Given User enters text "Manage Offers" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
	| Key         | Value         |
	| SideSubMenu | Manage Offers |
	Given User clicks on "OLW_MANAGEOFFER.img_OfferCode_Filter"
	Given User clicks on "OLW_MANAGEOFFER.mic_OfferCode_FilterOption"
	When User waits "1" seconds
	# Search and Select Private Offer
	Given User enters text "<$PrivateOfferCode$>" in "USER_TRANS_LOG.TXT_PLAYER_ID_FILTER"
	When User pressed key "enter"
	When User waits "2" seconds
	Given User clicks on "OLW_MANAGEOFFER.lnk_OfferListDetail" with parameters
		| Key           | Value                |
		| OfferName     | <#OfferName#>        |
	    | OfferCode     | <$PrivateOfferCode$> |
		| OfferType     | <#OfferType#>        |
		| From          | <#ValidFromDate#>    |
		| To            | <#ValidToDate#>      |
		| IsPrivate     | Y                    |
	When User waits "2" seconds
	# Verify Delete Offer Button remain disabled.
    Then User verifies attribute "disabled" value "true" of element "OLW_MANAGEOFFER.btn_DeleteOffer"

Scenario: 003-Adding DELETEPRIVATEOFFER Permission from UC_TechServices user group.
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "DELETEPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                 |
	| permissionname | DELETEPRIVATEOFFER	 |	
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	When User waits "1" seconds
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI

Scenario: 004-After Adding DELETEPRIVATEOFFER Permission from UC_TechServices user group, check user will be able to delete Private offer from Manage Offer Page. (TC 590976)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
	When User waits "1" seconds
	Given User enters text "Manage Offers" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
	| Key         | Value         |
	| SideSubMenu | Manage Offers |
	Given User clicks on "OLW_MANAGEOFFER.img_OfferCode_Filter"
	When User waits "1" seconds
	Given User clicks on "OLW_MANAGEOFFER.mic_OfferCode_FilterOption"
	When User waits "1" seconds
	# Search and Delete Private Offer
	Given User enters text "<$PrivateOfferCode$>" in "USER_TRANS_LOG.TXT_PLAYER_ID_FILTER"
	When User pressed key "enter"
	When User waits "2" seconds
	Given User clicks on "OLW_MANAGEOFFER.lnk_OfferListDetail" with parameters
		| Key           | Value                |
		| OfferName     | <#OfferName#>        |
	    | OfferCode     | <$PrivateOfferCode$> |
		| OfferType     | <#OfferType#>        |
		| From          | <#ValidFromDate#>    |
		| To            | <#ValidToDate#>      |
		| IsPrivate     | Y                    |
	When User waits "2" seconds
    Given User clicks on "OLW_MANAGEOFFER.btn_DeleteOffer"
	# Provide Function Authorization
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Guest Satisfaction" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Test Delete Master Offer Comments" in "OLW_MANAGEOFFER.txt_AuthComment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds
	Then User verifies that element "OLW_MANAGEOFFER.lbl_DeleteSuccessMessage" is present "true" on UI with parameters
		| Key       | Value                                   | 
		| Message   | <#OfferName#> is deleted successfully.  |
	Given User clicks on "OLW_MANAGEOFFER.btn_AuthPopUpOk"
	When User waits "2" seconds
	# Search for deleted Private Offer
	Given User clicks on "OLW_MANAGEOFFER.img_OfferCode_Filter"
	When User waits "1" seconds
	Given User clicks on "OLW_MANAGEOFFER.mic_OfferCode_FilterOption"
	When User waits "1" seconds
	Given User enters text "<$PrivateOfferCode$>" in "USER_TRANS_LOG.TXT_PLAYER_ID_FILTER"
	When User pressed key "enter"
	When User waits "2" seconds
	# Verify deleted offer is not displayed in search result.
	Then User verifies that element "OLW_MANAGEOFFER.lnk_OfferListDetail" is present "false" on UI with parameters
		| Key           | Value                |
		| OfferName     | <#OfferName#>        |
	    | OfferCode     | <$PrivateOfferCode$> |
		| OfferType     | <#OfferType#>        |
		| From          | <#ValidFromDate#>    |
		| To            | <#ValidToDate#>      |
		| IsPrivate     | Y                    |
	When User waits "2" seconds
	When User executes query "Update OFR.UC_X_OfferMaster Set Active=1 where OfferCode='<$PrivateOfferCode$>'" with connection "<#Halo_db_connectionstring#>"











