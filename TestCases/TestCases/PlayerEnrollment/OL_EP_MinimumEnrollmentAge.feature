Feature: Verifing Minimum Age Enrollment Functionality

#******************************************************************************************************
#** Feature File                    : OL_EP_MinimumEnrollmentAge
#** Feature Name                    : Verifing Minimum Enrollment Age Functionality
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 282871
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  05/23/2022           Robbie Kalra				Initial Draft
#**************************************************************************************************/
@sequential@Release_15.0 @Player_Enrollment

Scenario Outline: 001- Setting enrollment age limit in Configure Enrollment
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

Scenario Outline: 002- Setting enrollment age limit in Configure Enrollment
Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	When User runs query "SELECT TOP 1 AT.Name FROM dbo.UC_X_AccountType AT,UC_X_AccountTypeMaster ATM,AccountTypePropertyMappings APM where AT.AccountTypeMasterID = ATM.ID and APM.AccountTypeID = AT.ID and AT.AccountTypeMasterID = 3 and APM.PropertyID = '<$PropertyID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "EnrollmentName"
	When User generates a "UniqueString" with "FirstName:3" for key "FIRST_NAME"
	When User generates a "UniqueString" with "MiddleName:3" for key "MIDDLE_NAME"
	When User generates a "UniqueString" with "LastName:3" for key "LAST_NAME"
	#Search for Enroll Player Menu
	Given User enters text "Enroll Player" in "lylMAIN_NAV_BOX.menu_Search_Box"
	When User waits "2" seconds
	#Selecting Enrollment Type and Property
	Given User clicks on "lylENROLL_PLAYER.EnrollPlayer_Menu"
	Given User clicks on "lylENROLL_PLAYER.Click_EnrollmentType_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.EnrollmentType_DropDown" with parameters
        | Key            | Value              |
        | EnrollmentType | <$EnrollmentName$> |
	Given User clicks on "lylENROLL_PLAYER.Click_PropertyDropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.PropertyDropDown" with parameters
        | Key            | Value              |
        | PropertyID     | <$PropertyName$>   |
	#Entering details in Player Identity Section
    Given User clicks on "lylENROLL_PLAYER.Click_Prefix_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Prefix_DropDown" with parameters
        | Key            | Value            |
        | PIPrefix       | <Prefix>         |  
	Given User enters text "<$FIRST_NAME$>" in "lylENROLL_PLAYER.FirstName_Txtbox"
	Given User enters text "<$MIDDLE_NAME$>" in "lylENROLL_PLAYER.MiddleName_TextBox"
	Given User enters text "<$LAST_NAME$>" in "lylENROLL_PLAYER.LastName_TxtBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Suffix_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Suffix_DropDown" with parameters
        | Key            | Value      |
        | PISuffix       | <Suffix>   |
	Given User enters text "<DOB>" in "lylENROLL_PLAYER.DOB_TextBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Gender_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Gender_DropDown" with parameters
        | Key            | Value        |
        | PIGender       | <Gender>     |
	#Verify Minimum age validation on UI
	Then User verifies that element "lylENROLL_PLAYER.UnderAgeValidation" is present "true" on UI with parameters
		| Key           | Value     |
		| UnderAge      | Under Age |

	Examples:
	| DOB      | Suffix | Prefix | Gender |
	| 1/1/2005 | Sr     | MR     | Male   |
	
