@Sequential@Release_15.0@Group_PrivateOffer@DeletePlayerPrivateOffer@Web
Feature: OL_PlayerPrivateOfferDeletion
#******************************************************************************
#**  Feature File                 : OL_PlayerPrivateOfferDeletion.feature
#**  Feature Name                 : Private Offer Deletion from Player
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 587266,587254


#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  04/22/2022     Sahil Thakur               Initial Draft
#********************************************************************************/

Scenario Outline: 001 Activate Function Authorizations for Adding and Deleting offer from Player Account. 
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "1" seconds
	Given User enters text "<Menu>" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
	| Key		  | Value		|
	| SideSubMenu | <Menu>		|
	Given User clicks on "lylFuncton_Authorze.mic_SelectFunctionName" with parameters
	| Key		  | Value			|
	| Option	  | <Operation>		|
	When User waits "1" seconds
	Then User "checks" element "lylFuncton_Authorze.chk_Password_Required"
	Then User "checks" element "lylFuncton_Authorze.chk_Reason_Required"
	Then User "checks" element "lylFuncton_Authorze.chk_Comment_Required"
	Given User clicks on "lylFuncton_Authorze.btn_Save"
	When User waits "1" seconds
    Then User verifies that element "lylFuncton_Authorze.lbl_SuccessMessage" is present "true" on UI
	Examples:
		| Menu		 				| Operation		|
		| Function Authorization	| Add Offer		| 
		| Function Authorization    | Delete Offer  |

Scenario Outline: 002 - Player Enrollment for Player Private offer deletion.
	When User generates a "RandomAlphabetic" with "5" for key "player_name"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	When Loyalty User Enroll Player via Webapp with "<PlayerName>" name and save key "PLAYER_ID" with data
	| Birthdate   | Gender	   | identificationtype	    |
	| <BirthDate> | <Gender>   | <IdentificationType>   |
	When User gets attribute "getText" value of "PLAYER_INFO.PLAYER_ID_SPAN" element to save with key "<PLAYER_ID_Key>"
Examples:
    | PlayerName      | BirthDate  | Gender | IdentificationType | PLAYER_ID_Key |
    | <$player_name$> | 01/01/1985 | Male   | Driver's License   | Player_ID   |

Scenario: 003-Removing DELETEPLAYERPRIVATEOFFER Permission from UC_TechServices user group. (TC 587266)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "DELETEPLAYERPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Verification of permission , it's category and description
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lnk_PermissionDetailAll" is present "true" on UI with parameters
	| Key             | Value                                                                                        |
	| PermissionName  | DELETEPLAYERPRIVATEOFFER                                                                     |
	| Category        | Player Functions                                                                             |
	| Description     | ABILITY IN WEB APP TO MANUALLY DELETE A PRIVATE OFFER THAT HAS BEEN ASSIGNED TO PLAYERS      |
	When User waits "2" seconds
	#Remove DELETEPLAYERPRIVATEOFFER permission from UC_TechServices user group.
	Then User "Unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                    |
	| permissionname | DELETEPLAYERPRIVATEOFFER |	
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	When User waits "1" seconds
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI

Scenario: 004- After removing DELETEPLAYERPRIVATEOFFER permission from UC_TechServices user group, check user won't be able to delete private offer from Player. (TC 587266)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User clicks on "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "4" seconds
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
    #Assigning Private Offer to Player
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "2" seconds
	Given User enters text "<#OfferName#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" with parameters
		| Key       | Value                  |
		| OfferName | <#OfferName#>	         |
		| OfferType | <#OfferType#>			 |
		| StartDate | <#ValidFromDate#>	     |
		| EndDate   | <#ValidToDate#>	     |
		| Amount    | <#OfferAmount#>	     |
		| Property  | <#OfferProperty#>		 |
		| IsPrivate | Y                      |
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"
	When User waits "2" seconds
	# Provide Authorization.
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Guest Satisfaction" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Test Comments" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	Given User clicks on "OLW_PLAYER_OFFER.btn_CancelAndReturn_PlayerOffer"
	When User waits "2" seconds
	#Search Private offer on Offer Tab and try deleting the offer.
	Given User enters text "<#OfferName#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.lnkassignedprivateoffer" with parameters
		| Key       | Value                  |
		| OfferName | <#OfferName#>	         |
		| OfferType | <#OfferType#>			 |
  		| Status    | Active                 |
		| StartDate | <#ValidFromDate#>	     |
		| EndDate   | <#ValidToDate#>	     |
		| Amount    | <#OfferAmount#>	     |
		| Property  | <#OfferProperty#>		 |
		| IsPrivate | Y                      |
  #Verify Delete Button will remain disabled.
  Then User verifies attribute "disabled" value "true" of element "OLW_PLAYER_OFFER.btn_Delete_Offer"

Scenario: 005- Add DELETEPLAYERPRIVATEOFFER Permission to UC_TechServices user group.
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "DELETEPLAYERPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                        |
	| permissionname | DELETEPLAYERPRIVATEOFFER |	
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	When User waits "1" seconds
	Then User verifies that element "OLW_USER_GROUP_PERMISSION.lbl_PermissionSavedMessage" is present "true" on UI

Scenario: 006-After adding DELETEPLAYERPRIVATEOFFER permission to UC_TechServices user group, check user will be able to delete private offer from Player.(TC 587254)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User clicks on "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	When User waits "2" seconds
	#Search Private offer on Offer Tab and try deleting the offer.
	Given User enters text "<#OfferName#>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.lnkassignedprivateoffer" with parameters
		| Key       | Value                  |
		| OfferName | <#OfferName#>	         |
		| OfferType | <#OfferType#>			 |
  		| Status    | Active                 |
		| StartDate | <#ValidFromDate#>	     |
		| EndDate   | <#ValidToDate#>	     |
		| Amount    | <#OfferAmount#>	     |
		| Property  | <#OfferProperty#>		 |
		| IsPrivate | Y                      |
	When User waits "1" seconds
	#Delete the offer from Player.
	Given User clicks on "OLW_PLAYER_OFFER.btn_Delete_Offer"
	When User waits "1" seconds
	#Enter Authorization Details
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "Employee Error" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "Delete Offer Testing" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	When User waits "1" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
    # Check Active/Redeemed/Voided/Expired checkboxes
	Then User "checks" element "OLW_PLAYER_OFFER.chk_Active"
	When User waits "1" seconds
	Then User "checks" element "OLW_PLAYER_OFFER.chk_Redeemed"
	When User waits "1" seconds
	Then User "checks" element "OLW_PLAYER_OFFER.chk_Voided"
	When User waits "1" seconds
	Then User "checks" element "OLW_PLAYER_OFFER.chk_Expired"
	When User waits "1" seconds
	Then User "checks" element "OLW_PLAYER_OFFER.chk_Reserved"
	#Validate Private offer will not be displayed after checking Active/Redeemed/Voided/Expired checkboxes.
	Then User verifies that element "OLW_PLAYER_OFFER.lnkassignedprivateoffer" is present "false" on UI with parameters
		| Key       | Value                  |
		| OfferName | <#OfferName#>	         |
		| OfferType | <#OfferType#>			 |
  		| Status    | Active                 |
		| StartDate | <#ValidFromDate#>	     |
		| EndDate   | <#ValidToDate#>	     |
		| Amount    | <#OfferAmount#>	     |
		| Property  | <#OfferProperty#>		 |
		| IsPrivate | Y                      |