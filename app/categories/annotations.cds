using RewardsMgmtService as service from '../../srv/service';
using from '../../srv/fiori';

annotate service.Categories with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : Name,
            },
            {
                $Type : 'UI.DataField',
                Value : Description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'LimitedDescendantCount',
                Value : LimitedDescendantCount,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DistanceFromRoot',
                Value : DistanceFromRoot,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DrillState',
                Value : DrillState,
            },
            {
                $Type : 'UI.DataField',
                Label : 'LimitedRank',
                Value : LimitedRank,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ]
);

annotate service.Categories with {
    parentCategory @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Categories',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : parentCategory_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Description',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'LimitedDescendantCount',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'DistanceFromRoot',
            },
        ],
    }
};

