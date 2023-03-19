@Release_15.0@Player_Enrollment@Duplicate_check@web

Feature: Verifying duplicate check functionality
	Configure duplicate check and validate the duplicate check on player at the time of enrollment

#******************************************************************************************************
#** Feature File                    : OL_EP_DuplicateCheck
#** Feature Name                    : Verifing flow of duplicate check
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 581367, 581370, 587269, 581372, 587302 
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  05/05/2022           Aayushi Nayak				Initial Draft
#**  09/19/2022			  Aayushi Nayak				FF Refractoring
#**************************************************************************************************/


Scenario Outline: 001- To Verify the Identification checkbox present on UI and Set Duplicate check criteria in configure enrollment (TC 581367, 581370, 587269)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Configure Enrollment" in "lylMAIN_NAV_BOX.menu_Search_Box"
	Given User clicks on "lylCONFIG_ENROLLMENT.conf_enrollmnt_menu"
	Given User clicks on "lylCONFIG_ENROLLMENT.Duplicate_Tab"
	#To verify Identfication option present on UI
	Then User verifies text - "Identification" is present on page
	#To verify address option has been removed from the UI
	Then User verifies that element "lylCONFIG_ENROLLMENT.chkbox_duplicatecriteria" is present "false" on UI with parameters
		| Key      | Value     |
		| infoItem | Address   |
	#Enable duplicate check configurations
	Then User "Checks" element "lylCONFIG_ENROLLMENT.chkbox_duplicatecriteria" with parameters
		| Key      | Value     |
		| infoItem | FirstName |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.chkbox_duplicatecriteria" with parameters
		| Key      | Value    |
		| infoItem | LastName |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value    |
		| infoItem | Birthday |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value  |
		| infoItem | Gender |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value |
		| infoItem | City  |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value |
		| infoItem | State |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value          |
		| infoItem | Identification |
	Given User clicks on "lylCONFIG_ENROLLMENT.DuplicateCheckSave_Button"
	Then User verifies text - "Duplicate criteria saved successfully." is present on page
	# enable duplicate chk from others tab
	Given User clicks on "lylCONFIG_ENROLLMENT.Other_Tab"
	Then User "checks" element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateChecking_CheckBox"
	Given User clicks on "lylCONFIG_ENROLLMENT.Others_Save_Button"
	Then User verifies text - "Other type updated successfully" is present on page

