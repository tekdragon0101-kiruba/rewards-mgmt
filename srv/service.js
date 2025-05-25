const cds = require("@sap/cds");
const { uuid } = cds.utils;

module.exports = class RewardsMgmtService extends cds.ApplicationService {
  init() {
    const { Rewards, Categories, RewardResources, isChildCategory } =
      cds.entities("RewardsMgmtService");

    // this.before (['CREATE', 'UPDATE'], Rewards, async (req) => {
    //   console.log('Before CREATE/UPDATE Rewards', req.data)
    // })
    // this.after ('READ', Rewards, async (rewards, req) => {
    //   console.log('After READ Rewards', rewards)
    // })
    // this.before (['CREATE', 'UPDATE'], Categories, async (req) => {
    //   console.log('Before CREATE/UPDATE Categories', req.data)
    // })
    // this.after ('READ', Categories, async (categories, req) => {
    //   console.log('After READ Categories', categories)
    // })
    // this.before (['CREATE', 'UPDATE'], RewardResources, async (req) => {
    //   console.log('Before CREATE/UPDATE RewardResources', req.data)
    // })
    // this.after ('READ', RewardResources, async (rewardResources, req) => {
    //   console.log('After READ RewardResources', rewardResources)
    // })
    // this.before (['CREATE', 'UPDATE'], isChildCategory, async (req) => {
    //   console.log('Before CREATE/UPDATE isChildCategory', req.data)
    // })
    // this.after ('READ', isChildCategory, async (isChildCategory, req) => {
    //   console.log('After READ isChildCategory', isChildCategory)
    // })

    this.on("createCategory", async (req) => {
      console.log("On createCategory", req.data);
      const { Name } = req.data;
      req.data.ID = uuid();
      req.data.parentCategory_ID = !req.data.isChild
        ? null
        : req.data.parentCategory_ID;
      await INSERT.into(Categories).entries(req.data);
      req.notify(`Category "${Name}" Successfully Created`);
    });
    this.on("deleteCategory", async (req) => {
      console.log("On deleteCategory", req.params);
      await DELETE.from(Categories).where({ ID: req.params });
      req.notify(`Category deleted`);
    });

    this.on("editCategory", async (req) => {
      console.log("on editCategory", req.data, req.params);

      const ID = req.params[0];
      let { parentCategory } = req.data;
      parentCategory = parentCategory || null;

      // Validate category relationships
      if (parentCategory && ID === parentCategory) {
        return req.error('Category ID and Parent Category ID should not be the same');
      }

      const childIds = await SELECT.from(Categories).columns('ID').where({ parentCategory_ID: ID });

      if (childIds.some(child => child.ID === parentCategory)) {
        return req.error('Category ID should not be assigned to a child category item');
      }

      // Update category details
      await UPDATE(Categories).set({
        Name: req.data.Name,
        Description: req.data.Description,
        parentCategory_ID: parentCategory
      }).where({ ID });

      req.notify("Category updated successfully");
    });

    return super.init();
  }
};
