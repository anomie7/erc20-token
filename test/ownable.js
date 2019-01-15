const Owned = artifacts.require("Owned");

contract("owned", async accounts => {
  let owner = accounts[0];

  it("should assert true", async () => {
    let owned = await Owned.deployed();
    assert.isTrue(await owned.isOwner());
  });

  it("should assert owner", async () => {
    let owned = await Owned.deployed();
    assert.equal(owner, await owned.owner());
  });

  it("should transfer Ownership", async () => {
    let owned = await Owned.deployed();
    let newOwner = accounts[1];
    owned.transferOwnership(newOwner);
    assert.equal(newOwner, await owned.owner());
  });
});
