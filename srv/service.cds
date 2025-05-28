using {rewardsmgmt as db} from '../db/schema';

@path    : '/rewardsmgmt'
@requires: 'authenticated-user'
service RewardsMgmtService {

    entity Rewards         as projection on db.Rewards;

    type inCategory {
        Name              : String(100) @mandatory;
        Description       : String(500) @mandatory;
        isChild           : Boolean default false;
        parentCategory_ID : String(36);
    };

    entity Categories      as projection on db.Categories
        actions {
            @Common: {SideEffects: {
                $Type         : 'Common.SideEffectsType',
                TargetEntities: ['/RewardsMgmtService.EntityContainer/Categories'],
            }, }
            action deleteCategory();
            @Common                         : {SideEffects: {
                $Type         : 'Common.SideEffectsType',
                TargetEntities: ['/RewardsMgmtService.EntityContainer/Categories'],
            }, }
            @cds.odata.bindingparameter.name: '_it'
            action editCategory(
                                @UI: {ParameterDefaultValue: _it.Name}
                                Name : inCategory        : Name @Common.Label: '{i18n>categoryName}',
                                @UI: {ParameterDefaultValue: _it.Description}
                                Description : inCategory : Description @Common.Label: '{i18n>categoryDescription}',
                                @UI: {ParameterDefaultValue: _it.parentCategory_ID}
                                parentCategory : String(36)  @Common.Label: 'Parent Category'  @Common: {
                ValueListWithFixedValues: true,
                ValueList               : {

                    $Type         : 'Common.ValueListType',
                    CollectionPath: 'Categories',
                    Parameters    : [
                        {
                            $Type            : 'Common.ValueListParameterInOut',
                            LocalDataProperty: 'parentCategory',
                            ValueListProperty: 'ID',

                        },
                        {
                            $Type            : 'Common.ValueListParameterDisplayOnly',
                            ValueListProperty: 'Name',
                        },
                    ],
                },
            }  )
        };

    @Common                                   : {SideEffects: {
        $Type         : 'Common.SideEffectsType',
        TargetEntities: ['/RewardsMgmtService.EntityContainer/Categories'],
    }, }
    action createCategory(Name : inCategory              : Name,
                          Description : inCategory       : Description,
                          isChild : inCategory           : isChild,
                          parentCategory_ID : inCategory : parentCategory_ID);

    @odata.draft.enabled
    entity RewardResources as projection on db.RewardResources;

    entity isChildCategory {
        key isChild : Boolean;
    }

}

annotate RewardsMgmtService.inCategory with {
    Name               @Common.Label: '{i18n>name}';
    isChild            @Common.Label: '{i18n>isChildCategory}'  @Common: {
        ValueListWithFixedValues: true,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'isChildCategory',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: isChild,
                ValueListProperty: 'isChild',
            }, ],
        },
    };
    Description        @Common.Label: '{i18n>description}';
    parentCategory_ID  @Common.Label: 'Parent Category'   @Common: {
        ValueListWithFixedValues: true,
        ValueList               : {

            $Type         : 'Common.ValueListType',
            CollectionPath: 'Categories',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'parentCategory_ID',
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Name',
                },
            ],
        },
        Text                    : Name,
        TextArrangement         : #TextOnly,
    }  @UI.Hidden: {$edmJson: {$If: [
        {$Eq: [
            {$Path: 'isChild'},
            true
        ]},
        false,
        true
    ]}}
};

annotate RewardsMgmtService.Categories with actions {
    deleteCategory @Common.IsActionCritical
};
