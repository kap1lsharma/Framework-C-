@sequential@Release_15.0 @PMinimumEnrollmentAge@desktop
Feature: OLL_EP_MinimumEnrollmentAge-Verifing Minimum Age Enrollment Functionality

#******************************************************************************************************
#** Feature File                    : OL_EP_MinimumEnrollmentAge
#** Feature Name                    : Verifing Minimum Enrollment Age Functionality
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 599308
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  07/08/2022           Aayushi Nayak			Initial Draft
#**************************************************************************************************/

Scenario Outline: 001- Setting enrollment age limit in Configure Enrollment (TC 599308)
    #Login to WebApp and enroll Player
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
    Given User enters text "Configure Enrollment" in "lylMAIN_NAV_BOX.menu_Search_Box"
	When User waits "2" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.conf_enrollmnt_menu"
	Given User clicks on "lylCONFIG_ENROLLMENT.Other_Tab"
	Given User clears "lylCONFIG_ENROLLMENT.Other_MinimumAge_TextBox"
	Given User enters text "<MinAge>" in "lylCONFIG_ENROLLMENT.Other_MinimumAge_TextBox"
	Given User clicks on "lylCONFIG_ENROLLMENT.Others_Save_Button"
	Examples:
	| MinAge |
	| 18     |

Scenario Outline: 002- Enroll Player To check minimum age limit (TC 599308)
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "3" seconds
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	When User runs query "SELECT TOP 1 AT.Name FROM dbo.UC_X_AccountType AT,UC_X_AccountTypeMaster ATM,AccountTypePropertyMappings APM where AT.AccountTypeMasterID = ATM.ID and APM.AccountTypeID = AT.ID and AT.AccountTypeMasterID = 3 and APM.PropertyID = '<$PropertyID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "EnrollmentName"
	When User generates a "UniqueString" with "FirstName:3" for key "FIRST_NAME"
	When User generates a "UniqueString" with "MiddleName:3" for key "MIDDLE_NAME"
	When User generates a "UniqueString" with "LastName:3" for key "LAST_NAME"
	#Search for Enroll Player Menu
	When User waits "4" seconds
	Given User clicks on "LLSideNavigation.mnu_EnrollPlayer"
	When User waits "2" seconds
	#Selecting Enrollment Type and Property
	Given User clicks on "OLL_ENROLLPLAYER.lst_EnrollmentType"
	When User waits "3" seconds
	Given User selects option "<#enrolltype#>" of element "OLL_ENROLLPLAYER.lst_EnrollmentType" by "value"
	Given User clicks on "OLL_ENROLLPLAYER.lst_enrollproperty"
	Given User selects option "<$PropertyName$>" of element "OLL_ENROLLPLAYER.lst_enrollproperty" by "value"
	#Entering details in Player Identity Section
	When User waits "3" seconds
	Given User clicks on "OLL_ENROLLPLAYER.lst_Prefix"
	Given User selects option "<Prefix>" of element "OLL_ENROLLPLAYER.lst_Prefix" by "value"
	Given User types text "<$FIRST_NAME$>" in "OLL_ENROLLPLAYER.txt_FirstName"
	Given User types text "<$MIDDLE_NAME$>" in "OLL_ENROLLPLAYER.txt_middlename"
	Given User types text "<$LAST_NAME$>" in "OLL_ENROLLPLAYER.txt_LastName"
	Given User clicks on "OLL_ENROLLPLAYER.lst_SuffixType"
	Given User selects option "<Suffix>" of element "OLL_ENROLLPLAYER.lst_SuffixType" by "value"
	Given User types text "<DOB>" in "OLL_ENROLLPLAYER.txt_BirthDate"
	Given User clicks on "OLL_ENROLLPLAYER.lst_Gender"
	Given User selects option "<Gender>" of element "OLL_ENROLLPLAYER.lst_Gender" by "value"
	When User gets attribute "Name" value of "OLL_ENROLLPLAYER.lbl_UnderAge" element to save with key "UnderAgeValidation"
	#Validate UnderAge message on UI
	When User performs string operation "stringEquals" of provided value "<$UnderAgeValidation$>" with "<underAge>"
	

	Examples:
	| DOB      | Suffix | Prefix | Gender | underAge  |
	| 1/1/2005 | Sr     | MR     | Male   | Under Age |
	
#Close the Loyalty Lite application
Scenario: 003-Close all instance of Loyalty Lite Desktop application.
	When User switch to window application "ATI.Loyalty.Lite.Client.exe"
	Given User closes application