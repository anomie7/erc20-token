const Owned = artifacts.require("Owned");

contract("owned", async accounts => {
  let owner = accounts[0];
  let owned;

  before(async function() {
    owned = await Owned.deployed();
  });

  it("should assert true", async () => {
    assert.isTrue(await owned.isOwner());
  });

  it("should assert owner", async () => {
    assert.equal(owner, await owned.owner());
  });

  it("should transfer Ownership", async () => {
    let newOwner = accounts[1];
    owned.transferOwnership(newOwner);
    assert.equal(newOwner, await owned.owner());
  });
});
