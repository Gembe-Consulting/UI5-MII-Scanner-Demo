Feature: Creating a stock transfer 
	Users can create a stock transfer, either with goods receipt to process order or without.
	Entering a storage unit number will show the neccessarry data of that storage unit,
	and pre-populate some input fields.
	
	Background:
		Given I start the app from 'com/mii/scanner/app/mockServer.html'
		When I navigate to "Start/Materialbewegung/UL"
		
	Scenario: Should navigate to Stock Transfer Page and see all UI elements
		Then I can see stockTransferPage in action.StockTransfer view
		Then I can see storageBinSelection with editable is 'true' in action.StockTransfer view
		Then storageBinSelection in action.StockTransfer view contains 16 items
		Then I can see storageUnitInput with editable is 'true' in action.StockTransfer view
		Then I can see storageUnitInput with value '' in action.StockTransfer view
		Then I can see quantityInput with value '0,000' in action.StockTransfer view
		Then I can see unitOfMeasureInput in action.StockTransfer view
		Then I can see orderNumberInput with editable is 'false' in action.StockTransfer view
		Then I can see storageUnitActualQuantityText with text ' ' in action.StockTransfer view
		Then I can see storageUnitTargetQuantityText with text ' ' in action.StockTransfer view
		Then I can see clearFormButton in action.StockTransfer view
		Then I can see cancelButton in action.StockTransfer view
		Then I cannot see saveButton in action.StockTransfer view