Scenario Outline: 002- Enroll 1st Player (TC 581370)
	When User generates a "UniqueString" with "FirstName:3" for key "FIRST_NAME"
	When User generates a "UniqueString" with "MiddleName:3" for key "MIDDLE_NAME"
	When User generates a "UniqueString" with "LastName:3" for key "LAST_NAME"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User clicks on "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User enters text "Enroll Player" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylENROLL_PLAYER.EnrollPlayer_Menu"
	Given User clicks on "lylENROLL_PLAYER.Click_EnrollmentType_DropDown"
	#Enroll Player
	Given User clicks without delay on "lylENROLL_PLAYER.EnrollmentType_DropDown" with parameters
		| Key            | Value        |
		| EnrollmentType | <enrolltype> |
	Given User clicks on "lylENROLL_PLAYER.Click_Prefix_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Prefix_DropDown" with parameters
		| Key      | Value    |
		| PIPrefix | <prefix> |
	Given User enters text "<$FIRST_NAME$>" in "lylENROLL_PLAYER.FirstName_Txtbox"
	Given User enters text "<$MIDDLE_NAME$>" in "lylENROLL_PLAYER.MiddleName_TextBox"
	Given User enters text "<$LAST_NAME$>" in "lylENROLL_PLAYER.LastName_TxtBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Suffix_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Suffix_DropDown" with parameters
		| Key      | Value    |
		| PISuffix | <suffix> |
	Given User enters text "<DOB>" in "lylENROLL_PLAYER.DOB_TextBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Gender_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Gender_DropDown" with parameters
		| Key      | Value    |
		| PIGender | <gender> |
	#Entering details in Identification Section
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Type_DropDown" with parameters
		| Key                | Value                |
		| IdentificationType | <IdentificationType> |
	When User waits "3" seconds
	Given User enters text "<IdentificationID>" in "lylENROLL_PLAYER.ID#_TextBox"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.ID_DOB_Text Box"
	When User waits "3" seconds
	Given User enters text "<IdentificationDOB>" in "lylENROLL_PLAYER.ID_DOB_Text Box"
	Given User clicks on "lylENROLL_PLAYER.ID_ExpireDate_TextBox"
	Given User enters text "<IdentificationExpiryDate>" in "lylENROLL_PLAYER.ID_ExpireDate_TextBox"
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Country_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_CountryDropDown" with parameters
		| Key                   | Value     |
		| IdentificationCountry | <Country> |
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.Click_ID_State_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_State_Drop Down" with parameters
		| Key                 | Value   |
		| IdentificationState | <State> |
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Nationality_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Nationality" with parameters
		| Key                       | Value         |
		| IdentificationNationality | <Nationality> |
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Gender_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Gender" with parameters
		| Key                  | Value    |
		| IdentificationGender | <gender> |
	#Entering details in Address Section
	Then User "Checks" element "lylENROLL_PLAYER.Address_OptIn_RadioButton" 
	Then User "Checks" element "lylENROLL_PLAYER.Address_Preferred_RadioButton"
	Given User clicks on "lylENROLL_PLAYER.Click_Address_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.mic_Address_Type_DropDown" with parameters
		| Key     | Value     |
		| AddType | <AddType> |
	When User waits "3" seconds
	Given User enters text "<AddressLine1>" in "lylENROLL_PLAYER.AddressLine1_TextBox"
	Given User enters text "<AddressLine2>" in "lylENROLL_PLAYER.AddressLine2_TextBox"
	Given User enters text "<AddressCity>" in "lylENROLL_PLAYER.Address_City_Text Box"
	Given User clicks on "lylENROLL_PLAYER.Click_Address_Country_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Address_Country_DropDown" with parameters
		| Key            | Value     |
		| AddressCountry | <Country> |
	When User runs query "select C.CountryCode from  UC_X_CountryCodeMaster C where CountryName = '<Country>'" with connection "<#Halo_db_connectionstring#>" and save with key "CountryCode"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.Click_Address_State_DropDown"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.Address_State_DropDown" with parameters
		| Key          | Value   |
		| AddressState | <State> |
	When User runs query "select S.StateCode from  UC_X_StateCode S where StateCodeDesc = '<State>'" with connection "<#Halo_db_connectionstring#>" and save with key "StateCode"
	Given User enters text "<ZipCode>" in "lylENROLL_PLAYER.Address_ZipCode"
	#User click on Enroll Button
	Given User clicks on "lylENROLL_PLAYER.EnrollOnly_Button"
	When User waits "3" seconds
	When User gets attribute "getText" value of "lylPlayer_Info.PlayerID" element to save with key "UniversalPlayerID"

	Examples:
		| enrolltype | prefix | suffix | DOB      | gender | IdentificationType | IdentificationID | IdentificationDOB | IdentificationExpiryDate | SSN         | AddType | AddressLine1 | AddressLine2    | AddressCity | ZipCode | TelephoneNumber | State  | Country       | Nationality |
		| Standard   | Ms     | JR     | 1/1/1990 | Female | License            | 1234568          | 1/1/1990          | 1/1/2099                 | 656-57-5676 | Work    | Hno345,Road2 | Street1,Sector4 | NewCity     | 12345   | 9818821710      | Nevada | United States | Indian      |


