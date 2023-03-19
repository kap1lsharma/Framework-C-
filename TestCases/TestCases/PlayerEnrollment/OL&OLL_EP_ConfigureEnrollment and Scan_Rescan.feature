@Release_15.0@Group_Player_Enrollment@scan/Rescan@enrollplayerwithoutrequireddata@desktop
Feature: OL&OLL_EP_ConfigureEnrollment and Scan_Rescan- Verifying configure Enrollment Type, Scan/Rescan and Player enrollment without Required fields
	Configure enrollment and validate the player if not fill the required field data

#******************************************************************************************************
#** Feature File                    : OL_EP_PLAYER_PlayerEnrollment
#** Feature Name                    : Verifing flow of Conigure enrollment,scan/Rescan and enrollment without required fields
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 589760, 589765, 590287, 590288, 597678
#****************************************************************************************************/
#**  Created Date:        Author:                # Comments
#**  02/05/2022           Aayushi Nayak			 Initial Draft
#**  06/15/2022           Aayushi Nayak			 Player Enrollment without passing data in required fields in LL
#**  06/29/2022			  Aayushi Nayak			 Added Scenario for Scan/Rescan in Loyalty Lite
#**************************************************************************************************/

Scenario: 001- Create a Enrollment type under Configure Enrollment page (TC 589760)
	#Login to WebApp and Pick property value
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	When User generates a "UniqueString" with "Test Enrollment:3" for key "ENROLLMENT_NAME"
	#Search for Conigure Enrollment page
	Given User enters text "Configure Enrollment" in "lylMAIN_NAV_BOX.menu_Search_Box"
	When User waits "2" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.conf_enrollmnt_menu"
	Given User clicks on "lylCONFIG_ENROLLMENT.AddNewEnrollmentType_Button"
	#Create New Enrollment type
	Given User enters text "<$ENROLLMENT_NAME$>" in "lylCONFIG_ENROLLMENT.EnrollmentName_TextBox"
	Given User clicks on "lylCONFIG_ENROLLMENT.Click_Propty_DropDown"
	Given User clicks on "lylCONFIG_ENROLLMENT.Click_Propty_DropDown"
	Given User clicks on "lylCONFIG_ENROLLMENT.Propery_DropDown"
	Given User select list "lylCONFIG_ENROLLMENT.AccountType_DropDown" options "<accountType>" by "visibletext"
	#To set Enrollment type options
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value           |
		| infoItem  | PlayerIdentity1 |
		| condition | Require         |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value           |
		| infoItem  | PlayerIdentity2 |
		| condition | Optional        |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value   |
		| infoItem  | Gender  |
		| condition | Require |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value      |
		| infoItem  | Occupation |
		| condition | Require    |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value          |
		| infoItem  | Identification |
		| condition | Require        |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value    |
		| infoItem  | Address  |
		| condition | Optional |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value     |
		| infoItem  | Telephone |
		| condition | Optional  |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value    |
		| infoItem  | Email    |
		| condition | Optional |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value    |
		| infoItem  | Social   |
		| condition | Optional |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value    |
		| infoItem  | SMS      |
		| condition | Optional |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value    |
		| infoItem  | PIN      |
		| condition | Optional |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value    |
		| infoItem  | SSN      |
		| condition | Optional |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value      |
		| infoItem  | EnrollProp |
		| condition | Optional   |
	Given User clicks on "lylCONFIG_ENROLLMENT.SaveEnrollmentType_Button"
	#Verify enrollment type created successfully and visible in the left panel
	Then User verifies that element "lylCONFIG_ENROLLMENT.EnrollmentCreatedMsg_Text" is present "true" on UI with parameters
		| Key           | Value                              |
		| Enrollmenttxt | Enrollment type successfully saved |

		
	Examples:
		| accountType | Property |
		|Credit      | <$PropertyName$> |

Scenario: 002- Edit the Enrollment type under Configure Enrollment page (TC 589760)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Configure Enrollment" in "lylMAIN_NAV_BOX.menu_Search_Box"
	When User waits "2" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.conf_enrollmnt_menu"
	Given User enters text "<$ENROLLMENT_NAME$>" in "lylCONFIG_ENROLLMENT.Enrlment_type__seachbox"
	When User waits "1" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.Enrollmentype_searchlist" with parameters
		| Key           | Value                 |
		| enrollmenttype | <$ENROLLMENT_NAME$> |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value      |
		| infoItem  | Occupation |
		| condition | Optional   |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value          |
		| infoItem  | Identification |
		| condition | Optional       |
	Given User clicks on "lylCONFIG_ENROLLMENT.SaveEnrollmentType_Button"
	Then User verifies that element "lylCONFIG_ENROLLMENT.EnrollmentCreatedMsg_Text" is present "true" on UI with parameters
		| Key           | Value                              |
		| Enrollmenttxt | Enrollment type successfully updated |

