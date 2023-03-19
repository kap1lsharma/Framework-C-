@Release_15.0@Group_PrivateOffer@FunctionAuthorization_Add/Delete@Web
Feature: OL_AddDeletePrivateOffer_FunctionAuth
#******************************************************************************
#**  Feature File                 : OL_AddDeletePrivateOffer_FunctionAuth.feature
#**  Feature Name                 : Funtion Authorization - To check functionality of Add Offer/Delete Offer Function Authorization
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 585315

#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  04/22/2022     Sahil Thakur               Initial Draft
#********************************************************************************/
 
Scenario Outline: 001 - Player Enrollment for Player Private offer Assignment.
	When User generates a "RandomAlphabetic" with "5" for key "player_name"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	When Loyalty User Enroll Player via Webapp with "<PlayerName>" name and save key "PLAYER_ID_Key" with data
	| Birthdate   | Gender	   | identificationtype	    |
	| <BirthDate> | <Gender>   | <IdentificationType>   |
	When User waits "2" seconds
	When User runs query "Select Concat(FirstName,' ',MiddleName,' ',LastName,' ',Suffix) from UC_PL_Player where UniversalPlayerId='<$PLAYER_ID_Key$>'" with connection "<#Halo_db_connectionstring#>" and save with key "<FullPlayerName>"
	When User waits "2" seconds
Examples:
    | PlayerName      | BirthDate  | Gender | IdentificationType | PLAYER_ID_Key | FullPlayerName |
    | <$player_name$> | 01/01/1985 | Male   | Driver's License   | Player_Id_1   | Player_Name_1  |
    | <$player_name$> | 01/01/1986 | Male   | Driver's License   | Player_Id_2   | Player_Name_2  |
    | <$player_name$> | 01/01/1987 | Male   | Driver's License   | Player_Id_3   | Player_Name_3  |
    | <$player_name$> | 01/01/1988 | Male   | Driver's License   | Player_Id_4   | Player_Name_4  |
    | <$player_name$> | 01/01/1989 | Male   | Driver's License   | Player_Id_5   | Player_Name_5  |

Scenario Outline: 002 Deactivate Function Authorizations by marking all fields invisible for assigning offer to Player Account. 
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
	Then User "<PasswordVisible>" element "lylFuncton_Authorze.chk_Password_Visible"
	Then User "<ReasonVisible>" element "lylFuncton_Authorze.chk_Reason_Visible"
	Then User "<CommentVisible>" element "lylFuncton_Authorze.chk_Comment_Visible"
	Then User "<PasswordMandatory>" element "lylFuncton_Authorze.chk_Password_Required"
	Then User "<ReasonMandatory>" element "lylFuncton_Authorze.chk_Reason_Required"
	Then User "<CommentMandatory>" element "lylFuncton_Authorze.chk_Comment_Required"
	Given User clicks on "lylFuncton_Authorze.btn_Save"
	When User waits "1" seconds
    Then User verifies that element "lylFuncton_Authorze.lbl_SuccessMessage" is present "true" on UI
	Examples:
		| Menu                   | Operation    | PasswordVisible | ReasonVisible | CommentVisible | PasswordMandatory | ReasonMandatory | CommentMandatory |
		| Function Authorization | Add Offer    | unchecks        | unchecks      | unchecks       | unchecks          | unchecks        | unchecks         |
		| Function Authorization | Delete Offer | unchecks        | unchecks      | unchecks       | unchecks          | unchecks        | unchecks         |

Scenario Outline: 003 Validate Private offer assignment/deletion after removing the Add Offer/Delete Offer function authorization.
    Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "1" seconds
	Given User clicks on "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User enters text "<Player_Id>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	When User waits "1" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value     |
		| Dashboard_Tab | <TabName> |
	When User waits "1" seconds
   #Assigning Private Offer to Player
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "2" seconds
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" with parameters
		| Key       | Value           |
		| OfferName | <OfferName>     |
		| OfferType | <OfferType>     |
		| StartDate | <ValidFromDate> |
		| EndDate   | <ValidToDate>   |
		| Amount    | <OfferAmount>   |
		| Property  | <OfferProperty> |
		| IsPrivate | Y               |
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"
	When User waits "2" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value                                           |
		| Message | You've added <OfferName> to player <PlayerName> |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value     |
		| Dashboard_Tab | <TabName> |
	When User waits "1" seconds
	# Check Private offer is assigned to Player
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.lnkassignedprivateoffer" with parameters
		| Key       | Value           |
		| OfferName | <OfferName>     |
		| OfferType | <OfferType>     |
		| Status    | Active          |
		| StartDate | <ValidFromDate> |
		| EndDate   | <ValidToDate>   |
		| Amount    | <OfferAmount>   |
		| Property  | <OfferProperty> |
		| IsPrivate | Y               |
    When User waits "1" seconds
	#Delete the offer from Player.
	Given User clicks on "OLW_PLAYER_OFFER.btn_Delete_Offer"
	When User waits "1" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value                                        |
		| Message | Removed <OfferName> from player <PlayerName> |
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
	When User waits "2" seconds
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
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
	When User waits "1" seconds