Scenario Outline: 003- Enter 2nd Player data to Verify duplicate check Pop Up, verify existing player details and ignore during player enrollment (TC 581372, 581370, 587302)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User clicks on "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User enters text "Enroll Player" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylENROLL_PLAYER.EnrollPlayer_Menu"
	Given User clicks on "lylENROLL_PLAYER.Click_EnrollmentType_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.EnrollmentType_DropDown" with parameters
		| Key            | Value        |
		| EnrollmentType | <enrolltype> |
	Given User clicks on "lylENROLL_PLAYER.Click_Prefix_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Prefix_DropDown" with parameters
		| Key      | Value    |
		| PIPrefix | <prefix> |
	Given User enters text "<$FIRST_NAME$>" in "lylENROLL_PLAYER.FirstName_Txtbox"
	Given User enters text "<$MIDDLE_NAME$>" in "lylENROLL_PLAYER.MiddleName_TextBox"
	Given User enters text "<$LAST_NAME$>" in "lylENROLL_PLAYER.LastName_TxtBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Suffix_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Suffix_DropDown" with parameters
		| Key      | Value    |
		| PISuffix | <suffix> |
	Given User enters text "<DOB>" in "lylENROLL_PLAYER.DOB_TextBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Gender_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Gender_DropDown" with parameters
		| Key      | Value    |
		| PIGender | <gender> |
	#Entering details in Identification Section
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Type_DropDown" with parameters
		| Key                | Value                |
		| IdentificationType | <IdentificationType> |
	When User waits "3" seconds
	Given User enters text "<IdentificationID>" in "lylENROLL_PLAYER.ID#_TextBox"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.ID_DOB_Text Box"
	When User waits "3" seconds
	Given User enters text "<IdentificationDOB>" in "lylENROLL_PLAYER.ID_DOB_Text Box"
	Given User clicks on "lylENROLL_PLAYER.ID_ExpireDate_TextBox"
	Given User enters text "<IdentificationExpiryDate>" in "lylENROLL_PLAYER.ID_ExpireDate_TextBox"
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Country_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_CountryDropDown" with parameters
		| Key                   | Value     |
		| IdentificationCountry | <Country> |
	When User waits "4" seconds
	Given User clicks on "lylENROLL_PLAYER.Click_ID_State_DropDown"
	When User waits "4" seconds
	Given User clicks without delay on "lylENROLL_PLAYER.ID_State_Drop Down" with parameters
		| Key                 | Value   |
		| IdentificationState | <State> |
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Nationality_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Nationality" with parameters
		| Key                       | Value         |
		| IdentificationNationality | <Nationality> |
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Gender_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Gender" with parameters
		| Key                  | Value    |
		| IdentificationGender | <gender> |
	#Entering details in Address Section
	Then User "Checks" element "lylENROLL_PLAYER.Address_OptIn_RadioButton" 
	Then User "Checks" element "lylENROLL_PLAYER.Address_Preferred_RadioButton"
	Given User clicks on "lylENROLL_PLAYER.Click_Address_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.mic_Address_Type_DropDown" with parameters
		| Key     | Value     |
		| AddType | <AddType> |
	When User waits "3" seconds
	Given User enters text "<AddressLine1>" in "lylENROLL_PLAYER.AddressLine1_TextBox"
	Given User enters text "<AddressLine2>" in "lylENROLL_PLAYER.AddressLine2_TextBox"
	Given User enters text "<AddressCity>" in "lylENROLL_PLAYER.Address_City_Text Box"
	Given User clicks on "lylENROLL_PLAYER.Click_Address_Country_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Address_Country_DropDown" with parameters
		| Key            | Value     |
		| AddressCountry | <Country> |
	When User runs query "select C.CountryCode from  UC_X_CountryCodeMaster C where CountryName = '<Country>'" with connection "<#Halo_db_connectionstring#>" and save with key "CountryCode"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.Click_Address_State_DropDown"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.Address_State_DropDown" with parameters
		| Key          | Value   |
		| AddressState | <State> |
	When User runs query "select S.StateCode from  UC_X_StateCode S where StateCodeDesc = '<State>'" with connection "<#Halo_db_connectionstring#>" and save with key "StateCode"
	Given User clicks on "lylENROLL_PLAYER.Address_ZipCode"
	When User waits "5" seconds
	#Verify the Dup Check Pop up UI
	Then User verifies that element "lylENROLL_PLAYER.mic_Duplicate_Account_Notfication" is present "true" on UI
	#To Verify existing player detail in the duplicate check pop up window
	Given User clicks without delay on "lylENROLL_PLAYER.dupcheck_existing_player" with parameters
		| Key               | Value               |
		| UniversalPlayerID | <$UniversalPlayerID$> |
	Then User verifies that element "lylENROLL_PLAYER.dupcheck_patron_act" is present "true" on UI with parameters
		| Key      | Value     |
		| infoitem | <$UniversalPlayerID$> |
	Given User clicks on "lylENROLL_PLAYER.dupcheck_viewpatron_okbtn"
	#To Click on the ignore button to close duplicate check pop-up window
	Given User clicks on "lylENROLL_PLAYER.btn_dupcheckignore"
	#User click on Enroll Button
	Given User clicks on "lylENROLL_PLAYER.EnrollOnly_Button"
	When User waits "3" seconds
	When User gets attribute "getText" value of "lylPlayer_Info.PlayerID" element to save with key "UniversalPlayerID"

	Examples:
		| enrolltype | prefix | suffix | DOB      | gender | IdentificationType | IdentificationID | IdentificationDOB | IdentificationExpiryDate | SSN         | AddType | AddressLine1 | AddressLine2    | AddressCity | TelephoneNumber | State  | Country       | Nationality |
		| Standard   | Ms     | JR     | 1/1/1990 | Female | License            | 1234568          | 1/1/1990          | 1/1/2099                 | 656-57-5676 | Work    | Hno345,Road2 | Street1,Sector4 | NewCity     |  9818821710      | Nevada | United States | Indian      |


	Scenario Outline: 004- To Verify the duplicate check on changing identification type (TC 587302)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User clicks on "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User enters text "Enroll Player" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylENROLL_PLAYER.EnrollPlayer_Menu"
	Given User clicks on "lylENROLL_PLAYER.Click_EnrollmentType_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.EnrollmentType_DropDown" with parameters
		| Key            | Value        |
		| EnrollmentType | <enrolltype> |
	Given User clicks on "lylENROLL_PLAYER.Click_Prefix_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Prefix_DropDown" with parameters
		| Key      | Value    |
		| PIPrefix | <prefix> |
	Given User enters text "<$FIRST_NAME$>" in "lylENROLL_PLAYER.FirstName_Txtbox"
	Given User enters text "<$MIDDLE_NAME$>" in "lylENROLL_PLAYER.MiddleName_TextBox"
	Given User enters text "<$LAST_NAME$>" in "lylENROLL_PLAYER.LastName_TxtBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Suffix_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Suffix_DropDown" with parameters
		| Key      | Value    |
		| PISuffix | <suffix> |
	Given User enters text "<DOB>" in "lylENROLL_PLAYER.DOB_TextBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Gender_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Gender_DropDown" with parameters
		| Key      | Value    |
		| PIGender | <gender> |
	#Entering details in Identification Section and select identiication as - Alien Registration
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Type_DropDown" with parameters
		| Key                | Value                |
		| IdentificationType | <IdentificationType2> |
	When User waits "2" seconds
	Given User enters text "<IdentificationID>" in "lylENROLL_PLAYER.ID#_TextBox"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.ID_DOB_Text Box"
	When User waits "3" seconds
	Given User enters text "<IdentificationDOB>" in "lylENROLL_PLAYER.ID_DOB_Text Box"
	Given User clicks on "lylENROLL_PLAYER.ID_ExpireDate_TextBox"
	Given User enters text "<IdentificationExpiryDate>" in "lylENROLL_PLAYER.ID_ExpireDate_TextBox"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Country_DropDown"
	When User waits "3" seconds
	Given User clicks without delay on "lylENROLL_PLAYER.ID_CountryDropDown" with parameters
		| Key                   | Value     |
		| IdentificationCountry | <Country> |
	When User waits "2" seconds
	Given User clicks on "lylENROLL_PLAYER.Click_ID_State_DropDown"
	When User waits "3" seconds
	Given User clicks without delay on "lylENROLL_PLAYER.ID_State_Drop Down" with parameters
		| Key                 | Value   |
		| IdentificationState | <State> |
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Nationality_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Nationality" with parameters
		| Key                       | Value         |
		| IdentificationNationality | <Nationality> |
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Gender_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Gender" with parameters
		| Key                  | Value    |
		| IdentificationGender | <gender> |
	#Entering details in Address Section
	Then User "Checks" element "lylENROLL_PLAYER.Address_OptIn_RadioButton" 
	Then User "Checks" element "lylENROLL_PLAYER.Address_Preferred_RadioButton"
	Given User clicks on "lylENROLL_PLAYER.Click_Address_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.mic_Address_Type_DropDown" with parameters
		| Key     | Value     |
		| AddType | <AddType> |
	When User waits "3" seconds
	Given User enters text "<AddressLine1>" in "lylENROLL_PLAYER.AddressLine1_TextBox"
	Given User enters text "<AddressLine2>" in "lylENROLL_PLAYER.AddressLine2_TextBox"
	Given User enters text "<AddressCity>" in "lylENROLL_PLAYER.Address_City_Text Box"
	Given User clicks on "lylENROLL_PLAYER.Click_Address_Country_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Address_Country_DropDown" with parameters
		| Key            | Value     |
		| AddressCountry | <Country> |
	When User runs query "select C.CountryCode from  UC_X_CountryCodeMaster C where CountryName = '<Country>'" with connection "<#Halo_db_connectionstring#>" and save with key "CountryCode"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.Click_Address_State_DropDown"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.Address_State_DropDown" with parameters
		| Key          | Value   |
		| AddressState | <State> |
	When User runs query "select S.StateCode from  UC_X_StateCode S where StateCodeDesc = '<State>'" with connection "<#Halo_db_connectionstring#>" and save with key "StateCode"
	Given User clicks on "lylENROLL_PLAYER.Address_ZipCode"
	When User waits "5" seconds
	#Change the identification type as - Alien Registration to Driver's License to check duplicate pop up
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Type_DropDown" with parameters
		| Key                | Value                |
		| IdentificationType | <IdentificationType1> |
	#To verify dup check pop-up UI window
	Then User verifies that element "lylENROLL_PLAYER.mic_Duplicate_Account_Notfication" is present "true" on UI
	Given User clicks on "lylENROLL_PLAYER.btn_dupcheckignore"
	#User click on Enroll Button
	Given User clicks on "lylENROLL_PLAYER.EnrollOnly_Button"
	When User waits "3" seconds
	When User gets attribute "getText" value of "lylPlayer_Info.PlayerID" element to save with key "UniversalPlayerID"

	Examples:
		| enrolltype | prefix | suffix | DOB      | gender | IdentificationType1 | IdentificationID | IdentificationDOB | IdentificationExpiryDate | IdentificationType2 | SSN | AddType | AddressLine1 | AddressLine2 | AddressCity | TelephoneNumber | State | Country | Nationality |
		| Standard   | Ms     | JR     | 1/1/1990 | Female | License             | 1234568          | 1/1/1990          | 1/1/2099                 |  Alien Registration |656-57-5676 | Work    | Hno345,Road2 | Street1,Sector4 | NewCity     |  9818821710      | Nevada | United States | Indian      |