#		Then on the Stock Transfer Page: I should see all input fields are initial

	Scenario: Should select the correct storage bin key when users select an entry from storage bin list
		When I press ARROW_DOWN + ALT at storageBinSelection in action.StockTransfer view
		 And I click on first item of storageBinSelection items in action.StockTransfer view
		Then I can see storageBinSelection with selectedKey 'BA01' in action.StockTransfer view
		 And I can see storageBinSelection with valueState 'Success' in action.StockTransfer view
		When I click on last item of storageBinSelection items in action.StockTransfer view
		Then I can see storageBinSelection with selectedKey 'PRODUKTION' in action.StockTransfer view
		 And I can see storageBinSelection with valueState 'Success' in action.StockTransfer view
		When I enter 'NON_EXISTING_STORAGE_BIN' into storageBinSelection in action.StockTransfer view
		Then I can see storageBinSelection with selectedKey '' in action.StockTransfer view
		 And I can see storageBinSelection with valueState 'Error' in action.StockTransfer view
		When I click on clearFormButton in action.StockTransfer view
		Then I can see storageBinSelection with valueState 'None' in action.StockTransfer view
		
	Scenario: Should read storage unit data and validate data when users enter storage unit number
		When I enter '00000000109330000013' into storageUnitInput in action.StockTransfer view
		Then I can see storageUnitInput with value '109330000013' in action.StockTransfer view
		 And I can see storageUnitInput with valueState 'Success' in action.StockTransfer view
		 And I can see quantityInput with editable is 'true' in action.StockTransfer view
		 And I can see quantityInput with value '' in action.StockTransfer view
		 And I can see quantityInput has focus in action.StockTransfer view
		 And I can see orderNumberInput with value '1093300' in action.StockTransfer view
		 And I can see storageUnitActualQuantityText with text '0,001 KG' in action.StockTransfer view
		 And I can see storageUnitTargetQuantityText with text '600,000 KG' in action.StockTransfer view
		When I click on clearFormButton in action.StockTransfer view
		Then I can see storageUnitInput with valueState 'None' in action.StockTransfer view
		 And I can see quantityInput with editable is 'false' in action.StockTransfer view
		When I enter '00000000109330000014' into storageUnitInput in action.StockTransfer view
		Then I can see storageUnitInput with value '109330000014' in action.StockTransfer view
		 And I can see storageUnitInput with valueState 'Success' in action.StockTransfer view
		 And I can see quantityInput with editable is 'false' in action.StockTransfer view
		 And I can see quantityInput with value '300,000' in action.StockTransfer view
		 And I can see storageUnitActualQuantityText with text '300,000 KG' in action.StockTransfer view
		 And I can see storageUnitTargetQuantityText with text '600,000 KG' in action.StockTransfer view
		When I enter '00000000000000000001' into storageUnitInput in action.StockTransfer view
		Then I can see storageUnitInput with valueState 'Error' in action.StockTransfer view
		 And I can see messageStrip with text 'Achtung: Palette '00000000000000000001' existiert nicht!' in action.StockTransfer view
		 And I can see messageStrip with type 'Error' in action.StockTransfer view
		 And I can see orderNumberInput with value '' in action.StockTransfer view
		 And I can see storageUnitActualQuantityText with text ' ' in action.StockTransfer view
		 And I can see storageUnitTargetQuantityText with text ' ' in action.StockTransfer view
		 
	Scenario: Should enable save Button once users provide all input and input is valid
		When I look at the screen
		Then I cannot see saveButton in action.StockTransfer view
		When I press ARROW_DOWN + ALT at storageBinSelection in action.StockTransfer view
		 And I click on 3rd item of storageBinSelection items in action.StockTransfer view
		Then I can see storageBinSelection with value 'KH01' in action.StockTransfer view
		Then I cannot see saveButton in action.StockTransfer view
		When I enter '00000000109330000013' into storageUnitInput in action.StockTransfer view
		Then I cannot see saveButton in action.StockTransfer view
		When I enter '300,123' into quantityInput in action.StockTransfer view
		 And I press ENTER at quantityInput in action.StockTransfer view
		Then I can see saveButton in action.StockTransfer view
		When I enter '00000000000000000001' into storageUnitInput in action.StockTransfer view
		Then I cannot see saveButton in action.StockTransfer view
		When I enter '00000000109330000014' into storageUnitInput in action.StockTransfer view
		Then I can see saveButton in action.StockTransfer view
		When I enter 'XXX' into storageBinSelection in action.StockTransfer view
		Then I cannot see saveButton in action.StockTransfer view
		When I click on 14th item of storageBinSelection items in action.StockTransfer view
		Then I can see storageBinSelection with value 'PVB TT' in action.StockTransfer view
		 And I can see saveButton in action.StockTransfer view
		When I click on clearFormButton in action.StockTransfer view
		Then I cannot see saveButton in action.StockTransfer view
		
	Scenario: Should successfully post stock transfer to SAP ERP without a priori goods receipt posting
		When I press ARROW_DOWN + ALT at storageBinSelection in action.StockTransfer view
		 And I click on last item of storageBinSelection items in action.StockTransfer view
		 And I enter '00000000109330000014' into storageUnitInput in action.StockTransfer view
		 And I click on saveButton in action.StockTransfer view
		Then I can see messageStrip with text 'Umlagerung von Palette '109330000014' nach Lagerplatz 'PRODUKTION' wurde erfolgreich gebucht!' in action.StockTransfer view
		 And I can see messageStrip with type 'Success' in action.StockTransfer view
		 And I can see storageUnitInput with value '' in action.StockTransfer view
		 And I can see storageBinSelection with value '' in action.StockTransfer view

	Scenario: Should successfully post stock transfer to SAP ERP including a pre-leading goods receipt posting
		When I press ARROW_DOWN + ALT at storageBinSelection in action.StockTransfer view
		 And I click on last item of storageBinSelection items in action.StockTransfer view
		 And I enter '00000000109330000013' into storageUnitInput in action.StockTransfer view
		 And I enter '321,123' into quantityInput in action.StockTransfer view
		 And I click on saveButton in action.StockTransfer view
		Then I can see messageStrip with text 'Wareneingang von Palette '109330000013' und Umlagerung nach Lagerplatz 'PRODUKTION' wurde erfolgreich gebucht!' in action.StockTransfer view
		 And I can see messageStrip with type 'Success' in action.StockTransfer view
		 And I can see storageUnitInput with value '' in action.StockTransfer view
		 And I can see storageBinSelection with value '' in action.StockTransfer view