Examples: 
		| Player_Id       | TabName | OfferName     | PlayerName        | OfferType     | ValidFromDate     | ValidToDate     | OfferAmount     | OfferProperty     |
		| <$Player_Id_1$> | Offers  | <#OfferName#> | <$Player_Name_1$> | <#OfferType#> | <#ValidFromDate#> | <#ValidToDate#> | <#OfferAmount#> | <#OfferProperty#> |

Scenario Outline: 004 Activate Function Authorizations with Password field only(mandatory) for Private offer to Player Account.  
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
	Then User "<PasswordVisible>" element "lylFuncton_Authorze.chk_Password_Visible"
	Then User "<ReasonVisible>" element "lylFuncton_Authorze.chk_Reason_Visible"
	Then User "<CommentVisible>" element "lylFuncton_Authorze.chk_Comment_Visible"
	Then User "<PasswordMandatory>" element "lylFuncton_Authorze.chk_Password_Required"
	Then User "<ReasonMandatory>" element "lylFuncton_Authorze.chk_Reason_Required"
	Then User "<CommentMandatory>" element "lylFuncton_Authorze.chk_Comment_Required"
	Given User clicks on "lylFuncton_Authorze.btn_Save"
	When User waits "1" seconds
    Then User verifies that element "lylFuncton_Authorze.lbl_SuccessMessage" is present "true" on UI
	Examples:
		| Menu                   | Operation    | PasswordVisible | ReasonVisible | CommentVisible | PasswordMandatory | ReasonMandatory | CommentMandatory |
		| Function Authorization | Add Offer    | checks          | unchecks      | unchecks       | checks            | unchecks        | unchecks         |
		| Function Authorization | Delete Offer | checks          | unchecks      | unchecks       | checks            | unchecks        | unchecks         |

Scenario Outline: 005 Validate after adding the Function Authorizations with only Password field visible and mandatory for adding the Private offer to Player Account. 
    Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "1" seconds
	Given User clicks on "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User enters text "<Player_Id>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	When User waits "1" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value     |
		| Dashboard_Tab | <TabName> |
	When User waits "1" seconds
    #Assigning Private Offer to Player
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "2" seconds
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" with parameters
		| Key       | Value           |
		| OfferName | <OfferName>     |
		| OfferType | <OfferType>     |
		| StartDate | <ValidFromDate> |
		| EndDate   | <ValidToDate>   |
		| Amount    | <OfferAmount>   |
		| Property  | <OfferProperty> |
		| IsPrivate | Y               |
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"
	# Validating only the Password field is displayed on Authorization Popup.
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Password" is present "true" on UI
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Reason" is present "false" on UI	
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Comment" is present "false" on UI
	When User waits "2" seconds
	# Submit Authorization without entering any value in mandatory field
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds	
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value               |
		| Message | Enter Your Password |
	When User waits "2" seconds	
	# Submit Authorization after entering incorrect password.
	Given User enters text "ABC" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value            |
		| Message | Invalid Password |
	When User waits "2" seconds
    # Submit Authorization after entering correct password.
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value                                           |
		| Message | You've added <OfferName> to player <PlayerName> |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	# Check offer is assigned to Player
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value     |
		| Dashboard_Tab | <TabName> |
	When User waits "1" seconds
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
    Given User clicks on "OLW_PLAYER_OFFER.lnkassignedprivateoffer" with parameters
		| Key       | Value           |
		| OfferName | <OfferName>     |
		| OfferType | <OfferType>     |
		| Status    | Active          |
		| StartDate | <ValidFromDate> |
		| EndDate   | <ValidToDate>   |
		| Amount    | <OfferAmount>   |
		| Property  | <OfferProperty> |
		| IsPrivate | Y               |
    When User waits "1" seconds
	# Delete the offer from Player.
	Given User clicks on "OLW_PLAYER_OFFER.btn_Delete_Offer"
    # Validating only the Password field is displayed on Authorization Popup.
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Password" is present "true" on UI
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Reason" is present "false" on UI	
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Comment" is present "false" on UI
	When User waits "2" seconds
	# Submit Authorization without entering any value in mandatory field
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds	
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value               |
		| Message | Enter Your Password |
	When User waits "2" seconds	
	# Submit Authorization after entering incorrect password.
	Given User enters text "ABC" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value            |
		| Message | Invalid Password |
	When User waits "2" seconds
    # Submit Authorization after entering correct password.
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "1" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value                                        |
		| Message | Removed <OfferName> from player <PlayerName> |
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
	When User waits "2" seconds
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
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
	When User waits "1" seconds