Scenario Outline: 003- To Validate the Scan/Rescan button for all Enrollment type and Validate Scan id button removed from UI(2.1) (TC 590287, 590288, 590294)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Enroll Player" in "lylMAIN_NAV_BOX.menu_Search_Box"
	When User waits "2" seconds
	Given User clicks on "lylENROLL_PLAYER.EnrollPlayer_Menu"
	Given User clicks on "lylENROLL_PLAYER.Click_EnrollmentType_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.EnrollmentType_DropDown" with parameters
		| Key            | Value        |
		| EnrollmentType | <enrolltype> |
	#Verify Scan id button removed from UI
	Then User verifies that element "lylENROLL_PLAYER.Scanid_btn" is present "False" on UI
	#Verify the Scan/Rescan Button on UI
	Then User verifies that element "lylENROLL_PLAYER.scan/Rescan" is present "true" on UI
	#Click on Scan/Rescan button and Verify the scan pop-up window
	Given User clicks on "lylENROLL_PLAYER.scan/Rescan"
	Then User verifies text - "Please wait while we scan your Identification..." is present on page
	Given User clicks on "lylENROLL_PLAYER.Scan_notiication_wndw_cancel"
	#To Check Rescan Functionality and validation message
	Given User clicks on "lylENROLL_PLAYER.scan/Rescan"
	When User waits "3" seconds
	Then User verifies text - "Pressing the Scan/Rescan button more than once on the same guest will overwrite all data fields. Do you wish to continue Yes or No?" is present on page
	Given User clicks on "lylENROLL_PLAYER.ovrride_wndw_No_button"
	Examples: 
	| enrolltype          |
	| <$ENROLLMENT_NAME$> |
	| Basic				  |
	| Credit			  |
	| Standard			  |
	| Credit Limited	  |

Scenario Outline: 004- To Validate the Scan/Rescan button for all Enrollment type and Validate Scan id button removed from UI in Loyalty Lite(2.1) (TC 590296, 590297, 590298)
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	Given User clicks on "LLSideNavigation.mnu_EnrollPlayer"
	Given User clicks on "OLL_ENROLLPLAYER.lst_EnrollmentType"
	When User waits "3" seconds
	Given User selects option "<#enrolltype#>" of element "OLL_ENROLLPLAYER.lst_EnrollmentType" by "value"
	Then User verifies that element "OLL_ENROLLPLAYER.btn_ScanRescan_Button" is present "true" on UI
	Given User clicks on "OLL_ENROLLPLAYER.btn_ScanRescan_Button"
	Given User clicks on "OLL_ENROLLPLAYER.btn_Scan/Rescan_OK"
	#To Check Rescan Functionality and validation message
	Given User clicks on "OLL_ENROLLPLAYER.btn_ScanRescan_Button"
	When User waits "3" seconds
	Then User verifies that element "OLL_ENROLLPLAYER.lbl_Rescan_Validation_Msg" is present "true" on UI
	When User waits "3" seconds
	When User pressed key "tab"
	When User pressed key "enter"
	Given User closes application

	Examples: 
	| enrolltype          |
	| <$ENROLLMENT_NAME$> |
	| Basic				  |
	| Credit			  |
	| Standard			  |
	| Credit Limited	  |


Scenario: 005 - To Check validation if doesn't enter data for the Required field. (TC 589765)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Enroll Player" in "lylMAIN_NAV_BOX.menu_Search_Box"
	When User waits "2" seconds
	Given User clicks on "lylENROLL_PLAYER.EnrollPlayer_Menu"
	Given User clicks on "lylENROLL_PLAYER.Click_EnrollmentType_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.EnrollmentType_DropDown" with parameters
		| Key          | Value                 |
		| EnrollmentType | <$ENROLLMENT_NAME$> |
	#Validate the error window 
	Given User clicks on "lylENROLL_PLAYER.EnrollOnly_Button"
	Then User verifies that element "lylENROLL_PLAYER.Validation_notification_window" is present "true" on UI with parameters
		| Key          | Value                           |
		| ErrorMessage | Enrollment cannot be completed. |
	Given User clicks on "lylENROLL_PLAYER.Enroll_Error_msg_ok"

Scenario: 006 - To Check validation if doesn't enter data for the Required field in LoyaltyLite. (TC 597678)
	#Switch to Loyalty Lite application
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "4" seconds
	Given User clicks on "LLSideNavigation.mnu_EnrollPlayer"
	Given User clicks on "OLL_ENROLLPLAYER.lst_EnrollmentType"
	When User waits "3" seconds
	Given User selects option "<#enrolltype#>" of element "OLL_ENROLLPLAYER.lst_EnrollmentType" by "value"
	Given User clicks on "LLSideNavigation.btn_pagedown"
	Given User clicks on "LLSideNavigation.btn_pagedown"
	Given User clicks on "LLSideNavigation.btn_pagedown"
	Given User clicks on "OLL_ENROLLPLAYER.btn_enrollonly"
	#Validate the Error Window
	Then User verifies that element "OLL_ENROLLPLAYER.lbl_enrollvalidationmsg" is present "true" on UI
	Given User clicks on "OLL_ENROLLPLAYER.btn_ok"
	

Scenario: 007 - Inactivate Enrollment type of existing player (TC 589760)
	When User executes query "Update UC_X_AccountType set Active=0 where Name = '<$ENROLLMENT_NAME$>' and AccountTypeMasterID=1" with connection "<#Halo_db_connectionstring#>"

#Close the Loyalty Lite application
Scenario: 008-Close all instance of Loyalty Lite Desktop application.
	When User switch to window application "ATI.Loyalty.Lite.Client.exe"
	Given User closes application