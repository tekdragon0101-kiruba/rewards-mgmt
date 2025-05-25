using {RewardsMgmtService as service} from './service';
using {rewardsmgmt as db} from '../db/schema';

annotate service.RewardResources with
@UI: {
    SelectionFields                  : [
        Name,
        category.Name
    ],
    LineItem                         : [
        {Value: Name},
        {Value: Description},
        {
            $Type: 'UI.DataFieldWithUrl',
            Value: Url,
            Url  : 'Url',
        },
        {Value: category_ID},

    ],
    HeaderInfo                       : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : '{i18n>rewardResource}',
        TypeNamePlural: '{i18n>rewardResourcesPlural}',
        Title         : {Value: Name},
        Description   : {Value: category.Name},
    },
    Facets                           : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'RewardResourceDetails',
        Label : '{i18n>rewardResourceDetails}',
        Target: '@UI.FieldGroup#rewardResourceDetails',
    }, ],
    FieldGroup #rewardResourceDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {Value: Name},
            {Value: Description},
            {Value: category_ID},
            {
                $Type: 'UI.DataFieldWithUrl',
                Value: Name,
                Url  : Url,
                Label: '{i18n>URL}'
            },
        ],
    },
};

annotate service.RewardResources with {
    category  @Common.ValueList: {
        CollectionPath: 'Categories',
        $Type         : 'Common.ValueListType',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: 'category_ID',
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Name',
            }
        ],
    }  @Common: {
        Text           : Name,
        TextArrangement: #TextOnly,
    };
};

////////////////////////////////////////////////////////////////

// Categories

aspect Hierarchy {
    LimitedDescendantCount : Integer64 = null;
    DistanceFromRoot       : Integer64 = null;
    DrillState             : String    = null;
    LimitedRank            : Integer64 = null;
}

annotate Hierarchy with @Capabilities.FilterRestrictions.NonFilterableProperties: [
    'LimitedDescendantCount',
    'DistanceFromRoot',
    'DrillState',
    'LimitedRank'
];

annotate Hierarchy with @Capabilities.SortRestrictions.NonSortableProperties: [
    'LimitedDescendantCount',
    'DistanceFromRoot',
    'DrillState',
    'LimitedRank'
];

extend db.Categories with Hierarchy;

////////////////////////////////////////////////////////////////////////////
//
//	Categories Tree Table Annotations
//
//  DISCLAIMER: The below are an alpha version implementation and will change in final release !!!
//
annotate db.Categories with @Aggregation.RecursiveHierarchy #CategoryHierarchy: {
    $Type                   : 'Aggregation.RecursiveHierarchyType',
    NodeProperty            : ID, // identifies a node
    ParentNavigationProperty: parentCategory // navigates to a node's parent
};

annotate db.Categories with @Hierarchy.RecursiveHierarchy #CategoryHierarchy: {
    $Type                 : 'Hierarchy.RecursiveHierarchyType',
    LimitedDescendantCount: LimitedDescendantCount,
    DistanceFromRoot      : DistanceFromRoot,
    DrillState            : DrillState,
    LimitedRank           : LimitedRank
};

annotate db.Categories with @(
    readonly,
    cds.search: {Name}
);

////////////////////////////////////////////////////////////////////////////
//
//	Categories List
//
annotate service.Categories with @(
    Common.SemanticKey: [Name],
    UI                : {
        SelectionFields: [Name],
        LineItem       : [
            {
                Value: Name,
                Label: '{i18n>categoryName}'
            },
            {
                Value: Description,
                Label: '{i18n>categoryDescription}'
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action: 'RewardsMgmtService.EntityContainer/createCategory',
                Label : '{i18n>createCategory}',
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action: 'RewardsMgmtService.editCategory',
                Label : '{i18n>editCategory}',
                Inline: true
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action: 'RewardsMgmtService.deleteCategory',
                Label : '{i18n>deleteCategory}',
            
            }
        ],
    }
);

////////////////////////////////////////////////////////////////////////////
//
//	Genre Details
//
annotate service.Categories with @(UI: {
    Identification: [{Value: Name}],
    HeaderInfo    : {
        TypeName      : '{i18n>Categories}',
        TypeNamePlural: '{i18n>Categories}',
        Title         : {Value: Name},
        Description   : {Value: ID}
    }
});