Examples: 
		| Player_Id       | TabName | OfferName     | PlayerName        | OfferType     | ValidFromDate     | ValidToDate     | OfferAmount     | OfferProperty     |
		| <$Player_Id_2$> | Offers  | <#OfferName#> | <$Player_Name_2$> | <#OfferType#> | <#ValidFromDate#> | <#ValidToDate#> | <#OfferAmount#> | <#OfferProperty#> |

Scenario Outline: 006 Activate Function Authorization with only Reason field visible and mandatory for adding Private offer to Player Account.  
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
	Then User "<PasswordVisible>" element "lylFuncton_Authorze.chk_Password_Visible"
	Then User "<ReasonVisible>" element "lylFuncton_Authorze.chk_Reason_Visible"
	Then User "<CommentVisible>" element "lylFuncton_Authorze.chk_Comment_Visible"
	Then User "<PasswordMandatory>" element "lylFuncton_Authorze.chk_Password_Required"
	Then User "<ReasonMandatory>" element "lylFuncton_Authorze.chk_Reason_Required"
	Then User "<CommentMandatory>" element "lylFuncton_Authorze.chk_Comment_Required"
	Given User clicks on "lylFuncton_Authorze.btn_Save"
	When User waits "1" seconds
    Then User verifies that element "lylFuncton_Authorze.lbl_SuccessMessage" is present "true" on UI
	Examples:
		| Menu                   | Operation    | PasswordVisible | ReasonVisible | CommentVisible | PasswordMandatory | ReasonMandatory | CommentMandatory |
		| Function Authorization | Add Offer    | unchecks        | checks        | unchecks       | unchecks          | checks          | unchecks         |
		| Function Authorization | Delete Offer | unchecks        | checks        | unchecks       | unchecks          | checks          | unchecks         |

Scenario Outline: 007 Validate after adding the Function Authorization with visible only Reason field(mandatory) for adding Private offer to Player Account. 
    Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "1" seconds
	Given User clicks on "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User enters text "<Player_Id>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	When User waits "1" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value     |
		| Dashboard_Tab | <TabName> |
	When User waits "1" seconds
    # Assigning Private Offer to Player
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "2" seconds
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" with parameters
		| Key       | Value                  |
		| OfferName | <OfferName>	         |
		| OfferType | <OfferType>			 |
		| StartDate | <ValidFromDate>	     |
		| EndDate   | <ValidToDate>	     |
		| Amount    | <OfferAmount>	     |
		| Property  | <OfferProperty>		 |
		| IsPrivate | Y                      |
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"
	# Validating only the reason field is displayed on Authorization Popup.
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Password" is present "false" on UI
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Reason" is present "true" on UI	
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Comment" is present "false" on UI
	When User waits "2" seconds
	# Submit Authorization after selecting correct reason.
	Given User selects option "<AddOfferAuthReason>" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value                                           |
		| Message | You've added <OfferName> to player <PlayerName> |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	When User waits "1" seconds
	# Check offer is assigned to Player
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value     |
		| Dashboard_Tab | <TabName> |
	When User waits "1" seconds
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
    Given User clicks on "OLW_PLAYER_OFFER.lnkassignedprivateoffer" with parameters
		| Key       | Value           |
		| OfferName | <OfferName>     |
		| OfferType | <OfferType>     |
		| Status    | Active          |
		| StartDate | <ValidFromDate> |
		| EndDate   | <ValidToDate>   |
		| Amount    | <OfferAmount>   |
		| Property  | <OfferProperty> |
		| IsPrivate | Y               |
    When User waits "1" seconds
    # Delete the offer from Player.
	Given User clicks on "OLW_PLAYER_OFFER.btn_Delete_Offer"
    # Validating only the reason field is displayed on Authorization Popup.
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Password" is present "false" on UI
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Reason" is present "true" on UI	
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Comment" is present "false" on UI
	When User waits "2" seconds
	# Submit Authorization after selecting correct reason.
	Given User selects option "<DeleteOfferAuthReason>" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value                                        |
		| Message | Removed <OfferName> from player <PlayerName> |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	When User waits "1" seconds
    Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	When User waits "1" seconds
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
	When User waits "2" seconds
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
	# Validate Private offer will not be displayed after checking Active/Redeemed/Voided/Expired checkboxes.
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
	When User waits "1" seconds