Scenario Outline: 005- Disable Duplicate check criteria in configure enrollment (TC 581367)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Configure Enrollment" in "lylMAIN_NAV_BOX.menu_Search_Box"
	Given User clicks on "lylCONFIG_ENROLLMENT.conf_enrollmnt_menu"
	Given User clicks on "lylCONFIG_ENROLLMENT.Duplicate_Tab"
	#Disable duplicate check configurations
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.chkbox_duplicatecriteria" with parameters
		| Key      | Value     |
		| infoItem | FirstName |
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.chkbox_duplicatecriteria" with parameters
		| Key      | Value    |
		| infoItem | LastName |
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value    |
		| infoItem | Birthday |
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value  |
		| infoItem | Gender |
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value |
		| infoItem | City  |
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value |
		| infoItem | State |
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value          |
		| infoItem | Identification |
	Given User clicks on "lylCONFIG_ENROLLMENT.DuplicateCheckSave_Button"
	Then User verifies text - "Duplicate criteria saved successfully." is present on page
	# enable duplicate chk from others tab
	Given User clicks on "lylCONFIG_ENROLLMENT.Other_Tab"
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateChecking_CheckBox"
	Given User clicks on "lylCONFIG_ENROLLMENT.Others_Save_Button"
	Then User verifies text - "Other type updated successfully" is present on page


	Scenario Outline: 006- To Verify Dup check pop up should not appear on UI for disabled Configurations (TC 587302)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User clicks on "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User enters text "Enroll Player" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylENROLL_PLAYER.EnrollPlayer_Menu"
	Given User clicks on "lylENROLL_PLAYER.Click_EnrollmentType_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.EnrollmentType_DropDown" with parameters
		| Key            | Value        |
		| EnrollmentType | <enrolltype> |
	Given User clicks on "lylENROLL_PLAYER.Click_Prefix_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Prefix_DropDown" with parameters
		| Key      | Value    |
		| PIPrefix | <prefix> |
	Given User enters text "<$FIRST_NAME$>" in "lylENROLL_PLAYER.FirstName_Txtbox"
	Given User enters text "<$MIDDLE_NAME$>" in "lylENROLL_PLAYER.MiddleName_TextBox"
	Given User enters text "<$LAST_NAME$>" in "lylENROLL_PLAYER.LastName_TxtBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Suffix_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Suffix_DropDown" with parameters
		| Key      | Value    |
		| PISuffix | <suffix> |
	Given User enters text "<DOB>" in "lylENROLL_PLAYER.DOB_TextBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Gender_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Gender_DropDown" with parameters
		| Key      | Value    |
		| PIGender | <gender> |
	#Entering details in Identification Section
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Type_DropDown" with parameters
		| Key                | Value                |
		| IdentificationType | <IdentificationType> |
	When User waits "2" seconds
	Given User enters text "<IdentificationID>" in "lylENROLL_PLAYER.ID#_TextBox"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.ID_DOB_Text Box"
	When User waits "3" seconds
	Given User enters text "<IdentificationDOB>" in "lylENROLL_PLAYER.ID_DOB_Text Box"
	Given User clicks on "lylENROLL_PLAYER.ID_ExpireDate_TextBox"
	Given User enters text "<IdentificationExpiryDate>" in "lylENROLL_PLAYER.ID_ExpireDate_TextBox"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Country_DropDown"
	When User waits "3" seconds
	Given User clicks without delay on "lylENROLL_PLAYER.ID_CountryDropDown" with parameters
		| Key                   | Value     |
		| IdentificationCountry | <Country> |
	When User waits "2" seconds
	Given User clicks on "lylENROLL_PLAYER.Click_ID_State_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_State_Drop Down" with parameters
		| Key                 | Value   |
		| IdentificationState | <State> |
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Nationality_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Nationality" with parameters
		| Key                       | Value         |
		| IdentificationNationality | <Nationality> |
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Gender_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Gender" with parameters
		| Key                  | Value    |
		| IdentificationGender | <gender> |
	#Entering details in Address Section
	Then User "Checks" element "lylENROLL_PLAYER.Address_OptIn_RadioButton" 
	Then User "Checks" element "lylENROLL_PLAYER.Address_Preferred_RadioButton"
	Given User clicks on "lylENROLL_PLAYER.Click_Address_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.mic_Address_Type_DropDown" with parameters
		| Key     | Value     |
		| AddType | <AddType> |
	When User waits "3" seconds
	Given User enters text "<AddressLine1>" in "lylENROLL_PLAYER.AddressLine1_TextBox"
	Given User enters text "<AddressLine2>" in "lylENROLL_PLAYER.AddressLine2_TextBox"
	Given User enters text "<AddressCity>" in "lylENROLL_PLAYER.Address_City_Text Box"
	Given User clicks on "lylENROLL_PLAYER.Click_Address_Country_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Address_Country_DropDown" with parameters
		| Key            | Value     |
		| AddressCountry | <Country> |
	When User runs query "select C.CountryCode from  UC_X_CountryCodeMaster C where CountryName = '<Country>'" with connection "<#Halo_db_connectionstring#>" and save with key "CountryCode"
	When User waits "4" seconds
	Given User clicks on "lylENROLL_PLAYER.Click_Address_State_DropDown"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.Address_State_DropDown" with parameters
		| Key          | Value   |
		| AddressState | <State> |
	When User runs query "select S.StateCode from  UC_X_StateCode S where StateCodeDesc = '<State>'" with connection "<#Halo_db_connectionstring#>" and save with key "StateCode"
	Given User clicks on "lylENROLL_PLAYER.Address_ZipCode"
	When User waits "5" seconds
	#To Check dup check pop up window doesn't appear on UI
	Then User verifies that element "lylENROLL_PLAYER.mic_Duplicate_Account_Notfication" is present "False" on UI
	

	Examples:
		| enrolltype | prefix | suffix | DOB      | gender | IdentificationType | IdentificationID | IdentificationDOB | IdentificationExpiryDate | SSN         | AddType | AddressLine1 | AddressLine2    | AddressCity | TelephoneNumber | State  | Country       | Nationality |
		| Standard   | Ms     | JR     | 1/1/1990 | Female | License            | 1234568          | 1/1/1990          | 1/1/2099                 | 656-57-5676 | Work    | Hno345,Road2 | Street1,Sector4 | NewCity     |  9818821710      | Nevada | United States | Indian      |
