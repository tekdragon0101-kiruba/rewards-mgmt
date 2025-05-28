namespace rewardsmgmt;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity Rewards : cuid, managed {
    Name           : String(100)           @mandatory;
    Description    : String(500);
    category       : Association to Categories;
    PointsRequired : Integer;
    ValidFrom      : DateTime default $now @cds.valid.from;
    ValidTo        : DateTime              @cdsa.valid.to;
}


entity Categories : cuid {
    Name           : String(100) @mandatory;
    Description    : String(500);
    parentCategory : Association to Categories;
    child          : Composition of Categories
                         on child.parentCategory = $self;
}

entity RewardResources : cuid {
    Name        : String(100) @mandatory;
    Description : String(500);
    Url         : String(500);
    category    : Association to Categories;
}

annotate RewardResources with {
    ID          @title: '{i18n>id}';
    Name        @title: '{i18n>name}';
    Description @title: '{i18n>description}';
    category    @title: '{i18n>category}';
    Url         @title: '{i18n>URL}';
};

annotate Categories with {
    ID             @title: '{i18n>id}';
    Name           @title: '{i18n>categoryName}';
    Description    @title: '{i18n>ca}';
    parentCategory @title: '{i18n>parentCategory}';
};

annotate Rewards with {
    ID             @title: '{i18n>id}';
    Name           @title: '{i18n>name}';
    Description    @title: '{i18n>description}';
    category       @title: '{i18n>category}';
    PointsRequired @title: '{i18n>pointsRequired}';
    ValidFrom      @title: '{i18n>validFrom}';
    ValidTo        @title: '{i18n>validTo}';
};