Examples: 
		| Player_Id       | TabName | OfferName     | PlayerName        | OfferType     | ValidFromDate     | ValidToDate     | OfferAmount     | OfferProperty     | AddOfferAuthReason | DeleteOfferAuthReason |
		| <$Player_Id_3$> | Offers  | <#OfferName#> | <$Player_Name_3$> | <#OfferType#> | <#ValidFromDate#> | <#ValidToDate#> | <#OfferAmount#> | <#OfferProperty#> | Guest Satisfaction | Trip Incentive        |

Scenario Outline: 008 Activate Function Authorizations with Comment field only(mandatory) for Private offer to Player Account.  
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
	Then User "<PasswordVisible>" element "lylFuncton_Authorze.chk_Password_Visible"
	Then User "<ReasonVisible>" element "lylFuncton_Authorze.chk_Reason_Visible"
	Then User "<CommentVisible>" element "lylFuncton_Authorze.chk_Comment_Visible"
	Then User "<PasswordMandatory>" element "lylFuncton_Authorze.chk_Password_Required"
	Then User "<ReasonMandatory>" element "lylFuncton_Authorze.chk_Reason_Required"
	Then User "<CommentMandatory>" element "lylFuncton_Authorze.chk_Comment_Required"
	Given User clicks on "lylFuncton_Authorze.btn_Save"
	When User waits "1" seconds
    Then User verifies that element "lylFuncton_Authorze.lbl_SuccessMessage" is present "true" on UI
	Examples:
		| Menu                   | Operation    | PasswordVisible | ReasonVisible | CommentVisible | PasswordMandatory | ReasonMandatory | CommentMandatory |
		| Function Authorization | Add Offer    | unchecks        | unchecks      | checks         | unchecks          | unchecks        | checks           |
		| Function Authorization | Delete Offer | unchecks        | unchecks      | checks         | unchecks          | unchecks        | checks           |

Scenario: 009 Validate by adding the Function Authorizations with Comment field only(mandatory) for Private offer to Player Account. 
    Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "1" seconds
	Given User clicks on "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User enters text "<Player_Id>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	When User waits "1" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value     |
		| Dashboard_Tab | <TabName> |
	When User waits "1" seconds
    # Assigning Private Offer to Player
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "2" seconds
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" with parameters
		| Key       | Value           |
		| OfferName | <OfferName>     |
		| OfferType | <OfferType>     |
		| StartDate | <ValidFromDate> |
		| EndDate   | <ValidToDate>   |
		| Amount    | <OfferAmount>   |
		| Property  | <OfferProperty> |
		| IsPrivate | Y               |
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"
	# Validating only the comment field is displayed on Authorization Popup.
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Password" is present "false" on UI
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Reason" is present "false" on UI	
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Comment" is present "true" on UI
	When User waits "2" seconds
	# Submit Authorization without entering comment
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds	
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value              |
		| Message | Enter Your Comment |
	When User waits "2" seconds	
    # Submit Authorization after entering correct comments.
	Given User enters text "<AddOfferAuthComment>" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value                                           |
		| Message | You've added <OfferName> to player <PlayerName> |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	# Check offer is assigned to Player
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value     |
		| Dashboard_Tab | <TabName> |
	When User waits "1" seconds
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
    Given User clicks on "OLW_PLAYER_OFFER.lnkassignedprivateoffer" with parameters
		| Key       | Value           |
		| OfferName | <OfferName>     |
		| OfferType | <OfferType>     |
		| Status    | Active          |
		| StartDate | <ValidFromDate> |
		| EndDate   | <ValidToDate>   |
		| Amount    | <OfferAmount>   |
		| Property  | <OfferProperty> |
		| IsPrivate | Y               |
    When User waits "1" seconds
	# Delete the offer from Player.
	Given User clicks on "OLW_PLAYER_OFFER.btn_Delete_Offer"
    # Validating only the comment field is displayed on Authorization Popup.
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Password" is present "false" on UI
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Reason" is present "false" on UI	
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Comment" is present "true" on UI
	When User waits "2" seconds
	# Submit Authorization without entering comment
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds	
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value              |
		| Message | Enter Your Comment |
	When User waits "2" seconds	
    # Submit Authorization after entering correct comments.
	Given User enters text "<DeleteOfferAuthComment>" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "1" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value                                        |
		| Message | Removed <OfferName> from player <PlayerName> |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	When User waits "1" seconds
    Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	When User waits "1" seconds
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
	When User waits "2" seconds
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
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
	When User waits "1" seconds
