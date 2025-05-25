sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'for //rewardresources/test/integration/FirstJourney',
		'for //rewardresources/test/integration/pages/RewardResourcesList',
		'for //rewardresources/test/integration/pages/RewardResourcesObjectPage'
    ],
    function(JourneyRunner, opaJourney, RewardResourcesList, RewardResourcesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('for //rewardresources') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheRewardResourcesList: RewardResourcesList,
					onTheRewardResourcesObjectPage: RewardResourcesObjectPage
                }
            },
            opaJourney.run
        );
    }
);