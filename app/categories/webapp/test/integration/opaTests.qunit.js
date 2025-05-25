sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'for/me/categories/test/integration/FirstJourney',
		'for/me/categories/test/integration/pages/CategoriesList',
		'for/me/categories/test/integration/pages/CategoriesObjectPage'
    ],
    function(JourneyRunner, opaJourney, CategoriesList, CategoriesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('for/me/categories') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheCategoriesList: CategoriesList,
					onTheCategoriesObjectPage: CategoriesObjectPage
                }
            },
            opaJourney.run
        );
    }
);