Examples: 
		| Player_Id       | TabName | OfferName     | PlayerName        | OfferType     | ValidFromDate     | ValidToDate     | OfferAmount     | OfferProperty     | AddOfferAuthComment | DeleteOfferAuthComment |
		| <$Player_Id_4$> | Offers  | <#OfferName#> | <$Player_Name_4$> | <#OfferType#> | <#ValidFromDate#> | <#ValidToDate#> | <#OfferAmount#> | <#OfferProperty#> | Add Offer Comments  | Delete Offer Comments  |

Scenario Outline: 010 Activate Function Authorizations with all fields mandatory for Adding Private offer to Player Account.  
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
	Then User "<PasswordVisible>" element "lylFuncton_Authorze.chk_Password_Visible"
	Then User "<ReasonVisible>" element "lylFuncton_Authorze.chk_Reason_Visible"
	Then User "<CommentVisible>" element "lylFuncton_Authorze.chk_Comment_Visible"
	Then User "<PasswordMandatory>" element "lylFuncton_Authorze.chk_Password_Required"
	Then User "<ReasonMandatory>" element "lylFuncton_Authorze.chk_Reason_Required"
	Then User "<CommentMandatory>" element "lylFuncton_Authorze.chk_Comment_Required"
	Given User clicks on "lylFuncton_Authorze.btn_Save"
	When User waits "1" seconds
    Then User verifies that element "lylFuncton_Authorze.lbl_SuccessMessage" is present "true" on UI

Examples:
		| Menu                   | Operation    | PasswordVisible | ReasonVisible | CommentVisible | PasswordMandatory | ReasonMandatory | CommentMandatory |
		| Function Authorization | Add Offer    | unchecks        | checks        | checks         | checks            | checks          | checks           |
		| Function Authorization | Delete Offer | unchecks        | checks        | checks         | checks            | checks          | checks           |

Scenario: 011 Validate by adding the function authorization with all fields mandatory for assigning private offer to player.
    Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "1" seconds
	Given User clicks on "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User enters text "<Player_Id>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "1" seconds
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	When User waits "1" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value     |
		| Dashboard_Tab | <TabName> |
	When User waits "1" seconds
    #Assigning Private Offer to Player
	Given User clicks on "OLW_PLAYER_OFFER.btn_Add_Active_Offer"
	When User waits "2" seconds
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Offers_Search"
	When User waits "4" seconds
	Given User clicks on "OLW_PLAYER_OFFER.lnkunassignedPrivateOffer" with parameters
		| Key       | Value           |
		| OfferName | <OfferName>     |
		| OfferType | <OfferType>     |
		| StartDate | <ValidFromDate> |
		| EndDate   | <ValidToDate>   |
		| Amount    | <OfferAmount>   |
		| Property  | <OfferProperty> |
		| IsPrivate | Y               |
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_AddActiveOffer"
	When User waits "2" seconds
	# Validating all fields are displayed on Authorization Popup.
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Password" is present "true" on UI
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Reason" is present "true" on UI	
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Comment" is present "true" on UI
	# Submit Authorization without entering any value in mandatory fields.
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds	
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value               |
		| Message | Enter Your Password |
	When User waits "2" seconds	
	# Submit Authorization after entering correct password and  rest mandatory fields left empty.
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value              |
		| Message | Enter Your Comment |
	When User waits "2" seconds
	# Submit Authorization after entering incorrect password and enter comment.
	Given User enters text "ABC" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User enters text "<AddOfferAuthComment>" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value            |
		| Message | Invalid Password |
	When User waits "2" seconds
    # Submit Authorization after entering/selecting correct password,reason and comment.
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "<AddOfferAuthReason>" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "<AddOfferAuthComment>" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value                                           |
		| Message | You've added <OfferName> to player <PlayerName> |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	#Check offer is assigned to Player
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value     |
		| Dashboard_Tab | <TabName> |
	When User waits "1" seconds
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.lnkassignedprivateoffer" with parameters
		| Key       | Value           |
		| OfferName | <OfferName>     |
		| OfferType | <OfferType>     |
		| Status    | Active          |
		| StartDate | <ValidFromDate> |
		| EndDate   | <ValidToDate>   |
		| Amount    | <OfferAmount>   |
		| Property  | <OfferProperty> |
		| IsPrivate | Y               |
    When User waits "1" seconds
	# Delete the offer from Player.
	Given User clicks on "OLW_PLAYER_OFFER.btn_Delete_Offer"
    When User waits "1" seconds 
	# Validating all fields are displayed on Authorization Popup.
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Password" is present "true" on UI
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Reason" is present "true" on UI	
	Then User verifies that element "OLW_PLAYER_OFFER.txt_Authorization_Comment" is present "true" on UI
	# Submit Authorization without entering any value in mandatory fields.
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds	
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value               |
		| Message | Enter Your Password |
	When User waits "2" seconds	
	# Submit Authorization after entering correct password and  rest mandatory fields left empty.
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value              |
		| Message | Enter Your Comment |
	When User waits "2" seconds
	# Submit Authorization after entering incorrect password and enter comment.
	Given User enters text "ABC" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User enters text "<DeleteOfferAuthComment>" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value            |
		| Message | Invalid Password |
	When User waits "2" seconds
    # Submit Authorization after entering/selecting correct password,reason and comment.
	Given User enters text "<#Halo_password#>" in "OLW_PLAYER_OFFER.txt_Authorization_Password"
	Given User selects option "<DeleteOfferAuthReason>" of element "OLW_PLAYER_OFFER.txt_Authorization_Reason" by "visibletext"
	Given User enters text "<DeleteOfferAuthComment>" in "OLW_PLAYER_OFFER.txt_Authorization_Comment"
	Given User clicks on "OLW_PLAYER_OFFER.btn_Authorization_Submit"
	When User waits "2" seconds
	Then User verifies that element "OLW_PLAYER_OFFER.lbl_AuthorizationPopupMessage" is present "true" on UI with parameters
		| Key     | Value                                        |
		| Message | Removed <OfferName> from player <PlayerName> |
	Given User clicks on "OLW_PLAYER_OFFER.btn_Information_Popup_OK"
	When User waits "1" seconds
    Given User clicks on "OLW_DASHBOARD.Dashboard_Tab" with parameters
		| Key           | Value  |
		| Dashboard_Tab | Offers |
	When User waits "1" seconds
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
	When User waits "2" seconds
	Given User enters text "<OfferName>" in "OLW_PLAYER_OFFER.txt_OfferName_Search"
	When User waits "2" seconds
	Given User clicks on "OLW_PLAYER_OFFER.AssignedOffer_Search_Button"
	When User waits "2" seconds
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
	When User waits "1" seconds

Examples:
		| Player_Id       | TabName | OfferName     | PlayerName        | OfferType     | ValidFromDate     | ValidToDate     | OfferAmount     | OfferProperty     | AddOfferAuthReason | AddOfferAuthComment | DeleteOfferAuthReason | DeleteOfferAuthComment |
		| <$Player_Id_5$> | Offers  | <#OfferName#> | <$Player_Name_5$> | <#OfferType#> | <#ValidFromDate#> | <#ValidToDate#> | <#OfferAmount#> | <#OfferProperty#> | Employee Error     | Add Offer Comments  | Trip Incentive        | Delete Offer Comments  |




















